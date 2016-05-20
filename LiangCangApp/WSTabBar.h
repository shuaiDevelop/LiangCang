//
//  WSTabBar.h
//  WSNetWorkExam
//
//  Created by MS on 15/9/25.
//  Copyright © 2015年 WS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSTabBar;
@class WSimageButton;
@protocol WSTabBarDelegate <NSObject>

-(void)tabbar:(WSTabBar *)tabbar didSelectedIndex:(NSUInteger)index;
@end
@interface WSTabBar : UIView
{
    UIButton * btn1;
    UIButton * btn2;
    UIButton * btn3;
    UIButton * btn4;
    UIButton * btn5;
}

@property (nonatomic, weak) id <WSTabBarDelegate> delegate;
@property (nonatomic, assign) NSUInteger index; // 用来记录当前被选中的按钮

@end
