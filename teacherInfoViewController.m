//
//  teacherInfoViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/2.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "teacherInfoViewController.h"
#import "ConstantHeader.h"
#import "MobClick.h"

#define TEACHER_NAME_LIST         @[@"高淑萍",@"马建荣",@"张鹏鸽",@"刘振华",@"陈怀琛",@"张海琴",@"刘建强",@"张友乐"]
#define TEACHER_PHONE             @[@"029-88202875",@"🈚️",@"🈚️",@"🈚️",@"🈚️",@"🈚️",@"🈚️",@"🈚️"]

#define TEACHER_MAIL              @[@"gaosp@mail.xidian.edu.cn",@"majianrongj@126.com",@"pgzhang@mail.xidian.edu.cn",@"：zh_liu#mail.xidian.edu.cn",@"hchchen@xidian.edu.cn",@"🈚️",@"🈚️",@"🈚️"]

@interface teacherInfoViewController ()

@end

@implementation teacherInfoViewController{
    UIAlertView *alertView_1;
    UIAlertView *alertView_2;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"page_teachaer_info"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人主页";
    _teacherImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 70, 100, 100)];
    _telephone = [[UILabel alloc] initWithFrame:CGRectMake(120, 75, 50, 50)];
    _eMail = [[UILabel alloc] initWithFrame:CGRectMake(120, 120, 50, 50)];
    _teacherInfo = [[UILabel alloc] initWithFrame:CGRectMake(5, 180, 120, 20)];
    _teacherDescription = [[UITextView alloc] initWithFrame:CGRectMake(5, 200, MAIN_SCREEN_X - 10, 210)];
    _phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 75, 120, 50)];
    _eMailButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 120, 160, 50)];
    
    _telephone.text = @"电话:";
    _eMail.text = @"邮箱:";
    _teacherInfo.text = @"教师简介";
    _teacherDescription.editable = NO;
    _teacherDescription.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    [_phoneButton addTarget:self action:@selector(dailPhoneNumber) forControlEvents:UIControlEventTouchDown];
    [_eMailButton addTarget:self action:@selector(sendEMail) forControlEvents:UIControlEventTouchDown];
    _teacherImage.layer.cornerRadius = 50;
    _teacherImage.layer.masksToBounds = YES;
    _teacherImage.layer.borderWidth = 1;
    
    [self.view addSubview:_teacherImage];
    [self.view addSubview:_telephone];
    [self.view addSubview:_eMail];
    [self.view addSubview:_teacherInfo];
    [self.view addSubview:_teacherDescription];
    [self.view addSubview:_phoneButton];
    [self.view addSubview:_eMailButton];
    _teacherNameList = TEACHER_NAME_LIST;
    _teacherPhone = TEACHER_PHONE;
    _teacherMail = TEACHER_MAIL;
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"first_use_teacher_info"]){
        if(IS_IPHONE5_OR_S_C)
            [self loadGuideForIphone5];
        else if(IS_IPHONE6)
            [self loadGuideForIphone6];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"first_use_teacher_info"];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"page_teacher_info"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --
#pragma 自定义方法
-(void)setTeacherTag:(int)tag{
    _tag = tag;
    [self setTheElement];
}

-(void)setTheElement{
    _teacherImage.image = [UIImage imageNamed:[[_teacherNameList objectAtIndex:_tag] stringByAppendingString:@".jpg"]];
    NSString *path = [[NSBundle mainBundle] pathForResource:[_teacherNameList objectAtIndex:_tag] ofType:@"txt"];
    NSString *description = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    _teacherDescription.text = description;
    [_phoneButton setTitle:[_teacherPhone objectAtIndex:_tag] forState:UIControlStateNormal];
    [_eMailButton setTitle:[_teacherMail objectAtIndex:_tag] forState:UIControlStateNormal];
    [_eMailButton setTitleColor:ORANGE_COLOR forState:UIControlStateNormal];
    _eMailButton.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:12];
    [_phoneButton setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
}

-(void)dailPhoneNumber{
    if([[_teacherPhone objectAtIndex:_tag] isEqualToString:@"🈚️"]){
        alertView_1 = [[UIAlertView alloc] initWithTitle:@"" message:@"抱歉，该老师暂时不对外提供电话号码" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alertView_1 show];
    }else{
        alertView_1 = [[UIAlertView alloc] initWithTitle:nil message:@"确认拨打电话?" delegate:self cancelButtonTitle:@"直接拨打" otherButtonTitles:@"返回", nil];
        [alertView_1 show];
    }
}

-(void)sendEMail{
    if([[_teacherMail objectAtIndex:_tag] isEqualToString:@"🈚️"]){
        alertView_2 = [[UIAlertView alloc] initWithTitle:@"" message:@"抱歉，该老师暂时不对外提供邮箱" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alertView_2 show];
    }else{
        alertView_2 = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"确认发送邮件到%@",[_teacherMail objectAtIndex:_tag]] delegate:self cancelButtonTitle:@"直接发送" otherButtonTitles:@"返回", nil];
        [alertView_2 show];
    }
}

#pragma mark --
#pragma 加载新手指导
-(void)loadGuideForIphone5{
    _guideImage = [UIImageView new];
    _guideImage.frame = [[UIScreen mainScreen] bounds];
    _guideImage.image = [UIImage imageNamed:@"guide_for_iPhone5_2"];
    [self.view addSubview:_guideImage];
}

-(void)loadGuideForIphone6{
    _guideImage = [UIImageView new];
    _guideImage.frame = [[UIScreen mainScreen] bounds];
    _guideImage.image = [UIImage imageNamed:@"guide_for_iPhone6_2"];
    [self.view addSubview:_guideImage];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.5 animations:^{
        _guideImage.alpha = 0;
    }];
    [_guideImage performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
}


#pragma mark --
#pragma UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        if([alertView isEqual:alertView_1]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[_teacherPhone objectAtIndex:_tag]]]];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@",[_teacherMail objectAtIndex:_tag]]]];
        }
    }else{
        return;
    }
}

@end
