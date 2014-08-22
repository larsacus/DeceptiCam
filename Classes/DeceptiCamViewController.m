//
//  DeceptiCamViewController.m
//  DeceptiCam
//
//  Created by Lars Anderson on 2/19/11.
//  Copyright 2011 Drink & Apple. All rights reserved.
//

#import "DeceptiCamViewController.h"
#import "LACallButtonContainer.h"
#import <QuartzCore/QuartzCore.h>

#define kBorderWidth 2.0f
#define kCornerRadius 8.0f

@implementation DeceptiCamViewController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad{
    [super viewDidLoad];
#if !TARGET_IPHONE_SIMULATOR
	_cameraManager = [[LACamManager alloc] init];
	[[self cameraManager] createNewSessionWithVideo:NO];
#endif
	
	[[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(handleProximitySensorChange) 
												 name:@"UIDeviceProximityStateDidChangeNotification"
											   object:nil
	 ];
	/*[[[self buttonContainer] layer] setCornerRadius:12.0f];
	[[[self buttonContainer] layer] setBorderWidth:1.0f];
	[[[self buttonContainer] layer] setBorderColor:[UIColor blackColor].CGColor];
	[[[self buttonContainer] layer] setEdgeAntialiasingMask:kCALayerTopEdge];
	
	[[[self buttonContainer] layer] setShadowOffset:CGSizeMake(3, -3)];
	[[[self buttonContainer] layer] setShadowColor:[UIColor blackColor].CGColor];
	[[[self buttonContainer] layer] setShadowOpacity:0.5];
	[[[self buttonContainer] layer] setShadowRadius:2.0f];
	*/
    UIImage *redButton = [UIImage imageNamed:@"end.png"];
    [self.endButton setBackgroundImage:redButton forState:UIControlStateNormal];
	
	[[self topLeft] setBackgroundImage:[[UIImage imageNamed:@"1x1black"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
	[[self topLeft] setBackgroundImage:[[UIImage imageNamed:@"1x1blue"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
	
	
	[[self topCenter] setBackgroundImage:[[UIImage imageNamed:@"1x1black"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
	[[self topCenter] setBackgroundImage:[[UIImage imageNamed:@"1x1blue"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
	
	[[self topRight] setBackgroundImage:[[UIImage imageNamed:@"1x1black"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
	[[self topRight] setBackgroundImage:[[UIImage imageNamed:@"1x1blue"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
	
	[[self bottomLeft] setBackgroundImage:[[UIImage imageNamed:@"1x1black"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
	[[self bottomLeft] setBackgroundImage:[[UIImage imageNamed:@"1x1blue"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
	
	[[self bottomCenter] setBackgroundImage:[[UIImage imageNamed:@"1x1black"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
	[[self bottomCenter] setBackgroundImage:[[UIImage imageNamed:@"1x1blue"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
	
	[[self bottomRight] setBackgroundImage:[[UIImage imageNamed:@"1x1black"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
	[[self bottomRight] setBackgroundImage:[[UIImage imageNamed:@"1x1blue"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
	
    
	UIView *buttonContainerBorder = [[UIView alloc] initWithFrame:CGRectMake(22.0f, 124.0f, 275.0f, 211.0f)]; 
	UIView *buttonContainer = [[UIView alloc] initWithFrame:[buttonContainerBorder frame]];
    
    [[buttonContainerBorder layer] setCornerRadius:kCornerRadius];
    [[buttonContainerBorder layer] setBorderWidth:kBorderWidth];
    //[[buttonContainerBorder layer] setBorderColor:[UIColor colorWithWhite:0.1 alpha:0.6].CGColor];
    [[buttonContainerBorder layer] setBorderColor:[UIColor colorWithWhite:0.1 alpha:0.6].CGColor];
    
    [[buttonContainerBorder layer] setCornerRadius:kCornerRadius];
    [[buttonContainerBorder layer] setMasksToBounds:YES];
    //[[buttonContainer layer] setBorderWidth:0.0f];
    //[[buttonContainer layer] setMasksToBounds:YES];
    
	
    float xOffset = 2.0f;
    float yOffset = 2.0f;
	float buttonHeight = buttonContainer.frame.size.height/2-yOffset;
	float buttonWidth = buttonContainer.frame.size.width/3-xOffset*2/3;
    float spacerWidth = 0.0f;
    float spacerHeight = 0.0f;
    
	[[self topLeft] setFrame:CGRectMake(0 + xOffset, 
										0 + yOffset, 
										buttonWidth, 
										buttonHeight)
	 ];
	[[self topCenter] setFrame:CGRectMake(buttonWidth + xOffset + spacerWidth, 
										  0 + yOffset, 
										  buttonWidth, 
										  buttonHeight)
	 ];
	[[self topRight] setFrame:CGRectMake(2*(buttonWidth) + xOffset + spacerWidth, 
										 0 + yOffset, 
										 buttonWidth, 
										 buttonHeight)
	 ];
	[[self bottomLeft] setFrame:CGRectMake(xOffset, 
										   buttonHeight + yOffset + spacerHeight/2, 
										   buttonWidth, 
										   buttonHeight)
	 ];
	[[self bottomCenter] setFrame:CGRectMake(buttonWidth + xOffset + spacerWidth,
											 buttonHeight + yOffset + spacerHeight/2,
											 buttonWidth, 
											 buttonHeight)
	 ];
	[[self bottomRight] setFrame:CGRectMake(2*(buttonWidth) + xOffset + spacerWidth,
											buttonHeight + yOffset + spacerHeight/2,
											buttonWidth, 
											buttonHeight)
	 ];
	
    //set frame here so it doesn't interfere with above geometry
    //[buttonContainer setFrame:CGRectInset([buttonContainer frame], 2.0, 2.0)];
    
	[buttonContainer addSubview:[self topLeft]];
	[buttonContainer addSubview:[self topCenter]];
	[buttonContainer addSubview:[self topRight]];
	[buttonContainer addSubview:[self bottomLeft]];
	[buttonContainer addSubview:[self bottomCenter]];
	[buttonContainer addSubview:[self bottomRight]];
    
    [[buttonContainer layer] setCornerRadius:kCornerRadius-kBorderWidth];
    [[buttonContainer layer] setBounds:CGRectInset(CGRectMake(0, 0, [buttonContainer frame].size.width, [buttonContainer frame].size.height), kBorderWidth, kBorderWidth)];
    [[buttonContainer layer] setMasksToBounds:YES];
	
	//LACallButtonContainer *callButtonLines = [[LACallButtonContainer alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 275.0f, 211.0f)];
    LACallButtonContainer *callButtonLines = [[LACallButtonContainer alloc] initWithFrame:[buttonContainerBorder frame]];
    
    [[self view] addSubview:buttonContainerBorder];
	[[self view] addSubview:buttonContainer];
    [[self view] addSubview:callButtonLines];
}

-(void)handleProximitySensorChange{
	NSLog(@"Handling proximity change");
	if([[UIDevice currentDevice] proximityState]){
		NSLog(@"Initiating recording");
		[self performSelector:@selector(initiateCapture) withObject:nil afterDelay:1];
	}
	else {
		if ([[self cameraManager] isMovieMode]) {
			[[self cameraManager] stopRecordingMovie];
		} else {
            [[self cameraManager] haltStillCapture];
        }
	}
}

-(void)initiateCapture{
	if (![[self cameraManager] isMovieMode]) {
		NSLog(@"Capturing still");
		[[self cameraManager] initiateStillCapture];
	}
	else {
		NSLog(@"Starting to record movie");
		[[self cameraManager] startRecordingMovie];
	}
}

- (IBAction)toggleMovieMode:(id)sender{
    UIButton *movieButton = (UIButton*)sender;
    bool movieMode = (movieButton.state == UIControlStateHighlighted || movieButton.state == UIControlStateSelected);
    [movieButton setSelected:movieMode];
    [movieButton setHighlighted:movieMode];
    movieMode ? [[self cameraManager] switchToVideoMode] : [[self cameraManager] switchToPhotoMode];
}

- (void)viewDidUnload {
    _endButton = nil;
    [self setEndButton:nil];
    [super viewDidUnload];
}
@end
