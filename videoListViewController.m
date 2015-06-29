//
//  videoListViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/6/25.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "videoListViewController.h"
#import "videoSelectTableViewCell.h"
#import "moviePlayViewController.h"

#define VIDEO_NAME_ARRAY @[@"矩阵运算",@"矩阵应用",@"基本语法",@"Matlab入门",@"Matlab语言概述"]

@interface videoListViewController ()
<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@end

@implementation videoListViewController {
    UITableView                 *aTableView;
    videoSelectTableViewCell    *selectCell;
    NSString                    *filePath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadCellData)
                                                 name:@"reloadCell"
                                               object:nil];
    
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    aTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:aTableView];
    aTableView.delegate = self;
    aTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ****table view delegate and data 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"video%d.mp4",(int)indexPath.row + 1]];
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"videoSelectTableViewCell" owner:self options:0];
    videoSelectTableViewCell *cell = [array firstObject];
    cell.tag = indexPath.row + 1;
    cell.thubnailImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%d.jpg",(int)indexPath.row + 1]];
    cell.descriptionTitle.text = [VIDEO_NAME_ARRAY objectAtIndex:indexPath.row];
    [cell.descriptionTitle setFont:[UIFont fontWithName:@"GeezaPro" size:15]];
    cell.fileExits = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if(cell.fileExits) {
        [cell.downloadButton setTitle:@"观看" forState:UIControlStateNormal];
    }else {
        [cell.downloadButton setTitle:@"下载" forState:UIControlStateNormal];
    }
    filePath = nil;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.bounds.size.height / 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"video%d.mp4",(int)indexPath.row + 1]];
    
    selectCell = (videoSelectTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if(selectCell.fileExits) {
        moviePlayViewController *vc = [[moviePlayViewController alloc] init];
        vc.filePath = filePath;
        [self.navigationController pushViewController:vc animated:YES];
        [vc beginPlay];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"视频没有下载，请下载之后再观看"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    filePath = nil;
}

- (void)reloadCellData {
    [aTableView reloadData];
}



@end
