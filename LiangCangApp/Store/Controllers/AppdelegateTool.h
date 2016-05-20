//
//  AppdelegateTool.h
//  WeiChatDemo
//
//  Created by 赵城林 on 15/10/18.
//  Copyright © 2015年 赵宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppdelegateTool : NSObject

+ (instancetype) appDelegateTool;

@property (nonatomic ,strong) NSString * userCode;


+ (void) openWeiChatWith:(id) parms;


@end
