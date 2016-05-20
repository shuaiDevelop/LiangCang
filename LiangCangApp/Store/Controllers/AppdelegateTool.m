//
//  AppdelegateTool.m
//  WeiChatDemo
//
//  Created by 赵城林 on 15/10/18.
//  Copyright © 2015年 赵宇. All rights reserved.
//

#import "AppdelegateTool.h"
#import "WXApi.h"
@implementation AppdelegateTool
@synthesize userCode = _userCode;


+ (instancetype) appDelegateTool
{
    static AppdelegateTool *mannager  = nil;
    
   static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
        mannager = [[AppdelegateTool alloc]init];
        
    });
    return  mannager;
    
    
}
- (void) setUserCode:(NSString *)userCode
{
    
    _userCode = userCode;
    
    NSUserDefaults *defasults = [NSUserDefaults standardUserDefaults];
    
    [defasults setObject:_userCode forKey:@"userCode"];
    
    [defasults synchronize];
    
    
}
- (NSString *)userCode
{
    

    return [[NSUserDefaults standardUserDefaults]objectForKey:@"userCode"];
    
    
}
+ (void) openWeiChatWith:(id)parms
{
 
    PayReq *request = [[PayReq alloc]init];
    request.prepayId = [parms objectForKey:@"prepayId"];
    request.partnerId = [parms objectForKey:@"partnerid"];
    request.package = [parms objectForKey:@"package"];
    request.nonceStr = [parms objectForKey:@"nonceStr"];
    request.timeStamp = [[parms objectForKey:@"timeStamp"] intValue];
    request.sign =  [parms objectForKey:@"paySign"];
    [WXApi sendReq:request];

    
}
@end
