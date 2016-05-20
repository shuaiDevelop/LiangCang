//
//  LikeModel.h
//  LiangCangApp
//
//  Created by MS on 15/10/16.
//  Copyright © 2015年 WS. All rights reserved.
/*"comment_count" : "0",
 "goods_id" : "232344",
 "goods_image" : "http://imgs-qn.iliangcang.com/ware/goods/big/2/232/232344.jpg",
 "goods_name" : "MARSÈLL",
 "like_count" : "1",
 "liked" : 0,
 "owner_id" : "4381",
 "price" : "6501.78",
 "promotion_imgurl" : null,
 "sale_by" : "*/

#import <Foundation/Foundation.h>

@interface LikeModel : NSObject
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * goods_image;
@property (nonatomic, copy) NSString * goods_name;


@end
