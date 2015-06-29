//
//  downLoadTableViewCell.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/3.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "downLoadTableViewCell.h"
#import "ConstantHeader.h"

#define COLOR_MIX(x,y,z,alp)    [UIColor colorWithRed:x/255.0 green:y/255. blue:z/255. alpha:alp]

#define FILE_DEFAULT_PATH   [[NSHomeDirectory() stringByAppendingString:@"/Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"Chapter0%d.pdf",_index + 1]]


#define BUTTON_SELECT           1000
#define BUTTON_DESELECT         1001
#define BUTTON_FINISHDOWN       1002

@implementation downLoadTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withIndex:(int)index{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _index = index;
        _chapterInfo_lable = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height/2, self.frame.size.width/2, self.frame.size.height - 20)];
        _downLoadButton = [[UIButton alloc] initWithFrame:CGRectMake(50 + _chapterInfo_lable.frame.size.width, 30, self.frame.size.width/3, self.frame.size.height/2)];
        
        [_downLoadButton setTitle:@"下载" forState:UIControlStateNormal];
        [_downLoadButton setTitle:@"下载中" forState:UIControlStateSelected];
        [_downLoadButton addTarget:self action:@selector(beginDownload) forControlEvents:UIControlEventTouchDown];
        [_downLoadButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [_downLoadButton setBackgroundColor:COLOR_MIX(176, 196, 222, 1)];
        _downLoadButton.layer.cornerRadius = 5;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if( (_fileExits = [fileManager fileExistsAtPath:FILE_DEFAULT_PATH])){
            [self changeButtonAppence:BUTTON_FINISHDOWN];
        }else{
            [self changeButtonAppence:BUTTON_DESELECT];
        }
        
        [self addSubview:_chapterInfo_lable];
        [self addSubview:_downLoadButton];
    }
    return self;
}

-(void)beginDownload{
    
    [self changeButtonAppence:BUTTON_SELECT];
    NSString *urlString = [NSString stringWithFormat:@"http://xxdsapp.710071.net/downLoad/Chapter0%ld.pdf",(long)self.index + 1];
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"NetConnectStatus"] == AFNetworkReachabilityStatusNotReachable){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"设备没有联网，将无法提供下载功能" delegate:nil
                                                  cancelButtonTitle:@"返回"
                                                  otherButtonTitles: nil, nil];
        [alertView show];
    }
    else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            _downLoadHelper = [[DownLoadHelper alloc] initWithURL:[NSURL URLWithString:urlString] withProgressView:_downLoadProcessView];
            _downLoadHelper.delegate = self;
            [_downLoadHelper beginDownLoad];
        });
    }
}
#pragma mark --
#pragma Button不同状态的转换

-(void)changeButtonAppence:(int)state{
    
    if(state == BUTTON_SELECT){
        _downLoadButton.selected = YES;
    }else if (state == BUTTON_DESELECT){
        _downLoadButton.selected = NO;
    }else{
        _downLoadButton.userInteractionEnabled = NO;
        [_downLoadButton setBackgroundColor:WHITE_COLOR];
        _downLoadButton.selected = NO;
        [_downLoadButton setTitle:@"已下载" forState:UIControlStateNormal];
        [_downLoadButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}



#pragma mark--
#pragma DownLoadTableViewCell Delegate

-(void)RefreshProcessView:(float)process{
    _downLoadProcessView.progress = process;
}

-(int)getDownLoadURLTag{
    return (int)self.tag;
}

-(void)downLoadComplete{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:nil message:@"下载完成" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
    [view show];
    [self changeButtonAppence:BUTTON_FINISHDOWN];
}

-(void)downLoadFailed{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:nil message:@"下载失败" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
    [view show];
    _downLoadButton.selected = NO;
    [self changeButtonAppence:BUTTON_DESELECT];
}

#pragma mark --
#pragma 生成动画
-(CABasicAnimation *)beginAnimation{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position";
    animation.fromValue = [NSValue valueWithCGPoint:_downLoadButton.layer.position];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(40 + _chapterInfo_lable.frame.size.width, 35)];
    animation.duration = 1.0;
    return animation;
}

@end
