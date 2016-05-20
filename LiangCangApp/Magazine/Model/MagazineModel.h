//
//  MagazineModel.h
//  LiangCangApp
//
//  Created by MS on 15/10/7.
//  Copyright © 2015年 WS. All rights reserved.
/*"access_url" : "http://www.iliangcang.com/i/topicapp/201510062714",
 "addtime" : "2015-10-06 00:27:54",
 "author_id" : "4",
 "author_name" : "《新视线》",
 "cat_id" : "11",
 "cat_name" : "文化",
 "cover_img" : "http://imgs-qn.iliangcang.com/ware/appimg/topic/cover/651_.jpg?_t=1444107821",
 "cover_img_new" : "http://imgs-qn.iliangcang.com/ware/appimg/topic/cover/651_.jpg?_t=1444107821",
 "hit_number" : 44902,
 "nav_title" : "良仓杂志",
 "taid" : "651",
 "topic_name" : "抵达波普的16条大道",
 "topic_url" : "http://www.iliangcang.com/i/topicapp/201510090949"
*/

#import <Foundation/Foundation.h>

@interface MagazineModel : NSObject

@property (nonatomic, copy) NSString * access_url;
@property (nonatomic, copy) NSString * addtime;
@property (nonatomic, copy) NSString * author_id;
@property (nonatomic, copy) NSString * author_name;
@property (nonatomic, copy) NSString * cat_id;
@property (nonatomic, copy) NSString * cat_name;     //使用

@property (nonatomic, copy) NSString * cover_img;    //
@property (nonatomic, copy) NSString * cover_img_new;
@property (nonatomic, copy) NSString * hit_number;
@property (nonatomic, copy) NSString * nav_title;
@property (nonatomic, copy) NSString * taid;
@property (nonatomic, copy) NSString * topic_name;   //
@property (nonatomic, copy) NSString * topic_url;    //传值

@end
