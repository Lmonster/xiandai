//
//  CalculationViewController.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/22.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "Caculation.h"
#import "matrixView.h"
#import "keyBoardView.h"
#import "selectLineAndRow.h"

// 需要遵守的协议是：_keyBoardDidTouchedDelegate,matrixViewDelegate,selectRowAndLineDelegate
// 实现的分别为：
// 1.键盘点击时，textField显示的内容的更新
// 2.当前textFieldsView界面的交互内容，主要有当前正在编辑的textField，当前textField的行列数，当前各个textField的内容
// 3.更改改行列数的时候更新最新的行列数，并且更新textFieldView
@interface CalculationViewController:UIViewController<_keyBoardDidTouchedDelegate,matrixViewDelegate,selectRowAndLineDelegate>

//用于存储TextField实例的一个数组
@property (strong ,nonatomic) NSMutableArray *TFArray;

//
@property (assign ,nonatomic) int numberOfRow;

@property (assign ,nonatomic) int numberOfLine;

@property (strong ,nonatomic) Caculation *Caculation;

@property (strong ,nonatomic) matrixView *TFView;

@property (strong ,nonatomic) keyBoardView *keyboard;

@property (strong ,nonatomic) selectLineAndRow *popView;

@property (strong ,nonatomic) UIView *backgroundView;

@property (strong ,nonatomic) UIImageView *guideImage;
@end
