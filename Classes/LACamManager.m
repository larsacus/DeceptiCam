//
//  LACamManager.m
//  DeceptiCam
//
//  Created by Lars Anderson on 2/20/11.
//  Copyright 2011 Drink & Apple. All rights reserved.
//
#if !TARGET_IPHONE_SIMULATOR
#import "LACamManager.h"
#import <ImageIO/ImageIO.h>
#import <CoreMedia/CoreMedia.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AudioToolbox/AudioToolbox.h>

@interface LACamManager ()

@property (nonatomic, strong) NSTimer *stillTimer;

@end

@implementation LACamManager

- (void)createNewSessionWithVideo:(BOOL)hasVideo{
	#if !TARGET_IPHONE_SIMULATOR
	
	//creates capture session
	if (![self captureSession]) {
		_captureSession = [[AVCaptureSession alloc] init];
	}
	else {
		//if capture session already exists, removes all outputs
		NSArray *outputDevices = [[self captureSession] outputs];
		for (AVCaptureOutput *output in outputDevices) {
			[[self captureSession] removeOutput:output];
		}
        
        NSArray *inputDevices = [[self captureSession] inputs];
        for (AVCaptureInput *input in inputDevices) {
            [[self captureSession] removeInput:input];
        }
	}
	
	if (hasVideo) {
		//creates video outputs and inputs
        NSLog(@"Setting capture session preset to video");
		[[self captureSession] setSessionPreset:AVCaptureSessionPresetHigh];
		
		//creates video input if it doesn't exist
		if (![self videoCaptureDeviceInput]) {
            NSLog(@"Creating Video Input");
			_videoCaptureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo] error:nil];
		}
		
		//creates audio input if it doesn't exist
		if (![self audioCaptureDeviceInput]) {
            NSLog(@"Creating Audio Input");
			_audioCaptureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio] error:nil];
		}
		
		//creates movie file output for video
		if (![self movieFileOutput]) {
            NSLog(@"Creating Movie File Output");
			_movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
		}
		
		//adds inputs to video capture session
		if ([[self captureSession] canAddInput:[self videoCaptureDeviceInput]]) {
            NSLog(@"Adding Video Input to Capture Session");
			[[self captureSession] addInput:[self videoCaptureDeviceInput]];
		}
		if ([[self captureSession] canAddInput:[self audioCaptureDeviceInput]]) {
            NSLog(@"Adding Audio Input to Capture Session");
			[[self captureSession] addInput:[self audioCaptureDeviceInput]];
		}
		
		//adds movie file output to capture session
		if ([[self captureSession] canAddOutput:[self movieFileOutput]]) {
            NSLog(@"Adding Movie File Output to Capture Session");
			[[self captureSession] addOutput:[self movieFileOutput]];
		}
	}
	else {
        NSLog(@"Setting capture session preset to photo");
		[[self captureSession] setSessionPreset:AVCaptureSessionPresetPhoto];
		
		//create device input
		if (![self stillCaptureDeviceInput]) {
            NSLog(@"Creating Capture Input");
			_stillCaptureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo] error:nil];
		}
		
		//creates still image output if it doesn't exist
		if (![self stillOutput]) {
            NSLog(@"Creating still output");
			_stillOutput = [[AVCaptureStillImageOutput alloc] init];
		}
		
		//add still input to capture session
		if ([[self captureSession] canAddInput:[self stillCaptureDeviceInput]]) {
            NSLog(@"Adding still input to capture session");
			[[self captureSession] addInput:[self stillCaptureDeviceInput]];
		}
		
		//adds still image output to capture session
		if ([[self captureSession] canAddOutput:[self stillOutput]]) {
            NSLog(@"Adding still image output to capture session");
			[[self captureSession] addOutput:[self stillOutput]];
		}
	}
	
	if (![[self captureSession] isRunning]) {
        NSLog(@"Starting capture session");
		[[self captureSession] startRunning];
        NSLog(@"Done!");
	}
	
	#endif
}

- (void)initiateStillCapture{
	//route all audio to the receiver
	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
	[[AVAudioSession sharedInstance] setActive:YES error:nil];
	UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_None;
	AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
	
	[self takeStillPhoto];

	if (self.stillTimer == nil) {
        self.stillTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                           target:self
                                                         selector:@selector(takeStillPhoto)
                                                         userInfo:nil
                                                          repeats:YES];
    }
}

- (void)haltStillCapture {
    [self cancelStillTimer];
}

- (void)takeStillPhoto {
    if ([[self captureSession] sessionPreset] == AVCaptureSessionPresetPhoto && [self stillOutput]) {
		AVCaptureConnection *stillConnection = nil;
		for (AVCaptureConnection *connection in [[self stillOutput] connections]) {
			for (AVCaptureInputPort *port in [connection inputPorts]) {
				if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
					stillConnection = connection;
					break;
				}
			}
			if (stillConnection) { break; }
		}
		
		//AVCaptureConnection *stillConnection = [
		
		[[self stillOutput] captureStillImageAsynchronouslyFromConnection:stillConnection completionHandler:
		 ^(CMSampleBufferRef imageSampleBuffer, NSError *error){
			 CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer,kCGImagePropertyExifDictionary, NULL);
			 if (exifAttachments) {
				 //do something with the attachments
				 
			 }
			 if(imageSampleBuffer != nil){
				 NSData *jpgData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
				 UIImage *image = [[UIImage alloc] initWithData:jpgData];
				 ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
				 [library writeImageToSavedPhotosAlbum:[image CGImage]
										   orientation:(ALAssetOrientation)[image imageOrientation]
									   completionBlock:^(NSURL *assetURL, NSError *error){
                                           if (error) {
                                               if ([self respondsToSelector:@selector(captureStillImageFailedWithError:)]) {
                                                   [self captureStillImageFailedWithError:error];
                                               }
                                           }
                                           if (!error) {
                                               NSLog(@"Image saved to camera roll at %@", assetURL);
                                           }
									   }];
			 }
			 else if (error) {
				 if ([self respondsToSelector:@selector(captureStillImageFailedWithError:)]) {
					 [self captureStillImageFailedWithError:error];
				 }
			 }
		 }];
	}
	else {
		NSLog(@"Cannot take still photo in video mode");
	}
}

- (void)cancelStillTimer {
    //route all audio back to the default
	[[AVAudioSession sharedInstance] setActive:NO error:nil];
    [self.stillTimer invalidate];
    self.stillTimer = nil;
}

- (BOOL)isMovieMode{
    return ([[self captureSession] sessionPreset] == AVCaptureSessionPresetHigh);
}

- (void)startRecordingMovie{
	if (![[self movieFileOutput] isRecording]) {
		[self correctVideoConnectionOrientationWithCurrentOrientation];
		
		NSLog(@"Starting to record movie to file");
		NSURL *movieURL = [self getNewMovieURL];
		[[self movieFileOutput] startRecordingToOutputFileURL:movieURL recordingDelegate:self];
	}
	else {
		//error
		NSLog(@"Cannot start movie capture while currently recording");
	}
}

- (void)stopRecordingMovie{
	if ([self isMovieMode] && [[self movieFileOutput] isRecording]) {
		[[self movieFileOutput] stopRecording];
	}
	else {
		NSLog(@"Cannot stop movie capture in photo mode or session is not running");
	}

}

- (NSURL *)getNewMovieURL{
	NSString *outputPath = [[NSString alloc] initWithFormat:@"%@%@", NSTemporaryDirectory(), @"output.mov"];
	NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:outputPath];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:outputPath]) {
		NSError *error;
		if ([fileManager removeItemAtPath:outputPath error:&error] == NO) {
			NSLog(@"Error removing file at path %@: %@, %@", outputPath, error, [error userInfo]);
		}
	}
	return outputURL;
}

- (void)switchToVideoMode{
	if ([[self captureSession] isRunning]) {
		[[self captureSession] beginConfiguration];
		[self createNewSessionWithVideo:YES];
		[[self captureSession] commitConfiguration];
	}
	else {
		[self createNewSessionWithVideo:YES];
	}
}

- (void)switchToPhotoMode{
	if ([[self captureSession] isRunning]) {
		[[self captureSession] beginConfiguration];
		[self createNewSessionWithVideo:NO];
		[[self captureSession] commitConfiguration];
	}
	else {
		[self createNewSessionWithVideo:NO];
	}
}

- (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType fromConnections:(NSArray *)connections{
	for ( AVCaptureConnection *connection in connections ) {
		for ( AVCaptureInputPort *port in [connection inputPorts] ) {
			if ( [[port mediaType] isEqual:mediaType] ) {
				return connection;
			}
		}
	}
	return nil;
}

- (void)correctVideoConnectionOrientationWithCurrentOrientation{
	for (AVCaptureConnection *connection in [[self movieFileOutput] connections] ) {
		if ([connection isVideoOrientationSupported]) {
            UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
            AVCaptureVideoOrientation avFoundationOrientation = [self avCaptureOrientationFromDeviceOrientation:deviceOrientation];
			[connection setVideoOrientation:avFoundationOrientation];
		}
	}
}

- (AVCaptureVideoOrientation)avCaptureOrientationFromDeviceOrientation:(UIDeviceOrientation)deviceOrientation {
    switch (deviceOrientation) {
        case UIDeviceOrientationLandscapeLeft:
            return AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIDeviceOrientationLandscapeRight:
            return AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIDeviceOrientationPortrait:
            return AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            return AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        default:
            return AVCaptureVideoOrientationLandscapeLeft;
            break;
    }
}

#pragma mark -
#pragma mark AVCaptureFileOutputRecording Delegate
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
	BOOL recordedSuccessfully = YES;
	
	if ([error code] != noErr) {
		id value = [[error userInfo] objectForKey:AVErrorRecordingSuccessfullyFinishedKey];
		if (value) {
			recordedSuccessfully = [value boolValue];
		}
	}
	
	//save movie to photo roll
	if (recordedSuccessfully) {
		NSLog(@"Saving movie to photos album");
		ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];

		if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputFileURL]) {
			[library writeVideoAtPathToSavedPhotosAlbum:outputFileURL
										completionBlock:^(NSURL *assetURL, NSError *error){
                                            if (error) {
                                                NSLog(@"Error writing video file to path %@: %@, %@", assetURL, error, [error userInfo]);
                                            } else {
												NSLog(@"Video saved to camera roll at %@", assetURL);
											}
										}];
		} else {
			NSLog(@"Video is somehow not compatible with saved photos album: %@", outputFileURL);
		}
		
	}
	else {
		NSLog(@"Movie not recorded successfully");
	}

}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
	//add listener to [captureOutput recordedDuration] and update UI
	NSLog(@"Did start to record file");
}

- (void)captureStillImageFailedWithError:(NSError *)error {
    NSLog(@"Still capture failed with error: %@, %@", error, [error userInfo]);
}

//completion handler for saving movie to photo roll
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
	NSLog(@"Finished saving file");
}

- (void)didReceiveMemoryWarning{
    NSLog(@"Received memory warning - clearing out unused resources");
    if ([self isMovieMode]) {
        if ([self stillOutput]) {
            _stillOutput = nil;
        }
        if ([self stillCaptureDeviceInput]) {
            _stillCaptureDeviceInput = nil;
        }
    }
    else{
        if ([self movieFileOutput]) {
            _movieFileOutput = nil;
        }
        if ([self audioCaptureDeviceInput]) {
            _audioCaptureDeviceInput = nil;
        }
    }
}


@end

#endif
