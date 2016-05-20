//
//  StoreViewController.m
//  LiangCangApp
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "StoreViewController.h"
#import "DetailViewController.h"
#import "ShopListViewController.h"
#import "BusViewController.h"
#import "LCStoreDetailViewController.h"
@interface StoreViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataSource;
    NSArray *_dataSourceCell;
    BOOL _isOpen3;
    BOOL _isOpen4;
    BOOL _isOpen5;
    BOOL _isOpen6;
    BOOL _isOpen7;
}
@end

@implementation StoreViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavBar];
    [self initData];
    [self initui];
    //    [self initui];
    // Do any additional setup after loading the view.
}
-(void)initData{
    _isOpen3 = NO;
    _isOpen4 = NO;
    _isOpen5 = NO;
    _isOpen6 = NO;
    _isOpen7 = NO;
    _dataSource = [[NSArray alloc]init];
//    _dataSource = @[@"良仓清单",@"礼物",@"服饰",@"家居",@"艺术",@"其他"];
    _dataSource = @[@"10.jpg",@"6.jpg",@"5.jpg",@"3.jpg",@"9.jpg",@"1.jpg"];

     
    NSString *path = [[NSBundle mainBundle]pathForResource:@"StoreCell" ofType:@"plist"];
    _dataSourceCell = [[NSArray alloc]initWithContentsOfFile:path];
}

-(void)creatNavBar{
self.navigationItem.title = @"商店";
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame  = CGRectMake(0, 0, 32, 20);
    [btn setImage:[UIImage imageNamed:@"letter_icon_search@3x.png"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"letter_icon_search@3x.png"] forState:UIControlStateNormal];
    //    [btn setBackgroundImage:[UIImage imageNamed:@"btn_nav_option@2x.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnActionSearch) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem * leftbtn = [[UIBarButtonItem alloc] initWithCustomView:btn];

    self.navigationItem.leftBarButtonItem = leftbtn;
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame  = CGRectMake(0, 0, 32, 20);
    [btn1 setImage:[UIImage imageNamed:@"btn_ware_comment@2x.png"] forState:UIControlStateNormal];
    //    [btn setBackgroundImage:[UIImage imageNamed:@"btn_nav_option@2x.png"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnActionSale) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem * rightbtn = [[UIBarButtonItem alloc] initWithCustomView:btn1];

    self.navigationItem.rightBarButtonItem = rightbtn;


}

-(void)btnActionSearch{
    NSLog(@"11");
}
-(void)btnActionSale{

    BusViewController *busvc = [[BusViewController alloc]init];
    [self.navigationController pushViewController:busvc animated:YES];

}
-(void)initui{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"storeNextCell" bundle:nil] forCellReuseIdentifier:@"storeNextCell"];


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataSourceCell.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return _isOpen3 ? [_dataSourceCell[section] count ]:0;
    }
    if (section == 3) {
        return _isOpen4 ? [_dataSourceCell[section] count ]:0;
    }
    if (section == 4) {
        return _isOpen5 ? [_dataSourceCell[section] count ]:0;
    }
    if (section == 5) {
        return _isOpen6 ? [_dataSourceCell[section] count ]:0;
    }
    if (section == 6) {
        return _isOpen7 ? [_dataSourceCell[section] count ]:0;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"storecellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    cell.textLabel.text = _dataSourceCell[indexPath.section][indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:_dataSource[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {

        UIView *view = [[UIView alloc]init];
        UIButton *btn1 = [Tools createButtonBgImage:@"7.jpg" title:@"" tag:1 target:self action:@selector(btnaction:)];
        UIButton *btn2 = [Tools createButtonBgImage:@"8.jpg" title:@"" tag:2 target:self action:@selector(btnaction:)];
        UIButton *btn3 = [Tools createButtonBgImage:@"2.jpg" title:@"" tag:3 target:self action:@selector(btnaction:)];
        UIButton *btn4 = [Tools createButtonBgImage:@"4.jpg" title:@"" tag:4 target:self action:@selector(btnaction:)];
        btn1.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 131);
        btn2.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 131);
        btn3.frame = CGRectMake(0, 131, SCREEN_WIDTH/2, 131);
        btn4.frame = CGRectMake(SCREEN_WIDTH/2, 131, SCREEN_WIDTH/2, 131);
        [view addSubview:btn1];
        [view addSubview:btn2];
        [view addSubview:btn3];
        [view addSubview:btn4];

        return view;

    }
    else{
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 199);
//        [button setTitle:_dataSource[section-1] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:_dataSource[section-1]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:_dataSource[section-1]] forState:UIControlStateNormal];
        button.tag = 4+section;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnaction:) forControlEvents:UIControlEventTouchUpInside];

        return button;

    }

}
-(void)btnaction:(UIButton *)btn{
    if (btn.tag==1) {
        DetailViewController *DetailVc = [[DetailViewController alloc]init];
        DetailVc.title = @"商店";
        DetailVc.tagg = btn.tag;
        [self.navigationController pushViewController:DetailVc animated:YES];

    }
    if (btn.tag == 2) {
        DetailViewController *DetailVc = [[DetailViewController alloc]init];
        DetailVc.title = @"商店";
        DetailVc.tagg = btn.tag;
        [self.navigationController pushViewController:DetailVc animated:YES];

    }
    if (btn.tag == 3) {


    }
    if (btn.tag == 4) {
        DetailViewController *DetailVc = [[DetailViewController alloc]init];
        DetailVc.title = @"商店";
        DetailVc.tagg = btn.tag;
        [self.navigationController pushViewController:DetailVc animated:YES];
    }
    if (btn.tag == 5) {
        ShopListViewController *shop = [[ShopListViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shop animated:YES];

    }

    if (btn.tag > 5) {
        if (btn.tag == 6) {
            _isOpen3 = !_isOpen3;
        }
        if (btn.tag == 7) {
            _isOpen4 = !_isOpen4;
        }
        if (btn.tag == 8) {
            _isOpen5 = !_isOpen5;
        }
        if (btn.tag == 9) {
            _isOpen6 = !_isOpen6;
        }
        if (btn.tag == 10) {
            _isOpen7 = !_isOpen7;
        }
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag - 4] withRowAnimation:UITableViewRowAnimationNone];


    }


}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    UIImage * image = [UIImage imageNamed:@"1.jpg"];

    if (section == 0) {
      return 262;
    }
    else{

        return image.size.height;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    DetailViewController *detailVc = [[DetailViewController alloc]init];
    
    LCStoreDetailViewController *detailVc = [LCStoreDetailViewController new];
    detailVc.section = indexPath.section;
    if (indexPath.section == 2) {
        detailVc.Presentid = indexPath.row + 6;
        detailVc.section = indexPath.section;
        detailVc.title = @"礼物";
    }
    if (indexPath.section == 3) {
        detailVc.Presentid = indexPath.row + 9;
        detailVc.section = indexPath.section;
        detailVc.title = @"服饰";
    }
    if (indexPath.section == 4) {
        detailVc.Presentid = indexPath.row + 2;
        detailVc.section = indexPath.section;
        detailVc.title = @"家居";
    }
    if (indexPath.section == 5) {
        detailVc.Presentid = indexPath.row + 6;
        detailVc.section = indexPath.section;
        detailVc.title = @"艺术";
    }
    if (indexPath.section == 6) {
        detailVc.Presentid = indexPath.row + 9;
        detailVc.section = indexPath.section;
        detailVc.title = @"其他";

    }

    [self.navigationController pushViewController:detailVc animated:YES];
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
