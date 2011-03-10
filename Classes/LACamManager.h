//
//  LACamManager.h
//  DeceptiCam
//
//  Created by Lars Anderson on 2/20/11.
//  Copyright 2011 Drink & Apple. All rights reserved.
//
#if !TARGET_IPHONE_SIMULATOR
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface LACamManager : NSObject <AVCaptureFileOutputRecordingDelegate> {
	AVCaptureSession			*_captureSession;
	AVCaptureDevice				*_captureDevice;
	AVCaptureDeviceInput		*_stillCaptureDeviceInput;
	AVCaptureDeviceInput		*_videoCaptureDeviceInput;
	AVCaptureDeviceInput		*_audioCaptureDeviceInput;
	AVCaptureMovieFileOutput	*_videoOutput;
	AVCaptureStillImageOutput	*_stillOutput;
	AVCaptureMovieFileOutput	*_movieFileOutput;
}

@property (nonatomic,retain) AVCaptureSession			*captureSession;
@property (nonatomic,retain) AVCaptureDevice			*captureDevice;
@property (nonatomic,retain) AVCaptureDeviceInput		*stillCaptureDeviceInput;
@property (nonatomic,retain) AVCaptureDeviceInput		*videoCaptureDeviceInput;
@property (nonatomic,retain) AVCaptureDeviceInput		*audioCaptureDeviceInput;
@property (nonatomic,retain) AVCaptureMovieFileOutput	*videoOutput;
@property (nonatomic,retain) AVCaptureStillImageOutput	*stillOutput;
@property (nonatomic,retain) AVCaptureMovieFileOutput	*movieFileOutput;

- (void)createNewSessionWithVideo:(BOOL)hasVideo;
- (BOOL)isMovieMode;
- (void)startRecordingMovie;
- (void)stopRecordingMovie;
- (void)switchToPhotoMode;
- (void)switchToVideoMode;
- (void)takeStill;
- (NSURL *)getNewMovieURL;
- (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType fromConnections:(NSArray *)connections;
- (void)correctVideoConnectionOrientationWithCurrentOrientation;

@end
#endif
