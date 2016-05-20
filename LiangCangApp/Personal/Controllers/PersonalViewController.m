//
//  PersonViewController.m
//  LiangCangApp
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "PersonalViewController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
#import "PleftViewController.h"
#import "SettingView.h"
#import "UMSocial.h"
#import "EnterView.h"
#import "EnterViewController.h"
#import "PersonalView.h"
@interface PersonalViewController ()<SettingViewDelegate,EnterViewdelegate>
{

    UITableView *_tableView;
    NSString *_type;

    SettingView *setView;
    PersonalView *personView;
    PersonalView *personal;
}
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUi];
    [self creatNavBar];
    [self addPersonCenter];
    [self creatEnterView];
    // Do any additional setup after loading the view.
}
-(void)creatEnterView{
    self.enter = [[EnterView alloc]initWithFrame:self.view.bounds];
    self.enter.delegate = self;
    [self.view addSubview:self.enter];
    [self.view bringSubviewToFront:self.enter];



}
-(void)Enterview{

    EnterViewController *enterVc = [[EnterViewController alloc]init];
    [self presentViewController:enterVc animated:YES completion:^{

        [self.enter removeFromSuperview];
    }];

}

#pragma mark -- 注册通知
-(void)addPersonCenter{

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PerSonAbserver:) name:NSNotificationName object:nil];
}
-(void)PerSonAbserver:(NSNotification *)info{

   self.navigationItem.title =  [info.userInfo objectForKey:@"username"];

    _type = [info.userInfo objectForKey:@"type"];
    NSLog(@"%@",NSStringFromClass([SettingView class]));
    if ([_type isEqualToString:NSStringFromClass([SettingView class])]) {
        [personView removeFromSuperview];
        [personal removeFromSuperview];
        setView = [[SettingView alloc]initWithFrame:self.view.bounds];
        setView.delegate = self;

        [self.view addSubview:setView];
        [self.view bringSubviewToFront:setView];
        NSLog(@"person");
    }
    if ([_type isEqualToString:NSStringFromClass([PersonalView class])]) {
        [setView removeFromSuperview];
        [self.enter removeFromSuperview];
        personView = [[PersonalView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:personView];
        [self.view bringSubviewToFront:personView];


    }


}
-(void)UmengPresent{
    NSLog(@"umeng");

    NSArray * platformArr = @[UMShareToSina,
                              UMShareToTencent,
                              UMShareToQzone,
                              UMShareToQQ,
                              ];

    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56237669e0f55ade5e002e5a"
                                      shareText:@"来看看我设计的App哦。"
                                     shareImage:[UIImage imageNamed:@"splash_5_24.png"]
                                shareToSnsNames:platformArr
                                       delegate:nil];


}
-(void)creatNavBar{

    self.navigationItem.title = @"个人";
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame  = CGRectMake(0, 0, 32, 20);
    [btn setImage:[UIImage imageNamed:@"btn_nav_option_h4@2x.png"] forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem * leftbtn = [[UIBarButtonItem alloc] initWithCustomView:btn];

    self.navigationItem.leftBarButtonItem = leftbtn;


}

-(void)btnAction{
    DDMenuController *dd = (DDMenuController *)((AppDelegate*)[[UIApplication sharedApplication]delegate].window.rootViewController.childViewControllers[4]);


    [dd showLeftController:YES];
    //

}
-(void)initUi{

    personal = [[PersonalView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:personal];


}
- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNotificationName object:nil];
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
