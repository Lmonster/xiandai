//
//  videoDisplayCellTableViewCell.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/6/24.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "videoDisplayCellTableViewCell.h"
#import "AFNetworking.h"

@implementation videoDisplayCellTableViewCell {
    NSURLSession *session;
    NSURLSessionDownloadTask *download;
    NSOperationQueue *queue;
    NSFileManager *fileManager;
    NSString *filePath;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        queue = [[NSOperationQueue alloc] init];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    }
    return self;
}



-(void)beginDownload {
    
    download = [session downloadTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://xxdsapp.710071.net/video/video%d.mp4",(int)self.tag]]];
    filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"video%d.mp4",(int)self.tag]];
    fileManager = [NSFileManager defaultManager];
    [download resume];
}

#pragma mark -urlsession task

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    NSLog(@"正在发送数据");
}
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    NSLog(@"download processs is %f",((float)totalBytesWritten / totalBytesExpectedToWrite));
}

-(void)URLSession:(NSURLSession *)session
     downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    
    if([fileManager fileExistsAtPath:[location path]]) {
        NSLog(@"file exits");
    }else {
        NSLog(@"file not exits");
    }
    NSData *data = [NSData dataWithContentsOfFile:location.path];
    [fileManager createFileAtPath:filePath contents:data attributes:0];
    
    NSLog(@"system location is %@",location);
    NSLog(@"my location is %@",filePath);
    
//    if(error) {
//        NSLog(@"error to move the video to location %@",error.description);
//    }else {
//        NSLog(@"download and move to location successfully");
//    }
}



@end
