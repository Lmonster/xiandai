//
//  loadPDFViewController.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/4.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loadPDFViewController : UIViewController

@property (strong ,nonatomic) UIWebView *webView;

@property (strong ,nonatomic) NSURL *filePath;

-(void)loadThePDFView;
@end
