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
		self.userInteractionEnabled = NO;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.7].CGColor;
        self.layer.borderWidth = 2.0f;
        self.layer.cornerRadius= 10.0f;

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
	CGContextSetGrayFillColor(context, 0.1, 0.0);
	CGContextMoveToPoint(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect));
	CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect) + radius, radius, 3 * M_PI / 2, 0, 0);
	CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius, radius, 0, M_PI / 2, 0);
	CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMaxY(rect) - radius, radius, M_PI / 2, M_PI, 0);
	CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect) + radius, radius, M_PI, 3 * M_PI / 2, 0);
	
	CGContextClosePath(context);
	CGContextFillPath(context);
	CGColorRef blackLineColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
	CGColorRef darkGrayLineColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5].CGColor;
	CGColorRef grayLineColor = [UIColor colorWithWhite:0.5 alpha:0.8].CGColor;
	CGColorRef lightGrayLineColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
	UIGraphicsPushContext(context);
	
	float horLineXStart = 0.0f;
	float horLineXEnd = rect.size.width+2*kInsetWidth;
	float horLineY = rect.size.height/2;
	
	float vertLine1X = rect.size.width/3;
	float vertLineYStart = 0.0f;
	float vertLineYEnd = rect.size.height+2*kInsetWidth;
	
	float vertLine2X = 2*(vertLine1X);
	
	//horizontal line
	
	drawHalfPxStroke(context, 
					 CGPointMake(horLineXStart					, horLineY+1.0), 
					 CGPointMake(horLineXEnd					, horLineY+1.0), 
					 lightGrayLineColor);
	drawHalfPxStroke(context, 
					 CGPointMake(horLineXStart					, horLineY+0.5), 
					 CGPointMake(horLineXEnd					, horLineY+0.5), 
					 grayLineColor);
	drawHalfPxStroke(context, 
					 CGPointMake(horLineXStart					, horLineY-0.5), 
					 CGPointMake(horLineXEnd					, horLineY-0.5), 
					 darkGrayLineColor);
	
	
	//first vertical line
	
	drawHalfPxStroke(context, 
					 CGPointMake(vertLine1X+1.25			, vertLineYStart), 
					 CGPointMake(vertLine1X+1.25			, vertLineYEnd), 
					 lightGrayLineColor);
	drawHalfPxStroke(context, 
					 CGPointMake(vertLine1X+0.75			, vertLineYStart), 
					 CGPointMake(vertLine1X+0.75			, vertLineYEnd), 
					 grayLineColor);
	drawHalfPxStroke(context, 
					 CGPointMake(vertLine1X-0.25			, vertLineYStart), 
					 CGPointMake(vertLine1X-0.25			, vertLineYEnd), 
					 darkGrayLineColor);
	
	//second vertical line
	drawHalfPxStroke(context, 
					 CGPointMake(vertLine2X+1.0		, vertLineYStart), 
					 CGPointMake(vertLine2X+1.0		, vertLineYEnd), 
					 lightGrayLineColor);
	drawHalfPxStroke(context, 
					 CGPointMake(vertLine2X+0.5		, vertLineYStart), 
					 CGPointMake(vertLine2X+0.5		, vertLineYEnd), 
					 grayLineColor);
	drawHalfPxStroke(context, 
					 CGPointMake(vertLine2X-0.5		, vertLineYStart), 
					 CGPointMake(vertLine2X-0.5		, vertLineYEnd), 
					 darkGrayLineColor);
	
	//all black lines need to be drawn on top
	drawHalfPxStroke(context, 
					 CGPointMake(horLineXStart		, horLineY), 
					 CGPointMake(horLineXEnd		, horLineY), 
					 blackLineColor);
	drawHalfPxStroke(context, 
					 CGPointMake(vertLine1X			, vertLineYStart), 
					 CGPointMake(vertLine1X			, vertLineYEnd), 
					 blackLineColor);
	drawHalfPxStroke(context, 
					 CGPointMake(vertLine2X			, vertLineYStart), 
					 CGPointMake(vertLine2X			, vertLineYEnd), 
					 blackLineColor);
	
	
	/*
	CGColorRef redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5].CGColor;
	CGContextSetFillColorWithColor(context, redColor);
	CGContextFillRect(context, self.bounds);
	 */
	
}

- (void)dealloc {
    [super dealloc];
}


@end
