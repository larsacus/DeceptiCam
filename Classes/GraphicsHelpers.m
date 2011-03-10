//
//  GraphicsHelpers.m
//  DeceptiCam
//
//  Created by Lars Anderson on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphicsHelpers.h"


@implementation GraphicsHelpers

void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, 
				   CGColorRef color) {
	
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
    CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);        
	
}

void drawHalfPxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, 
				   CGColorRef color) {
	//when drawing half-pixel strokes on iPhone 4 (whole pixel lines), no aliasing will occur
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetLineWidth(context, 0.5);
    CGContextMoveToPoint(context, startPoint.x + 0.25, startPoint.y + 0.25);
    CGContextAddLineToPoint(context, endPoint.x + 0.25, endPoint.y + 0.25);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);        
	
}

@end
