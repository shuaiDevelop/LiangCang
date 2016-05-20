//
//  brand_infoModel.h
//  LiangCang
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 11111111. All rights reserved.
//
/*
 "brand_desc" : "以出售极具设计感的纸制品闻名的Midori，如今已经成为日本顶级生活文具品牌。自1950年创立以来，Midori始终将越用越好的设计作为衡量标准，并赋予产品更为浓厚的感性元素。60年来，Midori在追求此理念的助力下从未停止前进的步伐，通过高品质的文具为我们的生活、工作和旅行带来了无限的乐趣。",
 "brand_id" : "5",
 "brand_logo" : "http://imgs-qn.iliangcang.com/ware/brand/5.jpg",
 "brand_name" : "Midori"

 */

#import <Foundation/Foundation.h>

@interface brand_infoModel : NSObject

@property(nonatomic,copy)NSString *brand_desc;
@property(nonatomic,copy)NSString *brand_id;

@property(nonatomic,copy)NSString *brand_logo;
@property(nonatomic,copy)NSString *brand_name;

@end
