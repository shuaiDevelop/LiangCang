//
//  LCStoreOneViewController.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/18.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "LCStoreOneViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "OneStoreModel.h"
#import "OneStoreTableViewCell.h"
#import "LCOneStoreDetailController.h"

#define URL @"http://iliangcang.com:8200/brand/list/2?app_key=iphone&build=170&offset=10&osVersion=93&start=%d&v=2.5.0"
@interface LCStoreOneViewController () <UITableViewDelegate,UITableViewDataSource>

{

    BOOL isUp;
    int page;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataSource;
@end

@implementation LCStoreOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isUp = NO;
    page = 0;
    [self.view addSubview:self.tableView];
    [self downLoadData];
}
- (void)downLoadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __weak typeof(self) weakSelf = self;
    [manager GET:[NSString stringWithFormat:URL,page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            
            
            if (!isUp) {
                [self.dataSource removeAllObjects];
            }
            NSError * error;
            NSDictionary * rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            if (!error) {
                
                for (NSDictionary * dic in [rootDic[@"data"] objectForKey:@"items"]) {
                    
                    OneStoreModel * model = [[OneStoreModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [weakSelf.dataSource addObject:model];
                    
                    
                }
                
                
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [weakSelf.tableView reloadData];
                [weakSelf.tableView headerEndRefreshing];
                [weakSelf.tableView footerEndRefreshing];
            });
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];

}
- (NSArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    
    return _dataSource;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49 - 40) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB_COLOR(21, 21, 21, 1);
        [_tableView registerNib:[UINib nibWithNibName:@"OneStoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"OneStoreTableViewCell"];
        [self addrefesh];
    }
    
    
    return _tableView;
}
- (void)addrefesh{

    [self.tableView addHeaderWithTarget:self action:@selector(headerAction)];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerAction)];

}
- (void)headerAction{

    page = 0;
    isUp = NO;
    [self downLoadData];
}
- (void)footerAction{
    page += 10;
    isUp = YES;
    [self downLoadData];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    OneStoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OneStoreTableViewCell"];
    if (!cell) {
        cell = [[OneStoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OneStoreTableViewCell"];
    }
    cell.model = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 67;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LCOneStoreDetailController * store = [LCOneStoreDetailController new];
    store.idnumber = [NSString stringWithFormat:@"%@",[self.dataSource[indexPath.row] idd]];
    store.logo = [NSString stringWithFormat:@"%@",[[self.dataSource[indexPath.row] logo] objectForKey:@"url"]];
    store.name = [self.dataSource[indexPath.row] name];
    store.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:store animated:YES];


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
