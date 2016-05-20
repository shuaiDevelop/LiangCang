//
//  TopViewCell.h
//  LiangCang
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreModel;
@interface TopViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIScrollView *imageScroll;
@property (strong, nonatomic) IBOutlet UILabel *pricelabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *favlabel;
@property (strong, nonatomic) IBOutlet UILabel *descriplabel;
-(void)refreshWith:(StoreModel *)model;
@end
