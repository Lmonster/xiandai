//
//  DownloadCoursewareViewController.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/6.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFFileHelper.h"

@interface DownloadCoursewareViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

//    USED FOR PUTTING THE CONTAINTS OF THE DOWNLODA
//    这是整个viewController的基本界面，是整个界面的核心
@property (strong ,nonatomic) UITableView *tableView;

@end
