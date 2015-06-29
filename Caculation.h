//
//  Caculation.h
//  linearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/15.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Caculation : NSObject

/*
 

 用作为栈来存储输入的数据
 
 
 */
@property (strong ,nonatomic)  NSMutableArray *dataArray;




/*
 
 用作栈来存储符号数据
 
 */
@property (strong ,nonatomic) NSMutableArray *calculateTypeArray;



/*
 
 用来存储数组的行列信息
 
 */
@property (strong ,nonatomic) NSMutableArray *arrayInfo;


 /*
  
  
  各种处理方法
  
  */

-(void)pushwithData:(NSMutableArray *)dataArray withType:(int)type withArrayRow:(int) row withArrayLine:(int) line;


-(NSMutableArray *)calculateData;
@end
