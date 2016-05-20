//
//  WSButton.m
//  LiangCangApp
//
//  Created by MS on 15/10/17.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "WSButton.h"

@implementation WSButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor orangeColor];
        self.transform = CGAffineTransformRotate(self.transform, M_PI/2);
        self.titleLabel.backgroundColor = [UIColor whiteColor];
//        self.titleLabel.font = [UIFont systemFontOfSize:30];
        self.titleLabel.transform = CGAffineTransformRotate(self.titleLabel.transform, -M_PI/2);
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, -M_PI/2);
        //self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.width/2);

    }
    return  self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{

    return CGRectMake(0, 0, SCREEN_WIDTH/8, 40);
}

@end
