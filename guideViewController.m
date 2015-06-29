//
//  guideViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/4.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "guideViewController.h"
#import "ConstantHeader.h"

@interface guideViewController ()

@end

@implementation guideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadThePDF{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_X, MAIN_SCREEN_Y)];
    [self.view addSubview:_webView];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"guide" ofType:@"pdf"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/guide.pdf"]]){
        
    }else{
        [fileManager moveItemAtPath:filePath toPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/guide.pdf"] error:nil];
    }
//    filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/guide.pdf"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    [_webView loadRequest:[NSURLRequest requestWithURL:fileURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10]];
    fileURL = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
