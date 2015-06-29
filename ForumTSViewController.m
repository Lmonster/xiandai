//
//  ForumViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/22.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "ForumTSViewController.h"
#import "ConstantHeader.h"
#import "TSTableViewCell.h"
#import "teacherInfoViewController.h"
#import "MobClick.h"

#define TEACHER_NAME_LIST         @[@"高淑萍",@"马建荣",@"张鹏鸽"]

#define TEACJER_SHORT_DESCRIPTION @[@"获2009年陕西省普通高校教学成果二等奖1项",@"获校教学成果优秀奖，编写《线性代数》新教材及辅导书",@"理学院数学系青年教师讲课比赛第一名"]


@implementation ForumViewTSController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"名师风采";
    [self.view setBackgroundColor:[UIColor grayColor]];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 5 ,MAIN_SCREEN_X - 20, MAIN_SCREEN_Y + 5) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _teacherNameList = [[NSArray alloc] init];
    _teacherNameList = TEACHER_NAME_LIST;
    _teacherShortDescription = [[NSArray alloc] init];
    _teacherShortDescription = TEACJER_SHORT_DESCRIPTION;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"page_3"];
}



#pragma Mark-
#pragma UITableViewDataScource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CellIdentifier";
    TSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell ==nil){
        cell = [[TSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *teacherName = [_teacherNameList objectAtIndex:indexPath.row];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:teacherName ofType:@"jpg"];
    cell.cellImageView.image = [UIImage imageWithContentsOfFile:filePath];
    cell.cellMainLabel.text = [NSString stringWithFormat:@"       %@",[_teacherNameList objectAtIndex:indexPath.row]];
    cell.cellDetailLabel.text = [_teacherShortDescription objectAtIndex:indexPath.row];
    return cell;
}



#pragma mark --
#pragma UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    teacherInfoViewController *viewController = [[teacherInfoViewController alloc] init];
    [viewController.view setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1.0]];
    [viewController setTeacherTag:(int)indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    CATransform3D transform;
    transform = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    transform.m34 = 1.0/ -600;
    
    // 2. 定义cell的初始状态
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = transform;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    // 3. 定义cell的最终状态，并提交动画
    [UIView beginAnimations:@"transform" context:NULL];
    [UIView setAnimationDuration:0.5];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    [UIView commitAnimations];
}

@end
