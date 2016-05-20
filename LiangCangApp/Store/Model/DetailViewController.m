//
//  DetailViewController.m
//  LiangCang
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "DetailViewController.h"
#import "StoreModel.h"
#import "brand_infoModel.h"
#import "StoreCell.h"
#import "MJRefresh.h"
#import "StoreButton.h"
#import "SaleViewController.h"
#import "StoreViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
@interface DetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataSource;
    NSArray *_dataSourceStore;
    NSArray *_dataSourcePrice;
    NSMutableArray *_dataSource2;
    NSArray *_dataPrice;
    
    NSInteger _page;
    NSString *_path;
    UICollectionView *_collectionView;
    UITableView *_tableView;
    
    BOOL _isSelectedleft;
    BOOL _isSelectedright;
    
    StoreButton *_btn1;
    StoreButton *_btn2;
    BOOL _btnSelect;
    
    BOOL _isUp;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatNavbar];
    [self initData];
//    [self loadData];
    [self initUi];
}
-(void)initData{
    _isUp = NO;
    _isSelectedleft = NO;
    _isSelectedright = NO;
    _btnSelect = YES;
    _page = 1;
    _dataSource = [[NSMutableArray alloc]init];
   _dataPrice = @[@"200",@"200",@"500",@"1000",@"3000",@"3000"];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"DetailCell" ofType:@"plist"];
    _dataSourceStore = [[NSArray alloc]initWithContentsOfFile:path];

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



-(void)creatNavbar{
   

    UIButton * barbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    barbtn.frame = CGRectMake(0, 0, 30, 20);

    [barbtn setBackgroundImage:[UIImage imageNamed:@"btn_backNormal@2x.png"]  forState:UIControlStateNormal];
    [barbtn addTarget:self action:@selector(barbtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithCustomView:barbtn];
    self.navigationItem.leftBarButtonItem = left;

}
-(void)barbtnClick{
        
    [self.navigationController popToRootViewControllerAnimated:YES];

}

#pragma Mark -- 解析数据
-(void)loadData{
       if (self.tagg <= 4) {
        NSString * url = [[NSString stringWithFormat:FourBtn_url,self.tagg,_page]stringByAppendingString:Path];;
        _path = url;
    }
    if (self.section == 2) {
        NSString *url = [[NSString stringWithFormat:Present_url,self.Presentid,_page]stringByAppendingString:Path];;
        _path = url;
    }
    if (self.section == 3) {
        NSString *url = [[NSString stringWithFormat:Clothe_url,self.Presentid,_page]stringByAppendingString:Path];
        _path = url;
    }
    if (self.section == 4) {
        NSString *url = [[NSString stringWithFormat:Home_url,self.Presentid,_page]stringByAppendingString:Path];
        _path = url;
    }
    if (self.section == 5) {
        NSString *url = [[NSString stringWithFormat:ART_url,self.Presentid,_page]stringByAppendingString:Path];
        _path = url;
    }
    if (self.section == 6) {
        NSString *url = [[NSString stringWithFormat:Other_url,self.Presentid,_page]stringByAppendingString:Path];
        _path = url;
    }
    [self DownloadDataWith:_path];
    
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
#pragma Mark -- 搭建ui

-(void)initUi{
    self.Title = self.title;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
  
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];

    [_collectionView registerNib:[UINib nibWithNibName:@"StoreCell" bundle:nil] forCellWithReuseIdentifier:@"store"];
    [self CreatButtonWithtext:self.title];
    
    //取消按钮弹出。上面两个按钮
    [self cancel];
     [self setupRefresh];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    self.tabBarController.tabBar.hidden = NO;
}
-(void)CreatButtonWithtext:(NSString *)text{
    _btn1 = [StoreButton StoreeButton];
    [_btn1 setTitle:text forState:UIControlStateNormal];
    [_btn1 setImage:[UIImage imageNamed:@"spec_arrow1@2x.png"] forState:UIControlStateNormal];
    _btn1.tintColor = [UIColor blackColor];
    _btn1.frame = CGRectMake(0, 64, SCREEN_WIDTH/2, 44);
    [_btn1 setBackgroundColor:[UIColor whiteColor]];
    [_btn1 addTarget:self action:@selector(buttonleft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn1];
  
    _btn2 = [StoreButton StoreeButton];
    [_btn2 setTitle:@"价格筛选" forState:UIControlStateNormal];
    [_btn2 setTintColor:[UIColor blackColor]];
    [_btn2 setImage:[UIImage imageNamed:@"spec_arrow1@2x.png"] forState:UIControlStateNormal];
     [_btn2 setBackgroundColor:[UIColor whiteColor]];
    _btn2.frame = CGRectMake(SCREEN_WIDTH/2, 64, SCREEN_WIDTH/2, 44);
    [_btn2 addTarget:self action:@selector(buttonright) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn2];
    
    

}
-(void)creatTableWithNum:(NSInteger)num{

   
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, num * 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(void)buttonleft{
    if (_btnSelect) {
        [_tableView removeFromSuperview];
        NSInteger count = [_dataSourceStore[self.section] count];
        [self creatTableWithNum:count];
      
        
        
        [_tableView reloadData];
  
    }
    
   }
-(void)buttonright{
     _btnSelect = !_btnSelect;
    if (!_btnSelect) {
        [_tableView removeFromSuperview];
       
        _dataSourcePrice = @[@"全部",@"0-200",@"201-500",@"501-1000",@"1001-3000",@"3000"];
        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _dataSourcePrice.count * 44);
        NSInteger count = _dataSourcePrice.count;
        [self creatTableWithNum:count];
        [_tableView reloadData];
    }
   
}
-(void)cancel{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.navigationController.navigationBar addGestureRecognizer:tap];
    
}
-(void)tapAction{
    NSLog(@"22");

    [_tableView removeFromSuperview];

}
#pragma mark -- UItableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return  _btnSelect ? [_dataSourceStore[self.section] count]:_dataSourcePrice.count ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailcell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"detailcell"];
    }
    if (_btnSelect) {
        
            cell.textLabel.text = _dataSourceStore[self.section][indexPath.row];
        

    }else {
    
        cell.textLabel.text = _dataSourcePrice[indexPath.row];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    for(NSInteger i = 0 ; i <6;i++){
        
        if(i == indexPath.row){
           
             UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType =UITableViewCellAccessoryCheckmark;
            
        }else{
            NSIndexPath *indexpa = [NSIndexPath indexPathForRow:i inSection:0];
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexpa];
            cell.accessoryType = UITableViewCellAccessoryNone;
        
        }
}

    [tableView reloadData];
    
 //_dataSourcePrice = @[@"全部",@"0-200",@"201-500",@"501-1000",@"1001-3000",@"3000"];
    _page =1;
//    NSInteger i = [_dataPrice[indexPath.row] integerValue];
//    NSString *pathprice = [NSString stringWithFormat:price_url,i,_page];
//    [self DownloadDataWith:pathprice];
//    dispatch_async(dispatch_get_main_queue(), ^{
//         [_collectionView reloadData];
//    });
  
}
#pragma mark -- uicollectionViewdelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataSource.count/2;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"store" forIndexPath:indexPath];
    
    StoreModel *model = _dataSource[indexPath.row];
    
    cell.goods_name.text = model.goods_name;
    [cell.goods_image setImageWithURL:[NSURL URLWithString:model.goods_image]];
    cell.sale_by.text = model.sale_by;
    cell.price.text = model.price;
    cell.like_count.text = model.like_count;


    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(123, 177);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(10, 10, 10, 10);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SaleViewController *saleVc = [[SaleViewController alloc]init];
    StoreModel *model = _dataSource[indexPath.row];
    saleVc.storemodel = model;
    
    saleVc.idd = [model.goods_id integerValue];
    NSLog(@"33");
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:saleVc animated:YES];
    
    
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
