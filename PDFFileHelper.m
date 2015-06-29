//
//  PDFFileHelper.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/3.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "PDFFileHelper.h"

@implementation PDFFileHelper

-(int)getFilePageNumberAtPath:(NSString *)filePath{
    CFStringRef path;
    CFURLRef url;
    path = CFStringCreateWithCString (NULL, [filePath UTF8String], kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
    _document = CGPDFDocumentCreateWithURL (url);
    
    size_t numberOfPage = CGPDFDocumentGetNumberOfPages(_document);
    return (int)numberOfPage;
}

@end
