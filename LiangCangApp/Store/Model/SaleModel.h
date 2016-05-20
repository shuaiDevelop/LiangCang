//
//  SaleModel.h
//  LiangCang
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaleModel : NSObject

@property(nonatomic,copy)NSString *comment_count;
@property(nonatomic,copy)NSString *coupon_flag;
@property(nonatomic,copy)NSString *discount_price;
@property(nonatomic,copy)NSString *goods_id;
@property(nonatomic,copy)NSString *goods_image;
@property(nonatomic,copy)NSString *goods_name;
@property(nonatomic,copy)NSString *goods_url;
@property(nonatomic,copy)NSString *goods_desc;
@property(nonatomic,copy)NSString *is_gift;
@property(nonatomic,copy)NSString *like_count;
@property(nonatomic,copy)NSString *liked;
@property(nonatomic,copy)NSString *owner_id;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,retain)NSDictionary *brand_info;
@property(nonatomic,copy)NSString *sale_by;
@property(nonatomic,retain)NSArray *images_item;

@property(nonatomic,copy)NSString *rec_reason;
@property(nonatomic,retain)NSDictionary *good_guide;




@end
