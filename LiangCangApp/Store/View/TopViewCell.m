//
//  TopViewCell.m
//  LiangCang
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "TopViewCell.h"
#import "StoreModel.h"
#import "UIImageView+AFNetworking.h"
@implementation TopViewCell

- (void)awakeFromNib {
    // Initialization code
}

/*
 @property (strong, nonatomic) IBOutlet UIScrollView *imageScroll;
 @property (strong, nonatomic) IBOutlet UILabel *pricelabel;
 @property (strong, nonatomic) IBOutlet UILabel *nameLabel;
 
 @property (strong, nonatomic) IBOutlet UILabel *favlabel;
 @property (strong, nonatomic) IBOutlet UILabel *descriplabel;

 */

-(void)refreshWith:(StoreModel *)model{

    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.imageScroll.frame.size.height)];
    [imageview setImageWithURL:[NSURL URLWithString:model.goods_image]];
     imageview.userInteractionEnabled = YES;
    [self.imageScroll addSubview:imageview];
    
    self.pricelabel.text = model.price;
    self.favlabel.text = model.like_count;
    self.descriplabel.text = [model.brand_info objectForKey:@"brand_desc"];
    self.nameLabel.text = model.goods_name;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
