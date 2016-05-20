//
//  UserDetailViewController.m
//  LiangCangApp
//
//  Created by MS on 15/10/15.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserHeaderCollectionReusableView.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "LikeModel.h"

#import "UserHeaderCollectionReusableView.h"

#import "UserViewCell.h"
#import "ExpertCollectionViewCell.h"
#import "FollowingModle.h"

#import "ShareDetailViewController.h"

#define CellID @"Identifier"
@interface UserDetailViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionReusableViewDelegate>
{

    UICollectionView * _collectionView;

    NSMutableArray * likeDataArr;
    NSMutableArray * followingDataArr;
    NSString * url;
    NSInteger _tag;

}
@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = self.userName;
    [self initData];

    url= [NSString stringWithFormat:UserLikeUrlStr,self.userId];
    [self downloadDataWithUrlStr:url];
    [self createUI];

}
- (void)initData{
    _tag = 1;
    likeDataArr = [[NSMutableArray alloc] init];
    followingDataArr = [[NSMutableArray alloc] init];

   }

- (void)createUI{

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];

    [_collectionView registerClass:[UserHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellID];

        [_collectionView registerClass:[UserViewCell class] forCellWithReuseIdentifier:Identifier];

//        [_collectionView registerClass:[ExpertCollectionViewCell class] forCellWithReuseIdentifier:Identifier];



}
#pragma mark - 下载数据
- (void)downloadDataWithUrlStr:(NSString *)urlStr{

    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];


//       url = [NSString stringWithFormat:UserLikeUrlStr,self.userId];


    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if (!responseObject) {
            return ;
        }
        if (_tag == 1 || _tag == 2) {
            [self parseData:responseObject];

        }
        if (_tag == 3 || _tag == 4) {
            [self parseOtherData:responseObject];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];



}
// 喜欢 推荐
- (void)parseData:(NSData *)data{
    NSDictionary * rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary * dataDic = rootDic[@"data"];


    if ([dataDic[@"goods"] isKindOfClass:[NSString class]]) {

        return;
    }

    if ([dataDic[@"goods"] isKindOfClass:[NSArray class]]) {

//        if (_tag == 2) {
//            [likeDataArr removeAllObjects];
//        }
        for (NSDictionary * dic in dataDic[@"goods"]) {

            LikeModel * model = [[LikeModel alloc] init];

            model.goods_id = dic[@"goods_id"];
            model.goods_image = dic[@"goods_image"];
            model.goods_name = dic[@"goods_name"];
            [likeDataArr addObject:model];

        }
           dispatch_async(dispatch_get_main_queue(), ^{

               [_collectionView reloadData];

        });

    }

}
- (void)parseOtherData:(NSData *)data{

    NSDictionary * rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary * dataDic = rootDic[@"data"];
    if ([dataDic[@"users"] isKindOfClass:[NSString class]]) {

        return;
    }

    if ([dataDic[@"users"] isKindOfClass:[NSArray class]]) {

        for (NSDictionary * dic in dataDic[@"users"]) {
            FollowingModle * model = [[FollowingModle alloc] init];
            model.is_daren = dic[@"is_daren"];
            model.user_id = dic[@"user_id"];
            model.user_image = dic[@"user_image"];
            model.user_name = dic[@"user_name"];
            [followingDataArr addObject:model];

        }
        dispatch_async(dispatch_get_main_queue(), ^{

            [_collectionView reloadData];
            
        });

    }

}
#pragma mark - CollectionView 代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (_tag == 1 || _tag == 2) {
     return likeDataArr.count;
    }else{

        return followingDataArr.count;
    }



}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UserViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    if (_tag == 1 || _tag == 2) {
        LikeModel * model = likeDataArr[indexPath.row];
        [cell.imageView setImageWithURL:[NSURL URLWithString:model.goods_image]];
        return cell;

    }
    else{

    FollowingModle * model = followingDataArr[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:model.user_image]];

    return cell;
}

   
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{


    UserHeaderCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CellID forIndexPath:indexPath];
    header.delegate = self;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {

        [header.iconImageView setImageWithURL:[NSURL URLWithString:self.userImage] placeholderImage:[UIImage imageNamed:@"bg_badge4@2x.png"]];
        header.nameLabel.text = self.userName;

    }
    return header;
}
// 代理

- (void)reloadViewWithTag:(NSInteger)tag{
    _tag = tag;
        NSString * str = [NSString stringWithFormat:UserRecommendUrlStr,self.userId];
    if (_tag == 1) {
        [followingDataArr removeAllObjects];
        [likeDataArr removeAllObjects];

        [self downloadDataWithUrlStr:url];

    }
    if (_tag == 2) {
        [followingDataArr removeAllObjects];
        [likeDataArr removeAllObjects];

        [self downloadDataWithUrlStr:str];
    }
    if (_tag == 3) {
        [followingDataArr removeAllObjects];
        [likeDataArr removeAllObjects];

        [self downloadDataWithUrlStr:[NSString stringWithFormat:UserFollowingUrlStr,self.userId]];
    }
    if (_tag == 4) {
        [followingDataArr removeAllObjects];
        [likeDataArr removeAllObjects];

        [self downloadDataWithUrlStr:[NSString stringWithFormat:UserFollowedUrlStr,self.userId]];
    }



//    [self downloadDataWithUrlStr:url];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 170);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{


    return CGSizeMake(SCREEN_WIDTH/2 - 5, SCREEN_WIDTH/2);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    ShareDetailViewController * shareVC = [[ShareDetailViewController alloc] init];

//    shareVC.good_id = self.userId;

    if (_tag == 1 || _tag == 2) {
        LikeModel * model = likeDataArr[indexPath.row];
        shareVC.good_id = model.goods_id;
        shareVC.good_image = model.goods_image;


    }
    else{

        FollowingModle * model = followingDataArr[indexPath.row];
        shareVC.good_id = model.user_id;

        shareVC.good_image = model.user_image;

    }
    [self.navigationController pushViewController:shareVC animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
