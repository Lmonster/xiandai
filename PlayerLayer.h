//
//  PlayerLayer.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/6.
//  Copyright (c) 2015年 付国强. All rights reserved.
//


//  这是一个自定义的UIView，他的Layer是AVLayer。他有私有变量:控制视频的View，显示视频信息的View,以及AVPlayer用来控制视频的播放的情况
#ifndef AVPLAYCONTROL
#define AVPLAYCONTROL
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "videoProgressView.h"
#import "AVplayControl.h"

#endif

@class subPlaycontrolView;
@class videoProgressView;



@interface PlayerLayer : UIView

@property (strong) UIActivityIndicatorView *activeView;

@property (strong) subPlaycontrolView * playControlView;

@property (strong) AVplayControl *player;//AVPlayer的子类

@property (strong) videoProgressView *infoView; //视频信息View



@end
