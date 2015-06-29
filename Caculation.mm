//
//  Caculation.m
//  linearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/15.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "Caculation.h"
#import "Eigen/Dense"
#import "ConstantHeader.h"

using namespace Eigen;
using namespace std;



struct matrix_info{
    int row;
    int line;
    MatrixXf matrix;
};

@implementation Caculation{
    int calculateType;
    int dataCount;
    int typeCount;
    
    NSMutableArray *matrixInfo;
    
    struct matrix_info currentMatrix_info;
    struct matrix_info nextMatrix_info;
}

-(instancetype)init{
    self = [super init];
    if(self){
        _dataArray = [[NSMutableArray alloc] init];
        _calculateTypeArray = [[NSMutableArray alloc] init];
        matrixInfo = [[NSMutableArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cleanAllTheData)
                                                     name:@"cleanAllTheData"
                                                   object:nil];
    }
    return self;
}

-(void)pushwithData:(NSMutableArray *)dataArray withType:(int)type withArrayRow:(int)row withArrayLine:(int)line{
    
    if(!_calculateTypeArray && !matrixInfo){
        _calculateTypeArray = [[NSMutableArray alloc] init];
        matrixInfo = [[NSMutableArray alloc] init];
    }
    [_calculateTypeArray addObject:[NSNumber numberWithInt:type]];
    NSDictionary *tempDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSNumber numberWithInt:row],@"row",
                                    [NSNumber numberWithInt:line], @"line",
                                    dataArray,@"dataArray",nil];
    
    [matrixInfo addObject:tempDictionary];
    if((type <= 4 && type >= 0) || type == 6 || type ==29)
        [self calculateData];
}

-(NSDictionary *)calculateData{
    int flag_data = 0 ,flag_type = 0 ,type;
    NSDictionary *diction_1,*diction_2;
    diction_1 = [[NSDictionary alloc] init];
    diction_2 = [[NSDictionary alloc] init];

    if([matrixInfo count] ==1){
        diction_1 = [self calculation:[matrixInfo objectAtIndex:0] withMatrix_2:nil withType:[[_calculateTypeArray objectAtIndex:0] intValue]];
    }
    else{
        while(flag_data < [matrixInfo count] || flag_type < [_calculateTypeArray count]){
            if(flag_data == 0){
                diction_1 = [matrixInfo objectAtIndex:0];
                diction_2 = [matrixInfo objectAtIndex:1];
                type = [[_calculateTypeArray objectAtIndex:0] intValue];
                diction_1 = [self calculation:diction_1 withMatrix_2:diction_2 withType:type];
                flag_data = 2;
                flag_type ++;
            }
            else{
                if(flag_data < [matrixInfo count] && flag_type < [matrixInfo count]){
                    diction_2 = [matrixInfo objectAtIndex:flag_data];
                    type = [[_calculateTypeArray objectAtIndex:flag_type] intValue];
                    diction_1 = [self calculation:diction_1 withMatrix_2:diction_2 withType:type];
                    flag_data ++;
                    flag_type ++;
                }
                else{
                    type = [[_calculateTypeArray objectAtIndex:flag_type] intValue];
                    diction_1 = [self calculation:diction_1 withMatrix_2:nil withType:type];
                    flag_type ++;
                }
            }
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"calculationDidFinishNotification" object:self userInfo:diction_1];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanAllTheData" object:self];
    return diction_1;
}

-(NSMutableDictionary *)calculation:(NSDictionary *)matrix_1 withMatrix_2:(NSDictionary *)matrix_2 withType:(int)type{
    
    NSMutableDictionary *diction = [[NSMutableDictionary alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if(matrix_1 && matrix_2){
        
        currentMatrix_info.row = [[matrix_1 objectForKey:@"row"] intValue];
        nextMatrix_info.row = [[matrix_2 objectForKey:@"row"] intValue];
        currentMatrix_info.line = [[matrix_1 objectForKey:@"line"] intValue];
        nextMatrix_info.line = [[matrix_2 objectForKey:@"line"] intValue];
        currentMatrix_info.matrix = MatrixXf::Random(currentMatrix_info.row, currentMatrix_info.line);
        nextMatrix_info.matrix = MatrixXf::Random(nextMatrix_info.row, nextMatrix_info.line);
        
        for(int i = 0;i< currentMatrix_info.row ;i++)
            for(int j = 0; j<currentMatrix_info.line; j++)
            {
                currentMatrix_info.matrix(i,j) = [[[matrix_1 objectForKey:@"dataArray"] objectAtIndex:i * currentMatrix_info.line +j ] floatValue];
            }
        for(int i = 0;i< nextMatrix_info.row ;i++)
            for(int j =0; j<nextMatrix_info.line ;j++)
            {
                nextMatrix_info.matrix(i,j) = [[[matrix_2 objectForKey:@"dataArray"] objectAtIndex:i * currentMatrix_info.line +j] floatValue];
            }
        
        switch (type) {
            case PLUS:
                currentMatrix_info.matrix = currentMatrix_info.matrix + nextMatrix_info.matrix;
                break;
            case MINUS:
                currentMatrix_info.matrix = currentMatrix_info.matrix - nextMatrix_info.matrix;
            case MULTI:
                if(currentMatrix_info.line != nextMatrix_info.row)
                    return nil;
                else
                currentMatrix_info.matrix = currentMatrix_info.matrix * nextMatrix_info.matrix;
                currentMatrix_info.row = (int)currentMatrix_info.matrix.rows();
                currentMatrix_info.line = (int)currentMatrix_info.matrix.cols();
                break;
            case DIVISION:
                nextMatrix_info.matrix = nextMatrix_info.matrix.inverse();
                currentMatrix_info.matrix = currentMatrix_info.matrix * nextMatrix_info.matrix;
                currentMatrix_info.row = (int)currentMatrix_info.matrix.rows();
                currentMatrix_info.line = (int)currentMatrix_info.matrix.cols();
            default:
                break;
        }
    }
    
    else{
        currentMatrix_info.row = [[matrix_1 objectForKey:@"row"] intValue];
        currentMatrix_info.line = [[matrix_1 objectForKey:@"line"] intValue];
        currentMatrix_info.matrix = MatrixXf::Random(currentMatrix_info.row, currentMatrix_info.line);
        for(int i = 0;i< currentMatrix_info.row ;i++)
            for(int j = 0; j<currentMatrix_info.line; j++)
            {
                currentMatrix_info.matrix(i,j) = [[[matrix_1 objectForKey:@"dataArray"] objectAtIndex:i * currentMatrix_info.line +j] floatValue];
            }
        
        switch (type) {
            case INVERSE:
                currentMatrix_info.matrix = currentMatrix_info.matrix.inverse();
                currentMatrix_info.row = (int)currentMatrix_info.matrix.rows();
                currentMatrix_info.line = (int)currentMatrix_info.matrix.cols();
                break;
            case TRANSPOSITION:
                currentMatrix_info.matrix.transposeInPlace();
                currentMatrix_info.row = (int)currentMatrix_info.matrix.rows();
                currentMatrix_info.line = (int)currentMatrix_info.matrix.cols();
                break;
            case ADJOINT:
                currentMatrix_info.matrix.adjoint();
                currentMatrix_info.row = (int)currentMatrix_info.matrix.rows();
                currentMatrix_info.line = (int)currentMatrix_info.matrix.cols();
                break;
            case CONJUGATE:
                currentMatrix_info.matrix = currentMatrix_info.matrix.conjugate();
                currentMatrix_info.row = (int)currentMatrix_info.matrix.rows();
                currentMatrix_info.line = (int)currentMatrix_info.matrix.cols();
                break;
            case EIGENVALUE:
                currentMatrix_info.row = (int)currentMatrix_info.matrix.rows();
                currentMatrix_info.line = (int)currentMatrix_info.matrix.cols();
                break;
            default:
                break;
        }

    }
    for(int i = 0;i< currentMatrix_info.row ;i++)
        for(int j = 0; j<currentMatrix_info.line; j++)
        {
            [array addObject:[NSNumber numberWithFloat:currentMatrix_info.matrix(i,j)]];
        }
    [diction setValue:[NSNumber numberWithInt:currentMatrix_info.row] forKey:@"row"];
    [diction setValue:[NSNumber numberWithInt:currentMatrix_info.line] forKey:@"line"];
    [diction setValue:array forKey:@"dataArray"];
    return diction;
}

-(void)cleanAllTheData{
    _calculateTypeArray = nil;
    matrixInfo = nil;
}

@end
