//
//  ShareModel.h
//  LiangCangApp
//
//  Created by MS on 15/10/10.
//  Copyright © 2015年 WS. All rights reserved.
/*"comment_count" : "1",
 "coupon_flag" : false,
 "discount_price" : null,
 "goods_id" : "249026",
 "goods_image" : "http://imgs-qn.iliangcang.com/ware/goods/big/2/249/249026.jpg",
 "goods_name" : "/",
 "goods_url" : "https://blackbirdguitar.com/modeltabs/nylon/photos.html",
 "is_gift" : 0,
 "like_count" : "65",
 "liked" : "0",
 "owner_id" : "3516",
 "price" : 0,
 "promotion_imgurl" : null,
 "sale_by" : "other"*/

#import <Foundation/Foundation.h>

@interface ShareModel : NSObject

@property (nonatomic, copy) NSString * comment_count;
@property (nonatomic, copy) NSString * coupon_flag;
@property (nonatomic, copy) NSString * discount_price;
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * goods_image;       // 使用
@property (nonatomic, copy) NSString * goods_name;
@property (nonatomic, copy) NSString * goods_url;
@property (nonatomic, copy) NSString * is_gift;
@property (nonatomic, copy) NSString * like_count;
@property (nonatomic, copy) NSString * liked;
@property (nonatomic, copy) NSString * owner_id;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * promotion_imgurl;
@property (nonatomic, copy) NSString * sale_by;

@end
