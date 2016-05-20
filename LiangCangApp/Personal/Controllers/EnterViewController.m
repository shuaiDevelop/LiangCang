//
//  EnterViewController.m
//  LiangCang
//
//  Created by qianfeng on 15/10/20.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "EnterViewController.h"
#import "UMSocial.h"
#import "PersonalViewController.h"
#import "EnterView.h"
@interface EnterViewController ()
{
 NSInteger _index;
}
@end

@implementation EnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    
    
    // Do any additional setup after loading the view.
}
-(void)createView{
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT)];
    view.tag = 100;
    view.image = [UIImage imageNamed:@"img_01.jpg"];
    view.userInteractionEnabled = YES;
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(animationTransition) userInfo:nil repeats:YES];
    [self.view addSubview:view];

    // qq登录
    UIButton * qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqBtn.frame = CGRectMake(SCREEN_WIDTH/4*3, SCREEN_HEIGHT-200, 50, 50);
    //    [btn setImage:[UIImage imageNamed:@"sdk_weibo_logo@2x.png"] forState:UIControlStateNormal];
    [qqBtn setBackgroundImage:[UIImage imageNamed:@"qqicon.png"] forState:UIControlStateNormal];
    qqBtn.clipsToBounds = YES;
    qqBtn.layer.cornerRadius = 25.0f;
    [qqBtn addTarget:self action:@selector(qqBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:qqBtn];


    
    // 微博登陆
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT-200, 50, 50);
    //    [btn setImage:[UIImage imageNamed:@"sdk_weibo_logo@2x.png"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"sdk_weibo_logo@2x.png"] forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 25.0f;
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    
    UIButton *btnback = [UIButton buttonWithType:UIButtonTypeCustom];
    btnback.frame = CGRectMake(SCREEN_WIDTH-40, 64, 20, 20);

    [btnback setBackgroundImage:[UIImage imageNamed:@"btn_couponhelp@2x.png"] forState:UIControlStateNormal];
//    [btnback setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnback addTarget:self action:@selector(btnback) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnback];
    
    
}
-(void)btnback{
   
    PersonalViewController *pervc = [[PersonalViewController alloc]init];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [pervc.enter removeFromSuperview];
    }];

}
- (void)btnClicked{
    NSLog(@"微博");
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
           
            
            [self dismissViewControllerAnimated:YES completion:^{


            
            }];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationName object:nil userInfo:@{@"username":snsAccount.userName}];
            
//            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);

        }});
//    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
//        NSLog(@"SnsInformation is %@",response.data);
//    }];
//    

}
- (void)qqBtnClicked{

    NSLog(@"QQ");
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];

    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){

        //          获取微博用户名、uid、token等

        if (response.responseCode == UMSResponseCodeSuccess) {

            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];

            [self dismissViewControllerAnimated:YES completion:^{



            }];

            [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationName object:nil userInfo:@{@"username":snsAccount.userName}];
            


            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);

        }});

}
- (void)animationTransition{
    _index++;
    if(_index == 4){
        _index = 0;
    }
    UIImageView *imageL = (UIImageView *)[self.view viewWithTag:100];
    imageL.image = [UIImage imageNamed:[NSString stringWithFormat:@"img_%02ld.jpg",_index+1]];
    CATransition *ainm = [CATransition animation];
    ainm.type = @"fade";
    ainm.subtype = kCATransitionFromRight;
    ainm.duration = 1.5;
    
    [imageL.layer addAnimation:ainm forKey:nil];
    [self.view addSubview:imageL];
    
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
