//
//  UILabel+Category.m
//  YuLinZhengFeng
//
//  Created by 王帅 on 16/5/13.
//  Copyright © 2016年 shuai. All rights reserved.
//

#import "UILabel+Category.h"
#define RGBA(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
#define ThemeColor RGB(249, 103, 80)        // TabBar选中颜色

@implementation UILabel (Category)
+ (UILabel *)labelWithFont:(UIFont *)font
                 textColor:(UIColor *)textColor
             numberOfLines:(NSInteger)lines
             textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = textColor;
    label.numberOfLines = lines;
    label.textAlignment = textAlignment;
    return label;
}


+ (void)showStats:(NSString *)stats atView:(UIView *)view {
    
    UILabel *message = [[UILabel alloc] init];
    message.layer.cornerRadius = 10;
    message.clipsToBounds = YES;
    message.backgroundColor = RGBA(0, 0, 0, 0.8);
    message.numberOfLines = 0;
    message.font = [UIFont systemFontOfSize:15];
    message.textColor = [UIColor whiteColor];
    message.textAlignment = NSTextAlignmentCenter;
    message.alpha = 0;
    
    message.text = stats;
    CGSize size = [stats boundingRectWithSize:CGSizeMake(MAXFLOAT, 50)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                                      context:nil].size;
    message.frame = CGRectMake(0, 0, size.width + 20, size.height + 10);
    message.center = view.center;
    [view addSubview:message];
    
    [UIView animateWithDuration:1.5 animations:^{
        message.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            message.alpha = 0;
        } completion:^(BOOL finished) {
            [message removeFromSuperview];
            
        }];
    }];
}


- (void)setAttributeTextWithString:(NSString *)string range:(NSRange)range {
    NSMutableAttributedString *attrsString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrsString addAttribute:NSForegroundColorAttributeName value:ThemeColor range:range];
    self.attributedText = attrsString;
}

@end
