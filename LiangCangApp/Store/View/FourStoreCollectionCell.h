//
//  FourStoreCollectionCell.h
//  LiangCangApp
//
//  Created by 王帅 on 16/5/17.
//  Copyright © 2016年 WS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MagazineModel;
@interface FourStoreCollectionCell : UICollectionViewCell

@property (nonatomic,strong,readonly) UIImageView * backImageView;
@property (nonatomic,strong,readonly) UILabel * detailLabel;


@property (nonatomic,strong) MagazineModel * model;
@end
