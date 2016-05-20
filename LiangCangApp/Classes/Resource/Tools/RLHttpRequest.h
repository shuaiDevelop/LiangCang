//
//  RLHttpRequest.h
//  4_RLConnectionRequest
//
//  Created by RichyLeo on 15/9/15.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import <Foundation/Foundation.h>

// 前置的声明
@class RLHttpRequest;
@protocol RLHttpRequestDelegate <NSObject>

@optional
-(void)handleHttpRequestSuccess:(RLHttpRequest *)request;
-(void)handleHttpRequestFail:(RLHttpRequest *)request;

@end

@interface RLHttpRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableData * reciveData;  // 用来存储完整的数据
@property (nonatomic, assign) id <RLHttpRequestDelegate> delegate;

-(instancetype)initHttpRequestWithURLString:(NSString *)urlStr delegate:(id<RLHttpRequestDelegate>)delegate;

-(void)startTask;

-(void)cancelTask;

@end
