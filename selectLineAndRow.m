//
//  selectLineAndRow.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/28.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "selectLineAndRow.h"
#import "ConstantHeader.h"

@implementation selectLineAndRow

-(void)drawRect:(CGRect)rect{
    self.layer.cornerRadius = 2;
    _line_picker = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 10 , MAIN_SCREEN_X - 40, rect.size.height / 2)];
    _line_picker.delegate = self;
    [self addSubview:_line_picker];
    UIButton *confiermButton;
    UIButton *cancleButton;
    if(IS_IPHONE5_OR_S_C){
        confiermButton = [[UIButton alloc] initWithFrame:CGRectMake(230, 5, 80, 30)];
        cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 80, 30)];
    }else if(IS_IPHONE6 || IS_IPHONE6_PLUS){
        confiermButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 5, 80, 30)];
        cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 80, 30)];
    }else{
        confiermButton = [[UIButton alloc] initWithFrame:CGRectMake(230, 5, 80, 30)];
        cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 80, 30)];

    }
    confiermButton.layer.cornerRadius = 2;
    [confiermButton setTitle:@"确认" forState:UIControlStateNormal];
    cancleButton.layer.cornerRadius = 2;
    [cancleButton setTitle:@"退出" forState:UIControlStateNormal];
    
    [confiermButton addTarget:self
                       action:@selector(selectRowAndLine)
             forControlEvents:UIControlEventTouchDown];
    [cancleButton addTarget:self
                     action:@selector(backToMainView)
           forControlEvents:UIControlEventTouchDown];
    
    confiermButton.backgroundColor = [UIColor grayColor];
    cancleButton.backgroundColor = [UIColor grayColor];
    [self addSubview:confiermButton];
    [self addSubview:cancleButton];
}

#pragma mark--
#pragma UIPickerView 协议方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%d",(int)(row + 1)];
}

#pragma mark --
#pragma 自定义方法
-(void)selectRowAndLine{
    [_delegate selectedRow:(int)[_line_picker selectedRowInComponent:0] line:(int)[_line_picker selectedRowInComponent:1]];
}

-(void)selectRow:(int)row line:(int)line{
    [_row_picker selectRow:row inComponent:0 animated:YES];
    [_line_picker selectRow:line inComponent:0 animated:YES];
}

-(void)backToMainView{
    [_delegate back];
}


@end
