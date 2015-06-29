//
//  CalculationViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/22.
//  Copyright (c) 2015年 付国强. All rights reserved.
//


// 文件实现的是计算器界面
#import "CalculationViewController.h"
#import "Header.h"


struct pointToFirstRespond{
    int row;
    int line;
};


@implementation CalculationViewController{
    float widthOfTF;
    float heightOfTF;
    UITextField *editingTextField;
    UITextField *tempTextField;
    struct pointToFirstRespond pointer;
    NSMutableArray *resultArray;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"page_2"];
}

-(void)viewDidLoad{

    [super viewDidLoad];
    self.title = @"计算器";
    [self.view setBackgroundColor:WHITE_COLOR];
    [self setDefaultData];
    
    _Caculation = [[Caculation alloc] init]; /*  计算类的初始化 */
    tempTextField = [[UITextField alloc] init];
    _TFArray = [[NSMutableArray alloc] init];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showResult:)
                                                 name:@"calculationDidFinishNotification"
                                               object:nil];
    
    UIBarButtonItem *selectBar = [[UIBarButtonItem alloc] initWithTitle:@"选择行列数"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(selectLineAndRow)];
    self.navigationItem.rightBarButtonItem = selectBar;
    /*  keyBoard and matrixView alloc */
    
    _keyboard = [[keyBoardView alloc] initWithFrame:CGRectMake(0, 227, MAIN_SCREEN_X, 341)];
    [_keyboard setBackgroundColor:WHITE_COLOR];
    _TFView = [[matrixView alloc] initWithFrame:CGRectMake(0, 60, MAIN_SCREEN_X, 177)];
    [_TFView setBackgroundColor:WHITE_COLOR];
    
    _TFView.delegate = self;
    _keyboard.delegate = self;
    [self.view addSubview:_TFView];
    [self.view addSubview:_keyboard];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"first_use_calculation"]){
        [self performSelector:@selector(remove) withObject:nil afterDelay:1.5];
        if(IS_IPHONE5_OR_S_C)
            [self loadGuideForIphone5];
        else if (IS_IPHONE6)
            [self loadGuideForIphone6];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"first_use_calculation"];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"page_2"];
}


#pragma mark --
#pragma 自定义方法
-(void)setDefaultData{
    _numberOfLine = 3;
    _numberOfRow = 3;
}

-(void)keyBoardWillShow:(NSNotification *)notification{
    NSArray *windowsArray = [[UIApplication sharedApplication] windows];
    UIWindow *keyBoardWindow = [windowsArray objectAtIndex:1];
    UIView *tempView = [[keyBoardWindow subviews] objectAtIndex:0];
    UIView *keyBoardView = [[tempView subviews] objectAtIndex:0];
    keyBoardView.alpha = 0;
}

-(void)showResult:(NSNotification *)notification{
    NSDictionary *direction = [notification userInfo];
    _numberOfRow = [[direction objectForKey:@"row"] intValue];
    _numberOfLine = [[direction objectForKey:@"line"] intValue];
    resultArray = [NSMutableArray arrayWithArray:[direction objectForKey:@"dataArray"]];
    
//    [_TFView removeFromSuperview];
//    [_keyboard removeFromSuperview];
    _TFView = nil;
    _keyboard = nil;
    _keyboard = [[keyBoardView alloc] initWithFrame:CGRectMake(0, 227, MAIN_SCREEN_X, 341)];
//    [_keyboard setBackgroundColor:WHITE_COLOR];
    _keyboard.backgroundColor = WHITE_COLOR;
    _TFView = [[matrixView alloc] initWithFrame:CGRectMake(0, 60, MAIN_SCREEN_X, 177)];
    [_TFView setBackgroundColor:WHITE_COLOR];
    
    _TFView.delegate = self;
    _keyboard.delegate = self;
    [self.view addSubview:_TFView];
    [self.view addSubview:_keyboard];
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

-(void)selectLineAndRow{
    
    _popView = [[selectLineAndRow alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_Y - 230, MAIN_SCREEN_X, 230)];
    [_popView selectRow:_numberOfRow -1 line:_numberOfLine - 1];
    _popView.delegate = self;
    _backgroundView = [[UIView alloc] initWithFrame:MAIN_SCREEN_RECT];
    _backgroundView.backgroundColor = [UIColor grayColor];
    _backgroundView.alpha = 0.75;
    _popView.backgroundColor = WHITE_COLOR;
    _popView.layer.position = CGPointMake(MAIN_SCREEN_X / 2, MAIN_SCREEN_Y + 230);
    [self.view addSubview:_backgroundView];
    [self.view addSubview:_popView];
    [UIView animateWithDuration:0.5 animations:^{
        _popView.layer.position = CGPointMake(MAIN_SCREEN_X / 2, (MAIN_SCREEN_Y - 230 /2));
    }];
}


#pragma mark--
#pragma matrixView 协议方法
-(int)getMatrixInfo_line{
    return _numberOfLine;
}

-(int)getMatrixInfo_row{
    return _numberOfRow;
}

-(void)edittingTextFieldInfoWithRow:(int)row withLine:(int)line{
    pointer.line = line;
    pointer.row = row;
}

-(void)getTextFieldInfo:(NSMutableArray *)array{
    _TFArray = array;
    for(int i = 0 ;i< _numberOfRow ;i++)
        for(int j = 0; j< _numberOfLine;j++)
        {
            if(!resultArray)
                break;
            tempTextField = [_TFArray objectAtIndex:i * _numberOfLine +j];
            tempTextField.text = [NSString stringWithFormat:@"%f",[[resultArray objectAtIndex:i * _numberOfLine +j] floatValue]];
        }

    
}



#pragma mark--
#pragma keyBoardView协议方法

-(void)sendCleanInfo{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanAllTheData" object:self userInfo:nil];
    for(int i = 0 ;i< _numberOfRow ;i++)
        for(int j = 0; j< _numberOfLine;j++)
        {
            tempTextField = [_TFArray objectAtIndex:i * _numberOfLine +j];
            tempTextField.text = nil;
        }
}

-(void)sendCaculationInfo:(int)caculationType{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for(int i = 0; i< _numberOfRow ;i++)
        for(int j =0; j<_numberOfLine ;j++)
        {
            tempTextField = [_TFArray objectAtIndex:i * _numberOfLine + j];
            if(![tempTextField.text length])
                tempTextField.text = @"0";
            [dataArray addObject:[NSNumber numberWithFloat:[tempTextField.text floatValue]]];
            tempTextField.text = nil;
        }
    [_Caculation pushwithData:dataArray withType:caculationType withArrayRow:_numberOfRow withArrayLine:_numberOfLine];
}

-(void)sendMovaInfo:(int)moveType{
    
    if(moveType == 9){
        if(pointer.row == 0)
            pointer.row = _numberOfRow - 1;
        else
            pointer.row --;
    }
    if(moveType == 14){
        if(pointer.row == (_numberOfRow - 1))
            pointer.row = 0;
        else
            pointer.row ++;
    }
    if(moveType == 19){
        if(pointer.line == 0)
            pointer.line = _numberOfLine -1;
        else
            pointer.line --;
    }
    if(moveType == 24){
        if(pointer.line == (_numberOfLine - 1))
            pointer.line = 0;
        else
            pointer.line ++;
    }
    [[_TFArray objectAtIndex:pointer.row * _numberOfLine + pointer.line] becomeFirstResponder];
}

-(void)sendNumberInfo:(int)number{
    tempTextField = _TFView.editingTextField;
    if(number == DELETE_SIGN)
    {
        if(![tempTextField.text length])
            tempTextField.text = nil;
        else
            tempTextField.text = [tempTextField.text substringWithRange:NSMakeRange(0, [tempTextField.text length]-1)];
    }
    else
        if(number == POINT)
            tempTextField.text = [tempTextField.text stringByAppendingString:@"."];
    
    
        else
            if(number == MINUS_SIGN)
            {
                if(!tempTextField.text)
                    tempTextField.text = @"-";
                else{
                    tempTextField.text = tempTextField.text;
                }
            }
            else
                if(!tempTextField.text)
                    tempTextField.text = [NSString stringWithFormat:@"%d",number];
                else
                    tempTextField.text = [tempTextField.text stringByAppendingString:[NSString stringWithFormat:@"%d",number]];
}

#pragma mark --
#pragma 添加新手指导
-(void)loadGuideForIphone5{
    _guideImage = [UIImageView new];
    _guideImage.alpha = 1.0;
    _guideImage.frame = [[UIScreen mainScreen] bounds];
    _guideImage.image = [UIImage imageNamed:@"guide_for_iPhone5_1"];
    [self.view addSubview:_guideImage];
}

-(void)loadGuideForIphone6{
    _guideImage = [UIImageView new];
    _guideImage.alpha = 1.0;
    _guideImage.frame = [[UIScreen mainScreen] bounds];
    _guideImage.image = [UIImage imageNamed:@"guide_for_iPhone6_1"];
    [self.view addSubview:_guideImage];
    [self performSelector:@selector(remove) withObject:nil afterDelay:1];
}

-(void)remove{
    [UIView animateWithDuration:0.5 animations:^{
        _guideImage.alpha = 0;
    }];
    [_guideImage performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
}


#pragma mark --
#pragma selectedRowAndLine协议方法
-(void)selectedRow:(int)row line:(int)line{
    _numberOfLine = line + 1;
    _numberOfRow = row + 1;
    [UIView animateWithDuration:0.5 animations:^{
        [_popView.layer setPosition:CGPointMake(MAIN_SCREEN_X / 2, MAIN_SCREEN_Y + 230)];
        [_backgroundView setAlpha:0];
    }];
    [_popView performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:0.5];
    [_backgroundView performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:0.5];
    [_keyboard removeFromSuperview];
    [_TFView removeFromSuperview];
    _TFArray = nil;
    _keyboard = [[keyBoardView alloc] initWithFrame:CGRectMake(0, 227, MAIN_SCREEN_X, 341)];
    [_keyboard setBackgroundColor:WHITE_COLOR];
    _TFView = [[matrixView alloc] initWithFrame:CGRectMake(0, 60, MAIN_SCREEN_X, 177)];
    [_TFView setBackgroundColor:WHITE_COLOR];
    
    _TFView.delegate = self;
    _keyboard.delegate = self;
    [self.view addSubview:_TFView];
    [self.view addSubview:_keyboard];
}

-(void)back{
    CABasicAnimation *animation_1 = [CABasicAnimation animation];
    animation_1.keyPath = @"position";
    animation_1.fromValue = [NSValue valueWithCGPoint:CGPointMake(MAIN_SCREEN_X / 2, MAIN_SCREEN_Y - _popView.frame.size.height /2)];
    animation_1.toValue = [NSValue valueWithCGPoint:CGPointMake(MAIN_SCREEN_X / 2, MAIN_SCREEN_Y + _popView.frame.size.height)];
    animation_1.duration = 0.5;
    [_popView.layer addAnimation:animation_1 forKey:nil];
//    [UIView animateWithDuration:0.5 animations:^{
//        [_popView.layer setPosition:CGPointMake(MAIN_SCREEN_X / 2, MAIN_SCREEN_Y + 230)];
//        [_backgroundView setAlpha:0];
//    }];
    [_popView performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:0.5];
    [_backgroundView performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:0.5];
}
@end
