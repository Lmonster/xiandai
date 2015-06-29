//
//  videoProgressView.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/9.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "videoProgressView.h"

@implementation videoProgressView{
}

@synthesize progress = progress;
@synthesize labelRight = labelRight;
//@synthesize labelLeft = labelLeft;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark --
#pragma 初始化（有frame的限制）
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    float height = frame.size.height;
    float width = frame.size.width;
    if(self){
        progress = [[UIProgressView alloc] initWithFrame:CGRectMake(50, height/2 ,width - 80, height/8)];
        
        labelRight = [[UILabel alloc] initWithFrame:CGRectMake(width-40, height/4, 40, height/2)];
        self.duangButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height/4, 40, height/2)];
        [_duangButton setImage:[UIImage imageNamed:@"allScreen"] forState:UIControlStateNormal];
        _isRorate = NO;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    labelRight.textColor = [UIColor blackColor];
    labelRight.font = [UIFont fontWithName:@"Helvetica" size:10];
//    [self addSubview:progress];
    [self addSubview:labelRight];
    [self addSubview:self.duangButton];
    [_duangButton addTarget:self action:@selector(rotateView) forControlEvents:UIControlEventTouchDown];
}


#pragma mark--
#pragma 添加Observer
-(void)addPLayerObsever:(AVPlayer *)aPlayer{
    _player = aPlayer;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) usingBlock:^(CMTime time){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.labelRight.text = [NSString stringWithFormat:@"%f",(float)time.value/time.timescale];
            if(_duration){
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.progress.progress = (float)time.value/time.timescale/_duration;
                });
            }
            else
                self.progress.progress = 0;
        });
    }];
}

-(void)rotateView{
    _isRorate = !_isRorate;
    NSNumber *isRotate = [NSNumber numberWithBool:_isRorate];
    NSDictionary *postInfo =  @{@"isRotate":isRotate};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rotateView" object:self userInfo:postInfo];
}



@end
