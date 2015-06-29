//
//  PDFFileHelper.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/3.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PDFFileHelper : NSObject

@property (assign ,nonatomic) CGPDFDocumentRef document;

-(int)getFilePageNumberAtPath:(NSString *)filePath;

@end
