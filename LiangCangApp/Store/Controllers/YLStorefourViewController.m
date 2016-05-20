//
//  YLStorefourViewController.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/11.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "YLStorefourViewController.h"
#import "MagazineModel.h"

#import "MagDetailViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "FourStoreCollectionCell.h"
@interface YLStorefourViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)NSMutableArray * dataSource;
@property (nonatomic,strong)UICollectionView * collectionView;

@end

@implementation YLStorefourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.collectionView];
    [self loadData];
}


- (void)loadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __weak typeof(self) weakSelf = self;
    [manager GET:shop_Maga_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
            
            [weakSelf.dataSource removeAllObjects];
            NSError * error;
            NSDictionary * resopnseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            if (!error) {
                for (NSDictionary * dic in resopnseDic[@"data"]) {
                    MagazineModel * model = [[MagazineModel alloc] init];
                    
                    [model setValuesForKeysWithDictionary:dic];
                    [weakSelf.dataSource addObject:model];
                }
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [weakSelf.collectionView reloadData];
                    [weakSelf.collectionView headerEndRefreshing];

                });
                
            }
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
    
}


- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64-49-40) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[FourStoreCollectionCell class] forCellWithReuseIdentifier:@"FourStoreCollectionCell"];
        [self addRefresh];
    }
    
    return _collectionView;
}
- (void)addRefresh{
    // 添加头部视图，实现下拉刷新（恢复到列表最初的状态）
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRefresh)];
//    [self.collectionView headerBeginRefreshing];
    
    
}
- (void)headerRefresh{
    
    [self loadData];
    
}

// section 个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
// item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

// item 内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FourStoreCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FourStoreCollectionCell" forIndexPath:indexPath];
    
    cell.model = self.dataSource[indexPath.row];
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



    return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*9/16);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    MagDetailViewController * detailVC = [[MagDetailViewController alloc] init];
    MagazineModel * model = self.dataSource[indexPath.row];
    detailVC.topic_url = model.topic_url;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];



}
- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
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
