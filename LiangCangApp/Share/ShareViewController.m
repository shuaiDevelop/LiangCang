//
//  ShareViewController.m
//  LiangCangApp
//
//  Created by MS on 15/10/6.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "ShareViewController.h"
#import "StringConstants.h"
#import "AFNetworking.h"
#import "ShareModel.h"
#import "ShareCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DDMenuController.h"

#import "ShareDetailViewController.h" // 跳转 详情

#import "MJRefresh.h"



#import "AppDelegate.h"
@interface ShareViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{

    UICollectionView * _collectionView;
    NSMutableArray *_dataSource;
    BOOL isUp;
    NSInteger _currage;
    NSInteger _type;
    BOOL typeChange;

    NSInteger  max;
    NSInteger  min;

    NSString * url;
}
@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:NSNotificationName object:nil];

//http://app.iliangcang.com/goods/class?type=1&app_key=Android&build=2015092501&count=20&page=1&self_host=0&v=1.0
    if (IOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self createNavBar];
    [self initData];
//    [self downloadData];
    [self createUI];
//    [self followScrollView:_collectionView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;

}
- (void)createNavBar{
    self.navigationItem.title = @"分享";


    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 20);
    [leftBtn setImage:[UIImage imageNamed:@"btn_nav_option_h4@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;


//    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 30, 20);
//    [rightBtn setImage:[UIImage imageNamed:@"topmenu_cart@2x.png"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightButton;

}




// 抽屉
- (void)leftButtonClicked{

    DDMenuController *dd = (DDMenuController *)((AppDelegate*)[[UIApplication sharedApplication]delegate].window.rootViewController.childViewControllers[2]);

    [dd showLeftController:YES];


}
- (void)rightButtonClicked{


}
- (void)initData{
    _dataSource = [[NSMutableArray alloc] init];
    _currage = 1;
    _type = 100;
    isUp = NO;
    typeChange= NO;

}
- (void)createUI{

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];

    layout.scrollDirection = UICollectionViewScrollDirectionVertical;

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];

    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];

    [_collectionView registerClass:[ShareCollectionViewCell class] forCellWithReuseIdentifier:Identifier];

    [self addRefreshView];
}

#pragma mark - 通知

- (void)receiveNotification:(NSNotification * )noti{


    _type =  [[noti.userInfo objectForKey:@"type"] integerValue];
    min =[[noti.userInfo objectForKey:@"min"] integerValue];
    max = [[noti.userInfo objectForKey:@"max"] integerValue];
//    NSLog(@"%ld",_type);
    typeChange = YES;
    [self downloadData];

}
#pragma mark - 刷新列表

- (void)addRefreshView{
    [_collectionView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    [_collectionView headerBeginRefreshing];
    [_collectionView addFooterWithTarget:self action:@selector(footerRefreshing)];


}
- (void)headerRefreshing{

    _currage = 1;
    isUp = NO;
    [self downloadData];


}

- (void)footerRefreshing{
    isUp = YES;
    _currage++;
    [self downloadData];


}
#pragma mark - 下载数据

- (void)downloadData{

    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    // 类型分类
    NSString * urlStr = [NSString stringWithFormat:ShareUrlString,_type,_currage];

    // 价格分类
    NSString * priceStr = [NSString stringWithFormat:PriceUrlString,min,max,_currage];


    if (_type==0) {
        url = priceStr;
    }else{

        url = urlStr;
    }

    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [self parseData:responseObject];


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];

}
// 解析数据
- (void)parseData:(NSData *)data{

    NSDictionary * rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    if (typeChange) {
        [_dataSource removeAllObjects];
    }
    if (!isUp) {
        [_dataSource removeAllObjects];
    }
    for (NSDictionary * dic in rootDic[@"data"]) {

        ShareModel * model = [[ShareModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
//        NSLog(@"%@",model.goods_id);
        [_dataSource addObject:model];
    }

    dispatch_async(dispatch_get_main_queue(), ^{

        [_collectionView headerEndRefreshing];
        [_collectionView footerEndRefreshing];
        [_collectionView reloadData];
    });

}
#pragma mark - UICollectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio{

    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ShareCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];

    ShareModel * model = _dataSource[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:model.goods_image] placeholderImage:[UIImage imageNamed:@"icn_user_default@2x.png"]];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{


    return CGSizeMake(SCREEN_WIDTH/2 - 5, SCREEN_WIDTH/2);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    ShareModel * model = _dataSource[indexPath.row];
    ShareDetailViewController * shareVC = [[ShareDetailViewController alloc] init];
    shareVC.good_id = model.goods_id;
    shareVC.good_image = model.goods_image;

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shareVC animated:YES];


}
// 移除通知

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self name:NSNotificationName object:nil];
    
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
