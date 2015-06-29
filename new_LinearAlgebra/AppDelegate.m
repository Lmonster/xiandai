//
//  AppDelegate.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/21.
//  Copyright (c) 2015年 付国强. All rights reserved.
//


/**
 
 这是整个应用的第一个重要的文件，是一个开始的界面，也是整个界面的基础。所有的界面均是以他为基础所建立的。应用采用的是以UINavagation这个控件来管理UIViewController的，也就是第一个方法中的navigation这个instance。而这个实例是建立在window这个根之中的，一个应用一般情况下来说是有一个window的。而我们的应用就是只有一个window
 
 */
#import "AppDelegate.h"
#import "ConstantHeader.h"
#import "ViewController.h"
#import "AFNetworkReachabilityManager.h"
#import "MobClick.h"
//#import "BaiduMobStat.h"
#import "TopNavigationViewController.h"
#import "XGPush.h"
#import "XGSetting.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate () 

#define _IPHONE80_      80000

@end

@implementation AppDelegate {
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /**
     注册到APNs
     */
    [XGPush startApp:2200104951 appKey:@"IZ5Y35Y4Y3NR"];
    
    void (^successCallback)(void) = ^(void){
        //如果变成需要注册状态
        if(![XGPush isUnRegisterStatus])
        {
            //iOS8注册push方法
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
            
            float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
            if(sysVer < 8){
                [self registerPush];
            }
            else{
                [self registeriOS8];
            }
#else
            //iOS8之前注册push方法
            //注册Push服务，注册后才能收到推送
            [self registerPush];
#endif
        }
    };
    [XGPush initForReregister:successCallback];
    
    //推送反馈回调版本示例
    void (^successBlock)(void) = ^(void){
        //成功之后的处理
        NSLog(@"[XGPush]handleLaunching's successBlock");
    };
    
    void (^errorBlock)(void) = ^(void){
        //失败之后的处理
        NSLog(@"[XGPush]handleLaunching's errorBlock");
    };
    
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //清除所有通知(包含本地通知)
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [XGPush handleLaunching:launchOptions successCallback:successBlock errorCallback:errorBlock];
    

    /**
     添加友盟移动统计
     */
    
    [MobClick startWithAppkey:@"54feea55fd98c5d155000568" reportPolicy:BATCH channelId:@""];
    [MobClick setAppVersion:APP_VERSION];
    
    /**
    添加百度移动统计
     */
//    BaiduMobStat *baiduStat = [BaiduMobStat defaultStat];
//    [baiduStat startWithAppId:@"cf931fa7f1"];
//    baiduStat.shortAppVersion = APP_VERSION;
    
    
    /**    给window一个实例，并且要注意的是必须设定window的大小，他的大小必须要和Screen/bounds的大小一致，否则就会发生警告，影响后续功能的实现                                                                 */
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *controller = [UIViewController new];

    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"first_use_app"]){
        float height = [[UIScreen mainScreen] bounds].size.height;
        float width = [[UIScreen mainScreen] bounds].size.width;
        _scrollView = [UIScrollView new];
        _scrollView.frame = [[UIScreen mainScreen] bounds];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * 4, [[UIScreen mainScreen] bounds].size.height);
        for(int i = 0; i< 4; i++){
            UIImageView *imageView = [UIImageView new];
            imageView.frame = CGRectMake(i * width, 0, width, height);
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"preView_%d",i+1]];
            [_scrollView addSubview:imageView];
        }
        self.window.rootViewController = controller;
        [controller.view addSubview:_scrollView];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"first_use_app"];
    }else{
        [self loadRealMainView];
    }
    
/**      这是比较重要的一句，如果没有将无法显示界面                                                */
    [self.window makeKeyAndVisible];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Are you forgetting something?";
    notification.soundName = @"Default";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"进入了后台"); 
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"即将进入了后台");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"重新进入了后台");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark --
#pragma APNs
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    void (^successBlock)(void) = ^(void){
        //成功之后的处理
        NSLog(@"[XGPush]register successBlock");
    };
    
    void (^errorBlock)(void) = ^(void){
        //失败之后的处理
        NSLog(@"[XGPush]register errorBlock");
    };
    
    NSString * deviceTokenStr = [XGPush registerDevice:deviceToken successCallback:successBlock errorCallback:errorBlock];
    
    //如果不需要回调
    //[XGPush registerDevice:deviceToken];
    
    //打印获取的deviceToken的字符串
    NSLog(@"deviceTokenStr is %@",deviceTokenStr);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"fali to register\n");
    NSLog(@"%@",error);
}


#pragma mark --
#pragma scrollView delegate 
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.x > [[UIScreen mainScreen] bounds].size.width * 3){
        [_scrollView removeFromSuperview];
        [self loadRealMainView];
    }
}

/**
    检测网络
 */
-(void)loadRealMainView{
    //    用来检测网络状况的
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus stasu){
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:stasu] forKey:@"NetConnectStatus"];
        if(stasu == AFNetworkReachabilityStatusReachableViaWiFi){
        }if(stasu == AFNetworkReachabilityStatusNotReachable){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"检测到您的设备没有联网，这将影响到部分功能的使用" delegate:self cancelButtonTitle:@"去连接网络吧，亲" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    /**    建立一个持久化存储的值将来用来记录UINavagationBar的hidden与否                                    */
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"navigationBarIsHidden"];
    
    
    
    /**    这是生成的第一个ViewController，即是本应用的主界面                                        */
    ViewController *view  =[[ViewController alloc] init];
    
    
    
    /**     这是所有UIViewController的一个容器（可是这么讲，但是更好的说法是一个堆栈）并且将第一个ViewController压入栈中                                                                                    */
//    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:view];
    TopNavigationViewController *aNavigation = [[TopNavigationViewController alloc] initWithRootViewController:view];
//    self.window.rootViewController = navigation;
    self.window.rootViewController = aNavigation;

}

#pragma mark --
#pragma 进行推送通知的配置

//**************************registeriOS8****************************

-(void)registeriOS8{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
    //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    //Actions
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    
    acceptAction.identifier = @"ACCEPT_IDENTIFIER";
    acceptAction.title = @"Accept";
    
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction.destructive = NO;
    acceptAction.authenticationRequired = NO;
    
    //Categories
    UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    
    inviteCategory.identifier = @"INVITE_CATEGORY";
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
    
    NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
    
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}

//************************registerPush(注册iOS8以下版本的设备)*******************************

- (void)registerPush{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

//***********************local notification***************************

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [XGPush handleReceiveNotification:userInfo];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    NSLog(@"setting set success");
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

@end
