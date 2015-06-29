//
//  courseIntroductionViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/3/2.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "courseIntroductionViewController.h"
#import "ConstantHeader.h"

@interface courseIntroductionViewController ()

@end

@implementation courseIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titel = [UILabel new];
    _titel.frame = CGRectMake((MAIN_SCREEN_X - 120) / 2, 65, 120, 50);
    _titel.text = @"课程介绍";
    _titel.font = [UIFont fontWithName:@"HiraKaKuProN-W3" size:20];
    [self.view addSubview:_titel];
    
    _mainText = [UITextView new];
    _mainText.frame = CGRectMake(4, 120, MAIN_SCREEN_X - 8, MAIN_SCREEN_Y - 120);
    _mainText.text = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"courseIntroduction" withExtension:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    _mainText.font = [UIFont systemFontOfSize:20];
    _mainText.editable = NO;
    _mainText.scrollEnabled = YES;
    [self.view addSubview:_mainText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
