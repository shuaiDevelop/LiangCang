//
//  HZUIPageController.h
//  PageController
//
//  Created by MS on 15/9/13.
//  Copyright (c) 2015年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZUIPageController : UIPageControl

@property (nonatomic,strong)UIImage *pageIndicatorTintImage;
@property (nonatomic,strong)UIImage *currentPageIndicatorTintImage;

- (instancetype)initWithFrame:(CGRect)frame;
@end
