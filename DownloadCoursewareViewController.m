//
//  DownloadCoursewareViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/6.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "DownloadCoursewareViewController.h"
#import "ConstantHeader.h"
#import "downLoadTableViewCell.h"
#import "loadPDFViewController.h"
#import "MobClick.h"

@interface DownloadCoursewareViewController ()

@end

@implementation DownloadCoursewareViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"page_1"];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //    加载以及初始化_tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_X, MAIN_SCREEN_Y) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //    提前检测网路，采用的是检测NSUserDefault中写入的数据
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"NetConnectStatus"] intValue] == AFNetworkReachabilityStatusNotReachable){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"设备没有联网，将无法提供下载功能" delegate:nil
                                                  cancelButtonTitle:@"返回"
                                                  otherButtonTitles: nil, nil];
        [alertView show];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"page_1"];
}

#pragma Mark-
#pragma UITableViewDataScource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CellIdentifier";
    downLoadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell ==nil){
        cell = [[downLoadTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier withIndex:(int)indexPath.row];
    }
    cell.chapterInfo_lable.font = [UIFont fontWithName:@"STHeitiTC-Light" size:cell.chapterInfo_lable.frame.size.height];
    cell.chapterInfo_lable.text = [NSString stringWithFormat:@"第%d章课件",(int)indexPath.row + 1];
    return cell;
}


#pragma mark --
#pragma UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(IS_IPHONE6_PLUS)
        return 100;
    else
        return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_X, 30)];
    headerView.backgroundColor = [UIColor orangeColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, MAIN_SCREEN_X, 30)];
    if(section == 0){
        label.text = @"课程介绍";
    }
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    首先检查文件是否存在，如果存在的话，就用loadPDFViewController来初始化一个实例，然后push进去
    //    以下为初始化文件信息的相关情况：文件路径等情况。文件命名采用Chapter0x的格式
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fileName = [NSString stringWithFormat:@"Chapter0%d.pdf",(int)indexPath.row + 1];
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"/Documents/%@",fileName]];
    
    //    检测文件是否存在，然后根据不同情况来决定处理情况
    if([fileManager fileExistsAtPath:filePath]){
        loadPDFViewController *viewController = [[loadPDFViewController alloc] init];
        viewController.filePath = [NSURL fileURLWithPath:filePath];
        [viewController loadThePDFView];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:nil message:@"文件不存在，请先下载" delegate:nil
                                             cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [view show];
    }
    
}
@end
