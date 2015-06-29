//
//  playVedioViewController.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/8.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerLayer.h"
@class PlayerLayer;

@interface playVedioViewController : UIViewController

@property (strong) PlayerLayer *playerLayer;

@property (assign) BOOL isMooc;

@end
