//
//  matrixView.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/24.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol matrixViewDelegate<NSObject>

@required
-(int)getMatrixInfo_line;
-(int)getMatrixInfo_row;
-(void)edittingTextFieldInfoWithRow:(int)row withLine:(int)line;
-(void)getTextFieldInfo:(NSMutableArray *)array;


@end


@interface matrixView : UIView<UITextFieldDelegate>

@property (strong ,nonatomic) id<matrixViewDelegate> delegate;

@property (strong ,nonatomic) NSMutableArray *textFieldArray;

@property (strong ,nonatomic) UITextField *editingTextField;

@end
