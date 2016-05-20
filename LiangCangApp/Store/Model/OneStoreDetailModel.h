//
//  OneStoreDetailModel.h
//  LiangCangApp
//
//  Created by 王帅 on 16/5/18.
//  Copyright © 2016年 WS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneStoreDetailModel : NSObject

@property (nonatomic,copy) NSString * brand_id;
@property (nonatomic,copy) NSString * comment_count;
@property (nonatomic,copy) NSString * desc;//description
@property (nonatomic,copy) NSString * discount_price;
@property (nonatomic,copy) NSString * idd;//id
@property (nonatomic,strong) NSArray * images;
@property (nonatomic,copy) NSString * is_gift;
@property (nonatomic,copy) NSString * is_liked;
@property (nonatomic,copy) NSString * like_count;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * promotion_imgurl;
@property (nonatomic,copy) NSString * promotion_info;
@property (nonatomic,copy) NSString * sale_by;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * user_id;
@property (nonatomic,strong) NSDictionary * sku;

@end
