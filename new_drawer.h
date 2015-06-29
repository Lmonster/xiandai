//
//  new_drawer.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/3/2.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol drawViewDelegate <NSObject>

-(void)loadCalculateViewController;

@end

@interface new_drawer : UIView

@property (strong ,nonatomic) UIButton *view_1;

@property (strong ,nonatomic) UIButton *view_2;

@property (strong ,nonatomic) UIButton *view_3;

@property (strong ,nonatomic) UIButton *View_4;

@property (strong ,nonatomic) UIButton *View_5;

@property (strong ,nonatomic) UIImageView *imageView;

@property (weak) id<drawViewDelegate> delegate;


@end
