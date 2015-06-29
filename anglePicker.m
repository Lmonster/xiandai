//
//  anglePicker.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/26.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "anglePicker.h"


#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )   /*  转化角度为弧度  */
#define ToDeg(rad)		( (180.0 * (rad)) / M_PI )   /*  转化弧度位角度  */
#define SQR(x)			( (x) * (x) )


@implementation anglePicker{
    float angle;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    float rect_x = rect.size.width;
    float rect_y = rect.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextAddArc(context, rect_x / 2, rect_y / 2, rect_x / 2, 0, M_PI * 2, YES);
    CGContextAddArc(context, rect_x / 2, rect_y / 2, rect_x / 2 - 120, 0, M_PI * 2, YES);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    CGContextAddArc(context, rect_x / 2, rect_y / 2, rect_x / 2 - 60, 0, angle, NO);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 120);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextStrokePath(context);
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    CGPoint lastPoint=  [touch locationInView:self];
    angle = [self calculationAngle:lastPoint];
    [self setNeedsDisplay];
    return YES;
}

-(float)calculationAngle:(CGPoint)lastPoint{
    float center_x = self.layer.bounds.size.width / 2;
    float center_y = self.layer.bounds.size.height / 2;
    float p_x = lastPoint.x;
    float p_y = lastPoint.y;
    CGPoint v = CGPointMake(p_x - center_x, p_y - center_y);
    float vmag = sqrt(SQR(v.x) + SQR(v.y)) , result;
    v.x /= vmag;
    v.y /= vmag;
    double radians = atan2(v.y,v.x);
    result = ToDeg(radians);
    return (result >=0  ? result : result + 360.0);
}

@end
