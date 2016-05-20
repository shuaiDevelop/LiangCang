//
//  FourStoreCollectionCell.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/17.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "FourStoreCollectionCell.h"
#import "MagazineModel.h"
#import "UIImageView+WebCache.h"
@implementation FourStoreCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{

    _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _backImageView.userInteractionEnabled = YES;
    [self addSubview:_backImageView];
    
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, 20)];
    view.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2+20);

//    view.backgroundColor = [UIColor orangeColor];
    [_backImageView addSubview:view];
    
    
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    _detailLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    _detailLabel.textAlignment = NSTextAlignmentCenter;
    [_detailLabel setTextColor:[UIColor whiteColor]];
    [view addSubview:_detailLabel];
    

}

- (void)setModel:(MagazineModel *)model{
    _model = model;
    [_backImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.cover_img]]];
    _detailLabel.text = model.topic_name;
    

}
@end
