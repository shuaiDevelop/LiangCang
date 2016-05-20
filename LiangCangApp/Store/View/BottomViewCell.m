//
//  BottomViewCell.m
//  LiangCang
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "BottomViewCell.h"
#import "StoreModel.h"
@implementation BottomViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)refreshWith:(StoreModel *)model{
 self.rec_reason.text = [model.brand_info objectForKey:@"brand_desc"];
  self.content.text = @"所有商品均为正品保证，下单后四个工作日内发货。中国大陆地区免运费，默认发顺丰或圆通快递。\r\n蜡烛、液态品、手表等含电池产品无法空运，运输时间相较普通空运件会更久。\r\n如出现产品质量问题请在签收后72小时内联系客服。";
    [self.ownname setTitle:model.goods_name forState:UIControlStateNormal];
   

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
