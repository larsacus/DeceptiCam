//
//  GraphicsHelpers.h
//  DeceptiCam
//
//  Created by Lars Anderson on 3/6/11.
//  Copyright 2011 Drink & Apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GraphicsHelpers : NSObject {

}

void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color);
void drawHalfPxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color);

@end
