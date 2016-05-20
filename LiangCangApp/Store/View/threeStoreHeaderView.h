//
//  threeStoreHeaderView.h
//  LiangCangApp
//
//  Created by 王帅 on 16/5/12.
//  Copyright © 2016年 WS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface threeStoreHeaderView : UICollectionReusableView <SDCycleScrollViewDelegate>
- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic,strong) NSMutableArray * imageUrlArray;
@property (nonatomic,strong) SDCycleScrollView * scrollView;


@property (nonatomic,copy) void (^clickedBlock)(NSInteger clickedIndex);
@end
