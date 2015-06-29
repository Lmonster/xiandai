//
//  loadPDFViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/4.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "loadPDFViewController.h"
#import "ConstantHeader.h"

@interface loadPDFViewController ()

@end

@implementation loadPDFViewController{
    UINavigationBar *navigationBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadThePDFView{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,MAIN_SCREEN_X , MAIN_SCREEN_Y)];
    [_webView loadRequest:[NSURLRequest requestWithURL:_filePath]];
    [self.view addSubview:_webView];
    [self loadNavigationBar];
}

-(void)loadNavigationBar{
    navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_X, 60)];
    navigationBar.tintColor = WHITE_COLOR;
    navigationBar.barTintColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    UINavigationItem *items = [[UINavigationItem alloc] init];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backToUpView)];
    items.leftBarButtonItem = backButton;
    [navigationBar pushNavigationItem:items animated:YES];
    [self.view addSubview:navigationBar];
}

-(void)backToUpView{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
