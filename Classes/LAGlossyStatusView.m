//
//  LAGlossyStatusView.m
//  DeceptiCam
//
//  Created by Lars Anderson on 12/13/12.
//
//

#import "LAGlossyStatusView.h"
#import "GraphicsHelpers.h"

@implementation LAGlossyStatusView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    {
        [[UIColor colorWithWhite:0.f alpha:0.65f] setFill];
        
        CGContextFillRect(context, rect);
        
        [[UIColor colorWithWhite:1.f alpha:0.35f] setFill];
        UIBezierPath *shinePath = [UIBezierPath bezierPathWithRect:CGRectMake(0.f,
                                                                              0.f,
                                                                              CGRectGetWidth(self.frame),
                                                                              CGRectGetHeight(self.frame)/2)];
        CGContextSetBlendMode(context, kCGBlendModeSoftLight);
        [shinePath fill];
        
        draw1PxStroke(context, CGPointZero, CGPointMake(CGRectGetWidth(self.frame), 0.f), [UIColor lightGrayColor].CGColor);
        
        drawHalfPxStroke(context, CGPointMake(0.f, CGRectGetHeight(self.frame)), CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)), [UIColor lightGrayColor].CGColor);
    }
    CGContextRestoreGState(context);
    
    [super drawRect:rect];
}


@end
