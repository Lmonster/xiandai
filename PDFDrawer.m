//
//  PDFDrawer.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/30.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "PDFDrawer.h"
#import "ConstantHeader.h"

@interface PDFDrawer ()

@end

@implementation PDFDrawer

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageArray = [NSMutableArray new];
    _scrolView = [UIScrollView new];
    [self setScrolViewElement];
    _PDFView = [PDFVeiw new];
    [_PDFView setBackgroundColor:WHITE_COLOR];
    _PDFView.fileName = _fileName;
    _PDFView.filePath = _filePath;
    _PDFView.pageNumber = _pageNumber;
    _PDFView.frame = CGRectMake(0, 0, MAIN_SCREEN_X, MAIN_SCREEN_Y);
    [self.view addSubview:_scrolView];
    [_scrolView addSubview:_PDFView];
    [_PDFView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(instancetype)initControllerWithPage:(int)page_number withFilePath:(NSString *)file_path withFileName:(NSString *)fileName{
    self = [super init];
    if(self){
        _filePath = file_path;
        _fileName = fileName;
        _pageNumber = page_number;
    }
    return self;
}

#pragma mark--
#pragma 设置ScrollView的一些属性
-(void)setScrolViewElement{
    _scrolView.frame = CGRectMake(0 ,0 ,MAIN_SCREEN_X,MAIN_SCREEN_Y);
    _scrolView.delegate = self;
    _scrolView.maximumZoomScale = 1000;
    _scrolView.minimumZoomScale = MAIN_SCREEN_X/MAIN_SCREEN_Y;
    [_scrolView setZoomScale:MAIN_SCREEN_X/MAIN_SCREEN_Y animated:YES];
}

#pragma mark--
#pragma scrollViewDelegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _PDFView;
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CleanThePageArray" object:self];
}

@end
