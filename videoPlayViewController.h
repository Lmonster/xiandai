//
//  videoPlayViewController.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/6/21.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface videoPlayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *lastPlay;
@property (weak, nonatomic) IBOutlet UIImageView *gobackFast;
@property (weak, nonatomic) IBOutlet UIImageView *play;
@property (weak, nonatomic) IBOutlet UIImageView *goForwardFast;
@property (weak, nonatomic) IBOutlet UIImageView *playNext;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


@end
