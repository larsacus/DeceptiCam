//
//  DeceptiCamAppDelegate.h
//  DeceptiCam
//
//  Created by Lars Anderson on 2/19/11.
//  Copyright 2011 Drink & Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class DeceptiCamViewController;

@interface DeceptiCamAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DeceptiCamViewController *viewController;
	AVAudioSession *_audioSession;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DeceptiCamViewController *viewController;
@property (nonatomic, assign) AVAudioSession *audioSession;

@end

