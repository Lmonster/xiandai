//
//  ECoursewareViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/6.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "ECoursewareViewController.h"
#import "DownloadCoursewareViewController.h"
#import "playVedioViewController.h"
#import "ConstantHeader.h"
#import "AVplayControl.h"

@interface ECoursewareViewController ()

@end

@implementation ECoursewareViewController{
    UINavigationBar *navigationBar;
    DownloadCoursewareViewController *controller0;
    
}

#pragma mark --
#pragma 初始化

-(instancetype)init{
    self = [super init];
    if(self){
        controller0 = [[DownloadCoursewareViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenBar:) name:@"rotateView" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_X, 60)];
    navigationBar.barTintColor = [UIColor colorWithWhite:0.3 alpha:0.7];
    navigationBar.tintColor = [UIColor whiteColor];
    UINavigationItem *items = [[UINavigationItem alloc] init];
    items.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backToMainView)];
    [navigationBar pushNavigationItem:items animated:YES];
    
    
    controller0.view.frame = CGRectMake(0, 60, MAIN_SCREEN_X, MAIN_SCREEN_Y);
    [self addChildViewController:controller0];
    [self.view addSubview:controller0.view];
    [self.view addSubview:navigationBar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark --
#pragma 返回到上一个界面

-(void)backToMainView{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
}


#pragma mark --
#pragma 界面的旋转
-(void)viewChanging:(NSNotification *)noti{
}

-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

-(void)hiddenBar:(NSNotification *)notic{
    if([[[notic userInfo] objectForKey:@"isRotate"] boolValue])
        navigationBar.hidden = YES;
    else
        navigationBar.hidden = NO;
}



@end
