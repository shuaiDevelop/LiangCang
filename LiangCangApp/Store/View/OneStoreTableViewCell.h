//
//  OneStoreTableViewCell.h
//  LiangCangApp
//
//  Created by 王帅 on 16/5/18.
//  Copyright © 2016年 WS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OneStoreModel;
@interface OneStoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic,copy) NSString * logo;
@property (nonatomic,copy) NSString * name;

@property (nonatomic,strong) OneStoreModel * model;

@end
