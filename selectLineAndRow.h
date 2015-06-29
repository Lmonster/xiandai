//
//  selectLineAndRow.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/28.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectRowAndLineDelegate <NSObject>

-(void)selectedRow:(int)row line:(int)line;
-(void)back;

@end

@interface selectLineAndRow : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong ,nonatomic) UIPickerView *line_picker;

@property (strong ,nonatomic) UIPickerView *row_picker;

@property (strong ,nonatomic) id <selectRowAndLineDelegate> delegate;

-(void)selectRow:(int)row line:(int)line;

@end
