//
//  WSHttpRequest.m
//  WSConnectionRequest
//
//  Created by MS on 15/9/15.
//  Copyright (c) 2015年 WS. All rights reserved.
//

#import "WSHttpRequest.h"

@interface WSHttpRequest ()
{

    NSURLConnection *_connection;
}
@end

@implementation WSHttpRequest

- (instancetype)initHttpRequestWithURLString:(NSString *)urlStr delegate:(id <WSHttpRequestDelegate>)delegate
{
    self = [super init];
    if (self) {
        _connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]delegate:self];
        self.delegate = delegate;
    }
    return self;
}
- (void)startTask{

    [_connection start];
}

- (void)cancelTask{

    [_connection cancel];
}
// 开始请求的方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

    self.reciveData = [[NSMutableData alloc] init];

}
// 当数据量大的时候 该方法会调用多次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    // 追加新的数据
    [self.reciveData appendData:data];

}
// 请求结束调用的方法
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

    // 数据请求成功 调用此方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleHttpRequestSuccess:)]) {
        [self.delegate handleHttpRequestSuccess:self];
    }

}
// 数据请求失败的方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    if (self.delegate && [self.delegate respondsToSelector:@selector(handleHttpRequestFail:)]) {
        [self.delegate handleHttpRequestFail: self];
    }


}
@end
