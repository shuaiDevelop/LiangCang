//
//  ExpertViewController.m
//  LiangCangApp
//
//  Created by MS on 15/10/6.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "ExpertViewController.h"
#import "StringConstants.h"
#import "AFNetworking.h"
#import "ExpertModel.h"
#import "ExpertCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DDMenuController.h"

#import "MJRefresh.h"
#import "UserDetailViewController.h"

#import "AppDelegate.h"
static NSString * cellID = @"cellID";
@interface ExpertViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{


    NSMutableArray * _dataSource;
    UICollectionView * _collectionView;
    NSInteger _currage;

    NSString * insert;
    NSMutableString * _insertStr;

    BOOL isUp;

    
}

@end

@implementation ExpertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // Do any additional setup after loading the view.

    // 注册通知
    [self registNSNotification];
    [self createNavBar];


    [self initData];
    _insertStr = [NSMutableString stringWithFormat:ExpertUrlString,_currage];

    [self initUI];
    [self followScrollView:_collectionView];

}
- (void)registNSNotification{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NSNotificationName2 object:nil];

}
- (void)createNavBar{
  self.navigationItem.title = @"达人";

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

#pragma mark - 通知

- (void)notification:(NSNotification *)noti{

    /**
     *  每次进来 先删除字符串  在重新赋值  下载数据 刷新列表
     */

   NSString * str = [_insertStr substringFromIndex:0];
    [_insertStr deleteCharactersInRange:NSMakeRange(0, str.length)];

    insert = [noti.userInfo objectForKey:@"insert"];
    _insertStr = [NSMutableString stringWithFormat:insert,_currage];

    [self downloadData];

}
#pragma mark - 抽屉效果
- (void)leftButtonClicked{
    DDMenuController *dd = (DDMenuController *)((AppDelegate*)[[UIApplication sharedApplication]delegate].window.rootViewController.childViewControllers[3]);

    [dd showLeftController:YES];
}
- (void)rightButtonClicked{

}
- (void)initData{
    _dataSource = [[NSMutableArray alloc] init];
    _currage = 1;

    isUp = NO;

}

- (void)initUI{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];

    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];

    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];


    [_collectionView registerClass:[ExpertCollectionViewCell class] forCellWithReuseIdentifier:cellID];

    [self addRefreshViews];
}

#pragma mark - 列表刷新

- (void)addRefreshViews{

    [_collectionView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    [_collectionView headerBeginRefreshing];
    [_collectionView addFooterWithTarget:self action:@selector(footerRefreshing)];

}
- (void)headerRefreshing{

    isUp = NO;
    _currage = 1;
    [self downloadData];


}

- (void)footerRefreshing{

    _currage++;
    isUp = YES;
    [self downloadData];


}
#pragma mark - UIcollectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio{

    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ExpertCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    ExpertModel * model = _dataSource[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:model.user_image] placeholderImage:[UIImage imageNamed:@"icn_user_default@2x.png"]];
    cell.nameLabel.text = model.user_name;
    cell.descLabel.text = model.user_desc;


    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

//    UIImage * image = [UIImage imageNamed:@"icn_user_default@2x.png"];
    return CGSizeMake(SCREEN_WIDTH/3-10, SCREEN_WIDTH/3+32);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ExpertModel * model = _dataSource[indexPath.row];
    UserDetailViewController * userVC = [[UserDetailViewController alloc] init];
    userVC.userId = model.user_id;
    userVC.userImage = model.user_image;
    userVC.userName = model.user_name;
    [self.navigationController pushViewController:userVC animated:YES];


}
#pragma mark - 下载数据
- (void)downloadData{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

//    NSString * urlStr = [NSString stringWithFormat:ExpertUrlString,_currage];
    [manager GET:_insertStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [self parseData:responseObject];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];

}
- (void)parseData:(NSData *)data{

    NSDictionary * rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    if (!isUp) {
        [_dataSource removeAllObjects];
    }
    for (NSDictionary * dic in rootDic[@"data"]) {

        ExpertModel * model = [[ExpertModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataSource addObject:model];

    }
    dispatch_async(dispatch_get_main_queue(), ^{

        [_collectionView headerEndRefreshing];
        [_collectionView footerEndRefreshing];
        [_collectionView reloadData];
    });

}
#pragma mark - 移除通知
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
