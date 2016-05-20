//
//  UserHeaderCollectionReusableView.h
//  LiangCangApp
//
//  Created by MS on 15/10/15.
//  Copyright © 2015年 WS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UICollectionReusableViewDelegate <NSObject>

- (void)reloadViewWithTag:(NSInteger)tag;

@end
@interface UserHeaderCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) UIView * view;                     // 背景view
@property (nonatomic, strong) UIImageView * iconImageView;       // 头像
@property (nonatomic, strong) UILabel * nameLabel;               // 用户名
@property (nonatomic, strong) UIButton * followBtn;              // 关注按钮
@property (nonatomic, strong) UIButton * privateBtn;             // 私信按钮

@property (nonatomic, strong) UIButton * likeButton;       // 喜欢
@property (nonatomic, strong) UIButton * recommendButton;  // 推荐
@property (nonatomic, strong) UIButton * followingButton;  // 关注
@property (nonatomic, strong) UIButton * followedButton;   // 粉丝
@property (nonatomic, strong) UIImageView * slideImgView;  // 改变的图标

@property (nonatomic, weak) id<UICollectionReusableViewDelegate> delegate;
@end
