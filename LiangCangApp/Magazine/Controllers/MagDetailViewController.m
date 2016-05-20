//
//  MagDetailViewController.m
//  LiangCangApp
//
//  Created by MS on 15/10/9.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "MagDetailViewController.h"
@interface MagDetailViewController () <UIWebViewDelegate>

@end

@implementation MagDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.title = @"良仓杂志";
//    self.tabBarController.tabBar.hidden = YES;
    [self createUIWebViews];
}
- (void)createUIWebViews{
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    webView.scalesPageToFit = YES;// 适应手机
    webView.delegate = self;
    [self.view addSubview:webView];

// 加载网页
    NSURL * url = [NSURL URLWithString:self.topic_url];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

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
