//
//  LCStoreViewController.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/6.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "LCStoreViewController.h"
#import "XWCatergoryView.h"
#import "StoreViewController.h"
#import "YLStorefiveViewController.h"
#import "YLStorefourViewController.h"
#import "YLStoreThreeViewController.h"
#import "YLStoreTwoViewController.h"
#import "LCStoreOneViewController.h"




#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
static CGFloat const titleH = 39;/** 文字高度  */

@interface LCStoreViewController ()<UIScrollViewDelegate,XWCatergoryViewDelegate>
/** 文字scrollView  */
@property (nonatomic, strong) UIScrollView *titleScrollView;
/** 控制器scrollView  */
@property (nonatomic, strong) UIScrollView *contentScrollView;
/** 标签文字  */
@property (nonatomic ,strong) NSArray * titlesArr;


@end

@implementation LCStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationItem.title = @"商店";
    
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 20);
    [rightBtn setImage:[UIImage imageNamed:@"topmenu_@2x.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;

    
    
    
    [self addChildViewController];    /** 添加子控制器视图  */
    [self setContentScrollView];      /** 添加scrollView  */
    
    [self setTitleScrollView];        /** 添加文字标签  */
    //
    //    self.contentScrollView.backgroundColor = [UIColor grayColor];
    //    self.view.backgroundColor = [UIColor grayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentScrollView.contentSize = CGSizeMake(self.titlesArr.count * ScreenW, 0);
    self.contentScrollView.bounces = NO;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator  = NO;
    self.contentScrollView.delegate = self;
   
    // Do any additional setup after loading the view.
}
- (void)rightButtonClicked{


}
-(void)addChildViewController{
    
    LCStoreOneViewController *vc  = [[LCStoreOneViewController alloc] init];
    YLStoreTwoViewController * blue = [[YLStoreTwoViewController alloc] init];
    YLStoreThreeViewController * yell = [[YLStoreThreeViewController alloc] init];
    YLStorefourViewController * view1 = [[YLStorefourViewController alloc] init];
    YLStorefiveViewController * view2 = [[YLStorefiveViewController alloc] init];
    
    NSArray * controllerArr = @[blue,vc,yell,view1,view2];
    
    for (int i = 0; i<self.titlesArr.count; i++) {
        
        [[controllerArr objectAtIndex:i] setTitle:self.titlesArr[i]];
        [self addChildViewController:[controllerArr objectAtIndex:i]];
        
    }
    
}
-(void)setTitleScrollView{
    
    //    CGRect rect  = CGRectMake(0, 0, ScreenW, titleH);
    //    self.titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
    //    [self.view addSubview:self.titleScrollView];
    XWCatergoryView * catergoryView = [[XWCatergoryView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, titleH)];
    //必须设置titles数据源
    catergoryView.titles = self.titlesArr;
    catergoryView.defaultIndex = 2;

    //必须设置关联的scrollview
    catergoryView.scrollView = self.contentScrollView;
    //代理坚挺点击;
    catergoryView.delegate = self;
    //设置文字左右渐变
    catergoryView.titleColorChangeGradually = YES;
    //开启底部线条
    catergoryView.bottomLineEable = YES;
    //    catergoryView.titleFont = [UIFont boldSystemFontOfSize:15];
    //设置底部线条距离item底部的距离
    catergoryView.bottomLineSpacingFromTitleBottom =5;
    catergoryView.titleColor = [UIColor lightGrayColor];
    catergoryView.scaleEnable = YES;
    //    catergoryView.scaleRatio =
    //禁用点击item滚动scrollView的动画
    
    catergoryView.scrollWithAnimaitonWhenClicked = YES;
    catergoryView.backgroundColor = RGB_COLOR(21, 21, 21, 1);
    catergoryView.titleColorChangeGradually = YES;
    catergoryView.backEllipseEable = NO;
    catergoryView.titleSelectColor = [UIColor whiteColor];
    catergoryView.bottomLineColor = [UIColor whiteColor];
    //    self.navigationItem.titleView = catergoryView;
//    [catergoryView xw_realoadData];
    [self.view addSubview:catergoryView];
    
    
}
-(void)setContentScrollView{
    
    //    CGFloat y  = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect rect  = CGRectMake(0, titleH, ScreenW, ScreenH - titleH);
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    [self.view addSubview:self.contentScrollView];
    self.contentScrollView.contentOffset = CGPointMake(ScreenW*3, 0);
    [self setUpOneChildController:2];
    
}
- (void)catergoryView:(XWCatergoryView *)catergoryView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    CGFloat x = indexPath.row * ScreenW;
    //    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    [self.contentScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    [self setUpOneChildController:indexPath.row];
    
    
    
    
    
}

-(void)setUpOneChildController:(NSInteger)index{
    
    
    CGFloat x  = index * ScreenW;
    UIViewController *vc  =  self.childViewControllers[index];
    if ([vc.view.superview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    vc.view.frame = CGRectMake(x, 0, ScreenW, ScreenH - self.contentScrollView.frame.origin.y);
    [self.contentScrollView addSubview:vc.view];
    
}


#pragma mark - UIScrollView  delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger i  = self.contentScrollView.contentOffset.x / ScreenW;
    [self.contentScrollView setContentOffset:CGPointMake(i*ScreenW, 0) animated:YES];
    [self setUpOneChildController:i];
    
}


-(NSArray *)titlesArr
{
    
    if (!_titlesArr) {
        _titlesArr  = [NSArray arrayWithObjects:@"分类",@"品牌",@"首页",@"专题",@"礼物",nil];
    }
    
    return _titlesArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
