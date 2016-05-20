//
//  UILabel+Category.h
//  YuLinZhengFeng
//
//  Created by 王帅 on 16/5/13.
//  Copyright © 2016年 shuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)
+ (UILabel *)labelWithFont:(UIFont *)font
                 textColor:(UIColor *)textColor
             numberOfLines:(NSInteger)lines
             textAlignment:(NSTextAlignment)textAlignment;


/**
 *     一个指示器
 *
 *  @param stats 提示内容
 *  @param view  添加到view上
 */
+ (void)showStats:(NSString *)stats atView:(UIView *)view;

/**
 *  快速设置富文本
 *
 *  @param string 需要设置的字符串
 *  @param range  需要设置的范围（范围文字颜色显示为下厨房橘红色）
 */
- (void)setAttributeTextWithString:(NSString *)string range:(NSRange)range;

@end
