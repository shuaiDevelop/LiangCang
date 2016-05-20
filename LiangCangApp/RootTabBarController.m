//
//  RootTabBarController.m
//  LiangCangApp
//
//  Created by MS on 15/10/6.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "RootTabBarController.h"
#import "DDMenuController.h"
#import "WSTabBar.h"
#import "MagazineViewController.h"
#import "StoreViewController.h"
#import "ShareViewController.h"
#import "ExpertViewController.h"
#import "PersonalViewController.h"
#import "PleftViewController.h"
#import "Tools.h"
#import "LCStoreViewController.h"
//抽屉效果 界面
#import "LeftViewController.h"
#import "ExpertLeftController.h"

@interface RootTabBarController () <WSTabBarDelegate>
{
    WSTabBar * _tabbar;
    UIImageView * _imageView;
    NSTimer *myAnimatedTimer;
    int i;
}

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewControllers];
    _tabbar = [[WSTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    _tabbar.delegate = self;
    _tabbar.index = 0;
    i = 2;
    // 替换原本的tabbar
    self.tabBar.userInteractionEnabled = YES;
    [self.tabBar addSubview:_tabbar];
}
- (void)createViewControllers{
    MagazineViewController * magazineVC = [[MagazineViewController alloc] init];
//    magazineVC.view.backgroundColor = [UIColor blackColor];
    UINavigationController * magazineNC = [[UINavigationController alloc] initWithRootViewController:magazineVC];

//    StoreViewController * storeVC = [[StoreViewController alloc] init];
    LCStoreViewController * storeVC = [LCStoreViewController new];
    UINavigationController * storeNC = [[UINavigationController alloc] initWithRootViewController:storeVC];

    ShareViewController * shareVC = [[ShareViewController alloc] init];
    LeftViewController *left = [[LeftViewController alloc]init];
    UINavigationController * shareNC = [[UINavigationController alloc] initWithRootViewController:shareVC];
//    shareNC.navigationBar.barStyle = UIBarStyleBlackTranslucent;

    DDMenuController *dd = [[DDMenuController alloc]initWithRootViewController:shareNC];
    dd.leftViewController = left;



    ExpertViewController * expertVC = [[ExpertViewController alloc] init];
    ExpertLeftController * expertLeft = [[ExpertLeftController alloc] init];
    UINavigationController * expertNC = [[UINavigationController alloc] initWithRootViewController:expertVC];
//    DDMenuController *dd = [[DDMenuController alloc]initWithRootViewController:shareNC];
    DDMenuController *dd1 = [[DDMenuController alloc]initWithRootViewController:expertNC];
    dd1.leftViewController = expertLeft;


    PersonalViewController * personalVC = [[PersonalViewController alloc] init];
    PleftViewController * plleftVC = [[PleftViewController alloc] init];
    UINavigationController * personalNC = [[UINavigationController alloc] initWithRootViewController:personalVC];

    DDMenuController *dd3 = [[DDMenuController alloc]initWithRootViewController:personalNC];
    dd3.leftViewController = plleftVC;
    



    self.viewControllers = @[storeNC,magazineNC,dd,dd1,dd3];
    self.tabBar.barTintColor = [UIColor blackColor];

    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT)];
//    NSMutableArray *imageArr = [[NSMutableArray alloc]init];
//    for (NSInteger i =2; i <=36 ; i++) {
//        UIImage * image = [Tools imageWithName:[NSString stringWithFormat:@"splash_5_%ld.png",i]];
//        [imageArr addObject:image];
//
//    }
    [self.view addSubview:_imageView];
    [self.view bringSubviewToFront:_imageView];

    myAnimatedTimer = [NSTimer scheduledTimerWithTimeInterval:0.09 target:self selector:@selector(setNextImage) userInfo:nil repeats:YES];
    
//    _imageView.animationImages = imageArr;
//    _imageView.animationDuration = 3;
//    _imageView.animationRepeatCount = 1;
    [_imageView startAnimating];


}
-(void)setNextImage
{
    _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"splash_5_%d.png",i]];
    i++;
    if (i > 36) {
        [myAnimatedTimer invalidate];
        myAnimatedTimer = nil;
        [_imageView removeFromSuperview];
        return;
    }
    
}

- (void)tabbar:(WSTabBar *)tabbar didSelectedIndex:(NSUInteger)index{

    [self setSelectedIndex:index];
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    
    [myAnimatedTimer invalidate];
    myAnimatedTimer = nil;

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
