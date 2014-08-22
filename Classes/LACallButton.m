//
//  LACallButton.m
//  DeceptiCam
//
//  Created by Lars Anderson on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LACallButton.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>


@implementation LACallButton


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		[[self layer] setBorderWidth:1.0];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect {
    // Uncomment drawRect and replace the contents with the following:
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGColorRef redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
	
	CGContextSetFillColorWithColor(context, redColor);
	CGContextFillRect(context, self.bounds);
}*/




@end
