//
//  PleftViewCell.m
//  LiangCang
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "PleftViewCell.h"

@implementation PleftViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)refreshWith:(NSString *)normalImage and:(NSString *)SelectedImage and:(NSString *)str{

    [self.imageBtn setImage:[Tools imageWithName:normalImage] forState:UIControlStateNormal];
    [self.imageBtn setImage:[Tools imageWithName:SelectedImage] forState:UIControlStateSelected];
    self.name.text = str;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
