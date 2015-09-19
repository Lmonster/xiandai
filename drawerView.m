//
//  drawerView.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/22.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "drawerView.h"


@implementation drawerView

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 10, 60);
    CGContextAddLineToPoint(context, rect.size.width - 10, 60);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.7 alpha:1.0].CGColor);
    CGContextStrokePath(context);
    CGContextMoveToPoint(context, 10, 120);
    CGContextAddLineToPoint(context, rect.size.width - 10, 120);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.7 alpha:1.0].CGColor);
    CGContextStrokePath(context);
    CGContextMoveToPoint(context, 10, 180);
    CGContextAddLineToPoint(context, rect.size.width - 10, 180);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.7 alpha:1.0].CGColor);
    CGContextStrokePath(context);
    
    _view_1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 60)];
    _view_2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 65, rect.size.width, 60)];
    _view_3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 130, rect.size.width, 60)];
    _view_1.layer.cornerRadius = 5;
    _view_2.layer.cornerRadius = 5;
    _view_3.layer.cornerRadius = 5;
    [_view_1 setTitle:@"参数说明" forState:UIControlStateNormal];
    [_view_2 setTitle:@"还原图形" forState:UIControlStateNormal];
    [_view_3 setTitle:@"更多实例" forState:UIControlStateNormal];
    
    [_view_1 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [_view_2 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [_view_3 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:_view_1];
    [self addSubview:_view_2];
    [self addSubview:_view_3];
    
}

-(void)buttonTouched:(UIButton *)button{
    if([button isEqual:_view_1]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushGuide" object:self];
    }else if([button isEqual:_view_2]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"restorePic" object:self];
    }else if ([button isEqual:_view_3]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moreInstance" object:self];
    }
}

@end
