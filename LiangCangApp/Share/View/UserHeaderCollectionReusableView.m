//
//  UserHeaderCollectionReusableView.m
//  LiangCangApp
//
//  Created by MS on 15/10/15.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "UserHeaderCollectionReusableView.h"
@implementation UserHeaderCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];

    }
    return self;
}

- (void)createViews{

    _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    _view.userInteractionEnabled = YES;
    _view.backgroundColor = [UIColor blackColor];
    [self addSubview:_view];
    

    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 100, 100)];
    _iconImageView.userInteractionEnabled = YES;
    [_view addSubview:_iconImageView];


    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+10, 10, SCREEN_WIDTH/2, 20)];
    _nameLabel.textColor = [UIColor whiteColor];
    [_view addSubview:_nameLabel];
//@"跟帖底.png"
    

    _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _followBtn.frame = CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 150, CGRectGetMaxY(_nameLabel.frame)+50, 40, 30);
    _followBtn.frame = CGRectMake(SCREEN_WIDTH -100, CGRectGetMaxY(_nameLabel.frame)+50, 40, 30);

    [_followBtn setBackgroundImage:[UIImage imageNamed:@"跟帖底.png"] forState:UIControlStateNormal];
    [_followBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_view addSubview:_followBtn];

    _privateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _privateBtn.frame = CGRectMake(CGRectGetMaxX(_followBtn.frame) + 10, CGRectGetMaxY(_nameLabel.frame)+50, 40, 30);
    [_privateBtn setBackgroundImage:[UIImage imageNamed:@"跟帖底.png"] forState:UIControlStateNormal];
    [_privateBtn setTitle:@"私信" forState:UIControlStateNormal];
    [_view addSubview:_privateBtn];

    _slideImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/8, CGRectGetMaxY(_iconImageView.frame) + 30, 20, 20)];
    _slideImgView.center = CGPointMake(SCREEN_WIDTH/8, CGRectGetMaxY(_iconImageView.frame) + 45);
    _slideImgView.image = [UIImage imageNamed:@"btn_favorite@2x.png"];
    _slideImgView.userInteractionEnabled = YES;
    [_view addSubview:_slideImgView];


    _likeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _likeButton.frame = CGRectMake(5, CGRectGetMaxY(_iconImageView.frame) + 10, SCREEN_WIDTH/4, 35);
    _likeButton.backgroundColor = [UIColor colorWithRed:183/255.0 green:221/255.0 blue:222/255.0 alpha:1];
    [_likeButton setTitle:@"喜欢" forState:UIControlStateNormal];
    [_likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_likeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _likeButton.tag = 1;
    [_view addSubview:_likeButton];


    _recommendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _recommendButton.frame = CGRectMake(CGRectGetMaxX(_likeButton.frame), CGRectGetMaxY(_iconImageView.frame) + 10, SCREEN_WIDTH/4, 35);
    _recommendButton.backgroundColor = [UIColor colorWithRed:155/255.0 green:194/255.0 blue:222/255.0 alpha:1];
    [_recommendButton setTitle:@"推荐" forState:UIControlStateNormal];
    [_recommendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_recommendButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _recommendButton.tag = 2;
    [_view addSubview:_recommendButton];


    _followingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _followingButton.frame = CGRectMake(CGRectGetMaxX(_recommendButton.frame), CGRectGetMaxY(_iconImageView.frame) + 10, SCREEN_WIDTH/4, 35);
    _followingButton.backgroundColor = [UIColor colorWithRed:143/255.0 green:172/255.0 blue:215/255.0 alpha:1];
    [_followingButton setTitle:@"关注" forState:UIControlStateNormal];
    [_followingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_followingButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _followingButton.tag = 3;
    [_view addSubview:_followingButton];



    _followedButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _followedButton.frame = CGRectMake(CGRectGetMaxX(_followingButton.frame), CGRectGetMaxY(_iconImageView.frame) + 10, SCREEN_WIDTH/4, 35);
    _followedButton.backgroundColor = [UIColor colorWithRed:118/255.0 green:148/255.0 blue:183/255.0 alpha:1];

    [_followedButton setTitle:@"粉丝" forState:UIControlStateNormal];
    [_followedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_followedButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _followedButton.tag = 4;
    [_followedButton bringSubviewToFront:_slideImgView];
    [_view addSubview:_followedButton];


    //    [slideImgView sendSubviewToBack:_followBtn];


    
}

- (void)buttonClicked:(UIButton *)btn{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(reloadViewWithTag:)] ) {
        [self.delegate reloadViewWithTag:btn.tag];
    }
    switch (btn.tag) {
        case 1:{
      [UIView animateWithDuration:0.5 animations:^{
    _slideImgView.center = CGPointMake(SCREEN_WIDTH/8, CGRectGetMaxY(_iconImageView.frame) + 45);

       }];


        }


            break;
        case 2:
        {
            [UIView animateWithDuration:0.5 animations:^{
                _slideImgView.center = CGPointMake(SCREEN_WIDTH/8*3, CGRectGetMaxY(_iconImageView.frame) + 45);
                
                
            }];
            
        }

            break;
        case 3:
        {
            [UIView animateWithDuration:0.5 animations:^{
                _slideImgView.center = CGPointMake(SCREEN_WIDTH/8*5, CGRectGetMaxY(_iconImageView.frame) + 45);


            }];

        }
            break;
        case 4:
        {
            [UIView animateWithDuration:0.5 animations:^{
                _slideImgView.center = CGPointMake(SCREEN_WIDTH/8*7, CGRectGetMaxY(_iconImageView.frame) + 45);


            }];

        }
            break;
        default:
            break;
    }


}
@end
