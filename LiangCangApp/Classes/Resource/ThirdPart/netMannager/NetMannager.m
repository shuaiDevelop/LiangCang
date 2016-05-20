//
//  NetMannager.m
//  Easyflower
//
//  Created by 赵宇 on 15/5/7.
//  Copyright (c) 2015年 DGL. All rights reserved.
//

#import "NetMannager.h"

@implementation NetMannager

+ (NetMannager *)shareMannager{
    static NetMannager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[NetMannager alloc] init];
    });
    return manager;
}
/*parms 参数*/
+(void)requestWithUrlString:(NSString *)string parms:(id)obj responseType:(NSString *)type finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed;{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:type];
    
    //有参数则进行POST方法请求、没有参数则进行GET请求
    if (obj==nil) {
        [manager GET:string parameters:nil success:finished failure:failed];
    }else{
        [manager POST:string parameters:obj success:finished failure:failed];
    }
}

+(void)uploadWithUrlString:(NSString *)urlString parms:(id)obj responseType:(NSString *)type uploadBlock:(UploadBlock)upload finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:type];
    [manager POST:urlString parameters:obj constructingBodyWithBlock:upload success:finished failure:failed];
}

+(void)downloadWithUrlString:(NSString *)urlString andFileName:(NSString *)fileName andObserver:(id)obj
{

    NSURLSessionConfiguration *config  =[NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    NSURL *url  =[NSURL URLWithString:urlString];
    NSProgress *progress = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSString *desPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",fileName];
        return [NSURL fileURLWithPath:desPath];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
    }];
    [progress addObserver:obj forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:NULL];
    [downloadTask resume];
}

@end
