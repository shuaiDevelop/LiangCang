//
//  StoreModel.h
//  LiangCang
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 11111111. All rights reserved.
//
/*
 "comment_count" : "0",
 "coupon_flag" : false,
 "discount_price" : null,
 "goods_id" : "35400",
 "goods_image" : "http://imgs-qn.iliangcang.com/ware/goods/big/2/35/35400.jpg",
 "goods_name" : "笔记本内芯套装",
 "goods_url" : "http://www.iliangcang.com/i/goods/?id=35400",
 "is_gift" : 1,
 "like_count" : "335",
 "liked" : "0",
 "owner_id" : "0",
 "price" : "278.00",
 "promotion_imgurl" : null,
 "sale_by" : "liangcang"

 
 */
#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property(nonatomic,copy)NSString *comment_count;
@property(nonatomic,copy)NSString *coupon_flag;
@property(nonatomic,copy)NSString *discount_price;
@property(nonatomic,copy)NSString *goods_id;
@property(nonatomic,copy)NSString *goods_image;
@property(nonatomic,copy)NSString *goods_name;
@property(nonatomic,copy)NSString *goods_url;
@property(nonatomic,copy)NSString *is_gift;
@property(nonatomic,copy)NSString *like_count;
@property(nonatomic,copy)NSString *liked;
@property(nonatomic,copy)NSString *owner_id;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,retain)NSDictionary *brand_info;
@property(nonatomic,copy)NSString *sale_by;

@end
