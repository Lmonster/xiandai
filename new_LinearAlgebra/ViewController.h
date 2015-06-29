//
//  ViewController.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/21.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "new_drawer.h"

@interface ViewController : UIViewController<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>


/*
 
 
 这是主页面的核心UI控件
 
 
 */
@property (strong ,nonatomic) UICollectionView *collectionView;




/*
 
 
 这是头部的主要控件
 
 
 */
@property (strong ,nonatomic) UIScrollView *scrollView;

@property (strong ,nonatomic) UIScrollView *mainScrollView;

@property (strong ,nonatomic) new_drawer *drawer;


@end

