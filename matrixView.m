//
//  matrixView.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/24.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "matrixView.h"
#import "ConstantHeader.h"

@implementation matrixView{
    int row;
    int line;
}

-(void)drawRect:(CGRect)rect{
    row = [_delegate getMatrixInfo_row];
    line = [_delegate getMatrixInfo_line];
    _textFieldArray = [[NSMutableArray alloc] init];
    _editingTextField = [[UITextField alloc] init];
    float lengthOfTF = (MAIN_SCREEN_X - (line - 1) * 5) / line;
    float heigthOfTF = (167 - (row - 1) * 5) / row;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for(int i = 0 ;i< row ;i++)
        for(int j =0 ;j< line ;j++)
        {
            CGContextMoveToPoint(context, j * lengthOfTF + j * 5, i * heigthOfTF + i * 5 + heigthOfTF);
            CGContextAddLineToPoint(context, j * lengthOfTF + j * 5 + lengthOfTF , i * heigthOfTF + i * 5 + heigthOfTF);
            CGContextSetLineWidth(context, 1);
            CGContextSetStrokeColorWithColor(context, BLACK_COLOR.CGColor);
            CGContextStrokePath(context);
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(j *lengthOfTF + j * 5, heigthOfTF * i + i * 5, lengthOfTF, heigthOfTF)];
            textField.delegate = self;
            [self addSubview:textField];
            [_textFieldArray addObject:textField];
        }
    [_delegate getTextFieldInfo:_textFieldArray];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _editingTextField = textField;
    int info_row = (int)[_textFieldArray indexOfObject:textField] / line;
    int info_line = (int)[_textFieldArray indexOfObject:textField] % line;
    [_delegate edittingTextFieldInfoWithRow:info_row withLine:info_line];
}


@end
