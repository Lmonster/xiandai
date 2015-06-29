//
//  videoDisplayCellTableViewCell.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/6/24.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface videoDisplayCellTableViewCell : UITableViewCell
<NSURLSessionDownloadDelegate,
NSURLSessionTaskDelegate,
NSURLSessionDelegate>

@property (assign) BOOL fileExits;
@property (strong, nonatomic) IBOutlet UIButton *beginLoad;
-(void)beginDownload;

@end
