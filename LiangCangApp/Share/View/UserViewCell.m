//
//  UserViewCell.m
//  LiangCangApp
//
//  Created by MS on 15/10/16.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "UserViewCell.h"

@implementation UserViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}
- (void)createView{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2-10, SCREEN_WIDTH/2)];
    _imageView.userInteractionEnabled = YES;
//    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];

}

@end
