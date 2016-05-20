//
//  SingleManager.m
//  5_SingleTon
//
//  Created by RichyLeo on 15/9/17.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import "SingleManager.h"

/**
 *  单例类：创建唯一对象，可传值。可以理解为全局变量使用
    面试题：会问到，可能要生写！
 */

@implementation SingleManager

// 第一种创建方式：
+(SingleManager *)sharedInstance
{
    __strong static SingleManager *sharedManager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[SingleManager alloc] init];
    });
    return sharedManager;
}

// 第二种创建方式：
+(SingleManager *)defaultInstance
{
    static SingleManager * defaultManager = nil;
    
    @synchronized(self){
        if(defaultManager == nil){
            defaultManager = [[SingleManager alloc] init];
        }
    }
    
    return defaultManager;
}

@end
