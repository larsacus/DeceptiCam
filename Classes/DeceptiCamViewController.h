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
	
}

#if !TARGET_IPHONE_SIMULATOR
@property (nonatomic,strong) LACamManager *cameraManager;
#endif
@property (nonatomic, strong) UIView *buttonContainer;
@property (nonatomic, strong) UIButton *topLeft;
@property (nonatomic, strong) UIButton *topCenter;
@property (nonatomic, strong) UIButton *topRight;
@property (nonatomic, strong) UIButton *bottomLeft;
@property (nonatomic, strong) UIButton *bottomCenter;
@property (nonatomic, strong) UIButton *bottomRight;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *contactImageView;
@property (nonatomic, strong) IBOutlet UIButton *endButton;

- (IBAction)toggleMovieMode:(id)sender;

@end

