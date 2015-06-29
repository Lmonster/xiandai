//
//  ForumViewSSController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/22.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "ForumViewSSController.h"
#import "ConstantHeader.h"

@implementation ForumViewSSController{
    UIWebView *webView;
    NSURLRequest *request;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, MAIN_SCREEN_X, MAIN_SCREEN_Y)];
        webView.delegate = self;
        self.title = @"在线交流";
    }
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:webView];
    UISwipeGestureRecognizer *gesture_left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveWebView:)];
    gesture_left.direction = UISwipeGestureRecognizerDirectionLeft;
    [webView addGestureRecognizer:gesture_left];
    UISwipeGestureRecognizer *gesture_right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveWebView:)];
    gesture_right.direction = UISwipeGestureRecognizerDirectionLeft;
    [webView addGestureRecognizer:gesture_right];
    
    request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://xxdsapp.710071.net/luntan/forum.php"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    [webView loadRequest:request];
}

#pragma mark--
#pragma webView delegate

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"加载失败，稍后重试"
                                                delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}


- (void)moveWebView:(UISwipeGestureRecognizer *)gesture {
    if(gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        [webView goBack];
    }else {
        [webView goForward];
    }
}


@end
