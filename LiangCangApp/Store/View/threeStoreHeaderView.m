//
//  threeStoreHeaderView.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/12.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "threeStoreHeaderView.h"
#import "SDCycleScrollView.h"
#import "scrollStoreModel.h"

@implementation threeStoreHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI:frame];
        
    }
    return self;
}
- (void)createUI:(CGRect)frame{

    self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:nil];
    self.scrollView.autoScrollTimeInterval = 5.0;
    self.scrollView.currentPageDotImage = [UIImage imageNamed:@"pagee.png"];
    self.scrollView.pageDotImage = [UIImage imageNamed:@"pageg.png"];
    [self addSubview:self.scrollView];

}
- (void)setImageUrlArray:(NSMutableArray *)imageUrlArray{
    _imageUrlArray = imageUrlArray;
    
    NSMutableArray * imageArr = [[NSMutableArray alloc] init];
    for (scrollStoreModel * model in imageUrlArray) {
        [imageArr addObject:model.pic_url];
        
    }
    _scrollView.imageURLStringsGroup = imageArr;


}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if (self.clickedBlock) {
        self.clickedBlock(index);

    }
    
    
}

@end
