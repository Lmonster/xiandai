//
//  new_drawer.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/3/2.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "new_drawer.h"
#import "ConstantHeader.h"
#import "CalculationViewController.h"


@implementation new_drawer

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 10, 60);
    CGContextAddLineToPoint(context, rect.size.width - 10, 60);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.7 alpha:1.0].CGColor);
    CGContextStrokePath(context);
    CGContextMoveToPoint(context, 10, 120);
    CGContextAddLineToPoint(context, rect.size.width - 10, 120);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.7 alpha:1.0].CGColor);
    CGContextMoveToPoint(context, 10, 180);
    CGContextAddLineToPoint(context, rect.size.width - 10, 180);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.7 alpha:1.0].CGColor);
    CGContextStrokePath(context);
    CGContextMoveToPoint(context, 10, 240);
    CGContextAddLineToPoint(context, rect.size.width - 10, 240);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.7 alpha:1.0].CGColor);
    CGContextStrokePath(context);
    CGContextMoveToPoint(context, 10, 300);
    CGContextAddLineToPoint(context, rect.size.width - 10, 300);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.7 alpha:1.0].CGColor);
    CGContextStrokePath(context);
    
    _imageView = [UIImageView new];
    _imageView.frame = CGRectMake(45, 0, 60, 60);
    _imageView.layer.cornerRadius = 30;
    _imageView.layer.masksToBounds = YES;
    _imageView.image = [UIImage imageNamed:@"mainIcon.png"];
    _view_1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 65, rect.size.width, 60)];
    _view_2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 130, rect.size.width, 60)];
    _view_3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 195, rect.size.width, 60)];
    _View_4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 255, rect.size.width, 60)];
    _View_5 = [[UIButton alloc] initWithFrame:CGRectMake(0, 315, rect.size.width, 60)];
    _view_1.layer.cornerRadius = 5;
    _view_2.layer.cornerRadius = 5;
    _view_3.layer.cornerRadius = 5;
    _View_4.layer.cornerRadius = 5;
    _View_5.layer.cornerRadius = 5;
    [_view_1 setTitle:@"课程介绍" forState:UIControlStateNormal];
    [_view_2 setTitle:@"版本信息" forState:UIControlStateNormal];
    [_view_3 setTitle:@"意见反馈" forState:UIControlStateNormal];
    [_View_4 setTitle:@"计算器" forState:UIControlStateNormal];
    [_View_5 setTitle:@"常见问题" forState:UIControlStateNormal];
    
    [_view_1 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [_view_2 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [_view_3 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [_View_4 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [_View_5 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_imageView];
    [self addSubview:_view_1];
    [self addSubview:_view_2];
    [self addSubview:_view_3];
    [self addSubview:_View_4];
    [self addSubview:_View_5];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_Y - 30, MAIN_SCREEN_X, 30)];
    label.numberOfLines = 2;
    label.frame = CGRectMake(0, MAIN_SCREEN_Y - 130,self.frame.size.width, 60);
    label.text = @"版权所有©西电网络精灵实验室";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    [self addSubview:label];
}

-(void)buttonTouched:(UIButton *)button{
    if([button isEqual:_view_1]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"postCourseIntroduction" object:nil];
    }else if ([button isEqual:_view_2]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"版本信息"
                                                            message:@"Version 1.0.1"
                                                           delegate:self
                                                  cancelButtonTitle:@"返回"
                                                  otherButtonTitles: nil, nil];
        [alertView show];
    }else if([button isEqual:_view_3]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"欢迎您加入我们的意见反馈群：189578668"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"知道了", nil];
        [alertView show];
    }else if([button isEqual:_View_4]){
        [_delegate loadCalculateViewController];
    }else if ([button isEqual:_View_5]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"postProblemList" object:nil];
    }
}

@end
