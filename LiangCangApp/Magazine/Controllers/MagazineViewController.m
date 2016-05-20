//
//  MagazineViewController.m
//  LiangCangApp
//
//  Created by MS on 15/10/6.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "MagazineViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

#import "MagazineModel.h"
#import "MagKeysModel.h"
#import "MagCustomViewCell.h"

#import "MJRefresh.h" // 刷新
#import "MagDetailViewController.h" // 跳转

#import "WSButton.h"

@interface MagazineViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * _dataSource;
    NSMutableArray * _keysArr;
    UITableView * _tableView;
    BOOL isUp;
    UIButton * btn;
}
@end

@implementation MagazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self createNavBar];
    [self initData];
//    [self loadData];
    [self createUI];

}
// 初始化数据
- (void)initData{
    _dataSource = [[NSMutableArray alloc] init];
    _keysArr = [[NSMutableArray alloc] init];
    isUp = NO;

}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;

}
- (void)createNavBar{

//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
//    button.backgroundColor = [UIColor blackColor];
//    [button setTitle:@"杂志" forState:UIControlStateNormal];
////    button.titleLabel.font = [UIFont systemFontOfSize:18.0f];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.navigationBar addSubview:button];
    self.navigationItem.title = @"杂志";


    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:29/255.0 green:29/255.0 blue:33/255.0 alpha:1];

    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, SCREEN_WIDTH/8, 40);
    btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    btn.backgroundColor = [UIColor colorWithRed:29/255.0 green:29/255.0 blue:33/255.0 alpha:1];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem * leftbtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn setTitle:@"Today" forState:UIControlStateNormal];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.navigationItem.leftBarButtonItem = leftbtn;


}
// 解析数据
- (void)loadData{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:MagazineUrlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        NSDictionary * dataDic = [rootDic objectForKey:@"data"];
        MagKeysModel * keysModel = [[MagKeysModel alloc] init];
        keysModel.keysArray = [dataDic objectForKey:@"keys"];
        _keysArr.array = keysModel.keysArray;
        NSDictionary * infoDic = [dataDic objectForKey:@"infos"];

        if (!isUp) {
            [_dataSource removeAllObjects];
        }
        for (NSInteger i = 0; i < keysModel.keysArray.count; i++) {
            NSArray * array = [infoDic objectForKey:keysModel.keysArray[i]];
            for (NSDictionary * dic in array) {
                MagazineModel * model = [[MagazineModel alloc] init];

                [model setValuesForKeysWithDictionary:dic];
                [_dataSource addObject:model];
            }
        }

          dispatch_async(dispatch_get_main_queue(), ^{

              [_tableView headerEndRefreshing];
              [_tableView footerEndRefreshing];
                [_tableView reloadData];
        });


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {


    }];

}

//  创建视图
- (void)createUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    [self addRefreshTableView];
}
#pragma mark - 列表刷新

- (void)addRefreshTableView{

    [_tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    [_tableView headerBeginRefreshing];
    [_tableView addFooterWithTarget:self action:@selector(footerRefreshing)];

}
- (void)headerRefreshing{
    [self loadData];

}
- (void)footerRefreshing{
    [self loadData];

}
#pragma mark - NavBar buttonClicked


#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
   MagCustomViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MagCustomViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID WithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
      
    [cell refreshInfoByModel:_dataSource[indexPath.row + 1] andStr:_keysArr[indexPath.row + 1]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return SCREEN_HEIGHT/3 + 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
    imageView.userInteractionEnabled = YES;
    MagazineModel * model = [_dataSource firstObject];
    [imageView setImageWithURL:[NSURL URLWithString:model.cover_img]];

    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/6 - 20, SCREEN_WIDTH, 18)];
    textLabel.text = model.topic_name;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:16.0f];
    [imageView addSubview:textLabel];

    UILabel * detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textLabel.frame) + 5, SCREEN_WIDTH, 15)];
    detailLabel.text = [NSString stringWithFormat:@"#  %@",model.cat_name];
    detailLabel.textColor = [UIColor whiteColor];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.font = [UIFont systemFontOfSize:12.0f];
    [imageView addSubview:detailLabel];

    return imageView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{


    return SCREEN_HEIGHT/3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MagDetailViewController * detailVC = [[MagDetailViewController alloc] init];
    MagazineModel * model = _dataSource[indexPath.row+1];
    detailVC.topic_url = model.topic_url;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];

}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    NSMutableString * string = [NSMutableString stringWithFormat:@"%@",_keysArr[indexPath.row]];
    NSRange range = {0,5};
    [string deleteCharactersInRange:range];

    [btn setTitle:string forState:UIControlStateNormal];


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
