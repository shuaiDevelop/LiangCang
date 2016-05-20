//
//  SaleViewController.h
//  LiangCang
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "RootViewController.h"

@class StoreModel;
@interface SaleViewController : RootViewController

@property(nonatomic,assign)NSInteger idd;

@property(nonatomic,strong) StoreModel *storemodel;

@end
