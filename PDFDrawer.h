//
//  PDFDrawer.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/30.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFVeiw.h"

@interface PDFDrawer : UIViewController<UIScrollViewDelegate>

@property (strong ,nonatomic)NSString *filePath;

@property (assign ,nonatomic)int pageNumber;

@property (strong ,nonatomic)NSString *fileName;

@property (strong ,nonatomic)UIScrollView *scrolView;

@property (strong ,nonatomic)PDFVeiw *PDFView;

@property (strong ,nonatomic) NSMutableArray *pageArray;

-(instancetype)initControllerWithPage:(int)page_number withFilePath:(NSString *)file_path withFileName:(NSString *)fileName;


@end
