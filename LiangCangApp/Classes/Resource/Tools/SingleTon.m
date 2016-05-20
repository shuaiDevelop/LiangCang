//
//  SingleTon.m
//  RLLimitApp
//
//  Created by RichyLeo on 15/9/29.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import "SingleTon.h"

/**
 *  单例类
 */
@implementation SingleTon

+(SingleTon *)sharedSingleTon
{
    static SingleTon * single = nil;
    @synchronized(self){
        if(single == nil){
            single = [[SingleTon alloc] init];
        }
    }
    return single;
}

-(instancetype)init
{
    if(self = [super init]){
       
        self.iddarr = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
