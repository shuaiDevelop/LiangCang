//
//  ExpertModel.h
//  LiangCangApp
//
//  Created by MS on 15/10/10.
//  Copyright © 2015年 WS. All rights reserved.
/*is_daren" : "1",
 "user_desc" : "日本时装设计师",
 "user_id" : "12596",
 "user_image" : "http://imgs-qn.iliangcang.com/ware/userhead/orig/2/12/12596.jpg?t=1444474038",
 "user_name"*/

#import <Foundation/Foundation.h>

@interface ExpertModel : NSObject

@property (nonatomic, copy) NSString * is_daren;
@property (nonatomic, copy) NSString * user_desc;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * user_image;
@property (nonatomic, copy) NSString * user_name;

@end
