//
//  videoSelectTableViewCell.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/6/24.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

// ATTENTION:
// THIS DESCRIPTION IS AN INSTRUCTION THAT TELL USERS HOW TO US IT
//
#import <UIKit/UIKit.h>

@interface videoSelectTableViewCell : UITableViewCell
<NSURLSessionDownloadDelegate,
NSURLSessionDelegate,
NSURLSessionDataDelegate>


//  UI
@property (weak, nonatomic) IBOutlet UIImageView        *thubnailImage;
@property (weak, nonatomic) IBOutlet UILabel            *mainTitle;
@property (weak, nonatomic) IBOutlet UILabel            *descriptionTitle;
@property (weak, nonatomic) IBOutlet UIButton           *downloadButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonLeftConstraint;
@property (weak, nonatomic) IBOutlet UIView *processView;
@property (weak, nonatomic) IBOutlet UILabel *processLabel;

// Data
@property (assign) BOOL fileExits;
@property (assign) BOOL downloading;

- (void)beginDownload;

@end
