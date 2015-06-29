//
//  PDFViewContoller.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/3.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PDFViewContoller :UIPageViewController





-(instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary *)options filePath:(NSString *)filePath;

@end
