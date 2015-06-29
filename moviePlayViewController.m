//
//  moviePlayViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/6/25.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "moviePlayViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface moviePlayViewController ()

@end

@implementation moviePlayViewController {
    MPMoviePlayerController *mpCV;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"filePath%@",_filePath);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDone) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)beginPlay {
    
    mpCV = [[MPMoviePlayerController alloc] initWithContentURL:[[NSURL alloc] initFileURLWithPath:_filePath isDirectory:NO]];
    NSLog(@"file path(URL) 2 is %@",[[NSURL alloc] initFileURLWithPath:_filePath isDirectory:NO]);
    mpCV.movieSourceType = MPMovieSourceTypeFile;
    mpCV.controlStyle = MPMovieControlStyleEmbedded;
    mpCV.scalingMode = MPMovieScalingModeAspectFit;
    mpCV.backgroundView.backgroundColor = [UIColor blackColor];
    mpCV.shouldAutoplay = YES;
    [mpCV.view setFrame:self.view.frame];
    [mpCV play];
    if(mpCV) {
        [self.view addSubview:mpCV.view];
    }
}

- (void)playDone {
    [mpCV.view removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    mpCV = nil;
}

- (void)dealloc {
    [mpCV.view removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    mpCV = nil;
}
@end
