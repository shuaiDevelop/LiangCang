//
//  ExpertCollectionViewCell.m
//  LiangCangApp
//
//  Created by MS on 15/10/10.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "ExpertCollectionViewCell.h"
#import "StringConstants.h"

@implementation ExpertCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
    }
    return self;
}
- (void)createViews{
    UIImage * image = [UIImage imageNamed:@"icn_user_default@2x.png"];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, SCREEN_WIDTH/3-5, SCREEN_WIDTH/3)];
    _imageView.contentMode = UIViewContentModeScaleToFill;
    _imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_imageView];

    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_imageView.frame)+1, image.size.width, 15)];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.font = [UIFont systemFontOfSize:12.0];
    _nameLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_nameLabel];

    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameLabel.frame)+1, image.size.width, 15)];
    _descLabel.font = [UIFont systemFontOfSize:10.0];
//    _descLabel.textColor = [UIColor colorWithRed:119 green:152 blue:162 alpha:1];
    [_descLabel setTextColor:[UIColor colorWithRed:119 green:152 blue:162 alpha:1]];
    [self.contentView addSubview:_descLabel];



}
@end
