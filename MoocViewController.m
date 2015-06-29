//
//  MoocViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/5/13.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "MoocViewController.h"
#import "playVedioViewController.h"

@interface MoocViewController ()

@end

@implementation MoocViewController{
    playVedioViewController *playController;
}

-(void)loadView{
    playController = [[playVedioViewController alloc] init];
    self.view = playController.view;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
