//
//  moreInstanceViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 8/25/15.
//  Copyright (c) 2015 付国强. All rights reserved.
//
#import "webViewController.h"
#import "moreInstanceViewController.h"

@interface moreInstanceViewController ()
<UITableViewDataSource,UITableViewDelegate> {
    UITableView *listTableView;
}

@end

@implementation moreInstanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    float width = [UIScreen mainScreen].bounds.size.width;
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, 200) style:UITableViewStylePlain];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [self.view addSubview:listTableView];
    listTableView.scrollEnabled = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark- table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell ==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"密码学";
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"通信学";
    }else if (indexPath.section == 2) {
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        webViewController *vc = [webViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        [vc loadURLString:@"http://wenku.baidu.com/link?url=_aUAkjOFPnUbL5twdVtqltsMD-st9-Tnk6dQ1HuWi-A_lHdn-zyogFpii8A4c6D2dLUIwEAohwxfjU4-0l1Vfp20uyMgLfr6vgN7scorzbe"];
    }else if (indexPath.section == 1) {
        webViewController *vc = [webViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        [vc loadURLString:@"http://wenku.baidu.com/link?url=3v3dIrvvDuIy_nB02TdjjfWZYaynCEGV1OepCzJjDmGmzBCh7Molbzf8r3zDwREMlcCumKwnGl7NQlViPTC1Nr1_m68s92smOk6Xk1Pc4iy"];
    }else if (indexPath.section == 2) {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)dealloc {
    listTableView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
