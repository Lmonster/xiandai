//
//  webViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/6/24.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "webViewController.h"

@interface webViewController ()

@end

@implementation webViewController {
    UIWebView *webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)beginLoad:(NSString *)fileName {
    [self.view addSubview:webView];
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
