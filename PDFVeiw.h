//
//  PDFVeiw.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/7.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFVeiw : UIView

@property (strong ,nonatomic) NSString *fileName;

@property (assign ,nonatomic) int pageNumber;

@property (strong ,nonatomic) NSString *filePath;

@property (strong ,nonatomic) UIImageView *guideImage;

@end
