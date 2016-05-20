//
//  ThreeStoreCollectionCell.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/16.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "ThreeStoreCollectionCell.h"
#import "threeStoreModel.h"
#import "UIImageView+WebCache.h"
@interface ThreeStoreCollectionCell ()
@end
@implementation ThreeStoreCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCell];
    }
    return self;
}

- (void)createCell{

    
    _begImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _begImageView.userInteractionEnabled = YES;
//    _begImageView.backgroundColor = [UIColor colorWithRed:arc4random()% 255 /255.0 green:arc4random()% 255 /255.0 blue:arc4random()% 255 /255.0 alpha:1];
    [self addSubview:_begImageView];


}
- (void)setModel:(threeStoreModel *)model{
    _model = model;

    [_begImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic_url]] placeholderImage:nil];

}
@end
