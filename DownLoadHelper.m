//
//  DownLoadHelper.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/3.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "DownLoadHelper.h"

#define FILE_DEFAULT_PATH   [[NSHomeDirectory() stringByAppendingString:@"/Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"Chapter0%d.pdf",_tag]]

@implementation DownLoadHelper

-(instancetype)initWithURL:(NSURL *)url withProgressView:(UIProgressView *)progressView{
    self = [super init];
    if(self){
        _progressView = progressView;
        _request = [[NSURLRequest alloc] initWithURL:url];
    }
    return self;
}

-(void)beginDownLoad{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLSessionDownloadTask *downLoadTask = [manager downloadTaskWithRequest:_request
                                                                     progress:nil
                                                                  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response){
                                                                      NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                                                                      return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
                                                                  }
                                                            completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error){
                                                                if(!error){
                                                                    [_delegate downLoadComplete];
                                                                }else{
                                                                    [_delegate downLoadFailed];
                                                                }
                                                            }
                                              ];
    [downLoadTask resume];
}


@end
