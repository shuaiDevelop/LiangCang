//
//  ShareDetailModel.h
//  LiangCangApp
//
//  Created by MS on 15/10/14.
//  Copyright © 2015年 WS. All rights reserved.
/*"comment_id" : "7545",
 "create_time" : "2015-10-14 11:28:36",
 "is_daren" : "0",
 "msg" : "手机jian zh.  工姿曰算80-300，只要有shou机 就可以工作，适合上学哒，上班哒，宅男宅女哦,加我釦釦：617005532",
 "parent_uid" : 0,
 "parent_username" : "",
 "user_id" : 464805799,
 "user_image" : "http://imgs-qn.iliangcang.com/ware/userhead/orig/3/464/805/464805799.jpg?t=1444821705",
 "user_name" : "网时*/

#import <Foundation/Foundation.h>

@interface ShareDetailModel : NSObject

@property (nonatomic, copy) NSString *comment_id;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *is_daren;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *parent_uid;

@property (nonatomic, copy) NSString *parent_username;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *user_image;
@property (nonatomic, copy) NSString *user_name;

@end
