//
//  ForumViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/5/15.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "ForumViewController.h"
#import "ForumTSViewController.h"
#import "ForumViewSSController.h"

@interface ForumViewController ()

@end

@implementation ForumViewController{
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _TeacherInfoViewController = [[ForumViewTSController alloc] init];
    _aForumViewController = [[ForumViewSSController alloc] init];
    NSLog(@"%@",_TeacherInfoViewController);
    NSLog(@"%@",_aForumViewController);
    if(_TeacherInfoViewController && _aForumViewController)
        self.viewControllers = @[_TeacherInfoViewController,_aForumViewController];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
