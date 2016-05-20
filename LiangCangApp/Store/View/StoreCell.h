//
//  StoreCell.h
//  LiangCang
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *goods_image;

@property (strong, nonatomic) IBOutlet UILabel *goods_name;

@property (strong, nonatomic) IBOutlet UILabel *sale_by;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *like_count;

@end
