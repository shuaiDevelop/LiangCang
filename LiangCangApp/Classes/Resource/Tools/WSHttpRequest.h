//
//  WSHttpRequest.h
//  WSConnectionRequest
//
//  Created by MS on 15/9/15.
//  Copyright (c) 2015年 WS. All rights reserved.
//

#import <Foundation/Foundation.h>

// 前置声明
@class WSHttpRequest;
@protocol WSHttpRequestDelegate <NSObject>

@optional
- (void)handleHttpRequestSuccess:(WSHttpRequest *)request;
- (void)handleHttpRequestFail:(WSHttpRequest *)request;

@end
@interface WSHttpRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic,strong) NSMutableData * reciveData; // 用来存储完整的数据

@property (nonatomic,weak) id <WSHttpRequestDelegate> delegate;

- (instancetype)initHttpRequestWithURLString:(NSString *)urlStr delegate:(id <WSHttpRequestDelegate>)delegate;

- (void)startTask;

- (void)cancelTask;
@end
