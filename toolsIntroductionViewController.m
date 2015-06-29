//
//  ViewController.m
//  temp
//
//  Created by 金宣成 on 15/5/13.
//  Copyright (c) 2015年 apress. All rights reserved.
//

#import "toolsIntroductionViewController.h"
#import "AWCollectionViewDialLayout.h"
#import "ConstantHeader.h"

@interface toolsIntroductionViewController ()

@end

static NSString *cellId = @"cellId";

static NSString *matlabIntro = @"\tMATLAB是美国MathWorks公司出品的商业数学软件，用于算法开发、数据可视化、数据分析以及数值计算的高级技术计算语言和交互式环境，主要包括MATLAB和Simulink两大部分。\n\n\tMATLAB是matrix&laboratory两个词的组合，意为矩阵工厂（矩阵实验室）。是由美国mathworks公司发布的主要面对科学计算、可视化以及交互式程序设计的高科技计算环境。它将数值分析、矩阵计算、科学数据可视化以及非线性动态系统的建模和仿真等诸多强大功能集成在一个易于使用的视窗环境中，为科学研究、工程设计以及必须进行有效数值计算的众多科学领域提供了一种全面的解决方案，并在很大程度上摆脱了传统非交互式程序设计语言（如C、Fortran）的编辑模式，代表了当今国际科学计算软件的先进水平。\n\n\tMATLAB和Mathematica、Maple并称为三大数学软件。它在数学类科技应用软件中在数值计算方面首屈一指。MATLAB可以进行矩阵运算、绘制函数和数据、实现算法、创建用户界面、连接其他编程语言的程序等，主要应用于工程计算、控制设计、信号处理与通讯、图像处理、信号检测、金融建模设计与分析等领域。\n\n\tMATLAB的基本数据单位是矩阵，它的指令表达式与数学、工程中常用的形式十分相似，故用MATLAB来解算问题要比用C，FORTRAN等语言完成相同的事情简捷得多，并且MATLAB也吸收了像Maple等软件的优点，使MATLAB成为一个强大的数学软件。在新的版本中也加入了对C，FORTRAN，C++，JAVA的支持。";

static NSString *mathmeticaIntro = @"\tMathematica是一款科学计算软件，很好地结合了数值和符号计算引擎、图形系统、编程语言、文本系统、和与其他应用程序的高级连接。很多功能在相应领域内处于世界领先地位，它也是使用最广泛的数学软件之一。Mathematica的发布标志着现代科技计算的开始。Mathematica是世界上通用计算系统中最强大的系统。自从1988发布以来，它已经对如何在科技和其它领域运用计算机产生了深刻的影响。\n\n\tMathematica的用户群中最主要的是科技工作者和其它专业人士。但是，Mathematica还被广泛地用于教学中。数学中的许多计算是非常繁琐的，特别是函数的作图费时又费力，而且所画的图形很不规范，所以现在流行用Mathematica符号计算系统进行学习，从高中到研究生院的数以百计的课程都使用它，很多问题便迎刃而解。此外，随着学生版的出现，Mathematica已经在全世界的学生中流行起来，成为了一个著名的工具.\n\n\tMathematica系统已经支持高性能计算。在Mathematica 5.2版本中，它已经支持自动多线程计算。在2002年，gridMathematica的引入使得用户级的并行编程可以在不同的集群和多处理器系统中进行在2008年，在所有的Mathematica许可证中囊括了并行计算技术，包括支持网格技术如Windows HPC Server 2008、Microsoft Compute Cluster Server和Sun Grid。2010年，Mathematica增加了对CUDA和OpenCLGPU硬件的支持。另外，第8版还可以生成C代码，它可以自动由系统C编译器进行编译，比如Intel C++编译器或者Visual Studio 2010编译器。";

static NSString *mapleIntro = @"\tMaple是目前世界上最为通用的数学和工程计算软件之一，在数学和科学领域享有盛誉，有“数学家的软件”之称。Maple 在全球拥有数百万用户，被广泛地应用于科学、工程和教育等领域，用户渗透超过96%的世界主要高校和研究所，超过81%的世界财富五百强企业。\n\n\tMaple系统内置高级技术解决建模和仿真中的数学问题，包括世界上最强大的符号计算、无限精度数值计算、创新的互联网连接、强大的4GL语言等，内置超过5000个计算命令，数学和分析功能覆盖几乎所有的数学分支，如微积分、微分方程、特殊函数、线性代数、图像声音处理、统计、动力系统等。\n\n\tMaple不仅仅提供编程工具，更重要的是提供数学知识。Maple是教授、研究员、科学家、工程师、学生们必备的科学计算工具，从简单的数字计算到高度复杂的非线性问题，Maple都可以帮助您快速、高效地解决问题。用户通过Maple产品可以在单一的环境中完成多领域物理系统建模和仿真、符号计算、数值计算、程序设计、技术文件、报告演示、算法开发、外部程序连接等功能，满足各个层次用户的需要，从高中学生到高级研究人员。";


@implementation toolsIntroductionViewController{
    int type;
    
    AWCollectionViewDialLayout *dialLayout;
    
    NSArray *nameArr;
    NSMutableArray *imageArr;
    
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_X, 60)];
    navigationBar.tintColor = WHITE_COLOR;
    navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(popViewController)];
    UINavigationItem *items = [[UINavigationItem alloc] initWithTitle:@"工具介绍"];
    items.leftBarButtonItem = backItem;
    navigationBar.items = @[items];
    
    UIImage *bgImage = [UIImage imageNamed:@"bg2.jpeg"];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [bgImageView setImage:bgImage];
    [self.view addSubview:bgImageView];
    
    CGFloat radius = 200;
    CGFloat angularSpacing = 40;
    CGFloat xOffset = 120;
    CGFloat cell_width = 240;
    CGFloat cell_height = 200;
    
    dialLayout = [[AWCollectionViewDialLayout alloc] initWithRadius:radius andAngularSpacing:angularSpacing andCellSize:CGSizeMake(cell_width, cell_height) andAlignment:WHEELALIGNMENTCENTER andItemHeight:cell_height andXOffset:xOffset];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:dialLayout];
    [_collectionView registerNib:[UINib nibWithNibName:@"dialCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    _intro = [[UITextView alloc] initWithFrame:CGRectMake(130, 80, 200, 450)];
    _intro.backgroundColor = [UIColor colorWithWhite:2.f alpha:0.5];
    _intro.text = mathmeticaIntro;
    _intro.font = [UIFont fontWithName:@"GeezaPro" size:20];
    [_intro setEditable:NO];
    [_intro.layer setCornerRadius:10];
    [self.view addSubview:_intro];
    
    
    
    nameArr = @[@"Mathmetica",@"MATLAB",@"Maple"];

    imageArr = [NSMutableArray new];
    for (int i = 0; i<3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.png",i]];
        UIImage *image = [UIImage imageNamed:@"bg2.jpeg"];
        [imageArr addObject:image];
        image = nil;
    }
    [self.view addSubview:navigationBar];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    
    cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    
    UIImageView *imgView = (UIImageView*)[cell viewWithTag:100];
    imgView.image = [imageArr objectAtIndex:indexPath.row];
    
    
    UILabel *nameLabel = (UILabel*)[cell viewWithTag:101];
    [nameLabel setText:[nameArr objectAtIndex:indexPath.row]];
    
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - UICollectionViewDelegate methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(240, 100);
}


- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0 , 0, 0, 0);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // any offset changes
    NSLog(@"%d",(int)scrollView.contentOffset.y/130);//这里我们输出 scrollView的纵向 偏移量
    switch ( (int)scrollView.contentOffset.y / 130) {
        case 0:
            [_intro setText:mathmeticaIntro];
            break;
        case 1:
            [_intro setText:matlabIntro];
            break;
        case 2:
            [_intro setText:mapleIntro];
            break;
        default:
            break;
    }

}

#pragma mark --
#pragma 自定义的类
-(void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
}
@end
