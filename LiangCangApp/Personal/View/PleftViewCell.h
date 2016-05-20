//
//  PleftViewCell.h
//  LiangCang
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PleftViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *imageBtn;
@property (strong, nonatomic) IBOutlet UILabel *name;
-(void)refreshWith:(NSString *)normalImage and:(NSString *)SelectedImage and:(NSString *)str;
@end
