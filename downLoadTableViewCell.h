//
//  downLoadTableViewCell.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/3.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownLoadHelper.h"

@interface downLoadTableViewCell : UITableViewCell<BeginRefreshProcessViewDelegate>

@property (strong ,nonatomic) UILabel *chapterInfo_lable;

@property (strong ,nonatomic) UIButton *downLoadButton;

@property (strong ,nonatomic) UIProgressView *downLoadProcessView;

@property (strong ,nonatomic) DownLoadHelper *downLoadHelper;

@property (assign ,nonatomic) BOOL fileExits;

@property (assign ,nonatomic) int index;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withIndex:(int)index;
@end
