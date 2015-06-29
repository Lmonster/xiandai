//
//  ViewController.h
//  temp
//
//  Created by 金宣成 on 15/5/13.
//  Copyright (c) 2015年 apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface toolsIntroductionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UITextView *intro;

@end

