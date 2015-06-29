//
//  PDFVeiw.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/7.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "PDFVeiw.h"
#import "Header.h"

@implementation PDFVeiw

-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if(IS_IPHONE5_OR_S_C){
        if([_fileName isEqualToString:@"test0"]){
            if(_pageNumber == 2){
                CGContextTranslateCTM(context,-70, self.frame.size.height + 60);
                CGContextScaleCTM(context, 0.75, -0.75);
            }else{
                CGContextTranslateCTM(context,-70, self.frame.size.height + 30);
                CGContextScaleCTM(context, 0.75, -0.75);
            }
        }
        else if ([_fileName isEqualToString:@"test1"]){
            if(_pageNumber == 2){
                CGContextTranslateCTM(context,-60, self.frame.size.height + 140);
                CGContextScaleCTM(context, 0.75, -0.8);
            }else{
                CGContextTranslateCTM(context,-60, self.frame.size.height + 100);
                CGContextScaleCTM(context, 0.75, -0.8);
            }
        }else if ([_fileName isEqualToString:@"test2"]){
            CGContextTranslateCTM(context,-60, self.frame.size.height + 85);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test3"]){
            CGContextTranslateCTM(context,-70, self.frame.size.height + 80);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test4"]){
            CGContextTranslateCTM(context,-70, self.frame.size.height + 80);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test5"]){
            CGContextTranslateCTM(context,-70, self.frame.size.height + 80);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test6"]){
            CGContextTranslateCTM(context,-65, self.frame.size.height + 70);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test_answer"]){
            CGContextTranslateCTM(context,-65, self.frame.size.height + 55);
            CGContextScaleCTM(context, 0.75, -0.70);
        }
    }else if (IS_IPHONE6){
        if([_fileName isEqualToString:@"test0"]){
            if(_pageNumber == 2){
                CGContextTranslateCTM(context,-50, self.frame.size.height - 20);
                CGContextScaleCTM(context, 0.75, -0.75);
            }else{
                CGContextTranslateCTM(context,-50, self.frame.size.height - 20);
                CGContextScaleCTM(context, 0.75, -0.75);
            }
        }
        else if ([_fileName isEqualToString:@"test1"]){
            if(_pageNumber == 2){
                CGContextTranslateCTM(context,-60, self.frame.size.height + 100);
                CGContextScaleCTM(context, 0.75, -0.8);
            }else{
                CGContextTranslateCTM(context,-60, self.frame.size.height + 100);
                CGContextScaleCTM(context, 0.75, -0.8);
            }
        }else if ([_fileName isEqualToString:@"test2"]){
            CGContextTranslateCTM(context,-60, self.frame.size.height + 10);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test3"]){
            CGContextTranslateCTM(context,-50, self.frame.size.height + 10);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test4"]){
            CGContextTranslateCTM(context,-60, self.frame.size.height + 10);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test5"]){
            CGContextTranslateCTM(context,-40, self.frame.size.height + 20);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test6"]){
            CGContextTranslateCTM(context,-40, self.frame.size.height + 10);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test_answer"]){
            CGContextTranslateCTM(context,-50, self.frame.size.height + 5);
            CGContextScaleCTM(context, 0.75, -0.70);
        }
    }else if (IS_IPHONE6_PLUS){
        if([_fileName isEqualToString:@"test0"]){
            if(_pageNumber == 2){
                CGContextTranslateCTM(context,-50, self.frame.size.height - 20);
                CGContextScaleCTM(context, 0.75, -0.75);
            }else{
                CGContextTranslateCTM(context,-50, self.frame.size.height - 20);
                CGContextScaleCTM(context, 0.75, -0.75);
            }
        }
        else if ([_fileName isEqualToString:@"test1"]){
            if(_pageNumber == 2){
                CGContextTranslateCTM(context,-60, self.frame.size.height + 10);
                CGContextScaleCTM(context, 0.75, -0.8);
            }else{
                CGContextTranslateCTM(context,-60, self.frame.size.height + 10);
                CGContextScaleCTM(context, 0.75, -0.8);
            }
        }else if ([_fileName isEqualToString:@"test2"]){
            CGContextTranslateCTM(context,-60, self.frame.size.height - 30);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test3"]){
            CGContextTranslateCTM(context,-50, self.frame.size.height - 50);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test4"]){
            CGContextTranslateCTM(context,-60, self.frame.size.height - 20);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test5"]){
            CGContextTranslateCTM(context,-40, self.frame.size.height - 20);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test6"]){
            CGContextTranslateCTM(context,-40, self.frame.size.height - 20);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test_answer"]){
            CGContextTranslateCTM(context,-50, self.frame.size.height + 5);
            CGContextScaleCTM(context, 0.75, -0.70);
        }

    }else if (IS_IPHONE4_OR_S){
        if([_fileName isEqualToString:@"test0"]){
            if(_pageNumber == 2){
                CGContextTranslateCTM(context,-70, self.frame.size.height + 60);
                CGContextScaleCTM(context, 0.75, -0.75);
            }else{
                CGContextTranslateCTM(context,-70, self.frame.size.height + 30);
                CGContextScaleCTM(context, 0.75, -0.75);
            }
        }
        else if ([_fileName isEqualToString:@"test1"]){
            if(_pageNumber == 2){
                CGContextTranslateCTM(context,-60, self.frame.size.height + 140);
                CGContextScaleCTM(context, 0.75, -0.8);
            }else{
                CGContextTranslateCTM(context,-60, self.frame.size.height + 100);
                CGContextScaleCTM(context, 0.75, -0.8);
            }
        }else if ([_fileName isEqualToString:@"test2"]){
            CGContextTranslateCTM(context,-60, self.frame.size.height + 85);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test3"]){
            CGContextTranslateCTM(context,-70, self.frame.size.height + 80);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test4"]){
            CGContextTranslateCTM(context,-70, self.frame.size.height + 80);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test5"]){
            CGContextTranslateCTM(context,-70, self.frame.size.height + 80);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test6"]){
            CGContextTranslateCTM(context,-65, self.frame.size.height + 70);
            CGContextScaleCTM(context, 0.75, -0.75);
        }else if ([_fileName isEqualToString:@"test_answer"]){
            CGContextTranslateCTM(context,-65, self.frame.size.height + 55);
            CGContextScaleCTM(context, 0.75, -0.70);
        }

    }
    [self displayPDFPage:context WithSize_t:_pageNumber WithFilePath:_filePath];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"first_use_PDF_view"]){
        if(IS_IPHONE5_OR_S_C)
            [self loadGuideForIphone5];
        else
            [self loadGuideForIphone6];
        [self performSelector:@selector(remove) withObject:nil afterDelay:2];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"first_use_PDF_view"];
    }
}



#pragma mark --
#pragma 自定义的方法/获取PDF文件
-(CGPDFDocumentRef)getPDFDocumentRef:(NSString *)filePath{
    CFStringRef path;
    CFURLRef url;
    CGPDFDocumentRef document;
    path = CFStringCreateWithCString (NULL, [filePath UTF8String], kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
    document = CGPDFDocumentCreateWithURL (url);
    CFRelease(url);
    return document;
}

-(void)displayPDFPage:(CGContextRef)contecxt WithSize_t:(size_t)page_Number WithFilePath:(NSString *)file_Path{
    CGPDFDocumentRef document;
    CGPDFPageRef page;
    document = [self getPDFDocumentRef:file_Path];
    page = CGPDFDocumentGetPage (document, page_Number);
    CGContextDrawPDFPage (contecxt, page);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    BOOL isHidden = [[[NSUserDefaults standardUserDefaults] objectForKey:@"navigationBarIsHidden"] boolValue];
    isHidden = !isHidden;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:isHidden] forKey:@"navigationBarIsHidden"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenOrShowNavigationBar"
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:isHidden],@"isHidden" ,nil]];
}


#pragma mark--
#pragma 添加新手指导
-(void)loadGuideForIphone5{
    _guideImage = [UIImageView new];
    _guideImage.frame = [[UIScreen mainScreen] bounds];
    _guideImage.image = [UIImage imageNamed:@"guide_for_iPhone5_4"];
    [self addSubview:_guideImage];
}

-(void)loadGuideForIphone6{
    _guideImage = [UIImageView new];
    _guideImage.frame = [[UIScreen mainScreen] bounds];
    _guideImage.image = [UIImage imageNamed:@"guide_for_iPhone6_4"];
    [self addSubview:_guideImage];
}

-(void)remove{
    [UIView animateWithDuration:0.5 animations:^{
        _guideImage.alpha = 0;
    }];
    [_guideImage performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
}

@end
