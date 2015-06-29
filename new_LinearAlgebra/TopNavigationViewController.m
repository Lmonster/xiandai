//
//  TopNavigationViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/9.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "TopNavigationViewController.h"

@interface TopNavigationViewController ()

@end

@implementation TopNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

#pragma mark --
#pragma 设置特定的外观
-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
