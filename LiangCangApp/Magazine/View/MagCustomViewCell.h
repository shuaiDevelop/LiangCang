//
//  MagCustomViewCell.h
//  LiangCangApp
//
//  Created by MS on 15/10/7.
//  Copyright © 2015年 WS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagazineModel.h"

@interface MagCustomViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * headLabel;
@property (nonatomic, strong) UIImageView * firstImageView;
@property (nonatomic, strong) UIImageView * secondImageView;
@property (nonatomic, strong) UILabel * textlabel;
@property (nonatomic, strong) UILabel * detailLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithFrame:(CGRect)frame;

- (void)refreshInfoByModel:(MagazineModel *)model andStr:(NSString *)str;
@end
