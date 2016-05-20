//
//  LCStoreDetailViewController.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/11.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "LCStoreDetailViewController.h"
#import "JCCollectionViewWaterfallLayout.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "StoreModel.h"
#import "brand_infoModel.h"
#import "StoreCell.h"
#import "SaleViewController.h"
#import "UIImageView+WebCache.h"
#import "WsDetailsViewController.h"
#import "LCStoreDetail.h"
#import "LrdOutputView.h"
@interface LCStoreDetailViewController () <UICollectionViewDataSource,UICollectionViewDelegate,LrdOutputViewDelegate>

{
    NSInteger _page;
    NSString *_path;
    BOOL _isUp;
}
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong)NSMutableArray * dataSource;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) LrdOutputView *outputView;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation LCStoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![self.titlee isEqualToString:@""] && self.titlee!= nil ) {
        self.navigationItem.title = self.titlee;

    }else{
    
    
    self.navigationItem.title = @"商店";
    }
    LrdCellModel *one = [[LrdCellModel alloc] initWithTitle:@"全部" imageName:@"item_school"];
    LrdCellModel *two = [[LrdCellModel alloc] initWithTitle:@"0 - 200" imageName:@"item_battle"];
    LrdCellModel *three = [[LrdCellModel alloc] initWithTitle:@"201 - 500" imageName:@"item_list"];
    LrdCellModel *four = [[LrdCellModel alloc] initWithTitle:@"501 - 1000" imageName:@"item_chat"];
    LrdCellModel *five = [[LrdCellModel alloc] initWithTitle:@"1000 - 3000" imageName:@"item_share"];
    LrdCellModel *six = [[LrdCellModel alloc] initWithTitle:@"3000以上" imageName:@"item_share"];
    
    self.dataArr = @[one, two, three, four, five,six];
    
    _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btn setTitle:@"价格筛选" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    _btn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_btn];
    _page = 1;
    _isUp = NO;
    _dataSource = [[NSMutableArray alloc] init];
    [self createCollectionView];
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

//    self.tabBarController.tabBar.hidden = NO;

}

- (void)onClicked:(UIButton *)btn{
    CGFloat x = btn.center.x;
    CGFloat y = btn.frame.origin.y + btn.bounds.size.height + 10;
    
    _outputView = [[LrdOutputView alloc] initWithDataArray:self.dataArr origin:CGPointMake(x, y) width:SCREEN_WIDTH height:20 direction:kLrdOutputViewDirectionLeft];
    
    _outputView.delegate = self;
    _outputView.dismissOperation = ^(){
        //设置成nil，以防内存泄露
        _outputView = nil;
    };
    [_outputView pop];
    
}
- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray * arr = @[@"全部",@"0 - 200",@"201 - 500",@"501 - 1000",@"1000 - 3000",@"3000以上"];
    [_btn setTitle:arr[indexPath.row] forState:UIControlStateNormal];
    
    
}

- (void)createCollectionView {
    
    JCCollectionViewWaterfallLayout * layout = [[JCCollectionViewWaterfallLayout alloc] init];
    layout.columnCount = 2;
    layout.edge = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,40, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = RGB_COLOR(21, 21, 21, 1);
    [_collectionView registerNib:[UINib nibWithNibName:@"StoreCell" bundle:nil] forCellWithReuseIdentifier:@"store"];
    [self.view addSubview:_collectionView];
    [self setupRefresh];
    
}

#pragma mark -- 刷新
-(void)setupRefresh
{
    // 添加头部视图，实现下拉刷新（恢复到列表最初的状态）
    [_collectionView addHeaderWithTarget:self action:@selector(headerRefresh)];
    
    // 该方法调用之后，自动调用下拉刷新 headerRefresh
    [_collectionView headerBeginRefreshing];
    
    // 添加尾部视图，实现上拉加载更多
    [_collectionView addFooterWithTarget:self action:@selector(footerRefresh)];
}
-(void)headerRefresh
{
    _page = 1;
    _isUp = NO;
    
    // 数据源要清空，重新添加
    [self loadData];
}

-(void)footerRefresh
{
    _page++;
    _isUp = YES;
    [self loadData];
}
#pragma Mark -- 解析数据
-(void)loadData{
//    if (self.tagg <= 4) {
//        NSString * url = [[NSString stringWithFormat:FourBtn_url,self.tagg,_page]stringByAppendingString:Path];;
//        _path = url;
//        [self DownloadDataWith:_path];
//        return;
//    }
    if (self.section == 0) {
        NSString *url = [NSString stringWithFormat:home__Url,self.Presentid,_page];
        _path = url;
        [self DownloadDataWith:_path];
return;
    }
    if (self.section == 1) {
        NSString *url = [NSString stringWithFormat:Clothe_url,self.Presentid,_page];
        _path = url;
        [self DownloadDataWith:_path];
return;
    }
    if (self.section == 2) {
        NSString *url = [NSString stringWithFormat:Other_url,self.Presentid,_page];
        _path = url;
        [self DownloadDataWith:_path];
return;
    }
    if (self.section == 3) {
        NSString *url = [NSString stringWithFormat:ART_url,self.Presentid,_page];
        _path = url;
        [self DownloadDataWith:_path];
return;
    }
    if (self.section == 4) {
        NSString *url = [NSString stringWithFormat:Present_url,self.Presentid,_page];
        _path = url;
        [self DownloadDataWith:_path];
return;
    }
    
    if (self.section == 10) {
        NSString *url = [NSString stringWithFormat:LCStoreDetail_URL,self.Presentid,_page];
        _path = url;
        [self DownloadDataWith:_path];
return;
    }
    
}
-(void)DownloadDataWith:(NSString *)path{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        [self parseData:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"11");
    }];
    
    
}

-(void)parseData:(NSData *)data{
    if (data == nil) {
        return;
    }
    if(!_isUp){
        // 下拉
        [_dataSource removeAllObjects];
    }
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *DataArr = [dic objectForKey:@"data"];
    for (NSDictionary *dicc in DataArr) {
        StoreModel *storeModel = [[StoreModel alloc]init];
        NSDictionary *infodic = [dicc objectForKey:@"brand_info"];
        brand_infoModel *infomodel = [[brand_infoModel alloc]init];
        [infomodel setValuesForKeysWithDictionary:infodic];
        [storeModel setValuesForKeysWithDictionary:dicc];
        [_dataSource addObject:storeModel];
        
        
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_collectionView headerEndRefreshing];
        
        // 结束上拉刷新的动画，View的展示
        [_collectionView footerEndRefreshing];
        [_collectionView reloadData];
        
    });
    
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
    
    StoreModel *model = _dataSource[indexPath.row];
    
    cell.goods_name.text = model.goods_name;
    [cell.goods_image setImageWithURL:[NSURL URLWithString:model.goods_image]];
    cell.sale_by.text = [model.brand_info objectForKey:@"brand_name"];
    cell.price.text = [NSString stringWithFormat:@"￥%@",model.price];
    cell.like_count.text = model.like_count;
    
    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(123, 177);
}
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LCStoreDetail * devec = [LCStoreDetail new];
    
//    WsDetailsViewController *devec = [[WsDetailsViewController alloc]init];
    StoreModel *model = _dataSource[indexPath.row];
//    devec.storemodel = model;
    devec.goodsid = model.goods_id;
//    devec.view.backgroundColor = [UIColor colorWithRed:74.0f/255.0f green:75.0f/255.0f blue:81.0f/255.0f alpha:1.0f];
       NSLog(@"33");
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:devec animated:YES];
    
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
