//
//  ShopListViewController.m
//  LiangCang
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "ShopListViewController.h"

@interface ShopListViewController ()
{
    UIWebView *_webView;

}
@end

@implementation ShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNaVbar];
    [self creatWebView];
    self.title = @"商店专题";
    // Do any additional setup after loading the view.
}
-(void)creatNaVbar{
    
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"filterSelected@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(barbtn)];
    self.navigationItem.leftBarButtonItem = barbtn;
    
}
-(void)barbtn{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)creatWebView{
    self.tabBarController.tabBar.hidden = YES;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    
    [_webView loadRequest:
     [NSURLRequest requestWithURL:
      [NSURL URLWithString:
       ShopList_url]]];


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
