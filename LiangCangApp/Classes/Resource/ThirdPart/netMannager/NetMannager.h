//
//  NetMannager.h
//  Easyflower
//
//  Created by 赵宇 on 15/5/7.
//  Copyright (c) 2015年 DGL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"

typedef void (^DownloadFinishedBlock) (AFHTTPRequestOperation *operation,id responsObj);
typedef void (^DownloadFailedBlock) (AFHTTPRequestOperation *operation,NSError *error);
typedef void (^UploadBlock) (id <AFMultipartFormData>formData);

@interface NetMannager : NSObject
+ (NetMannager *) shareMannager;
//普通数据请求(get和post请求)
+(void)requestWithUrlString:(NSString *)string parms:(id)obj responseType:(NSString *)type finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed;

//上传数据
+(void)uploadWithUrlString:(NSString *)urlString parms:(id)obj responseType:(NSString *)type uploadBlock:(UploadBlock)upload finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed;

//下载数据
+(void)downloadWithUrlString:(NSString *)urlString andFileName:(NSString *)fileName andObserver:(id)obj;
@end
