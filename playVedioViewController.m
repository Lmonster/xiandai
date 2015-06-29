//
//  playVedioViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/4/8.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "playVedioViewController.h"
#import "PlayerLayer.h"
#import "ConstantHeader.h"
#import <AVFoundation/AVFoundation.h>
#import <sqlite3.h>

@interface playVedioViewController ()<UITableViewDataSource,UITableViewDelegate,NSURLSessionDataDelegate>

@end

NSString *fetchString;

@implementation playVedioViewController{
    UITableView *aTableView;
    UIImage *Vedioimage;
    NSMutableArray *imageArray;
    NSMutableArray *nameArray;
    NSMutableArray *vedioArray;
    AVPlayerItem *currentItem;
    AVPlayerItem *lastItem;
    sqlite3 *sqliteHandle;
}

-(instancetype)init{
    self = [super init];
    if(self){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotate:) name:@"rotateView" object:nil];
        aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 260, MAIN_SCREEN_X, MAIN_SCREEN_Y - 200) style:UITableViewStylePlain];
        _playerLayer = [[PlayerLayer alloc] initWithFrame:CGRectMake(0, 60, MAIN_SCREEN_X, 200)];
        _playerLayer.layer.masksToBounds = YES;
        aTableView.delegate = self;
        aTableView.dataSource = self;
        imageArray = [[NSMutableArray alloc] init];
        vedioArray = [[NSMutableArray alloc] init];
        nameArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_isMooc) {
//        currentItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"mooc1" ofType:@"mp4"]]];
        currentItem  = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"http://xxdsapp.710071.net/video/video3.mp4"]];
//        [self.playerLayer.player replaceCurrentItemWithPlayerItem:currentItem];
    }else{
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_playerLayer];
    [self.view addSubview:aTableView];
    [self fetchData];
    [aTableView reloadData];
    
    if(_isMooc){
        lastItem = self.playerLayer.player.currentItem;
//        currentItem = [[AVPlayerItem alloc] initWithURL:[[NSBundle mainBundle] URLForResource:@"mooc1" withExtension:@"mp4"]];
//        currentItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"]];
        currentItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"http://xxdsapp.710071.net/video/video1.mp4"]];
        [self.playerLayer.player replaceCurrentItemWithPlayerItem:currentItem];
        lastItem = nil;
    }else{
        lastItem = self.playerLayer.player.currentItem;
//        currentItem = [[AVPlayerItem alloc] initWithURL:[[NSBundle mainBundle] URLForResource:@"video1" withExtension:@"mp4"]];
        currentItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"http://xxdsapp.710071.net/video/video1.mp4"]];
        [self.playerLayer.player replaceCurrentItemWithPlayerItem:currentItem];
        lastItem = nil;
    }
    
    AVPlayerItem *item = currentItem;
    UIProgressView *progress = self.playerLayer.infoView.progress;
    [self.playerLayer.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 10)
                                                          queue:dispatch_get_main_queue()
                                                     usingBlock:^(CMTime time){
                                                         [progress setProgress:CMTimeGetSeconds(item.duration)/CMTimeGetSeconds(time) animated:YES];
                                                     }];
}


#pragma Mark--
#pragma UITableViewdelegata
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [nameArray count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell ==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%ld.png",(long)indexPath.row+1]];
    }
    cell.textLabel.text = [vedioArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [nameArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    lastItem = self.playerLayer.player.currentItem;
    if(_isMooc){
        currentItem = [[AVPlayerItem alloc] initWithURL:[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"mooc%u",(unsigned int)indexPath.row+1] withExtension:@"mp4"]];
    }else{
        currentItem = [[AVPlayerItem alloc] initWithURL:[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"video%ld",(long)indexPath.row+1] withExtension:@"mp4"]];
    }
    [self.playerLayer.player replaceCurrentItemWithPlayerItem:currentItem];
    [self.playerLayer.player play];
    lastItem = nil;
}

-(void)rotate:(NSNotification *)notic{
    
    if([[[notic userInfo] valueForKey:@"isRotate"] boolValue]) {
        aTableView.alpha = 0;
        self.navigationController.navigationBarHidden = YES;
    }
    else {
        aTableView.alpha = 1;
        self.navigationController.navigationBarHidden = NO;
    }
}

#pragma mark -- 
#pragma sqlite

-(BOOL)openSqlite{
    NSString *fileNameString = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"sqlite"];
    const char *fileName = [fileNameString cStringUsingEncoding:NSUTF8StringEncoding];
    return sqlite3_open(fileName, &sqliteHandle);
}

-(void)fetchData{
    if([self openSqlite] == SQLITE_OK){
        if(self.isMooc)
            fetchString = @"select *from mookinfo";
        else
            fetchString = @"select *from videoinfo";
        
        sqlite3_stmt *stmt;
        
        if(sqlite3_prepare_v2(sqliteHandle, [fetchString UTF8String],-1, &stmt, nil) == SQLITE_OK){
            while (sqlite3_step(stmt) == SQLITE_ROW){
                NSString *string = [NSString stringWithCString:(const char *)sqlite3_column_text(stmt, 0) encoding:NSUTF8StringEncoding];
                if(string){
                    [vedioArray addObject:string];
                    string = nil;
                }
                string = [NSString stringWithCString:(const char *)sqlite3_column_text(stmt, 1) encoding:NSUTF8StringEncoding];
                if(string){
                    [nameArray addObject:string];
                    string = nil;
                }
            }
        }
    }else{
        
    }
}




@end
