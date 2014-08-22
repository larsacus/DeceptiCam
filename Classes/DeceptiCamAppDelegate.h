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

@interface DeceptiCamAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet DeceptiCamViewController *viewController;
@property (nonatomic, strong) AVAudioSession *audioSession;

@end

