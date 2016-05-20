//
//  NSString+SizeString.m
//  ECarThings
//
//  Created by MACLI on 16/3/15.
//  Copyright © 2016年 MACLI. All rights reserved.
//

#import "NSString+SizeString.h"

@implementation NSString (SizeString)

- (CGSize)stringSizeOfFont:(UIFont *)font textMaxSize:(CGSize)maxSize{
    
    return  [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

+ (NSString *)stringFloatTimeToString:(NSString *)time{
    
    return [[[self alloc]init] stringFloatTimeToString:time];
}
- (NSString *)stringFloatTimeToString:(NSString *)time{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time floatValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    return [formatter stringFromDate:date];
}

+ (NSString *)stringShuffledAlphabet:(NSInteger)num{
    
    return [[[self alloc]init] stringShuffledAlphabet:num];
    
}
- (NSString *)stringShuffledAlphabet:(NSInteger)num{
    
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *muStr = [[NSMutableString alloc]init];
    for(NSInteger i = 0 ; i<num ; i++){
        [muStr appendString:[alphabet substringWithRange:NSMakeRange(arc4random_uniform((unsigned int)alphabet.length), 1)]];
    }
    
    return muStr;
}

- (NSInteger)TodayDataWithDateString:(NSString *)dateString{
    if(dateString.length)
    {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps;
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
        NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        
        NSDate *now = [formatter dateFromString:dateString];
        calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        comps = [calendar components:unitFlags fromDate:now];
        
        
        return [comps weekday]-1;
        
        
    }
    return 1;
    
}
@end
