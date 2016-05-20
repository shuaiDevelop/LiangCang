//
//  WSTabBar.m
//  WSNetWorkExam
//
//  Created by MS on 15/9/25.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "WSTabBar.h"
#import "StringConstants.h"
#import "Tools.h"
#import "WSimageButton.h"
#define BUTTON_WIDTH    SCREEN_WIDTH / 5
#define BUTTON_HEIGHT   49

@implementation WSTabBar

-(instancetype)initWithFrame:(CGRect)frame
{

    if(self = [super initWithFrame:frame]){
        // 背景条
        UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
//        bgImageView.image = [UIImage imageNamed:@"bg_cell_normal@2x.png"];
        bgImageView.backgroundColor = [UIColor blackColor];
        bgImageView.userInteractionEnabled = YES;
        [self addSubview:bgImageView];

        btn1 = [Tools createButtonNormalImage:@"tabbar_shop@2x.png" selectedImage:@"tabbar_shop_h@2x.png" tag:0 addTarget:self action:@selector(buttonClicked:)];
        btn1.frame = CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT);
        btn1.selected = YES;
        [self addSubview:btn1];

        btn2 = [Tools createButtonNormalImage:@"tabbar_special@2x.png" selectedImage:@"tabbar_special_h@2x.png" tag:1 addTarget:self action:@selector(buttonClicked:)];
        btn2.frame = CGRectMake(BUTTON_WIDTH, 0, BUTTON_WIDTH, BUTTON_HEIGHT);
        [self addSubview:btn2];

        btn3 = [Tools createButtonNormalImage:@"tabbar_perfectware@2x.png" selectedImage:@"tabbar_perfectware_h@2x.png" tag:2 addTarget:self action:@selector(buttonClicked:)];
        btn3.frame = CGRectMake(BUTTON_WIDTH * 2, 0, BUTTON_WIDTH, BUTTON_HEIGHT);
        [self addSubview:btn3];

        btn4 = [Tools createButtonNormalImage:@"tabbar_activity@2x.png" selectedImage:@"tabbar_activity_h@2x.png" tag:3 addTarget:self action:@selector(buttonClicked:)];
        btn4.frame = CGRectMake(BUTTON_WIDTH * 3, 0, BUTTON_WIDTH, BUTTON_HEIGHT);
        [self addSubview:btn4];

        btn5 = [Tools createButtonNormalImage:@"tabbar_person@2x.png" selectedImage:@"tabbar_person_h@2x.png" tag:4 addTarget:self action:@selector(buttonClicked:)];
        btn5.frame = CGRectMake(BUTTON_WIDTH * 4, 0, BUTTON_WIDTH, BUTTON_HEIGHT);
        [self addSubview:btn5];

    }
    return self;
}

-(void)buttonClicked:(UIButton *)btn
{
    if(btn.tag == self.index){
        return;
    }

    // 改变当前选中的
    self.index = btn.tag;

    btn1.selected = (btn1.tag == self.index ? YES : NO);
    btn2.selected = (btn2.tag == self.index ? YES : NO);
    btn3.selected = (btn3.tag == self.index ? YES : NO);
    btn4.selected = (btn4.tag == self.index ? YES : NO);
    btn5.selected = (btn5.tag == self.index ? YES : NO);


    if(self.delegate && [self.delegate respondsToSelector:@selector(tabbar:didSelectedIndex:)]){
        [self.delegate tabbar:self didSelectedIndex:btn.tag];
    }
}

@end
