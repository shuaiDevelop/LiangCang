//
//  LCOneStoreDetailController.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/18.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "LCOneStoreDetailController.h"
#import "JCCollectionViewWaterfallLayout.h"
#import "AFNetworking.h"
#import "StoreModel.h"
#import "brand_infoModel.h"
#import "StoreCell.h"
#import "UIImageView+WebCache.h"
#import "WsDetailsViewController.h"
#import "OneStoreDetailModel.h"
#import "UIImageView+WebCache.h"
#import "LCStoreDetail.h"
#define url @"http://iliangcang.com:8200/brand/%@?app_key=iphone"
@interface LCOneStoreDetailController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    NSInteger _page;
    NSString *_path;
    BOOL _isUp;
}
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong)NSMutableArray * dataSource;
@property (strong, nonatomic) UIImageView *HeadImgView; //!< 头部图像

@end

@implementation LCOneStoreDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _dataSource = [[NSMutableArray alloc] init];
//    UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [imageview setImage:[UIImage imageNamed:@"Icon-titleview.png"]];
//    [self.navigationItem setTitleView:imageview];
    self.navigationItem.title = @"良仓品牌";
    [self downLoadData];
    
    [self createCollectionView];
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    // 与图像高度一样防止数据被遮挡
//    self.collectionView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, HeadImgHeight)];
    

}
- (void)createCollectionView {
    
    JCCollectionViewWaterfallLayout * layout = [[JCCollectionViewWaterfallLayout alloc] init];
    layout.columnCount = 2;
    layout.edge = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = RGB_COLOR(21, 21, 21, 1);
    [_collectionView registerNib:[UINib nibWithNibName:@"StoreCell" bundle:nil] forCellWithReuseIdentifier:@"store"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:_collectionView];
    
    self.HeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*260/640)];
    self.HeadImgView.image = [UIImage imageNamed:@"brand_bg@2x"];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    imageView.center = CGPointMake(self.HeadImgView.frame.size.width/2, self.HeadImgView.frame.size.height/2-10);
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 25;
    imageView.tag = 11;
    
    [imageView setImageWithURL:[NSURL URLWithString:self.logo]];
    
    [self.HeadImgView addSubview:imageView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.HeadImgView.frame.size.width, 20)];
   label.center =CGPointMake(self.HeadImgView.frame.size.width/2, self.HeadImgView.frame.size.height/2+35);
    label.text = self.name;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = 12;
    [self.HeadImgView addSubview:label];
    
    
    
    [_collectionView addSubview:self.HeadImgView];
    
}
- (void)downLoadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    __weak typeof(self) weakSelf = self;
    [manager GET:[NSString stringWithFormat:url,weakSelf.idnumber] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *DataArr = [dic objectForKey:@"data"];
            for (NSDictionary *dicc in [DataArr objectForKey:@"goods"]) {
                OneStoreDetailModel * model = [[OneStoreDetailModel alloc] init];
                [model setValuesForKeysWithDictionary:dicc];
                [_dataSource addObject:model];
                
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                // 结束上拉刷新的动画，View的展示
                [weakSelf.collectionView reloadData];
                
            });

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"11");
    }];



}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < 0) {
        self.HeadImgView.frame = CGRectMake(offsetY/2, offsetY, SCREEN_WIDTH - offsetY, SCREEN_WIDTH*260/640 - offsetY);  // 修改头部的frame值就行了
        
        UIImageView * imageView = [self.collectionView viewWithTag:11];
        imageView.center = CGPointMake(self.HeadImgView.frame.size.width/2, self.HeadImgView.frame.size.height/2-10);
        
        UILabel * label = [self.collectionView viewWithTag:12];
        label.center =CGPointMake(self.HeadImgView.frame.size.width/2, self.HeadImgView.frame.size.height/2+35);

    }
    
    /* 往上滑动contentOffset值为正，大多数都是监听这个值来做一些事 */
}

#pragma mark -- uicollectionViewdelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"store" forIndexPath:indexPath];
    
    OneStoreDetailModel * model = _dataSource[indexPath.row];
    
//    StoreModel *model = _dataSource[indexPath.row];
    cell.goods_name.text = model.name;
    [cell.goods_image setImageWithURL:[NSURL URLWithString:[[model.images firstObject] objectForKey:@"url"]]];
    cell.sale_by.text = model.sale_by;
    cell.price.text = [NSString stringWithFormat:@"￥%@",model.price];
    cell.like_count.text =[NSString stringWithFormat:@"%@",model.like_count];
    
    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(123, 177);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    http://app.iliangcang.com/goods?app_key=iphone&build=170&goods_id=247379&osVersion=93&v=2.5.0
//    NSLog(@"%@",[self.dataSource[indexPath.row] idd]);
    
    LCStoreDetail * detail = [LCStoreDetail new];
    
    detail.goodsid = [NSString stringWithFormat:@"%@",[self.dataSource[indexPath.row] idd]];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{



    return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*260/640);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section{

    return SCREEN_WIDTH*260/640+40;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        UIView  * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*260/640 + 40)];
        
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, SCREEN_WIDTH*260/640+5, 100, 20)];
        
        label.textColor = [UIColor whiteColor];
        label.text = @"品牌产品";
        [view addSubview:label];
        [header addSubview:view];
        
        return header;
        
    }
    return nil;


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
