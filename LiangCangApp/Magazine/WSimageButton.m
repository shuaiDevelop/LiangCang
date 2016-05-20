//
//  WSimageButton.m
//  LiangCangApp
//
//  Created by MS on 15/10/7.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "WSimageButton.h"

@implementation WSimageButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGRect)imageRectForContentRect:(CGRect)contentRect{

    return CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);


}

@end
