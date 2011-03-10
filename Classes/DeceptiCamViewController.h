//
//  DeceptiCamViewController.h
//  DeceptiCam
//
//  Created by Lars Anderson on 2/19/11.
//  Copyright 2011 Drink & Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "LACamManager.h"

@interface DeceptiCamViewController : UIViewController {
#if !TARGET_IPHONE_SIMULATOR
	LACamManager *_cameraManager;
#endif
	IBOutlet UIView *_buttonContainer;
	IBOutlet UIButton *_topLeft;
	IBOutlet UIButton *_topCenter;
	IBOutlet UIButton *_topRight;
	IBOutlet UIButton *_bottomLeft;
	IBOutlet UIButton *_bottomCenter;
	IBOutlet UIButton *_bottomRight;
	
}

#if !TARGET_IPHONE_SIMULATOR
@property (nonatomic,retain) LACamManager *cameraManager;
#endif
@property (nonatomic, assign) UIView *buttonContainer;
@property (nonatomic, assign) UIButton *topLeft;
@property (nonatomic, assign) UIButton *topCenter;
@property (nonatomic, assign) UIButton *topRight;
@property (nonatomic, assign) UIButton *bottomLeft;
@property (nonatomic, assign) UIButton *bottomCenter;
@property (nonatomic, assign) UIButton *bottomRight;

@end

