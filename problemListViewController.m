//
//  problemListViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/6/24.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "problemListViewController.h"
#import "webViewController.h"

@interface problemListViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation problemListViewController {
    UITableView *aTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常见问题";
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    aTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    aTableView.delegate = self;
    aTableView.dataSource = self;
    [self.view addSubview:aTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.bounds.size.height / 6.;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%d章常见问题",(int)indexPath.row + 1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    webViewController *vc = [[webViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    if(indexPath == 0) {
        [vc beginLoad:@"juzhen"];
    }
    [vc beginLoad:[NSString stringWithFormat:@"%d",(int)indexPath.row + 1]];
}
@end
