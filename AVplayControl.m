//
//  AVplayControl.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/6.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "AVplayControl.h"
@implementation AVplayControl{
}

#pragma mark --
#pragma playControlDelegate
-(instancetype)init{
    self = [super init];
    if(self){
        self.rate = 1.0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playToEndTime) name:@"AVPlayerItemDidPlayToEndTimeNotification" object:nil];
    }
    return self;
}


-(void)beginPlay{
    [self play];
}

-(void)beginPause{
    [self pause];
}

-(void)playWithRate:(float)rate{
    self.rate = rate;
    NSLog(@"playRate:%f",rate);
}

-(void)nextVideo{
    [self replaceCurrentItemWithPlayerItem:_nextPlayItem];
}

-(void)lastVideo{
    [self replaceCurrentItemWithPlayerItem:_lastPlayerItem];
}

-(void)playToEndTime{
    [self seekToTime:CMTimeMake(0, 1) completionHandler:^(BOOL finish){
        NSLog(@"playToEndTime");
    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}






@end
