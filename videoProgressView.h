//
//  videoProgressView.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/9.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^aBlk)(void);

@interface videoProgressView : UIView

@property (strong) UIProgressView *progress;

//@property (strong) UILabel *labelLeft;

@property (strong) UILabel *labelRight;

@property (weak) AVPlayer *player;

@property (assign) float duration;

@property (strong,nonatomic) UIButton *duangButton;

@property (assign) BOOL isRorate;

-(void)addPLayerObsever:(AVPlayer *)aPlayer;

@end
