//
//  RLHttpRequest.m
//  4_RLConnectionRequest
//
//  Created by RichyLeo on 15/9/15.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import "RLHttpRequest.h"

@interface RLHttpRequest ()
{
    NSURLConnection * _connection;
}
@end

@implementation RLHttpRequest

-(instancetype)initHttpRequestWithURLString:(NSString *)urlStr delegate:(id<RLHttpRequestDelegate>)delegate
{
    if(self = [super init]){
        // NSURLConnection 和 RLHttpRequest 之间的委托代理关系
        _connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] delegate:self];
        
        // 将HttpRequest和ViewController建立代理关系
        self.delegate = delegate;
    }
    
    return self;
}

-(void)startTask
{
    [_connection start];
}

-(void)cancelTask
{
    [_connection cancel];
}


// 开始请求的方法
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _reciveData = [[NSMutableData alloc] init];
}

// 当数据量比较大的时候，该方法会被调用多次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // 追加新的数据
    [self.reciveData appendData:data];
}

// 请求结束回调的方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // 数据请求成功，调用此方法
    if(self.delegate && [self.delegate respondsToSelector:@selector(handleHttpRequestSuccess:)]){
        [self.delegate handleHttpRequestSuccess:self];
    }
}

// 数据请求失败的方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(handleHttpRequestFail:)]){
        [self.delegate handleHttpRequestFail:self];
    }
}

@end
