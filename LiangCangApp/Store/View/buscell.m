//
//  buscell.m
//  LiangCang
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "buscell.h"
#import "UIImageView+AFNetworking.h"
@implementation buscell

- (void)awakeFromNib {
    // Initialization code
}

-(void)refreshWithModel:(NSArray *)arr{

    [self.imageico setImageWithURL:[NSURL URLWithString:arr[2]]];

    self.name.text = arr[1];
    self.pricelabel.text = arr[0];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
