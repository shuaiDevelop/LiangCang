//
//  AppDelegate.m
//  LiangCangApp
//
//  Created by MS on 15/10/6.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"
#import "DDMenuController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "WXApi.h"
#import "AppdelegateTool.h"

#import "APService.h"
//#import "Pingpp.h"

@interface AppDelegate () <WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    self.window.backgroundColor = [UIColor whiteColor];

    RootTabBarController * rootController = [[RootTabBarController alloc] init];

    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    // 导航条的设置
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName : [UIFont systemFontOfSize:18.0f],
                                                           NSForegroundColorAttributeName : [UIColor whiteColor]}];

    [UMSocialData setAppKey:@"56237669e0f55ade5e002e5a"];

    [UMSocialQQHandler setQQWithAppId:@"1104838229" appKey:@"6pwbqpMDSGktVW8C" url:@"http://www.umeng.com/social"];

    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxef43b8f9263b0597" appSecret:@"bd2d3dcf550159b64d50c9327a4d963b" url:@"http://www.umeng.com/social"];

    // 支付
//    [WXApi registerApp:WeiChatAppkey withDescription:nil];

//    if (![AppdelegateTool appDelegateTool].userCode) {
//        [self createAlertViewWithTitle:@"需要登录" andMessage:@"需要登录"];
//
//    }

    // 极光推送
    [self pushInfoWithOptions:launchOptions];

    self.window.rootViewController = rootController;

    [self.window makeKeyAndVisible];

    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
    return  [UMSocialSnsService handleOpenURL:url];

}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
//    [Pingpp handleOpenURL:url withCompletion:^(NSString *result, PingppError *error) {
//        if ([result isEqualToString:@"success"]) {
//            // 支付成功
//        } else {
//            // 支付失败或取消
//            NSLog(@"Error: code=%lu msg=%@", (unsigned long)error.code, [error getMsg]);
//        }
//    }];

//    return [WXApi handleOpenURL:url delegate:self];

    return  [UMSocialSnsService handleOpenURL:url];
}
- (void) onResp:(BaseResp *)resp
{

    NSString *str  = [NSString stringWithFormat:@"%d",resp.errCode];

    if ([resp isKindOfClass:[PayResp class]])
    {

        [self createAlertViewWithTitle:@"支付结果回调" andMessage:str];


    }else
    {


    }



}

- (void)pushInfoWithOptions:(NSDictionary *)launchOptions{

    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }

    // Required
    [APService setupWithOption:launchOptions];
}
- (void) createAlertViewWithTitle:(NSString *)title  andMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    [alert show];
    
    
    
}
#pragma mark - 极光推送 配置
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    // Required
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    // Required
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {


    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
