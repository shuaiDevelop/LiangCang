//
//  RootViewController.m
//  LiangCangApp
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 20);
    [rightBtn setImage:[UIImage imageNamed:@"topmenu_@2x.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    

    
    UIImage * image = [UIImage imageNamed:@"tabbg.png"];
    image = [image stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    NSDictionary * titleAttibutes = @{
                                      NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                      NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttibutes];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 5, 30, 30);
    UIImage * Sizeimage =[Tools imageWithImageSimple:[UIImage imageNamed:@"fanhui@2x.png"] scaledToSize:CGSizeMake(16, 18)];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        [btn setImage:Sizeimage forState:UIControlStateNormal];
        
    }else{
        
        [btn setImage:[UIImage imageNamed:@"fanhui@2x.png"] forState:UIControlStateNormal];
    }
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backbtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = backbtn;
}
- (void)rightButtonClicked{



}
- (void)onClick{

    [self.navigationController popViewControllerAnimated:YES];


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
