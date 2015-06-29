//
//  suggestViewController.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/15.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

@interface suggestViewController : UIViewController<SKPSMTPMessageDelegate,UIAlertViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (strong ,nonatomic) SKPSMTPMessage *messager;

@property (strong ,nonatomic) UIScrollView *scrollView;

@property (strong ,nonatomic) UILabel *label_1;

@property (strong ,nonatomic) UILabel *label_2;

@property (strong ,nonatomic) UILabel *label_3;

@property (strong ,nonatomic) UILabel *label_4;

@property (strong ,nonatomic)UITextField *textField_1;

@property (strong ,nonatomic)UITextField *textField_2;

@property (strong ,nonatomic)UITextField *textField_3;

@property (strong ,nonatomic)UITextField *textField_4;

@property (strong ,nonatomic) NSArray *array;

@property (strong ,nonatomic) UIButton *confirm_button;

@property (strong ,nonatomic) UITextView *infoTextView;

@property (strong ,nonatomic) NSString *suffix_mail;

@property (strong ,nonatomic) UIActivityIndicatorView *activityView;

@end
