//
//  SingleManager.h
//  5_SingleTon
//
//  Created by RichyLeo on 15/9/17.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleManager : NSObject

@property (nonatomic, copy) NSString * name;

// 第一种创建方式：
+(SingleManager *)sharedInstance;

// 第二种创建方式：
+(SingleManager *)defaultInstance;

@end
