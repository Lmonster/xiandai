//
//  teacherInfoViewController.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/2.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface teacherInfoViewController : UIViewController<UIAlertViewDelegate>


@property (strong ,nonatomic) UIImageView *teacherImage;

@property (strong ,nonatomic) UILabel *teacherInfo;

@property (strong ,nonatomic) UILabel *telephone;

@property (strong ,nonatomic) UILabel *eMail;

@property (strong ,nonatomic) UIButton *phoneButton;

@property (strong ,nonatomic) UIButton *eMailButton;

@property (assign ,nonatomic) int tag;

@property (strong ,nonatomic) NSArray *teacherNameList;

@property (strong ,nonatomic) NSArray *teacherPhone;

@property (strong ,nonatomic) NSArray *teacherMail;

@property (strong ,nonatomic) UITextView *teacherDescription;

@property (strong ,nonatomic) UIImageView *guideImage;
-(void)setTeacherTag:(int)tag;

@end
