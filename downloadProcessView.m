//
//  downloadProcessView.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/6/23.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "downloadProcessView.h"

@implementation downloadProcessView {
    BOOL isDowload;
    float process;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(manageTap)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)manageTap {
    
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context,process,0);
}



@end
