//
//  DownLoadHelper.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/3.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol BeginRefreshProcessViewDelegate <NSObject>

-(void)RefreshProcessView:(float)process;

-(int)getDownLoadURLTag;

-(void)downLoadComplete;

-(void)downLoadFailed;


@end

@interface DownLoadHelper : NSObject

@property (strong ,nonatomic) UIProgressView *progressView;

@property (strong ,nonatomic) NSURLRequest *request;

@property (strong ,nonatomic) id <BeginRefreshProcessViewDelegate> delegate;


-(instancetype)initWithURL:(NSURL *)url withProgressView:(UIProgressView *)progressView;

-(void)beginDownLoad;

@end
