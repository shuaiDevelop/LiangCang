//
//  ShareDetailViewCell.m
//  LiangCangApp
//
//  Created by MS on 15/10/14.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "ShareDetailViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface ShareDetailViewCell ()
{

    CGRect cellFrame;

}
@end
@implementation ShareDetailViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFrame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        cellFrame = frame;
        [self createViews];

    }
    return self;
}

- (void)createViews{

    _view = [[UIView alloc] initWithFrame:CGRectZero];

    _view.userInteractionEnabled = YES;
    _view.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_view];

    _userImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _userImageView.userInteractionEnabled = YES;
    [_view addSubview:_userImageView];

    _msgLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _msgLabel.textColor = [UIColor whiteColor];
    [_view addSubview:_msgLabel];

    _answerBtn = [UIButton buttonWithType:UIButtonTypeCustom];

//    [_answerBtn setImage:[UIImage imageNamed:@"跟帖底.png"] forState:UIControlStateNormal];
    [_answerBtn setBackgroundImage:[UIImage imageNamed:@"跟帖底.png"] forState:UIControlStateNormal];
    [_answerBtn setTitle:@"回复" forState:UIControlStateNormal];
    [_view addSubview:_answerBtn];

    _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _timeLabel.text = @"前";
    _timeLabel.textColor = [UIColor whiteColor];

    [_view addSubview:_timeLabel];


}

- (void)refreshCellWithModel:(ShareDetailModel *)model{

    CGSize labelHeight = [[NSString stringWithFormat:@"%@:%@",model.user_name,model.msg] boundingRectWithSize:CGSizeMake(cellFrame.size.width/2, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]} context:nil].size;

_view.frame = CGRectMake(0, 0, cellFrame.size.width, 90+labelHeight.height);
    _userImageView.frame = CGRectMake(20, 20, 50, 50);
    _userImageView.layer.cornerRadius = 25.0f;
    [_userImageView setImageWithURL:[NSURL URLWithString:model.user_image] placeholderImage:[UIImage imageNamed:@"bg_badge4@2x.png"]];


    _msgLabel.frame =CGRectMake(CGRectGetMaxX(_userImageView.frame) + 10, 40, cellFrame.size.width/2, labelHeight.height);
    _msgLabel.numberOfLines = 0;
    _msgLabel.text = [NSString stringWithFormat:@"%@:%@",model.user_name,model.msg];


    _answerBtn.frame = CGRectMake(CGRectGetMaxX(_msgLabel.frame) + 30, 40, 50, 30);


    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_userImageView.frame) + 10, CGRectGetMaxY(_msgLabel.frame)+5, cellFrame.size.width/2, 15);

    _timeLabel.text = model.create_time;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
