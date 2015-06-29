//
//  ConstantHeader.h
//  linearAlgebra
//
//  Created by WorkSpace_付国强 on 14/12/26.
//  Copyright (c) 2014年 付国强. All rights reserved.
//

#ifndef linearAlgebra_ConstantHeader_h
#define linearAlgebra_ConstantHeader_h


#endif

#define MAIN_SCREEN_RECT                     [[UIScreen mainScreen] bounds]
#define MAIN_SCREEN_X                        [[UIScreen mainScreen] bounds].size.width
#define MAIN_SCREEN_Y                        [[UIScreen mainScreen] bounds].size.height

#define WHITE_COLOR                     [UIColor whiteColor]
#define BLACK_COLOR                     [UIColor blackColor]
#define ORANGE_COLOR                    [UIColor orangeColor]
#define GRAY_COLOR                      [UIColor grayColor]
#define BLUE_COLOR                      [UIColor blueColor]


#define TRANSPOSITION                0
#define INVERSE                      1
#define CONJUGATE                    2
#define ADJOINT                      3
#define EIGENVALUE                   4


#define PLUS                      23
#define MINUS                     18
#define MULTI                     13
#define DIVISION                  28

#define IS_IPHONE6            CGRectEqualToRect([[UIScreen mainScreen] bounds],CGRectMake(0,0,375,667))
#define IS_IPHONE5_OR_S_C     CGRectEqualToRect([[UIScreen mainScreen] bounds],CGRectMake(0,0,320,568))
#define IS_IPHONE4_OR_S       CGRectEqualToRect([[UIScreen mainScreen] bounds],CGRectMake(0,0,320,480))
#define IS_IPHONE6_PLUS       CGRectEqualToRect([[UIScreen mainScreen] bounds],CGRectMake(0,0,414,736))

#define APP_VERSION           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

