//
//  ThreeStoreCollectionCell.h
//  LiangCangApp
//
//  Created by 王帅 on 16/5/16.
//  Copyright © 2016年 WS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class threeStoreModel;
@interface ThreeStoreCollectionCell : UICollectionViewCell
@property (nonatomic,strong,readonly) UIImageView * begImageView;
@property (nonatomic,strong) threeStoreModel * model;
@end
