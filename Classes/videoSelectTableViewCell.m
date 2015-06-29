//
//  videoSelectTableViewCell.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/6/24.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "videoSelectTableViewCell.h"

// make the downloadTask a static variable to remain in the memory
// in case of users back to the upper view
static NSURLSessionDownloadTask    *downloadTask;

@implementation videoSelectTableViewCell {
    NSURLSession                *aSession;
    NSString                    *filePath;
    NSOperationQueue            *queue;
    UIImageView                 *processImage;
}

- (void)awakeFromNib {
    
    [_mainTitle setFont:[UIFont fontWithName:@"Thonburi" size:10]];
    [_descriptionTitle setFont:[UIFont fontWithName:@"Thonburi" size:8]];
    _mainTitle.text = @"";
    queue = [[NSOperationQueue alloc] init];
    _processView.alpha = 0;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    aSession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:queue];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark *****button event*****

- (IBAction)download:(id)sender {
    
    filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"video%d.mp4",(int)self.tag]];
    if(_fileExits) {
        
    }else {
        
        self.userInteractionEnabled = NO;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://xxdsapp.710071.net/video/video%d.mp4",(int)self.tag]];
        _processLabel.text = @"下载中";
        _processLabel.textColor = [UIColor whiteColor];
        [_processLabel setFont:[UIFont fontWithName:@"Thonburi" size:_processView.bounds.size.height / 2]];
        _processView.bounds = self.bounds;
        _processView.center = CGPointMake(self.center.x - self.bounds.size.height, CGRectGetMidY(self.bounds));
        _processView.backgroundColor = [UIColor blackColor];
        _processView.alpha = 0.7;
        downloadTask = [aSession downloadTaskWithURL:url];
        [downloadTask resume];
        [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:0 animations:^{
            _processView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        } completion:^(BOOL finishi){
        }];
    }
}


#pragma mark *****NSURLSession download task*****

// begin to reveive the data from server
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
}

// recode the process of the downloading
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    NSLog(@"precess is :%f",(float)totalBytesWritten / totalBytesExpectedToWrite);
}


// do finish the download process
// here move the temp data to my location to save to video
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *data = [NSData dataWithContentsOfURL:location];
    [fileManager createFileAtPath:filePath contents:data attributes:0];
    NSLog(@"filePath is %@",filePath);
    _processView.alpha = 0;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"下载成功"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCell" object:nil];
}

// call when download finish no matter the result of process
- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    self.userInteractionEnabled = YES;
    
    if(error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告"
                                                            message:@"下载失败，请检查网络设置"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }else {
        downloadTask = nil;
        aSession = nil;
        filePath = nil;
        filePath = nil;
    }
}

#pragma mark ****custom methods**********
- (void)beginDownload {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://xxsdsapp.710071.video/video%d.mp4",(int)self.tag]];
    downloadTask = [aSession downloadTaskWithURL:url];
    [downloadTask resume];
}

@end
