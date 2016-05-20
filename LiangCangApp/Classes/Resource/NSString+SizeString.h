//
//  NSString+SizeString.h
//  ECarThings
//
//  Created by MACLI on 16/3/15.
//  Copyright © 2016年 MACLI. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "PrefixHeader.h"

@interface NSString (SizeString)
/**
 *  测字符串尺寸
 *
 *  @param font    字体大小
 *  @param maxSize size
 *
 *  @return size
 */
- (CGSize)stringSizeOfFont:(UIFont *)font textMaxSize:(CGSize)maxSize;
/**
 *  时间戳转时间
 *
 *  @param time 时间戳
 *
 *  @return 时间
 */
+ (NSString *)stringFloatTimeToString:(NSString *)time;
/**
 *  随机字符串
 *
 *  @param num 字符串长度
 *
 *  @return 随机字符串
 */
+ (NSString *)stringShuffledAlphabet:(NSInteger)num;
@end
