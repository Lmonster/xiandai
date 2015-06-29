//
//  ForumViewController.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/22.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForumViewTSController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (strong ,nonatomic) UITableView *tableView;

@property (strong ,nonatomic) NSArray *teacherNameList;

@property (strong ,nonatomic) NSArray *teacherShortDescription;
@end
