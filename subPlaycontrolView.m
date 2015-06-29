//
//  subPlaycontrolView.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/6.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "subPlaycontrolView.h"
#import "ConstantHeader.h"

@implementation subPlaycontrolView{
    UIButton *playButton;
    UIButton *playFastbButton;
    UIButton *playSlowButton;
    UIButton *nextButton;
    UIButton *lastButton;
}

-(instancetype)init{
    self = [super init];
    if(self){
        if(self.frame.origin.x ||
           self.frame.origin.y ||
           self.frame.size.height ||
           self.frame.size.width){
            self = [self initWithFrame:self.frame];
        }else{
           self = [self initWithFrame:CGRectMake(0, MAIN_SCREEN_Y - 40, MAIN_SCREEN_X, 40)];
        }
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    float squartWidth = frame.size.width / 5.;
    float squartHeight = frame.size.height;
    if(self){
        
        playButton = [[UIButton alloc] initWithFrame:CGRectMake(squartWidth * 2, 10, 55, 30)];
        playFastbButton = [[UIButton alloc] initWithFrame:CGRectMake(squartWidth * 3, 10, 55, 30)];
        playSlowButton = [[UIButton alloc] initWithFrame:CGRectMake(squartWidth * 1, 0, squartWidth, squartHeight)];
        nextButton = [[UIButton alloc] initWithFrame:CGRectMake(squartWidth * 4, 10, 55, 30)];
        lastButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 55, 30)];
        playButton.tag = PLAYNORMAL;
        playFastbButton.tag = PLAYFASTRATE(1);
        
        [playButton addTarget:self action:@selector(playOrPause:) forControlEvents:UIControlEventTouchDown];
        [playFastbButton addTarget:self action:@selector(playFast:) forControlEvents:UIControlEventTouchDown];
        [nextButton addTarget:self action:@selector(playNext) forControlEvents:UIControlEventTouchDown];
        [lastButton addTarget:self action:@selector(playLast) forControlEvents:UIControlEventTouchDown];
        
        [playButton setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        [playFastbButton setImage:[UIImage imageNamed:@"playFast"] forState:UIControlStateNormal];
        [playSlowButton setImage:[UIImage imageNamed:@"playSlow"] forState:UIControlStateNormal];
        [nextButton setImage:[UIImage imageNamed:@"nextPlay"] forState:UIControlStateNormal];
        [lastButton setImage:[UIImage imageNamed:@"lastPlay"] forState:UIControlStateNormal];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [self addSubview:playSlowButton];
    [self addSubview:playFastbButton];
    [self addSubview:playButton];
    [self addSubview:nextButton];
    [self addSubview:lastButton];
}

-(void)playOrPause:(UIButton*)button{
    button.tag = !button.tag;
    if((int)button.tag == PLAYNORMAL){
        [_delegate beginPlay];
        [button setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }else{
        [_delegate beginPause];
        [button setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
}

-(void)playFast:(UIButton *)button{
    int rate = (int)button.tag / 100;
    if(rate < 4){
        rate ++;
    }else{
        rate = 1;
    }
    button.tag = PLAYFASTRATE(rate);
    [_delegate playWithRate:rate];
}

-(void)playNext{
    [_delegate nextVideo];
}

-(void)playLast{
    [_delegate lastVideo];
}

-(void)setButtons{
    CGRect frame = self.frame;
    float squartWidth = frame.size.width / 5.;
    float squartHeight = frame.size.height;
    playButton.frame = CGRectMake(squartWidth * 2, 0, squartWidth, squartHeight);
    nextButton.frame = CGRectMake(squartWidth * 4, 0, squartWidth, squartHeight);
    playFastbButton.frame = CGRectMake(squartWidth * 3, 0 , squartWidth, squartHeight);
    lastButton.frame = CGRectMake(0, 0, squartWidth, squartHeight);
    playSlowButton.frame = CGRectMake(squartWidth * 1, 0, squartWidth, squartHeight);
    [playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [playButton setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
    [playFastbButton setTitle:@"快进" forState:UIControlStateNormal];
    [playFastbButton setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
    [playSlowButton setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
    [playSlowButton setTitle:@"快退" forState:UIControlStateNormal];
    [nextButton setTitle:@"下一曲" forState:UIControlStateNormal];
    [nextButton setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
    [lastButton setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
    [lastButton setTitle:@"上一曲" forState:UIControlStateNormal];
    self.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.7];
}
@end
