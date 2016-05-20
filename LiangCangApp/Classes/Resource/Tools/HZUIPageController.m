//
//  HZUIPageController.m
//  PageController
//
//  Created by MS on 15/9/13.
//  Copyright (c) 2015年 HZ. All rights reserved.
//

#import "HZUIPageController.h"

@implementation HZUIPageController
- (instancetype)initWithFrame:(CGRect)frame
{
    
    if(self = [super initWithFrame:frame]){
    

    }
        
        return self;
}

- (void)pageImageMake{
    if(self.pageIndicatorTintImage||self.currentPageIndicatorTintImage){
       for(NSInteger i = 0 ; i < self.subviews.count; i++ ){
    
        UIView *view = [self.subviews objectAtIndex:i];
           //        UIImageView *imageView = [[UIImageView alloc]initWithImage:self.pageIndicatorTintImage];
//        imageView.frame = CGRectMake(0, 0, 20, 7);
//           [imageView.layer setCornerRadius:10];
//        [view addSubview:imageView];
           UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
           btn.backgroundColor = [UIColor orangeColor];
           btn.frame = CGRectMake(0, 0, 20, 3);
           [view addSubview:btn];

        if(self.currentPage == i){
//            imageView.image = self.currentPageIndicatorTintImage;
//            [imageView.layer setCornerRadius:10];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor blueColor];
            btn.frame = CGRectMake(0, 0, 20, 3);
            [view addSubview:btn];
        }
    }
    }
}
- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    [self pageImageMake];
}
- (void)setPageIndicatorTintImage{

    [self pageImageMake];

}
- (void)setCurrentPageIndicatorTintImage{

    [self pageImageMake];

}
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    [self pageImageMake];

}
@end
