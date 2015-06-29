//
//  keyBoardView.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/24.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>


#define  DELETE_SIGN                1000
#define  MINUS_SIGN                 1001
#define  POINT                      1002

@protocol _keyBoardDidTouchedDelegate <NSObject>

@required
-(void)sendNumberInfo:(int)number;
-(void)sendCaculationInfo:(int)caculationType;
-(void)sendCleanInfo;
-(void)sendMovaInfo:(int)moveType;

@end



@interface keyBoardView : UIView


@property (strong ,nonatomic) id <_keyBoardDidTouchedDelegate> delegate;



@end
