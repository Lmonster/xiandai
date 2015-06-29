//
//  ForumViewController.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/5/15.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ForumViewSSController;
@class ForumViewTSController;

@interface ForumViewController : UITabBarController

@property (strong) ForumViewTSController *TeacherInfoViewController;

@property (strong) ForumViewSSController *aForumViewController;

@end
