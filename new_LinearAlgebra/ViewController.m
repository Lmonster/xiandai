//
//  ViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/21.
//  Copyright (c) 2015年 付国强. All rights reserved.
//


/** 
 
    应用的主界面，是各个功能的入口处，采用的是UICollectiveView作为基础界面来管理各个入口。
    文件的大部分实现的是UICollectiveView的构建和delegate的实现.
 
 */

#import "ViewController.h"
#import "updatePicViewController.h"
#import "videoListViewController.h"
#import "Header.h"
#import "ForumViewController.h"
#import "problemListViewController.h"
#import <CoreLocation/CoreLocation.h>

#define MAIN_SCREEN_RECT                 [[UIScreen mainScreen] bounds]

#define SCROLLVIEWFRAME                  CGRectMake (0,0,[[UIScreen mainScreen] bounds].size.width,146)

#define COLLECTVIEWFRAME                 CGRectMake (4,60,MAIN_SCREEN_RECT.size.width - 8,MAIN_SCREEN_RECT.size.height)



@interface ViewController ()
<drawViewDelegate>

@end

@implementation ViewController{
//    用来判断头部cell是否会到首页的一个变量
    int isGoBack;
    int isdrawerShow;
    int BGDefaultTag;
}

-(id)init{
    self = [super init];
    if(self){
    }
    return self;
}


-(void)viewDidLoad {
    
    [super viewDidLoad];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"BGTagSelect"]){
        [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"BGTagSelect"];
    }
    BGDefaultTag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"BGTagSelect"] intValue];
    [self.view setBackgroundColor:WHITE_COLOR];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关于"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(showDrawer)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:0.3 alpha:0.7];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.alpha = 0.5;
    _drawer = [new_drawer new];
    _drawer.frame = CGRectMake(0, 60, 150, MAIN_SCREEN_Y);
    _drawer.backgroundColor = WHITE_COLOR;
    _drawer.delegate = self;
    [self.view addSubview:_drawer];
//    添加一个观察者来来观察是否有通知“hiddenOrShowNavigationBar”在通知中心发布，这个通知是用来判断隐藏还是现实UINaviagtionBr的
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hiddenOrShowNavigationBar:) name:@"hiddenOrShowNavigationBar"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(postIntroductionView)
                                                 name:@"postCourseIntroduction"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(postProblemList) name:@"postProblemList"
                                               object:nil];

//    配置一些navigationController的相关量
    self.title = @"线性代数学习软件";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationController.navigationBar.frame].CGPath;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 0.1);
    self.navigationController.navigationBar.layer.shadowOpacity = 0.1;
//    初始化collectionView
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.minimumInteritemSpacing = 5;
    layOut.minimumLineSpacing = 3;
    
    //  各种控件的初始化
    
    _collectionView = [[UICollectionView alloc] initWithFrame:COLLECTVIEWFRAME collectionViewLayout:layOut];
    _scrollView = [[UIScrollView alloc] init];
    
    
    //  控件位置等性质的设置
    
    _scrollView.frame = SCROLLVIEWFRAME;
    _collectionView.frame = COLLECTVIEWFRAME;

    
    
    
    //  配置collectionView
    
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    
    //  配置其他控件
    _scrollView.contentSize = CGSizeMake(MAIN_SCREEN_X * 2, 146);
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    //添加手势
    UISwipeGestureRecognizer *gesture_right = [UISwipeGestureRecognizer new];
    gesture_right.direction = UISwipeGestureRecognizerDirectionRight;
    [gesture_right addTarget:self action:@selector(showDrawer:)];
    UISwipeGestureRecognizer *gesture_left = [UISwipeGestureRecognizer new];
    gesture_left.direction = UISwipeGestureRecognizerDirectionLeft;
    [gesture_left addTarget:self action:@selector(showDrawer:)];
    UISwipeGestureRecognizer *gesture_up = [UISwipeGestureRecognizer new];
    gesture_up.direction = UISwipeGestureRecognizerDirectionUp;
    [gesture_up addTarget:self action:@selector(rotateCell)];
    UISwipeGestureRecognizer *gesture_down = [UISwipeGestureRecognizer new];
    [gesture_down addTarget:self action:@selector(rotateCell)];
    [_collectionView addGestureRecognizer:gesture_left];
    [_collectionView addGestureRecognizer:gesture_right];
    [_collectionView addGestureRecognizer:gesture_up];
    [self.view addSubview:_collectionView];
}


-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma collectionView dataSource 的实现

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 9;
    return 7;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if(cell == nil){
        cell = [[UICollectionViewCell alloc] init];
    }
    
    if(indexPath.row == 0){
        UIView *shwoProblemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_X, 146)];
        shwoProblemView.backgroundColor = [UIColor whiteColor];
        UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_X, 146)];
        [shwoProblemView addSubview:aLabel];
        aLabel.text = @"常见问题总结";
        aLabel.layer.shadowOffset = CGSizeMake(5, 10);
        aLabel.layer.shadowOpacity = NO;
        CGRect rect = aLabel.bounds;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
        aLabel.layer.shadowPath = path.CGPath;
        [aLabel setFont:[UIFont fontWithName:@"Verdana" size:60]];
//        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_X, 146)];
        UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_X , 0, MAIN_SCREEN_X, 146)];
//        imageView1.image = [UIImage imageNamed:@"headDefaultImage1.png"];
        imageView2.image = [UIImage imageNamed:@"headDefaultImage2.jpg"];
//        [_scrollView addSubview:imageView1];
        [_scrollView addSubview:shwoProblemView];
        [_scrollView addSubview:imageView2];
        cell.backgroundView = _scrollView;
    }
    else{
        if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"BGTagSelect"] intValue])
            cell.layer.contents = (__bridge id)[UIImage imageNamed:[NSString stringWithFormat:@"icon%ld_1@2x",(long)indexPath.row]].CGImage;
        else
            cell.layer.contents = (__bridge id)[UIImage imageNamed:[NSString stringWithFormat:@"icon%ld_%d@2x",(long)indexPath.row,BGDefaultTag]].CGImage;
    }
    cell.tag = indexPath.row;
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(IS_IPHONE5_OR_S_C){
        if(indexPath.row ==0){
            return CGSizeMake(MAIN_SCREEN_X - 8, 146);
        }
        else{
            return CGSizeMake(153, 115);
        }
    }else if (IS_IPHONE4_OR_S){
        if(indexPath.row ==0){
            return CGSizeMake(MAIN_SCREEN_X - 8, 116);
        }
        else{
            return CGSizeMake(153, 100);
        }
    }else if(IS_IPHONE6){
        if(indexPath.row ==0){
            return CGSizeMake(MAIN_SCREEN_X - 8, 156);
        }
        else{
            return CGSizeMake(181, 145);
        }
    }else{
        if(indexPath.row ==0){
            return CGSizeMake(MAIN_SCREEN_X - 8, 176);
        }else{
            return CGSizeMake(200.5, 168);
        }
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    int selectedItem = (int)indexPath.row;
    UICollectionViewCell *tempCell = [collectionView cellForItemAtIndexPath:indexPath];
    if(selectedItem != 0)
        [tempCell.layer addAnimation:[self createAnimation] forKey:nil];
    if(selectedItem == 0){
        problemListViewController *vc = [[problemListViewController alloc] init];
        [self performSelector:@selector(pushView:) withObject:vc afterDelay:0.25];
    }else if (selectedItem == 1){
         ECoursewareViewController *viewController = [[ECoursewareViewController alloc] init];
        [self performSelector:@selector(pushView:) withObject:viewController afterDelay:0.25];
        
    }else if (selectedItem == 2){
        videoListViewController *viewController = [[videoListViewController alloc] init];
        [self performSelector:@selector(pushView:) withObject:viewController afterDelay:0.25];
    }else if (selectedItem == 3){
        PicExperienceViewController *viewcontroller = [[PicExperienceViewController alloc] init];
        [self performSelector:@selector(pushView:) withObject:viewcontroller afterDelay:0.25];
        
    }else if (selectedItem == 4){
        ForumViewController *viewController = [[ForumViewController alloc] init];
//        ForumViewTSController *viewController = [[ForumViewTSController alloc] init];
        [self performSelector:@selector(pushView:) withObject:viewController afterDelay:0.25];
    }else if (selectedItem == 5){
        toolsIntroductionViewController *viewController = [[toolsIntroductionViewController alloc] init];
        [self performSelector:@selector(pushView:) withObject:viewController afterDelay:0.25];
    }else if (selectedItem == 6){
        ExerciseViewController *viewController = [[ExerciseViewController alloc] init];
        [self performSelector:@selector(pushView:) withObject:viewController afterDelay:0.25];
    }else if (selectedItem == 7){
//        updatePicViewController *viewController =[[updatePicViewController alloc] init];
//        [self performSelector:@selector(pushView:) withObject:viewController afterDelay:0.25];
    }else if (selectedItem == 8){
        
    }
}

#pragma  mark --
#pragma 自定义的方法的实现

/** 
    Description: 用来控制头部ScrollVeiw的滚动
    Parament: none   
    returnValue: none                
 */
-(void)scroll{
    isGoBack = 1-isGoBack;
    [UIView animateWithDuration:1.0 animations:^{
        _scrollView.contentOffset = CGPointMake(MAIN_SCREEN_X * isGoBack, 0);
    } completion:^(BOOL finish){
        
    }];
}


/** 
    Description: 用来创建动画的方法，动画的keypath是bounds
    Parameter: none
    returnValue: 创建的动画
 */
-(CAKeyframeAnimation *)createAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"bounds";
    if(IS_IPHONE5_OR_S_C){
        animation.values = [NSArray arrayWithObjects:[NSValue valueWithCGRect:CGRectMake(0, 0, 153, 115)],
                            [NSValue valueWithCGRect:CGRectMake(5,0, 140, 110)],
                            [NSValue valueWithCGRect:CGRectMake(0, 0, 153, 115)],nil];
    }else if (IS_IPHONE6){
        animation.values = [NSArray arrayWithObjects:[NSValue valueWithCGRect:CGRectMake(0, 0, 181, 145)],
                            [NSValue valueWithCGRect:CGRectMake(5,0, 165, 140)],
                            [NSValue valueWithCGRect:CGRectMake(0, 0, 181, 145)],nil];
    }
    animation.duration = 0.25;
    return animation;
}


/** 
    Description: 用来pushviewController的方法
    Parameter: 用来push到navagationController的ViewController
    returnValue: none               
 */
-(void)pushView:(UIViewController *)viewController{
    [self.navigationController pushViewController:viewController animated:YES];
}


/** 
    Description: 通知方法，用来实现navigatonBar的显示与否
    Parameter: 公布的通知
    retureValue: none               
 */
-(void)hiddenOrShowNavigationBar:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    if([[info objectForKey:@"isHidden"] boolValue]){
        self.navigationController.navigationBarHidden = YES;
    }else{
        self.navigationController.navigationBarHidden = NO;
    }
}

- (void)postProblemList {
    problemListViewController *vc = [[problemListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 
   显示课程简介
 
 */
-(void)postIntroductionView{
    courseIntroductionViewController *viewController = [courseIntroductionViewController new];
    viewController.view.backgroundColor = WHITE_COLOR;
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
 
   显示drawer
 
*/
-(void)showDrawer{
    if(!isdrawerShow){
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5
                            options:0 animations:^{
                                _drawer.backgroundColor = [UIColor colorWithRed:81/255. green:81/255. blue:81/255. alpha:1];
                                _drawer.alpha = 1;
                                _collectionView.frame = CGRectMake(150, 60, MAIN_SCREEN_X - 8, MAIN_SCREEN_Y);
                            } completion:nil];
    }else{
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5
                            options:0 animations:^{
                                _drawer.backgroundColor = WHITE_COLOR;
                                _drawer.alpha = 0;
                                _collectionView.frame = COLLECTVIEWFRAME;
                            } completion:nil];
    }
    isdrawerShow = !isdrawerShow;

}


-(void)showDrawer:(UISwipeGestureRecognizer *)gesture{
    if(gesture != nil){
        if(!isdrawerShow || gesture.direction == UISwipeGestureRecognizerDirectionRight){
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5
                                options:0 animations:^{
                                    _drawer.backgroundColor = [UIColor colorWithRed:81/255. green:81/255. blue:81/255. alpha:1];
                                    _drawer.alpha = 1;
                                    _collectionView.frame = CGRectMake(150, 60, MAIN_SCREEN_X - 8, MAIN_SCREEN_Y);
                                } completion:nil];
        }else{
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5
                                options:0 animations:^{
                                    _drawer.backgroundColor = WHITE_COLOR;
                                    _drawer.alpha = 0;
                                    _collectionView.frame = COLLECTVIEWFRAME;
                                } completion:nil];
        }
    }else{
        if(!isdrawerShow){
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5
                                options:0 animations:^{
                                    _drawer.backgroundColor = [UIColor colorWithRed:81/255. green:81/255. blue:81/255. alpha:1];
                                    _drawer.alpha = 1;
                                    _collectionView.frame = CGRectMake(150, 60, MAIN_SCREEN_X - 8, MAIN_SCREEN_Y);
                                } completion:nil];
        }else{
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5
                                options:0 animations:^{
                                    _drawer.backgroundColor = WHITE_COLOR;
                                    _drawer.alpha = 0;
                                    _collectionView.frame = COLLECTVIEWFRAME;
                                } completion:nil];
        }

    }
    isdrawerShow = !isdrawerShow;
}

/**
 
 向上滑动来改变cell的背景色
 
 */
-(void)rotateCell{
    int temp;
    while (BGDefaultTag == (temp = rand()%6 +1)){
    }
    BGDefaultTag = temp;
    if(BGDefaultTag == 1){
        self.collectionView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    }else{
        _collectionView.backgroundColor = WHITE_COLOR;
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:BGDefaultTag] forKey:@"BGTagSelect"];
    for(int loop = 1; loop <=6 ; loop++){
        NSUInteger aIndex[] = {0,loop};
        NSIndexPath *index = [[NSIndexPath alloc] initWithIndexes:aIndex length:2];
        UICollectionViewCell *cell  = [_collectionView cellForItemAtIndexPath:index ];
        [self performSelector:@selector(beginRorate:) withObject:cell afterDelay:loop*0.2];
    }
}


/**
 
    旋转动画的同时改变背景图片
 
 */
-(void)beginRorate:(UICollectionViewCell *)cell{
    
    CAMediaTimingFunction *timeFunc = [CAMediaTimingFunction functionWithControlPoints:1 :2 :4 :10];
    CATransform3D rotate = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    rotate.m34 = 1 / -600;
    CABasicAnimation *animation_rotate = [CABasicAnimation animation];
    CABasicAnimation *animation_changeBG = [CABasicAnimation animation];
    CAAnimationGroup *animation_group = [CAAnimationGroup animation];
    animation_rotate.keyPath = @"transform";
    animation_rotate.toValue = [NSValue valueWithCATransform3D:rotate];
    animation_rotate.duration = 0.7;
    animation_rotate.cumulative = YES;
    animation_rotate.timingFunction = timeFunc;
    animation_rotate.repeatCount = 3;
    animation_changeBG.keyPath = @"contents";
    animation_changeBG.duration = 0.7;
    animation_changeBG.fromValue = self.view.layer.contents;
    animation_changeBG.timingFunction = timeFunc;
    animation_changeBG.toValue = (__bridge id)[UIImage imageNamed:[NSString stringWithFormat:@"icon%d_%d@2x.png",(int)cell.tag,BGDefaultTag]].CGImage;
    /*
    if(BGDefaultTag == 1){
        animation_changeBG.toValue = (__bridge id)[UIImage imageNamed:[NSString stringWithFormat:@"icon%d_@2x.png",(int)cell.tag]].CGImage;
    }else{
        animation_changeBG.toValue = (__bridge id)[UIImage imageNamed:[NSString stringWithFormat:@"icon%d@2x.png",(int)cell.tag]].CGImage;
    }
     */
    animation_group.animations = @[animation_changeBG,animation_rotate];
    [cell.layer addAnimation:animation_group forKey:nil];
    cell.layer.contents = (__bridge id)[UIImage imageNamed:[NSString stringWithFormat:@"icon%d_%d@2x.png",(int)cell.tag,BGDefaultTag]].CGImage;
}

-(BOOL)shouldAutorotate{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortraitUpsideDown;
}


#pragma mark --
#pragma drawerDelegate
-(void)loadCalculateViewController{
    CalculationViewController *viewController = [[CalculationViewController alloc] init];
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}



@end
