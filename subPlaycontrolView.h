//
//  subPlaycontrolView.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/6.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol playControlDelegate <NSObject>
@required
-(void)beginPlay;

-(void)beginPause;

-(void)nextVideo;

-(void)lastVideo;

-(void)playWithRate:(float)rate;

@end

@interface subPlaycontrolView : UIView

#define PLAYNORMAL      1

#define PAUSE           0

#define PLAYFASTRATE(X)     X*100

#define MOSTFASTRATE    400


@property (weak , nonatomic) id<playControlDelegate> delegate;

-(void)setButtons;


@end
