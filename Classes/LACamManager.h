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

@interface LACamManager : NSObject <AVCaptureFileOutputRecordingDelegate> 

@property (nonatomic,strong) AVCaptureSession			*captureSession;
@property (nonatomic,strong) AVCaptureDevice			*captureDevice;
@property (nonatomic,strong) AVCaptureDeviceInput		*stillCaptureDeviceInput;
@property (nonatomic,strong) AVCaptureDeviceInput		*videoCaptureDeviceInput;
@property (nonatomic,strong) AVCaptureDeviceInput		*audioCaptureDeviceInput;
@property (nonatomic,strong) AVCaptureStillImageOutput	*stillOutput;
@property (nonatomic,strong) AVCaptureMovieFileOutput	*movieFileOutput;

- (void)createNewSessionWithVideo:(BOOL)hasVideo;
- (BOOL)isMovieMode;
- (void)startRecordingMovie;
- (void)stopRecordingMovie;
- (void)switchToPhotoMode;
- (void)switchToVideoMode;
- (void)initiateStillCapture;
- (NSURL *)getNewMovieURL;
- (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType fromConnections:(NSArray *)connections;
- (void)correctVideoConnectionOrientationWithCurrentOrientation;
- (void)haltStillCapture;

@end
#endif
