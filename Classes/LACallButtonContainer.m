//
//  LACallButtonContainer.m
//  DeceptiCam
//
//  Created by Lars Anderson on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LACallButtonContainer.h"
#import "LACallButton.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "GraphicsHelpers.h"

#define kInsetWidth 2.0f

@implementation LACallButtonContainer

- (id)init{
	return [self initWithFrame:CGRectMake(160, 230, 280, 214)];
}


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		self.backgroundColor = [UIColor clearColor];
	}
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
	float radius = 8.0f;
	
	rect = self.bounds;
	CGContextRef context = UIGraphicsGetCurrentContext();   
	rect = CGRectInset(rect, kInsetWidth, kInsetWidth);
	
	CGContextBeginPath(context);
	CGContextSetGrayFillColor(context, 0.1, 0.7);
	CGContextMoveToPoint(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect));
	CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect) + radius, radius, 3 * M_PI / 2, 0, 0);
	CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius, radius, 0, M_PI / 2, 0);
	CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMaxY(rect) - radius, radius, M_PI / 2, M_PI, 0);
	CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect) + radius, radius, M_PI, 3 * M_PI / 2, 0);
	
	CGContextClosePath(context);
	CGContextFillPath(context);
	CGColorRef blackLineColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
	CGColorRef grayLineColor = [UIColor colorWithWhite:0.7 alpha:0.3].CGColor;
	UIGraphicsPushContext(context);
	
	
	drawHalfPxStroke(context, 
					 CGPointMake(0+kInsetWidth, rect.size.height/2+0.5), 
					 CGPointMake(rect.size.width+kInsetWidth/2, rect.size.height/2+0.5), 
					 grayLineColor);
	

	drawHalfPxStroke(context, 
					 CGPointMake(rect.size.width/3+0.75, kInsetWidth), 
					 CGPointMake(rect.size.width/3+0.75, rect.size.height+kInsetWidth/2), 
					 grayLineColor);
	
	
	drawHalfPxStroke(context, 
					 CGPointMake(2*(rect.size.width/3)+0.75, kInsetWidth), 
					 CGPointMake(2*(rect.size.width/3)+0.75, rect.size.height+kInsetWidth/2), 
					 grayLineColor);
	
	
	drawHalfPxStroke(context, CGPointMake(0+kInsetWidth, rect.size.height/2), CGPointMake(rect.size.width+kInsetWidth/2, rect.size.height/2), blackLineColor);
	drawHalfPxStroke(context, CGPointMake(rect.size.width/3, kInsetWidth), CGPointMake(rect.size.width/3, rect.size.height+kInsetWidth/2), blackLineColor);
	drawHalfPxStroke(context, CGPointMake(2*(rect.size.width/3), kInsetWidth), CGPointMake(2*(rect.size.width/3), rect.size.height+kInsetWidth/2), blackLineColor);
	/*
	CGColorRef redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5].CGColor;
	CGContextSetFillColorWithColor(context, redColor);
	CGContextFillRect(context, self.bounds);
	 */
	
}


/*- (void)layoutSubviews{
	
}*/

- (void)dealloc {
    [super dealloc];
}


@end
