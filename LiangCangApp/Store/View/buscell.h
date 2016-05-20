//
//  buscell.h
//  LiangCang
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface buscell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageico;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *pricelabel;
-(void)refreshWithModel:(NSArray *)arr;
@end
