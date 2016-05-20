//
//  LCStoreDetailViewController.h
//  LiangCangApp
//
//  Created by 王帅 on 16/5/11.
//  Copyright © 2016年 WS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootViewController.h"
@interface LCStoreDetailViewController :RootViewController
@property(nonatomic,assign) NSInteger tagg;

@property(nonatomic,assign) NSInteger Presentid;

@property(nonatomic,assign) NSInteger section;

@property(nonatomic,copy)NSString *titlee;

@property(nonatomic,copy) NSString * cat_code;

@end
