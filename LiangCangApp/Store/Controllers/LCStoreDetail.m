//
//  LCStoreDetail.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/18.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "LCStoreDetail.h"
#import "AFNetworking.h"
#import "LCStoreDetailModel.h"
#import "UIView+SDAutoLayout.h"
#import "SDCycleScrollView.h"
#import "OneStoreTableViewCell.h"
#import "NSString+SizeString.h"
#import "LCOneStoreDetailController.h"
#import "LCPlanPayViewController.h"

#define detail_Url @"http://app.iliangcang.com/goods?app_key=iphone&build=170&goods_id=%@&osVersion=93&v=2.5.0"
@interface LCStoreDetail () <UITableViewDataSource,UITableViewDelegate>
{

    BOOL _isSelelcted;

}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataSource;
@end

@implementation LCStoreDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self downLoadData];
    
    [self creatBottomBtn];
}

- (void)downLoadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __weak typeof(self) weakSelf = self;
    [manager GET:[NSString stringWithFormat:detail_Url,_goodsid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            
            
                     NSError * error;
            NSDictionary * rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            if (!error) {
                
                
                    LCStoreDetailModel * model = [[LCStoreDetailModel alloc] init];
                    [model setValuesForKeysWithDictionary:rootDic[@"data"]];
                    [weakSelf.dataSource addObject:model];
                    
                    
              
                
                
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.tableView reloadData];
                weakSelf.navigationItem.title = [[weakSelf.dataSource firstObject] goods_name];

            });
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];



}

- (UITableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor grayColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RGB_COLOR(26, 28, 31, 1);
        [_tableView registerNib:[UINib nibWithNibName:@"OneStoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"OneStoreTableViewCell"];

        
    }


    return _tableView;
}
- (NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        
        _dataSource = [[NSMutableArray alloc] init];
    }


    return _dataSource;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{



    return self.dataSource.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    OneStoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OneStoreTableViewCell"];
    if (!cell) {
        cell = [[OneStoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OneStoreTableViewCell"];
    }
//    cell.model = self.dataSource[indexPath.row];
    cell.logo = [self.dataSource[indexPath.row] owner_image];
    cell.name = [self.dataSource[indexPath.row] owner_name];
    cell.backImageView.clipsToBounds = YES;
    cell.backImageView.layer.cornerRadius = 25.0f;
    cell.backgroundColor = RGB_COLOR(26, 28, 31, 1);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{


 return [self createHeaderView];

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{



    return  [self createFooterView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    NSString * str = [[self.dataSource firstObject] goods_desc];
    NSString * str2 = [[self.dataSource firstObject] rec_reason];
    
   
    return SCREEN_WIDTH+260 + [str stringSizeOfFont:[UIFont boldSystemFontOfSize:16.0f] textMaxSize:CGSizeMake(SCREEN_WIDTH/2, MAXFLOAT)].height + [str2 stringSizeOfFont:[UIFont boldSystemFontOfSize:16.0f] textMaxSize:CGSizeMake(SCREEN_WIDTH-40, MAXFLOAT)].height;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{

    NSString * str = [[[self.dataSource firstObject] good_guide] objectForKey:@"content"];

    return 55+ [str stringSizeOfFont:[UIFont boldSystemFontOfSize:16.0f] textMaxSize:CGSizeMake(SCREEN_WIDTH-40, MAXFLOAT)].height;
}

- (UIView *)createHeaderView{

    
    CGFloat padding = 20.0f;
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = RGB_COLOR(26, 28, 31, 1);
    view.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
//    72 115 144
    // 轮播
    SDCycleScrollView * scroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:[[self.dataSource firstObject] images_item]];
//    scroll.autoScrollTimeInterval = 5.0f;
    scroll.autoScroll = NO;
    [view addSubview:scroll];
    scroll.sd_layout.leftSpaceToView(view,0).rightSpaceToView(view,0).heightIs(SCREEN_WIDTH).heightIs(SCREEN_WIDTH);
    
    // price
    UILabel * priceLabel = [UILabel new];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",[[self.dataSource firstObject] price]];
    priceLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    priceLabel.textColor = RGB_COLOR(72, 115, 144, 1);
    [view addSubview:priceLabel];
    priceLabel.sd_layout.leftSpaceToView(view,padding/2).topSpaceToView(scroll,padding).widthIs(SCREEN_WIDTH/2-padding/2).heightIs(padding);
    
    // like
    UIButton * likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString * title = [[self.dataSource firstObject] like_count];
     CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:12]];
    likeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    likeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    likeButton.titleEdgeInsets = UIEdgeInsetsMake(30, -[UIImage imageNamed:@"btn_cell_favorite4@2x"].size.width, 0, 0);
    likeButton.imageEdgeInsets = UIEdgeInsetsMake(-8, 3, 0, -titleSize.width);
    likeButton.contentEdgeInsets = UIEdgeInsetsMake(0, -3, 5, 0);
    [likeButton setImage:[UIImage imageNamed:@"btn_cell_favorite4@2x"] forState:UIControlStateNormal];
    [likeButton setTitle:[[self.dataSource firstObject] like_count] forState:UIControlStateNormal];
    [likeButton setTitleColor:RGB_COLOR(165, 173, 174, 1) forState:UIControlStateNormal];
    [view addSubview:likeButton];
    likeButton.sd_layout.topSpaceToView(scroll,padding/3).rightSpaceToView(view,padding).heightIs(50).widthIs(30);
    
    UILabel * ownerLabel = [UILabel new];
    ownerLabel.text = [NSString stringWithFormat:@"  %@",[[self.dataSource firstObject] owner_name]];
    ownerLabel.textColor = RGB_COLOR(165, 173, 174, 1);
    [view addSubview:ownerLabel];
    ownerLabel.sd_layout.leftEqualToView(priceLabel).topSpaceToView(priceLabel,padding/3).widthIs(SCREEN_WIDTH-padding*4).heightIs(padding);
    
    UILabel * goodsLabel = [UILabel new];
    goodsLabel.text = [NSString stringWithFormat:@"  %@",[[self.dataSource firstObject] goods_name]];
    goodsLabel.textColor = RGB_COLOR(165, 173, 174, 1);
    [view addSubview:goodsLabel];
    goodsLabel.sd_layout.leftEqualToView(ownerLabel).topSpaceToView(ownerLabel,padding/5).widthIs(SCREEN_WIDTH-padding*4).heightIs(padding);
    
    UILabel * labell = [UILabel new];
    labell.text = @"  商品描述";
    labell.textColor = RGB_COLOR(165, 173, 174, 1);
    [view addSubview:labell];
    labell.sd_layout.leftEqualToView(goodsLabel).topSpaceToView(goodsLabel,padding/2).widthIs(SCREEN_WIDTH-padding*4).heightIs(padding);
    
    UILabel * descLabel = [UILabel new];
    descLabel.numberOfLines = 0;
    descLabel.text = [NSString stringWithFormat:@"%@",[[self.dataSource firstObject] goods_desc]];
    descLabel.textColor = RGB_COLOR(67, 71, 72, 1);
    descLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [view addSubview:descLabel];
    descLabel.sd_layout.leftSpaceToView(view,padding/2+5).topSpaceToView(labell,padding/3).widthIs(SCREEN_WIDTH/2).autoHeightRatio(0);

    UILabel * label = [UILabel new];
    label.text = @"  推荐自";
    label.textColor = RGB_COLOR(165, 173, 174, 1);
    [view addSubview:label];
    label.sd_layout.leftEqualToView(goodsLabel).topSpaceToView(descLabel,padding).widthIs(SCREEN_WIDTH-padding*4).heightIs(padding);
    
    
    UIImageView * imageView = [UIImageView new];
    [imageView setImage:[UIImage imageNamed:@"Icon-titleview"]];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 20.0f;
    [view addSubview:imageView];
    imageView.sd_layout.leftSpaceToView(view,padding/2+5).topSpaceToView(label,padding/3).widthIs(40).heightIs(40);

    UILabel * label2 = [UILabel new];
    label2.text = @"良仓精选";
    label2.textColor = RGB_COLOR(165, 173, 174, 1);
    [view addSubview:label2];

    label2.sd_layout.leftSpaceToView(imageView,padding/2).centerYEqualToView(imageView).widthIs(SCREEN_WIDTH/2).heightIs(padding);
    
    UILabel * LCdescLabel = [UILabel new];
    LCdescLabel.numberOfLines = 0;
    LCdescLabel.text = [NSString stringWithFormat:@"%@",[[self.dataSource firstObject] rec_reason]];
    LCdescLabel.textColor = RGB_COLOR(67, 71, 72, 1);
    LCdescLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [view addSubview:LCdescLabel];
    LCdescLabel.sd_layout.leftSpaceToView(view,padding/2+5).topSpaceToView(label2,padding).widthIs(SCREEN_WIDTH-2*padding).autoHeightRatio(0);

    
    UILabel * label3 = [UILabel new];
    label3.text = @"  商品品牌";
    label3.textColor = RGB_COLOR(165, 173, 174, 1);
    [view addSubview:label3];
    
    label3.sd_layout.leftEqualToView(goodsLabel).topSpaceToView(LCdescLabel,padding/2).widthIs(SCREEN_WIDTH-padding*4).heightIs(padding);
    [view setupAutoHeightWithBottomView:label3 bottomMargin:5.0f];
    
        return view;
}

- (UIView *)createFooterView{
    CGFloat padding = 20.0f;

    UIView * footer = [UIView new];
    footer.backgroundColor = RGB_COLOR(26, 28, 31, 1);
    footer.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    UILabel * label = [UILabel new];
    label.text = [[[self.dataSource firstObject] good_guide] objectForKey:@"title"];
    label.textColor = RGB_COLOR(165, 173, 174, 1);
    [footer addSubview:label];
    label.sd_layout.leftSpaceToView(footer,padding/2+5).topSpaceToView(footer,padding).widthIs(SCREEN_WIDTH-padding*2).heightIs(padding);
    
    
    UILabel * descLabel = [UILabel new];
    descLabel.numberOfLines = 0;
    descLabel.text = [[[self.dataSource firstObject] good_guide] objectForKey:@"content"];
    descLabel.textColor = RGB_COLOR(67, 71, 72, 1);
    descLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [footer addSubview:descLabel];
    descLabel.sd_layout.leftEqualToView(label).topSpaceToView(label,padding/2).widthIs(SCREEN_WIDTH-padding*2).autoHeightRatio(0);
    
    [footer setupAutoHeightWithBottomView:descLabel bottomMargin:5.0f];
    
    
    return footer;


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LCOneStoreDetailController * detail = [LCOneStoreDetailController new];
    detail.idnumber = [NSString stringWithFormat:@"%@",[[[self.dataSource firstObject] brand_info] objectForKey:@"brand_id"]];
    detail.logo = [[self.dataSource firstObject] owner_image];
    detail.name = [[self.dataSource firstObject] owner_name];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 67;
}
-(void)creatBottomBtn{
    self.tabBarController.tabBar.hidden = YES;
    
    UIButton *btnleft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnleft setTitleColor:RGB_COLOR(174, 183, 185, 1) forState:UIControlStateNormal];
    btnleft.frame = CGRectMake(0, SCREEN_HEIGHT-64-49, SCREEN_WIDTH/2, 49);
    
    if (_isSelelcted) {
        [btnleft setTitle:@"取消加入" forState:UIControlStateNormal];
        NSLog(@"quxiao");
        
    }else{
        NSLog(@"jiaru");
        [btnleft setTitle:@"加入购物车" forState:UIControlStateNormal];
    }
    btnleft.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btnleft addTarget:self action:@selector(btnleft:) forControlEvents:UIControlEventTouchUpInside];
    [btnleft setBackgroundColor:RGB_COLOR(32, 35, 39, 1)];
    [self.view addSubview:btnleft];
    [self.view bringSubviewToFront:btnleft];
    
//    btnleft.sd_layout.leftSpaceToView (self.view,0).bottomSpaceToView(self.view,0).widthIs(SCREEN_WIDTH/2).heightIs(49);
    
    
    UIButton *btnright = [Tools createButtonBgImage:@"" title:@"直接购买" tag:11 target:self action:@selector(btnright)];
    btnright.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-49-64, SCREEN_WIDTH/2, 49);
    [btnright setTitleColor:RGB_COLOR(174, 183, 185, 1) forState:UIControlStateNormal];
    [btnright setBackgroundColor:RGB_COLOR(34, 40, 44, 1)];
    [self.view addSubview:btnright];
    
    [self.view bringSubviewToFront:btnright];
    
//    btnleft.sd_layout.rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0).widthIs(SCREEN_WIDTH/2).heightIs(49);

}
-(void)btnleft:(UIButton *)btn{
//    _isSelelcted = !_isSelelcted;
//    if (_isSelelcted) {
//        [btn setTitle:@"加入购物车" forState:UIControlStateNormal];
//        
//    }else{
//        [btn setTitle:@"取消加入" forState:UIControlStateNormal];
//       
//        
//    }
    
    LCPlanPayViewController * plan = [LCPlanPayViewController new];
    plan.type = @"pop";
    plan.model = [self.dataSource firstObject];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:plan];
    
    nav.navigationBar.tintColor = [UIColor whiteColor];
    nav.navigationBar.barTintColor = [UIColor blackColor];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    

    [self presentViewController:nav animated:YES completion:nil];
    
}
-(void)btnright{
    NSLog(@"2");
    
    LCPlanPayViewController * plan = [LCPlanPayViewController new];
    plan.type = @"push";
    plan.model = [self.dataSource firstObject];
    [self.navigationController pushViewController:plan animated:YES];

//    PayViewController *pay = [[PayViewController alloc]init];
//    pay.paymodel = self.storemodel;
//    
//    [self.navigationController pushViewController:pay animated:YES];
//    
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
