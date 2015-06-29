//
//  PicExperienceViewController.h
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 15/1/22.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "drawerView.h"
#import "anglePicker.h"
#import "TBCircularSlider.h"
#import "guideViewController.h"

@interface PicExperienceViewController : UIViewController<UITextFieldDelegate,anglePickerIsScroll>

/**
           THE VIEW WHIERE PUT THE MAIN IMAEG
 */
@property (strong ,nonatomic)UIImageView *imageView;

/**
 
           THE MAIN VIEW OF THE CONTROLLER VIEW
 */

@property (strong, nonatomic)UIScrollView *scrollView_MainView;

/**
 
           THE SUBVIEW OF THE MAIN SCROLLVIEW
 */

@property (strong ,nonatomic)UIScrollView *scrollView_subView;

/**
 
           THE DRAWER OF THE VIEW TO SHWO THE MENUE
 */


@property (strong ,nonatomic)drawerView *drawer;

/**
 
            THE CONTAINER OF ALL THE TEXTFIELDVIEWS 
 */
@property (strong ,nonatomic)NSMutableArray *TFArray;


/**
            AN ANGLEPICKER THAT PICK THE ANGLE THE PICTURE WILL ROTOTA
 
 */
@property (strong ,nonatomic)anglePicker * anglePicker;

@property (strong ,nonatomic) TBCircularSlider *anglePicker_1;

@property (strong ,nonatomic) TBCircularSlider *anglePicker_2;

@property (strong ,nonatomic) UIImageView *guideImage;




@end
