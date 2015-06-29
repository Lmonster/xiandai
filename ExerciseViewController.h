//
//  ExerciseViewController.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/22.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "PDFFileHelper.h"

@interface ExerciseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPageViewControllerDataSource>

/**
     THE MAIN CONTAINER OF THE OCNTENTS
 */
@property (strong ,nonatomic) UITableView *tableView;


/**
     THE ARRAY THAT CONSTANTS EXERCISE
 */
@property (strong ,nonatomic) NSMutableArray *exerciseArray;


/**
     THE ARRAY THE CONTAINS NUMBEROFPAGE
 */
@property (strong ,nonatomic) NSMutableArray *mostPageArray;

/**
      THE DATABASE
 */
@property (assign,nonatomic) sqlite3 *sqlite;

/**
      THE BOOKMARK 
 */
@property (assign ,nonatomic) int bookMark;

@property (strong ,nonatomic) PDFFileHelper *PDFFileHelper;

@property (strong ,nonatomic) NSMutableArray *pageContent;

@property (strong ,nonatomic) NSMutableArray *realPageContent;


@end
