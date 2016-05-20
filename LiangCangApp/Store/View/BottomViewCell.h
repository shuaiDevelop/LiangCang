//
//  BottomViewCell.h
//  LiangCang
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreModel;
@interface BottomViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *imgbtn;

@property (strong, nonatomic) IBOutlet UILabel *rec_reason;

@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UIButton *ownname;
-(void)refreshWith:(StoreModel *)model;
@end
