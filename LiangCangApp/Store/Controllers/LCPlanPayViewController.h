//
//  LCPlanPayViewController.h
//  LiangCangApp
//
//  Created by 王帅 on 16/5/20.
//  Copyright © 2016年 WS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootViewController.h"
@class LCStoreDetailModel;
@interface LCPlanPayViewController : RootViewController

@property (nonatomic,copy) NSString * type;
@property (nonatomic,strong) LCStoreDetailModel * model;

@end
