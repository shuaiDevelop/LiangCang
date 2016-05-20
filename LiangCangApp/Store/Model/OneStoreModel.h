//
//  OneStoreModel.h
//  LiangCangApp
//
//  Created by 王帅 on 16/5/18.
//  Copyright © 2016年 WS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneStoreModel : NSObject

@property (nonatomic,strong) NSDictionary * category;
@property (nonatomic,copy) NSString * desc;//description
@property (nonatomic,strong) NSNumber * idd; // id
@property (nonatomic,strong) NSDictionary * logo;
@property (nonatomic,copy) NSString * name;


@end
