//
//  SaleViewController.m
//  LiangCang
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "SaleViewController.h"
#import "SaleModel.h"
#import "brand_infoModel.h"
#import "good_guideModel.h"
#import "TopViewCell.h"
#import "BottomViewCell.h"
#import "DetailViewController.h"
#import "PayViewController.h"
#import "StoreModel.h"
#import "LCPlanPayViewController.h"
@interface SaleViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSource;
    UITableView *_tableView;
    NSArray *_busSource;
    NSArray *_arr;
    BOOL _isSelelcted;
}
@end

@implementation SaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavbar];
    [self initUi];
    [self creatBottomBtn];
    [self initData];
//    [self downLoadData];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)initData{
    _isSelelcted = NO;
    _dataSource = [[NSMutableArray alloc]init];
    _busSource = [[NSArray alloc]init];

}
-(void)creatNavbar{


    UIButton * barbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    barbtn.frame = CGRectMake(0, 0, 30, 20);
    //    [barbtn setImage:[UIImage imageNamed:@"btn_backNormal@2x.png"] forState:UIControlStateNormal];
    [barbtn setBackgroundImage:[UIImage imageNamed:@"btn_backNormal@2x.png"]  forState:UIControlStateNormal];
    [barbtn addTarget:self action:@selector(barbtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithCustomView:barbtn];
    self.navigationItem.leftBarButtonItem = left;

}
-(void)barbtnClick{

    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)creatBottomBtn{
    self.tabBarController.tabBar.hidden = YES;
   
       UIButton *btnleft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnleft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnleft.frame = CGRectMake(0, SCREEN_HEIGHT-64-49, SCREEN_WIDTH/2, 49);
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
   
    if (_isSelelcted) {
        [btnleft setTitle:@"取消加入" forState:UIControlStateNormal];
        NSLog(@"quxiao");
        
    }else{
        NSLog(@"jiaru");
        [btnleft setTitle:@"加入购物车" forState:UIControlStateNormal];
    }
    btnleft.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btnleft addTarget:self action:@selector(btnleft:) forControlEvents:UIControlEventTouchUpInside];
    [btnleft setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:btnleft];
    [self.view bringSubviewToFront:btnleft];
    
    UIButton *btnright = [Tools createButtonBgImage:@"" title:@"直接购买" tag:11 target:self action:@selector(btnright)];
    btnright.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-49-64, SCREEN_WIDTH/2, 49);
      [btnright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnright setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:btnright];
    
    [self.view bringSubviewToFront:btnright];
    NSLog(@"%f",CGRectGetMaxY(btnright.frame));
    NSLog(@"%f",SCREEN_HEIGHT);
}
-(void)btnleft:(UIButton *)btn{
//     _isSelelcted = !_isSelelcted;
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    if (_isSelelcted) {
//        [btn setTitle:@"加入购物车" forState:UIControlStateNormal];
//        [ud removeObjectForKey:self.storemodel.goods_id];
//        [ud synchronize];
//        
//    }else{
//      [btn setTitle:@"取消加入" forState:UIControlStateNormal];
//        StoreModel *model = self.storemodel;
//        NSString *idd = model.goods_id;
//        
//        
//        [[SingleTon sharedSingleTon].iddarr addObject:idd];
//        NSString *price = self.storemodel.price;
//        NSString *name = self.storemodel.goods_name;
//        NSString *imageurl = [self.storemodel.brand_info objectForKey:@"brand_logo"];
//        
//        _busSource = @[price,name,imageurl];
//        [ud setObject:_busSource forKey:idd];
//        [ud synchronize];
//
//    }
   

    
}
-(void)btnright{
    NSLog(@"2");
    PayViewController *pay = [[PayViewController alloc]init];
    pay.paymodel = self.storemodel;
    
    [self.navigationController pushViewController:pay animated:YES];

}

-(void)initUi{
   
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-64 ) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TopViewCell" bundle:nil] forCellReuseIdentifier:@"topviewcell"];
    [_tableView registerNib:[UINib nibWithNibName:@"BottomViewCell" bundle:nil] forCellReuseIdentifier:@"bottomviewcell"];

    [self.view sendSubviewToBack:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        TopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topviewcell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (!cell) {
            cell = [[TopViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"topviewcell"];

        }
        [cell refreshWith:self.storemodel];
        return cell;
        
    }else
       {
        BottomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bottomviewcell"];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (!cell) {
            cell = [[BottomViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bottomviewcell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
           [cell refreshWith:self.storemodel];
           
        return cell;
        
    }

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 502;
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
