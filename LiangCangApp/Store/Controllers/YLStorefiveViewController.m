//
//  YLStorefiveViewController.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/11.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "YLStorefiveViewController.h"
#import "LCStoreDetailViewController.h"
@interface YLStorefiveViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView * collectionView;

@end

@implementation YLStorefiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
}
- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64-49-40) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    
    return _collectionView;
}
// section 个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
// item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

// item 内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
//    cell.model = self.dataSource[indexPath.row];
    UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    
//    cell.backgroundColor = [UIColor blackColor];
    imageview.userInteractionEnabled = YES;
    [imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"LC%ld@2x.png",indexPath.row+1]]];
    [cell addSubview:imageview];
    return cell;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return CGSizeMake(SCREEN_WIDTH/3, SCREEN_WIDTH/3);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 536/2)];//536  750
        
        imageView.userInteractionEnabled = YES;
        [imageView setImage:[UIImage imageNamed:@"banner01@2x.png"]];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        
        [imageView addGestureRecognizer:tap];
        [header addSubview:imageView];
        return header;
        
        
        
    }



    return nil;

}
- (void)tapAction:(UITapGestureRecognizer *)gesture{

    LCStoreDetailViewController * storeDetail = [[LCStoreDetailViewController alloc] init];
    storeDetail.Presentid = 6;
    storeDetail.section = 10;
     storeDetail.titlee = @"良仓礼物";
    storeDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:storeDetail animated:NO];



}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSArray * arr = @[@"节日",@"爱情",@"生日",@"朋友",@"孩子",@"父母"];
    LCStoreDetailViewController * storeDetail = [[LCStoreDetailViewController alloc] init];
    storeDetail.Presentid = indexPath.row+1;
    storeDetail.section = 10;
    storeDetail.titlee = arr[indexPath.row];
    storeDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:storeDetail animated:NO];
    
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{



    return CGSizeMake(SCREEN_WIDTH, 536/2);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
