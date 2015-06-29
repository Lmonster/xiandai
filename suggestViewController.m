//
//  suggestViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/15.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "suggestViewController.h"
#import "AFNetworkReachabilityManager.h"

@interface suggestViewController ()

@end

@implementation suggestViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"page_5"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setScrollView];
    [self setLabelView];
    [self setTextView];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"NetConnectStatus"] intValue] == AFNetworkReachabilityStatusNotReachable){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"设备没有联网，怎么吐槽？" delegate:nil
                                                  cancelButtonTitle:@"返回"
                                                  otherButtonTitles: nil, nil];
        [alertView show];
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"说明" style:UIBarButtonItemStylePlain target:self action:@selector(pushExplainView)];

    // Do any additional setup after loading the view.
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"page_5"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma 初始化视图
-(void)setScrollView{
    _scrollView = [UIScrollView new];
    _scrollView.frame = CGRectMake(0, 0, MAIN_SCREEN_X, MAIN_SCREEN_Y);
    _scrollView.contentSize = CGSizeMake(MAIN_SCREEN_X, MAIN_SCREEN_Y + 100);
    _scrollView.backgroundColor = [UIColor colorWithRed:1 green:192/255. blue:203/255 alpha:1.0];
    _scrollView.delegate = self;
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer new];
    [gesture addTarget:self action:@selector(resignResponder)];
    [_scrollView addGestureRecognizer:gesture];
    [self.view addSubview:_scrollView];
    _confirm_button = [UIButton new];
    _confirm_button.frame = CGRectMake(170, 500, 120, 30);
    _confirm_button.backgroundColor = GRAY_COLOR;
    _confirm_button.layer.cornerRadius = 5;
    [_confirm_button setTitle:@"提交" forState:UIControlStateNormal];
    [_confirm_button addTarget:self action:@selector(sendMail) forControlEvents:UIControlEventTouchDown];
    [_scrollView addSubview:_confirm_button];
}

-(void)setLabelView{
    _label_1 = [UILabel new];
    _label_2 = [UILabel new];
    _label_3 = [UILabel new];
    _label_4 = [UILabel new];
    _label_1.frame = CGRectMake(5, 20, 120, 50);
    _label_2.frame = CGRectMake(5, 100, 120, 50);
    _label_3.frame = CGRectMake(5, 180, 120, 50);
    _label_4.frame = CGRectMake(5, 260, 120, 50);
    _array = [NSArray arrayWithObjects:_label_1,_label_2,_label_3,_label_4, nil];
    for(int i = 0 ; i<4; i++){
        ((UILabel *)[_array objectAtIndex:i]).textColor = WHITE_COLOR;
        ((UILabel *)[_array objectAtIndex:i]).font = [UIFont fontWithName:@"STHeiti-Light" size:100];
        [self.scrollView addSubview:[_array objectAtIndex:i]];
    }
    _label_1.text = @"邮箱";
    _label_2.text = @"邮箱密码";
    _label_3.text = @"标题";
    _label_4.text = @"我要吐槽";
}

-(void)setTextView{
    _array = nil;
    _textField_1 = [UITextField new];
    _textField_2 = [UITextField new];
    _textField_3 = [UITextField new];
    _textField_4 = [UITextField new];
    _array = [NSArray arrayWithObjects:_textField_1,_textField_2,_textField_3, nil];
//    _textField_1.text = [NSString stringWithFormat:@"@%@.com",_suffix_mail];
    for(int i = 0 ;i< 4; i++){
        if(i != 3){
            ((UITextField *)[_array objectAtIndex:i]).frame = CGRectMake(100, 30 + i * 80, 200, 30);
            ((UITextField *)[_array objectAtIndex:i]).backgroundColor = WHITE_COLOR;
            ((UITextField *)[_array objectAtIndex:i]).keyboardType = UIKeyboardTypeEmailAddress;
            ((UITextField *)[_array objectAtIndex:i]).delegate = self;
            [self.scrollView addSubview:[_array objectAtIndex:i]];
        }else{
            _infoTextView = [UITextView new];
            _infoTextView.frame = CGRectMake(100, 30 + i * 80, 200, 200);
            _infoTextView.delegate = self;
            [self.scrollView addSubview:_infoTextView];
        }
    }
}

#pragma mark --
#pragma UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    _scrollView.contentSize = CGSizeMake(MAIN_SCREEN_X, MAIN_SCREEN_Y + 100);
    if(IS_IPHONE5_OR_S_C)
        _scrollView.contentOffset = CGPointMake(0, 140);
    else
        _scrollView.contentOffset = CGPointMake(0, 90);
}

-(void)resignResponder{
    [_textField_1 resignFirstResponder];
    [_textField_2 resignFirstResponder];
    [_textField_3 resignFirstResponder];
    [_infoTextView resignFirstResponder];
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.contentSize = CGSizeMake(MAIN_SCREEN_X, MAIN_SCREEN_Y + 100);
}


#pragma mark --
#pragma 按钮的方法
-(void)sendMail{
    _messager = [SKPSMTPMessage new];
    _messager.delegate = self;
    _messager.toEmail = @"2695851920@qq.com";
    _messager.fromEmail = _textField_1.text;
    _messager.login = _textField_1.text;
    _messager.pass = _textField_2.text;
    _messager.subject = _textField_3.text;
    if([_textField_1.text hasSuffix:@"cn"])
        _messager.relayHost = [NSString stringWithFormat:@"smtp.%@.cn",_suffix_mail];
    else
        _messager.relayHost = [NSString stringWithFormat:@"smtp.%@.com",_suffix_mail];
    _messager.wantsSecure = YES;
    _messager.requiresAuth = YES;
    NSLog(@"%@",_messager.relayHost);
    NSDictionary * plainPart=[NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,_infoTextView.text,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey, nil];
    _messager.parts = @[plainPart];
    [_messager send];
    _activityView = [UIActivityIndicatorView new];
    _activityView.frame = CGRectMake(145, 503, 20, 20);
    [_activityView startAnimating];
    [self.scrollView addSubview:_activityView];
    NSLog(@"%@",_textField_4.text);
}

-(void)pushExplainView{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"说明" message:@"1.您的账号密码我们无权获取，请放心输入。\n2.如若多次尝试失败，请检查您的邮箱是否开启了smtp功能（您要不知道什么是smtp请自行goole）。\n3.非常感谢您对我们产品的支持，欢迎多多吐槽.(人身攻击就免了)" delegate:nil cancelButtonTitle:@"明白了" otherButtonTitles:nil, nil];
    [alertView show];
}


#pragma mark --
#pragma SKPSMTPMessageDeleate
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    [_activityView stopAnimating];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"❌" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"算了，不忍心吐槽。" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)messageSent:(SKPSMTPMessage *)message{
    [_activityView stopAnimating];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"吐槽成功，我们的程序员会更加努力的" message:@"😊" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
    [alertView show];
}


@end
