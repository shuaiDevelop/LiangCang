//
//  ShareDetailViewCell.h
//  LiangCangApp
//
//  Created by MS on 15/10/14.
//  Copyright © 2015年 WS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareDetailModel.h"

@interface ShareDetailViewCell : UITableViewCell

@property (strong, nonatomic) UIView * view;
@property(strong, nonatomic) UIImageView * userImageView;

@property(strong, nonatomic) UILabel * msgLabel;

@property(strong, nonatomic) UIButton * answerBtn;

@property(strong, nonatomic) UILabel * timeLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFrame:(CGRect)frame;
- (void)refreshCellWithModel:(ShareDetailModel *)model;
@end
