//
//  AVplayControl.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/6.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "subPlaycontrolView.h"

@interface AVplayControl : AVPlayer<playControlDelegate>

@property (strong ,nonatomic) AVPlayerItem *nextPlayItem;

@property (strong ,nonatomic) AVPlayerItem *lastPlayerItem;

@property (strong ,nonatomic) AVPlayerItem *currentPlayerItem;

-(void)beginPlay;

@end
