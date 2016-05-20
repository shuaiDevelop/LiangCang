//
//  OneStoreTableViewCell.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/18.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "OneStoreTableViewCell.h"
#import "UIImageView+WebCache.h"

#import "OneStoreModel.h"
@implementation OneStoreTableViewCell

- (void)awakeFromNib {
    
}
- (void)setName:(NSString *)name{

    _name = name;
    self.nameLabel.text = name;



}
- (void)setLogo:(NSString *)logo{

    _logo = logo;
    [self.backImageView  setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",logo]]];


}
- (void)setModel:(OneStoreModel *)model{

    _model = model;
    
    [self.backImageView  setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[model.logo objectForKey:@"url"]]]];
    self.nameLabel.text = model.name;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
