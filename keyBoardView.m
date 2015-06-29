//
//  keyBoardView.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/24.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "keyBoardView.h"
#import "ConstantHeader.h"

@implementation keyBoardView


#pragma mark --
#pragma 方法的重写
-(void)drawRect:(CGRect)rect{
    if(IS_IPHONE5_OR_S_C){
        for(int i = 0 ;i < 6;i ++)
            for(int j = 0 ;j < 5; j++)
            {
                if(i == 0 && j == 4){
                    break;
                }
                if(i == 0 && j == 3){
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(62.4 * j + 2 * j, i * 48.5  + i * 10, 62.4 * 2, 48.5)];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%d",i * 5 + j]] forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%dS",i * 5 + j]] forState:UIControlStateHighlighted];
                    button.tag = i * 5 + j;
                    [button addTarget:self action:@selector(buttonDidTouched:) forControlEvents:UIControlEventTouchDown];
                    [self addSubview:button];
                }else{
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(62.4 * j + 2 * j, i * 48.5 + i * 10, 62.4, 48.5)];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%d",i * 5 + j]] forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%dS",i * 5 + j]] forState:UIControlStateHighlighted];
                    button.tag = i * 5 + j;
                    [button addTarget:self action:@selector(buttonDidTouched:) forControlEvents:UIControlEventTouchDown];
                    [self addSubview:button];
                }
            }

    }
    else if (IS_IPHONE6){
        for(int i = 0 ;i < 6;i ++)
            for(int j = 0 ;j < 5; j++)
            {
                if(i == 0 && j == 4){
                    break;
                }
                if(i == 0 && j == 3){
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(73.4 * j + 2 * j, i * 63.5  + i * 10, 73.4 * 2, 63.5)];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%d",i * 5 + j]] forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%dS",i * 5 + j]] forState:UIControlStateHighlighted];
                    button.tag = i * 5 + j;
                    [button addTarget:self action:@selector(buttonDidTouched:) forControlEvents:UIControlEventTouchDown];
                    [self addSubview:button];
                }else{
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(73.4 * j + 2 * j, i * 63.5 + i * 10, 73.4, 63.5)];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%d",i * 5 + j]] forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%dS",i * 5 + j]] forState:UIControlStateHighlighted];
                    button.tag = i * 5 + j;
                    [button addTarget:self action:@selector(buttonDidTouched:) forControlEvents:UIControlEventTouchDown];
                    [self addSubview:button];
                }
            }
    }else if(IS_IPHONE6_PLUS){
        for(int i = 0 ;i < 6;i ++)
            for(int j = 0 ;j < 5; j++)
            {
                if(i == 0 && j == 4){
                    break;
                }
                if(i == 0 && j == 3){
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(81.4 * j + 2 * j, i * 72.5  + i * 10, 81.4 * 2, 72.5)];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%d",i * 5 + j]] forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%dS",i * 5 + j]] forState:UIControlStateHighlighted];
                    button.tag = i * 5 + j;
                    [button addTarget:self action:@selector(buttonDidTouched:) forControlEvents:UIControlEventTouchDown];
                    [self addSubview:button];
                }else{
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(81.4 * j + 2 * j, i * 72.5 + i * 10, 81.4, 72.5)];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%d",i * 5 + j]] forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%dS",i * 5 + j]] forState:UIControlStateHighlighted];
                    button.tag = i * 5 + j;
                    [button addTarget:self action:@selector(buttonDidTouched:) forControlEvents:UIControlEventTouchDown];
                    [self addSubview:button];
                }
            }

    }else if (IS_IPHONE4_OR_S){
        for(int i = 0 ;i < 6;i ++)
            for(int j = 0 ;j < 5; j++)
            {
                if(i == 0 && j == 4){
                    break;
                }
                if(i == 0 && j == 3){
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(62.4 * j + 2 * j, i * 35.5  + i * 8, 62.4 * 2, 35.5)];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%d",i * 5 + j]] forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%dS",i * 5 + j]] forState:UIControlStateHighlighted];
                    button.tag = i * 5 + j;
                    [button addTarget:self action:@selector(buttonDidTouched:) forControlEvents:UIControlEventTouchDown];
                    [self addSubview:button];
                }else{
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(62.4 * j + 2 * j, i * 35.5 + i * 8, 62.4, 35.5)];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%d",i * 5 + j]] forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%dS",i * 5 + j]] forState:UIControlStateHighlighted];
                    button.tag = i * 5 + j;
                    [button addTarget:self action:@selector(buttonDidTouched:) forControlEvents:UIControlEventTouchDown];
                    [self addSubview:button];
                }
            }

    }
}


#pragma mark --
#pragma 自定义的方法
-(void)buttonDidTouched:(UIButton *)button{
    int type = (int)button.tag;
    /**
    type <= 4 || type >= 0 || type == 6 分别对应着 转置 逆  特征值 伴随矩阵 sqrt
    type == 5 || type == 13  || type == 18 || type == 23 || type == 28 对应着加，减，乘，除
     
     */
    if( (type <= 4 && type >= 0) || type == 29){
        [_delegate sendCaculationInfo:type];
        
    }else if (type == 5 ||
              type == 13  ||
              type == 18 ||
              type == 23 ||
              type == 28){
        [_delegate sendCaculationInfo:type];
        
    }else if ((type <= 12 && type >= 10) ||
              (type <= 17 && type >= 15) ||
              (type <= 22 && type >= 20) ||
              (type <= 27 && type >= 25) ||
              (type == 8)){
        if(type <= 12 && type >= 10)
            [_delegate sendNumberInfo:(type - 3)];
        if(type <= 17 && type >= 15)
            [_delegate sendNumberInfo:(type - 11)];
        if(type <= 22 && type >= 20)
            [_delegate sendNumberInfo:(type - 19)];
        if(type == 26)
            [_delegate sendNumberInfo:0];
        if(type == 8)
            [_delegate sendNumberInfo:DELETE_SIGN];
        if(type == 25)
            [_delegate sendNumberInfo:MINUS_SIGN];
        if(type == 27)
            [_delegate sendNumberInfo:POINT];
    }else if (type == 7){
        [_delegate sendCleanInfo];
        
    }else if (type == 9 ||
              type == 14 ||
              type == 19 ||
              type == 24){
        [_delegate sendMovaInfo:type];
    }
}

-(void)dealloc{
    NSLog(@"keyBoard is dealloced");
}

@end
