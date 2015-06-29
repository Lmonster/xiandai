//
//  TSTableViewCell.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/2/2.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "TSTableViewCell.h"
#import "ConstantHeader.h"

#define MAIN_LABEL_LEFT_POSITION         5+_cellImageView.frame.size.width
#define MAIN_LABEL_SIZE_WIDTH            rect.size.width - _cellImageView.frame.size.width - 15

@implementation TSTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        CGRect rect = self.frame;
        _cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, (rect.size.width/3 - 10)/0.75, rect.size.width/3 - 10)];
//        _cellImageView.layer.borderColor = [UIColor colorWithRed:219 / 255. green:112/255. blue:147/255. alpha:1.0].CGColor;
//        _cellImageView.layer.borderWidth = 2;
        _cellMainLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_LABEL_LEFT_POSITION - 10, 5, MAIN_LABEL_SIZE_WIDTH, rect.size.height - 10)];
        _cellMainLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:25];
        _cellMainLabel.numberOfLines = 2;
        
        _cellDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_LABEL_LEFT_POSITION, 65, MAIN_LABEL_SIZE_WIDTH, 30)];
        _cellDetailLabel.textColor = [UIColor grayColor];
        _cellDetailLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:15];
        _cellDetailLabel.numberOfLines = 2;
//        _cellImageView.layer.cornerRadius = _cellImageView.frame.size.height / 2;
//        _cellImageView.layer.masksToBounds = YES;
        
        [self addSubview:_cellImageView];
        [self addSubview:_cellMainLabel];
        [self addSubview:_cellDetailLabel];

    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 120, rect.size.height /3);
    CGContextAddLineToPoint(context, 280, rect.size.height/3);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    CGContextMoveToPoint(context, 0 , rect.size.height - 10);
    CGContextAddLineToPoint(context, MAIN_SCREEN_X, rect.size.height - 10);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, 10);
    CGContextStrokePath(context);

}

@end
