//
//  MagCustomViewCell.m
//  LiangCangApp
//
//  Created by MS on 15/10/7.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "MagCustomViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface MagCustomViewCell ()
{

    CGRect cellFrame;

}
@end
@implementation MagCustomViewCell

- (void)awakeFromNib {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithFrame:(CGRect)frame 
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        cellFrame = frame;
        [self createUI];
    }
    return self;
}
- (void)createUI{

    self.headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cellFrame.size.width, 35)];
    self.headLabel.textColor = [UIColor whiteColor];
    self.headLabel.backgroundColor = [UIColor blackColor];
    self.headLabel.textAlignment = NSTextAlignmentCenter;
//    [self.headLabel setTintColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.headLabel];

    self.firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headLabel.frame), cellFrame.size.width, cellFrame.size.height/3)];
    self.firstImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.firstImageView];

    self.textlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cellFrame.size.height/6 - 20, cellFrame.size.width, 18)];
    self.textlabel.textColor = [UIColor whiteColor];
    self.textlabel.textAlignment = NSTextAlignmentCenter;
    self.textlabel.font = [UIFont systemFontOfSize:16.0f];
    [self.firstImageView addSubview:self.textlabel];
    
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textlabel.frame)+5, cellFrame.size.width, 15)];
    self.detailLabel.textColor = [UIColor whiteColor];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.firstImageView addSubview:self.detailLabel];


//
//    self.secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.firstImageView.frame), cellFrame.size.width, cellFrame.size.height/3)];
//    self.secondImageView.userInteractionEnabled = YES;
//    [self.contentView addSubview:self.secondImageView];
//


}

- (void)refreshInfoByModel:(MagazineModel *)model andStr:(NSString *)str{

    NSMutableString * string = [NSMutableString stringWithFormat:@"%@",str];
    NSRange range = {0,5};
    [string deleteCharactersInRange:range];
    self.headLabel.text = [NSString stringWithFormat:@"-- %@ --",string];

    [self.firstImageView setImageWithURL:[NSURL URLWithString:model.cover_img]];
    self.textlabel.text = model.topic_name;
    self.detailLabel.text = [NSString stringWithFormat:@"#  %@",model.cat_name];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
