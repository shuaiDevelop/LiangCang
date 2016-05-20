//
//  SettingView.h
//  LiangCang
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingViewDelegate <NSObject>

-(void)UmengPresent;

@end

@interface SettingView : UIView

@property(nonatomic,weak)id <SettingViewDelegate>delegate;

@end
