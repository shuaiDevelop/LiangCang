//
//  YLStoreThreeViewController.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/11.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "YLStoreThreeViewController.h"
#import "AFNetworking.h"
#import "JCCollectionViewWaterfallLayout.h"
#import "threeStoreHeaderView.h"
#import "scrollStoreModel.h"
#import "MagDetailViewController.h"
#import "threeStoreModel.h"
#import "ThreeStoreCollectionCell.h"
#import "LCStoreDetailViewController.h"
#import "MJRefresh.h"
@interface YLStoreThreeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property (nonatomic,strong)NSMutableArray * dataSource;
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSMutableArray * listDataSource;
@property (nonatomic,strong)JCCollectionViewWaterfallLayout * layout;
@end

@implementation YLStoreThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor redColor];
    [self createUI];
    [self loadData];
    
}
- (void)loadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __weak typeof(self) weakSelf = self;
    [manager GET:shop_mainURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.listDataSource removeAllObjects];
            NSError * error;
            NSDictionary * resopnseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            if (!error) {
                for (NSDictionary * dic in [resopnseDic[@"slide"] objectForKey:@"data"]) {
                    scrollStoreModel * model = [[scrollStoreModel alloc] init];
                    
                    [model setValuesForKeysWithDictionary:dic];
                    [weakSelf.dataSource addObject:model];
                }
                for (NSDictionary *dic in [resopnseDic[@"list"] objectForKey:@"list"]) {
            
                    
                    if ([dic objectForKey:@"one"]) {
                        threeStoreModel * model = [[threeStoreModel alloc] init];

                        [model setValuesForKeysWithDictionary:[dic objectForKey:@"one"]];
                        [weakSelf.listDataSource addObject:model];

                    }
                    if ([dic objectForKey:@"two"]) {
                        threeStoreModel * model = [[threeStoreModel alloc] init];

                        [model setValuesForKeysWithDictionary:[dic objectForKey:@"two"]];
                        [weakSelf.listDataSource addObject:model];
                        
                    }
                    if ([dic objectForKey:@"three"]) {
                        threeStoreModel * model = [[threeStoreModel alloc] init];

                        [model setValuesForKeysWithDictionary:[dic objectForKey:@"three"]];
                        [weakSelf.listDataSource addObject:model];
                        
                    }
                    if ([dic objectForKey:@"four"]) {
                        threeStoreModel * model = [[threeStoreModel alloc] init];

                        [model setValuesForKeysWithDictionary:[dic objectForKey:@"four"]];
                        [weakSelf.listDataSource addObject:model];
                        
                    }

                    
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

- (void)createUI{
//    [self.collectionView reloadData];
   

}
- (JCCollectionViewWaterfallLayout *)layout{

    if (_layout == nil) {
        _layout = [[JCCollectionViewWaterfallLayout alloc] init];
        _layout.edge = UIEdgeInsetsMake(1.0f, 1.0f, 0.5f, 1.0f);

    }

    return _layout;

}
- (UICollectionView *)collectionView{

    if (_collectionView == nil) {
        self.layout.columnCount = 2;
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        
        
         _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64-49-40) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[threeStoreHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CellIdentifierheader"];
        

        [_collectionView registerClass:[ThreeStoreCollectionCell class] forCellWithReuseIdentifier:@"StoreCollViewCell"];
        [self.view addSubview:_collectionView];
        [self addRefresh];
    }

    return _collectionView;
}
- (void)addRefresh{
    // 添加头部视图，实现下拉刷新（恢复到列表最初的状态）
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRefresh)];



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
    return self.listDataSource.count;
}

// item 内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ThreeStoreCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreCollViewCell" forIndexPath:indexPath];

    cell.model = self.listDataSource[indexPath.row];
    return cell;
    
}
// item 事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (![[[self.listDataSource objectAtIndex:indexPath.row] topic_url ] isEqualToString:@""] && [[self.listDataSource objectAtIndex:indexPath.row] topic_url ]!= nil) {
        MagDetailViewController * detail = [MagDetailViewController new];
        detail.topic_url =[[self.listDataSource objectAtIndex:indexPath.row] topic_url ];
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }else{
    
        LCStoreDetailViewController * storeDetail = [LCStoreDetailViewController new];
        storeDetail.Presentid = [[[self.listDataSource objectAtIndex:indexPath.row] content_id] integerValue];
        storeDetail.section = 10;
        storeDetail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:storeDetail animated:NO];
    
    }

    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:

            return CGSizeMake(SCREEN_WIDTH/2, 220);
            break;
        case 1:

            return CGSizeMake(SCREEN_WIDTH/2, 220);
            break;
            
        case 2:
            return CGSizeMake(SCREEN_WIDTH/2, 220);
            break;
        case 3:
            return CGSizeMake(SCREEN_WIDTH/2, 220);
            break;
            
        case 4:
            return CGSizeMake(SCREEN_WIDTH, 220);
            break;
        case 5:

            return CGSizeMake(SCREEN_WIDTH/2, 100*2);
            break;
        case 6:
            return CGSizeMake(SCREEN_WIDTH/2, 100*2);
            break;
            
        default:
            return CGSizeMake(0, 0);

            break;
    }
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        threeStoreHeaderView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CellIdentifierheader" forIndexPath:indexPath];
        
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*9/16);
        view.imageUrlArray = self.dataSource;
        
        __weak typeof(self) weakSelf = self;
        view.clickedBlock = ^(NSInteger index){
            if (![[[weakSelf.dataSource objectAtIndex:index] topic_url ] isEqualToString:@""] && [[_dataSource objectAtIndex:index] topic_url ]!= nil) {
                MagDetailViewController * detail = [MagDetailViewController new];
                detail.topic_url =[[weakSelf.dataSource objectAtIndex:index] topic_url ];
                detail.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:detail animated:YES];
            }else{
                
                LCStoreDetailViewController * storeDetail = [LCStoreDetailViewController new];
                storeDetail.Presentid = [[[weakSelf.dataSource objectAtIndex:index] content_id] integerValue];
                storeDetail.hidesBottomBarWhenPushed = YES;
                storeDetail.section = 10;

                [weakSelf.navigationController pushViewController:storeDetail animated:YES];
                
            }
            
            
            
        
        };
        return view;
        
    }
    
    return nil;

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
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section{


    return SCREEN_WIDTH*9/16;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{


    return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*9/16);

}
- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}
- (NSMutableArray *)listDataSource{

    if (_listDataSource == nil) {
        _listDataSource = [[NSMutableArray alloc] init];
    }

    return _listDataSource;
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
