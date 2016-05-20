//
//  LCStoreDetailModel.h
//  LiangCangApp
//
//  Created by 王帅 on 16/5/19.
//  Copyright © 2016年 WS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCStoreDetailModel : NSObject

@property (nonatomic,strong) NSNumber * able_buy;
@property (nonatomic,copy) NSString * able_buy_note;
@property (nonatomic,strong) NSDictionary * brand_info;
@property (nonatomic,copy) NSString * category_id;
@property (nonatomic,copy) NSString * comment_count;
@property (nonatomic,strong) NSDictionary * good_guide;
@property (nonatomic,copy) NSString * goods_desc;
@property (nonatomic,copy) NSString * goods_id;
@property (nonatomic,copy) NSString * goods_image;
@property (nonatomic,copy) NSString * goods_name;
@property (nonatomic,copy) NSString * goods_url;
@property (nonatomic,strong) NSArray * images_item;
@property (nonatomic,copy) NSString * is_daren;
@property (nonatomic,copy) NSString * is_gift;
@property (nonatomic,copy) NSString * like_count;
@property (nonatomic,copy) NSString * owner_desc;
@property (nonatomic,strong) NSNumber * liked;
@property (nonatomic,strong) NSNumber * owner_id;
@property (nonatomic,copy) NSString * owner_image;
@property (nonatomic,copy) NSString * owner_name;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * rec_reason;
@property (nonatomic,strong) NSNumber * servicer_id;
@property (nonatomic,strong) NSArray *  sku_info;

@end
