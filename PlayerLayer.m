//
//  PlayerLayer.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/6.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "PlayerLayer.h"
#import "ConstantHeader.h"
#import "AVplayControl.h"
#import "videoProgressView.h"


@implementation PlayerLayer{
    
    @private
    BOOL ifShowControlView;//控制是否显示控制layer
    NSTimer *timer;
    BOOL isRotate;
}

@synthesize playControlView = playControlView;
@synthesize infoView = infoView;

- (instancetype)init{
    self = [super init];
    if(self){
        ifShowControlView = YES;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    float playViewWidth = frame.size.width;
    float playViewHeight = frame.size.height;
    if(self){
        isRotate = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotate:) name:@"rotateView" object:nil];
        
//        生成核心的player
        AVAsset *asset = [AVAsset assetWithURL:[[NSBundle mainBundle] URLForResource:@"mooc1" withExtension:@"mp4"]];
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:asset];
        self.player = [[AVplayControl alloc] initWithPlayerItem:item];
        [self.player pause];
   
        
//      加载上下两个界面
        
        ifShowControlView = YES;
        playControlView = [[subPlaycontrolView alloc] initWithFrame:CGRectMake(0, playViewWidth * (3./4.), playViewWidth, playViewHeight / 4.)];
        infoView = [[videoProgressView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, playViewHeight / 4)];
        self.infoView.layer.delegate = self.infoView;
        self.playControlView.layer.delegate = self.playControlView;
        self.playControlView.delegate = self.player;
        [infoView addPLayerObsever:self.player];
        
        
//          添加加载的控件
        _activeView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(playViewWidth * (1/3.), playViewHeight * (1/4.), playViewHeight / 3., playViewHeight / 2.)];
        _activeView.alpha = 0;
        
        
//        添加手势识别器
        UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swip:)];
        leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        UISwipeGestureRecognizer * rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swip:)];
        rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:leftGesture];
        [self addGestureRecognizer:rightGesture];
    }
    return self;
}



-(void)drawRect:(CGRect)rect{
    playControlView.backgroundColor = BLACK_COLOR;
    playControlView.alpha = 0.7;
    infoView.backgroundColor = BLACK_COLOR;
    infoView.alpha = 0.7;
    [self ifShowPlayControl:ifShowControlView];
    if(ifShowControlView){
        [self addSubview:playControlView];
        [self addSubview:_activeView];
        [self addSubview:infoView];
    }
    [self addPlayerObserver];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    ifShowControlView = !ifShowControlView;
    [self ifShowPlayControl:ifShowControlView];
}


-(void)ifShowPlayControl:(BOOL)show{
    if(show){
        timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(checkControlView) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [UIView animateWithDuration:0.5
                              delay:0.1
             usingSpringWithDamping:0.5
              initialSpringVelocity:5
                            options:0
                         animations:^{
                             if(!isRotate){
                                 playControlView.frame = CGRectMake(0, self.frame.size.height *(3/4.), self.frame.size.width, 40);
                                 infoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/4);
                                 playControlView.alpha = 0.7;
                                 infoView.alpha = 0.7;
                             }else{
                                 playControlView.frame = CGRectMake(0, MAIN_SCREEN_X - 40, MAIN_SCREEN_Y, self.frame.size.height /6.);
                                 infoView.frame = CGRectMake(0,0, self.frame.size.height, 40);
                                 playControlView.alpha = 0.7;
                                 infoView.alpha = 0.7;
                             }
                         }
                         completion:^(BOOL fnish){}];
    }else{
        [timer invalidate];
        timer = nil;
       [UIView animateWithDuration:0.5
                             delay:0.1
            usingSpringWithDamping:0.5
             initialSpringVelocity:5
                           options:0
                        animations:^{
                            playControlView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 0);
                            infoView.frame = CGRectMake(0, 0, self.frame.size.width, 0);
                            playControlView.alpha = 0;
                            infoView.alpha = 0;
                        }
                        completion:^(BOOL finish){
                        }];
    }
}


-(void)checkControlView{
    if(ifShowControlView){
        ifShowControlView = !ifShowControlView;
        [self ifShowPlayControl:ifShowControlView];
    }else{
        [timer invalidate];
        timer = nil;
    }
}

#pragma mark --
#pragma 将其设置为AVPlayerLayer
+(Class)layerClass{
    return [AVPlayerLayer class];
}

-(AVPlayer *)player{
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}


#pragma amrk --
#pragma 手势
-(void)swip:(UISwipeGestureRecognizer *)gesture{
    float currentTime = (float)self.player.currentTime.value/self.player.currentTime.timescale;
    if(gesture.direction == UISwipeGestureRecognizerDirectionLeft){
        if(currentTime <= 30){
            [self.player seekToTime:CMTimeMake(0, 10) completionHandler:^(BOOL finish){
            }];}else{
                [self.player seekToTime:CMTimeMake(self.player.currentTime.timescale*(currentTime-30), self.player.currentTime.timescale)];
            }
    }else if(gesture.direction == UISwipeGestureRecognizerDirectionRight){
        [self.player seekToTime:CMTimeMake(self.player.currentTime.timescale*(currentTime+30), self.player.currentTime.timescale)];
    }
}

#pragma mark --
#pragma 旋转屏幕
-(void)rotate:(NSNotification *)notic{
    CGRect frame = self.frame;
//    float playViewWidth = frame.size.width;
    float playViewHeight = frame.size.height;
    isRotate = [[[notic userInfo] objectForKey:@"isRotate"] boolValue];
    if(isRotate){
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        self.layer.transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
        self.frame = CGRectMake(0, 0, MAIN_SCREEN_X, MAIN_SCREEN_Y);
        self.infoView.frame = CGRectMake(0, 0,MAIN_SCREEN_Y,40);
        self.playControlView.frame = CGRectMake(0, MAIN_SCREEN_X -40, MAIN_SCREEN_Y, 40);
        [self.playControlView setButtons];
    }else{
        self.layer.transform = CATransform3DIdentity;
        self.infoView.frame = CGRectMake(0, 0, frame.size.width, playViewHeight / 4);
        self.playControlView.frame = CGRectMake(0, playViewHeight *(3./4.),MAIN_SCREEN_X, playViewHeight / 4.);
        self.frame = CGRectMake(0, 60, MAIN_SCREEN_X, 200);
        [self.playControlView setButtons];
    }
}


#pragma mark --
#pragma 更新播放数据
-(void)addPlayerObserver{
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 10)
                                              queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
                                         usingBlock:^(CMTime time){
                                         }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





@end
