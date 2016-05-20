//
//  Tools.m
//  RenRenApp
//
//  Created by RichyLeo on 15/8/31.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import "Tools.h"
#import "pinyin.h"

@implementation Tools

/**
 *  通过文件路径加载图片
 *  该方法加载图片优势：不会将图片加到内存缓存中（适用类型：较大图片的处理）
 *
 *  @param imgName 图片名称（带扩展名）eg：btn_login.png
 *
 *  @return 返回图片对象
 */
+(UIImage *)imageWithName:(NSString *)pngimgName
{
    if(pngimgName){
        NSString * path = [[NSBundle mainBundle] pathForResource:pngimgName ofType:nil];
        UIImage * image = [UIImage imageWithContentsOfFile:path];
        return image;
    }
    
    return nil;
}
+(UIImage *)imageWithjpgName:(NSString *)jpgimgName
{
    if(jpgimgName){
        NSString * path = [[NSBundle mainBundle] pathForResource:jpgimgName ofType:@"jpg"];
        UIImage * image = [UIImage imageWithContentsOfFile:path];
        return image;
    }

    return nil;
}

// 创建一个按钮 （以图片展现）
+(WSimageButton *)createButtonNormalImage:(NSString *)normalImageName selectedImage:(NSString *)selectImageName tag:(NSUInteger)tag addTarget:(id)target action:(SEL)action
{
    WSimageButton * btn = [WSimageButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateHighlighted];
    btn.tag = tag;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}
+(UIButton *)createButtonBgImage:(NSString *)imageName title:(NSString *)title tag:(NSInteger)tag target:(id)target action:(SEL)action{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    btn.tag = tag;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return btn;
}

// 创建UILabel
+(UILabel *)createLabelWithFrame:(CGRect)frame textContent:(NSString *)text withFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)align
{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.font = font;
    label.textColor = color;
    label.textAlignment = align;
    label.text = text;
    
    return label;
}

+(UITextField *)createTextFieldWithFrame:(CGRect)frame
                             placeHolder:(NSString *)placeHolderStr
                             borderStyle:(UITextBorderStyle)style
                           textAlignment:(NSTextAlignment)alignment
                                    font:(UIFont *)font
                                isSecure:(BOOL)isSecure
{
    UITextField * textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeHolderStr;
    textField.borderStyle = style;
    textField.textAlignment = alignment;
    textField.font = font;
    if(isSecure){
        textField.secureTextEntry = YES;
    }
    
    return textField;
}
// 退出时的提示(AlertController)
+ (void)showAlertWithMessage:(NSString *)msg{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"退出" message:msg preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSLog(@"退出");
    }];
    [alertC addAction:sureAction];

    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        NSLog(@"取消");

    }];
    [alertC addAction:cancelAction];
    
    
}

/**
 *  按拼音排序（示例：通讯录A.B...Z）
 *
 *  @param srcArr 全部是中文汉字字符串的集合
 *
 *  @return 按照拼音首字母排好序的集合
 */
+(NSArray *)pinyinSortStringArray:(NSArray *)srcArr isOrderedAscending:(BOOL)isOrderedAscending
{
    // 按照字母排序
    NSArray * sortArr = [srcArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString * str1 = [self transitionToLetters:obj1];
        NSString * str2 = [self transitionToLetters:obj2];
        NSComparisonResult result = [str1 compare:str2];
        if(isOrderedAscending){
            return result == NSOrderedDescending;
        }
        return result == NSOrderedAscending;
    }];
    
    return sortArr;
}

// 将所有中文每个汉字转成字母（且只取第一个字母）
// 该方法为私有方法，仅在上边方法中调用
// eg：中国（zg）
+(NSString *)transitionToLetters:(NSString *)srcStr
{
    NSMutableString * pinyinStr = [[NSMutableString alloc] init];
    for(NSInteger i = 0; i < srcStr.length; i++){
        [pinyinStr appendFormat:@"%c", pinyinFirstLetter([srcStr characterAtIndex:i])];
    }
    
    return pinyinStr;
}
//压缩图片大笑
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

@end
