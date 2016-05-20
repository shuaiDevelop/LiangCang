//
//  ShareCollectionViewCell.m
//  LiangCangApp
//
//  Created by MS on 15/10/10.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "ShareCollectionViewCell.h"
#import "StringConstants.h"

@implementation ShareCollectionViewCell
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
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];

}
@end
