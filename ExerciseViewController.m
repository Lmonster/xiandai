//
//  ExerciseViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/22.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "ExerciseViewController.h"
#import "ConstantHeader.h"
#import "PDFViewContoller.h"
#import "PDFDrawer.h"
#import <sqlite3.h>
#import "Header.h"



//     THE PATH OF THE DATABASE
#define DATABASE_PATH        [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/test.sqlite"]

//     THE FILE NAME ARRAY
#define PDF_NAME_ARRAY       @[@"test0",@"test1",@"test2",@"test3",@"test4",@"test5",@"test6",@"test_answer"]


//     THE MOST NUMBER OF EACH FILE
#define MOST_PAGE            @[@"7",@"8",@"5",@"6",@"6",@"5",@"7",@"7"]


//     THE FIRST PAGE OF A FILE
#define FIRST_PAGE           1




@implementation ExerciseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"page_6"];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanThePageArray) name:@"CleanThePageArray" object:nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_X, MAIN_SCREEN_Y)
                                              style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _exerciseArray = [[NSMutableArray alloc] initWithArray:PDF_NAME_ARRAY];
    _mostPageArray = [[NSMutableArray alloc] initWithArray:MOST_PAGE];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:DATABASE_PATH]){
        sqlite3_open([DATABASE_PATH UTF8String], &_sqlite);
        [self createTheDatabase];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _pageContent = [[NSMutableArray alloc] init];
    _PDFFileHelper = [[PDFFileHelper alloc] init];
    _realPageContent = [NSMutableArray new];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"page_6"];
}


#pragma Mark-
#pragma UITableViewdelegata

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell ==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if(indexPath.row < 8){
        cell.textLabel.text = [NSString stringWithFormat:@"第%d套测试习题",(int)indexPath.row + 1];
    }
    if(indexPath.row == 8){
        cell.textLabel.text = @"未完待续，敬请期待";
        cell.userInteractionEnabled = NO;
    }
    cell.textLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:30];
    cell.imageView.layer.affineTransform = CGAffineTransformMakeScale(0.5, 0.5);
    cell.imageView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    return cell;
}



#pragma mark --
#pragma dataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *file_name = [_exerciseArray objectAtIndex:indexPath.row];
    NSString *file_path = [[NSBundle mainBundle] pathForResource:file_name ofType:@"pdf"];
    
    PDFViewContoller *viewController = [[PDFViewContoller alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                                  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                                options:nil];
    viewController.dataSource = self;
    [viewController.view setBackgroundColor:WHITE_COLOR];
    
    for(int i = 0; i<[_PDFFileHelper getFilePageNumberAtPath:file_path] ; i++){
        PDFDrawer *pdfView = [[PDFDrawer alloc] initControllerWithPage:i + 1 withFilePath:file_path withFileName:file_name];
        [pdfView.view setBackgroundColor:WHITE_COLOR];
        if(_pageContent)
            [_pageContent addObject:pdfView];
        else{
            _pageContent = [[NSMutableArray alloc] init];
            [_pageContent addObject:pdfView];
        }
    }
    _realPageContent = _pageContent;
     [viewController setViewControllers:@[[_pageContent objectAtIndex:0]]
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenOrShowNavigationBar"
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],@"isHidden" ,nil]];
}


#pragma mark --
#pragma 自定义方法

-(void)createTheDatabase{
    const char *createTable = "CREATE TABLE IF NOT EXISTS test_table (NAME TEXT , MOSTPAGE INTEGER)";
    if(sqlite3_exec(_sqlite, createTable, nil, nil, nil) == SQLITE_OK){
        for(int i = 0; i< 8; i++){
            NSString *insertString = [NSString stringWithFormat:@"insert into test_table values ('%@',%d)", [_exerciseArray objectAtIndex:i],[[_mostPageArray objectAtIndex:i] intValue]];
            const char *insert = [insertString UTF8String];
            sqlite3_exec(_sqlite, insert, nil, nil, nil);
        }
    }
}

-(void)cleanThePageArray{
    _pageContent = nil;
}

#pragma mark--
#pragma UIPageViewControllerDataScource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [_realPageContent indexOfObject:viewController];
    if(index == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"这是第一页，前面没有了" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alertView show];
        return nil;
    }else{
        index --;
        return [_realPageContent objectAtIndex:index];
    }
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    int index = (int)[_realPageContent indexOfObject:viewController];
    if(index == [_realPageContent count] - 1){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"已是最后一页" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alertView show];
        return nil;
    }else{
        index ++;
        return [_realPageContent objectAtIndex:index];
    }
}



@end
