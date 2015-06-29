//
//  PicExperienceViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/22.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "PicExperienceViewController.h"


@implementation PicExperienceViewController{
    UITextField *editingTextField;
    int ifGoBack;
    float angleContainer;
    float lastAngle;
    float angle_D_value;
    CATransform3D tran;
}

#pragma mark--
#pragma 对方法的重写
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushGuide) name:@"pushGuide" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restorePic) name:@"restorePic" object:nil];
    [MobClick beginLogPageView:@"page_3"];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    tran = CATransform3DIdentity;
    lastAngle = 0;
    self.title = @"图形互动";
    [self.view setBackgroundColor:WHITE_COLOR];
    ifGoBack = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getKeyboardInfo:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(pushDrawer)];
    
    _scrollView_MainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, MAIN_SCREEN_X , MAIN_SCREEN_Y - 60)];
    _scrollView_MainView.backgroundColor = BLACK_COLOR;
    if(IS_IPHONE4_OR_S)
        _scrollView_MainView.contentSize = CGSizeMake(MAIN_SCREEN_X, MAIN_SCREEN_Y + 100);
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_X, 200)];
    _drawer = [[drawerView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_X - 120, 60, 120 , MAIN_SCREEN_Y - 60)];
    _drawer.backgroundColor = [UIColor colorWithRed:112/255. green:128/255. blue:144/255. alpha:1.0];
    _imageView.image = [UIImage imageNamed:@"headDefaultImage1"];
    
    _scrollView_subView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 260, MAIN_SCREEN_X, MAIN_SCREEN_Y - 260)];
    [self setTextFields];
    _scrollView_subView.contentSize = CGSizeMake(MAIN_SCREEN_X * 2,MAIN_SCREEN_Y - 260);
    _scrollView_subView.pagingEnabled = YES;
    _scrollView_subView.backgroundColor = ORANGE_COLOR;
    _scrollView_subView.scrollEnabled = YES;
    
    _anglePicker_1 = [[TBCircularSlider alloc] initWithFrame:CGRectMake(0, 220, MAIN_SCREEN_X / 2, MAIN_SCREEN_X / 2)];
    _anglePicker_1.tag = 1;
    _anglePicker_2 = [[TBCircularSlider alloc] initWithFrame:CGRectMake(MAIN_SCREEN_X / 2, 220, MAIN_SCREEN_X / 2, MAIN_SCREEN_X / 2)];
    _anglePicker_2.tag = 2;
    
    [_anglePicker_1 addTarget:self
                      action:@selector(valueChanged:)
            forControlEvents:UIControlEventValueChanged];
    [_anglePicker_2 addTarget:self
                      action:@selector(valueChanged:)
            forControlEvents:UIControlEventValueChanged];
    
    _anglePicker_1.delegate = self;
    _anglePicker_2.delegate = self;
    [_scrollView_MainView addSubview:_anglePicker_1];
    [_scrollView_MainView addSubview:_anglePicker_2];
    [self.view addSubview:_drawer];
    [_scrollView_MainView addSubview:_imageView];
    [self.view addSubview:_scrollView_MainView];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"first_use_picExperience"]){
        if(IS_IPHONE5_OR_S_C)
            [self loadGuideForIphone5];
        else if (IS_IPHONE6)
            [self loadGuideForIphone6];
        [self performSelector:@selector(remove) withObject:nil afterDelay:1.0];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"first_use_picExperience"];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"page_3"];
}

#pragma mark --
#pragma 自定义的方法
-(void)setTextFields{
    _TFArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < 4; i++)
        for(int j = 0; j < 4; j++)
        {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(5 + (MAIN_SCREEN_X - 10) / 4 * j, 380 + 30 * i, (MAIN_SCREEN_X - 10) / 4, 30)];
            textField.layer.borderColor = [UIColor whiteColor].CGColor;
            textField.layer.borderWidth = 0.5;
            textField.layer.cornerRadius = 5;
            textField.delegate = self;
            textField.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:15];
            textField.textColor = WHITE_COLOR;
            textField.userInteractionEnabled = NO;
            [_scrollView_MainView addSubview:textField];
            [_TFArray addObject:textField];
        }
}

-(void)getKeyboardInfo:(NSNotification *)notification{
    NSDictionary *diction = [notification userInfo];
    CGRect keyBoardInfo = [[diction objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGPoint convertedPoint = [editingTextField.layer convertPoint:editingTextField.layer.position toLayer:self.view.layer];
    if((convertedPoint.y + 15) > (MAIN_SCREEN_Y - keyBoardInfo.size.height))
    {
        [UIView animateWithDuration:0.5
                         animations:^{
                             _scrollView_MainView.contentOffset = CGPointMake(0, (convertedPoint.y + 15 - MAIN_SCREEN_Y + keyBoardInfo.size.height));
                             _scrollView_MainView.contentSize = CGSizeMake(MAIN_SCREEN_X, MAIN_SCREEN_Y + 100);
                         }];
    }
}

-(void)pushDrawer{
    
    if(ifGoBack){
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:0 animations:^{
            _scrollView_MainView.layer.position = CGPointMake(MAIN_SCREEN_X / 2 - 120 , MAIN_SCREEN_Y / 2 + 30);
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:0 animations:^{
            _scrollView_MainView.layer.position = CGPointMake(MAIN_SCREEN_X / 2 , MAIN_SCREEN_Y / 2 + 30);
        } completion:nil];
    }
    ifGoBack = !ifGoBack;
}

//-(void)beginAnimation{
//    CATransform3D shaking = CATransform3DMakeRotation(-0.05, 0, 0, 1);
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"transform";
//    animation.duration = 0.1;
//    animation.repeatCount = 3;
//    animation.fromValue = [NSValue valueWithCATransform3D:shaking];
//    shaking = CATransform3DMakeRotation(0.05, 0, 0, 1);
//    animation.toValue = [NSValue valueWithCATransform3D:shaking];
//    [self.view.layer addAnimation:animation forKey:nil];
//}

-(void)valueChanged:(TBCircularSlider *)slider{
    angle_D_value = angleContainer - lastAngle;
    if(slider.tag == 1){
        tran = CATransform3DRotate(_imageView.layer.transform, angle_D_value / 360.0 * 2 * M_PI, 0, 0, 1);
        tran.m34 = 0.0005;
        _imageView.layer.transform = tran;
    }
    if(slider.tag == 2){
        tran = CATransform3DRotate(_imageView.layer.transform,  angle_D_value / 360.0 * 2 * M_PI, 1, 0, 0);
        tran.m34 = 0.0005;
        _imageView.layer.transform = tran;
    }
    UITextField *tempTextField = [[UITextField alloc] init];
    tempTextField = [_TFArray objectAtIndex:0];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m11];
    tempTextField = [_TFArray objectAtIndex:1];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m12];
    tempTextField = [_TFArray objectAtIndex:2];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m13];
    tempTextField = [_TFArray objectAtIndex:3];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m14];
    tempTextField = [_TFArray objectAtIndex:4];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m21];
    tempTextField = [_TFArray objectAtIndex:5];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m22];
    tempTextField = [_TFArray objectAtIndex:6];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m23];
    tempTextField = [_TFArray objectAtIndex:7];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m24];
    tempTextField = [_TFArray objectAtIndex:8];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m31];
    tempTextField = [_TFArray objectAtIndex:9];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m32];
    tempTextField = [_TFArray objectAtIndex:10];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m33];
    tempTextField = [_TFArray objectAtIndex:11];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m34];
    tempTextField = [_TFArray objectAtIndex:12];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m41];
    tempTextField = [_TFArray objectAtIndex:13];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m42];
    tempTextField = [_TFArray objectAtIndex:14];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m43];
    tempTextField = [_TFArray objectAtIndex:15];
    tempTextField.text = [NSString stringWithFormat:@"%f",_imageView.layer.transform.m44];
    lastAngle = lastAngle + angle_D_value;
}

-(void)pushGuide{
    guideViewController *viewController = [[guideViewController alloc] init];
    [viewController.view setBackgroundColor:WHITE_COLOR];
    [viewController loadThePDF];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)restorePic{
    [_imageView removeFromSuperview];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_X, 200)];
    _imageView.image = [UIImage imageNamed:@"headDefaultImage1"];
    [_scrollView_MainView addSubview:_imageView];
    [_anglePicker_1 removeFromSuperview];
    [_anglePicker_2 removeFromSuperview];
    _anglePicker_1 = [[TBCircularSlider alloc] initWithFrame:CGRectMake(0, 220, MAIN_SCREEN_X / 2, MAIN_SCREEN_X / 2)];
    _anglePicker_1.tag = 1;
    _anglePicker_2 = [[TBCircularSlider alloc] initWithFrame:CGRectMake(MAIN_SCREEN_X / 2, 220, MAIN_SCREEN_X / 2, MAIN_SCREEN_X / 2)];
    _anglePicker_2.tag = 2;
    
    [_anglePicker_1 addTarget:self
                       action:@selector(valueChanged:)
             forControlEvents:UIControlEventValueChanged];
    [_anglePicker_2 addTarget:self
                       action:@selector(valueChanged:)
             forControlEvents:UIControlEventValueChanged];
    
    _anglePicker_1.delegate = self;
    _anglePicker_2.delegate = self;
    [_scrollView_MainView addSubview:_anglePicker_1];
    [_scrollView_MainView addSubview:_anglePicker_2];
    
    UITextField *tempTextFiele = [[UITextField alloc] init];
    for(int i = 0; i< 4 ;i++)
        for(int j = 0 ;j< 4;j++){
            tempTextFiele = [_TFArray objectAtIndex:i*4+j];
            tempTextFiele.text = nil;
        }
}

#pragma mark --
#pragma 添加新手指导
-(void)loadGuideForIphone5{
    _guideImage = [UIImageView new];
    _guideImage.frame = [[UIScreen mainScreen] bounds];
    _guideImage.image = [UIImage imageNamed:@"guide_for_iPhone5_3"];
    [self.view addSubview:_guideImage];
}

-(void)loadGuideForIphone6{
    _guideImage = [UIImageView new];
    _guideImage.frame = [[UIScreen mainScreen] bounds];
    _guideImage.image = [UIImage imageNamed:@"guide_for_iPhone6_3"];
    [self.view addSubview:_guideImage];
}

-(void)remove{
    [UIView animateWithDuration:0.5 animations:^{
        _guideImage.alpha = 0;
    }];
    [_guideImage performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
}


#pragma mark --
#pragma UITextField delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    editingTextField = [[UITextField alloc] init];
    editingTextField = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.5
                     animations:^{
                         _scrollView_MainView.contentOffset = CGPointMake(0, 0);
                         _scrollView_MainView.contentSize = CGSizeMake(MAIN_SCREEN_X, MAIN_SCREEN_Y);
                     }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return  YES;
}


#pragma mark --
#pragma TBCirculationSlider 协议
-(void)isScrolling:(float)angle{
    angleContainer = angle;
}




@end
