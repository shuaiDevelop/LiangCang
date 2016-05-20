//
//  OneStoreDetailModel.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/18.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "OneStoreDetailModel.h"

@implementation OneStoreDetailModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        self.desc = value;
    }
    
    if ([key isEqualToString:@"id"]) {
        self.idd = value;
    }
    
    
    
}

@end
