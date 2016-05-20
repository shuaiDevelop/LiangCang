//
//  ShareDetailViewController.m
//  LiangCangApp
//
//  Created by MS on 15/10/10.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "ShareDetailViewController.h"
#import "WSTabBar.h"

#import "ShareDetailViewCell.h"
#import "ShareDetailModel.h"
#import "AFNetworking.h"

#import "ShareDetailHeaderModel.h"
#import "UIImageView+AFNetworking.h"

#import "UserDetailViewController.h"
#import "UMSocial.h"
@interface ShareDetailViewController () <UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource;
    NSMutableArray *_headDataArr;
    WSTabBar * _tabbar;
}
@end

@implementation ShareDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self createNavBar];
    [self initData];
    [self downloadData];
    [self createUI];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}
// 初始化数据
- (void)initData{
    _dataSource = [[NSMutableArray alloc] init];
    _headDataArr = [[NSMutableArray alloc] init];

}
- (void)createNavBar{
    self.navigationItem.title = @"良品";
    self.view.backgroundColor = [UIColor blackColor];


    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 20);
    [rightBtn setImage:[UIImage imageNamed:@"btn_forward4@2x.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

}

- (void)createUI{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource =  self;
//    _tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_tableView];

    [_tableView registerClass:[ShareDetailViewCell class] forCellReuseIdentifier:@"cellID"];

}

#pragma mark - 下载数据
- (void)downloadData{

    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];


    //异步  下载列表
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    [manager GET:[NSString stringWithFormat:ShareDetailUrlStr,self.good_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (!responseObject) {
            return ;
        }

        [self parseData:responseObject];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


});
    // 异步  下载header
    dispatch_async(dispatch_get_global_queue(0, 0), ^{


    [manager GET:[NSString stringWithFormat:ShareDetailHeaderUrlStr,self.good_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if (!responseObject) {
            return ;
        }

        [self parseHeaderData:responseObject];


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {


    }];
    



});

}
- (void)parseHeaderData:(NSData *)data{

    NSDictionary * rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary * dataDic = rootDic[@"data"];

    ShareDetailHeaderModel * model = [[ShareDetailHeaderModel alloc] init];
    model.is_daren = dataDic[@"is_daren"];
    model.owner_image = dataDic[@"owner_image"];
    model.price = dataDic[@"price"];
    model.like_count = dataDic[@"like_count"];
    model.owner_name = dataDic[@"owner_name"];
    model.owner_id = dataDic[@"owner_id"];

    [_headDataArr addObject:model];
    dispatch_async(dispatch_get_main_queue(), ^{

        [_tableView reloadData];
    });


}

- (void)parseData:(NSData *)data{

    NSDictionary * rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary * dataDic = rootDic[@"data"];


    if ([dataDic[@"items"] isKindOfClass:[NSString class]]) {

        return;
    }

    if ([dataDic[@"items"] isKindOfClass:[NSArray class]]) {

    {

        for (NSDictionary * dic in dataDic[@"items"]) {

            ShareDetailModel * model = [[ShareDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataSource addObject:model];
        }

        dispatch_async(dispatch_get_main_queue(), ^{

            [_tableView reloadData];
        });
        



    }
}




}
#pragma mark - UITableView 代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{



    if (_dataSource.count>0) {
        ShareDetailViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];


        cell = [[ShareDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID" withFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50)];
        [cell refreshCellWithModel:_dataSource[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    else{

        return nil;
    }



}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_dataSource.count > 0) {
        ShareDetailModel * model = _dataSource[indexPath.row];
        CGSize labelHeight = [[NSString stringWithFormat:@"%@:%@",model.user_name,model.msg] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH/2, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]} context:nil].size;


        return 90+labelHeight.height;

    }
    else{

        return 0;

    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    ShareDetailHeaderModel * model = [_headDataArr firstObject];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 120)];
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor blackColor];

    UIImageView * imagView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    imagView.userInteractionEnabled = YES;

    imagView.contentMode = UIViewContentModeScaleAspectFit;
    [imagView setImageWithURL:[NSURL URLWithString:self.good_image]];
    [view addSubview:imagView];

    // 爱好按钮
    UIButton * likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    likeBtn.frame = CGRectMake(SCREEN_WIDTH - 50, CGRectGetMaxY(imagView.frame)+5, 30, 30);
    [likeBtn setImage:[UIImage imageNamed:@"btn_unfavorite@2x.png"] forState:UIControlStateNormal];
    [likeBtn addTarget:self action:@selector(likeBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:likeBtn];

    // 爱好数量
    UILabel * likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 45, CGRectGetMaxY(likeBtn.frame)+5, 30, 30)];
    likeLabel.textColor = [UIColor whiteColor];
    likeLabel.text = model.like_count;
    [view addSubview:likeLabel];

    UILabel * priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(likeBtn.frame)+5, 100, 30)];
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.text = model.price;
    [view addSubview:priceLabel];

    UIButton * linkButton = [UIButton buttonWithType:UIButtonTypeCustom];

    linkButton.frame = CGRectMake(30, CGRectGetMaxY(priceLabel.frame)+5, 50, 30);
    [linkButton setImage:[UIImage imageNamed:@"btn_ware_buy@2x.png"] forState:UIControlStateNormal];
    [linkButton addTarget:self action:@selector(linkButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:linkButton];

    // 推荐  手势跳转

    UIImageView * recommendView = [[UIImageView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(linkButton.frame) + 5, 50, 50)];

    recommendView.userInteractionEnabled = YES;
    recommendView.layer.cornerRadius = 25.0f;
    [recommendView setImageWithURL:[NSURL URLWithString:model.owner_image] placeholderImage:[UIImage imageNamed:@"bg_badge4@2x.png"]];
    [view addSubview:recommendView];

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [recommendView addGestureRecognizer:tap];


    UILabel * ownLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(recommendView.frame) + 10, CGRectGetMaxY(linkButton.frame) + 20, SCREEN_WIDTH/2, 20)];
    ownLabel.text = [NSString stringWithFormat:@"%@ 推荐",model.owner_name];
    ownLabel.textColor = [UIColor whiteColor];
    [view addSubview:ownLabel];

    return view;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return SCREEN_HEIGHT - 130;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];

    btn.frame = CGRectMake(20, 10, SCREEN_WIDTH, 50);
//    [btn setImage:[UIImage imageNamed:@"1158492.png"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@" 写点什么!" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(writeClicked) forControlEvents:UIControlEventTouchUpInside];


    return btn;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 50;
}
#pragma mark - Header Button Clicked
// 爱好
- (void)likeBtnClicked{


}
// link
- (void)linkButtonClicked{


}
// 推荐
- (void)tapAction:(UITapGestureRecognizer *)gesture{

    ShareDetailHeaderModel * model = [_headDataArr firstObject];
    UserDetailViewController * userVC = [[UserDetailViewController alloc] init];
    userVC.userId = model.owner_id;
    userVC.userImage = model.owner_image;
    userVC.userName = model.owner_name;

    [self.navigationController pushViewController:userVC animated:YES];
    

}
#pragma mark - Footer Button Clicked
- (void)writeClicked{
    NSLog(@"写点什么");

}
#pragma mark - 分享
- (void)rightBtnClicked{
    ShareDetailHeaderModel * model = [_headDataArr firstObject];
//
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56237669e0f55ade5e002e5a"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:model.owner_image]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,
                                                 UMShareToTencent,
                                                 UMShareToWechatSession,
                                                 UMShareToQQ,
                                                 UMShareToQzone,
                                                 UMShareToWechatTimeline,
                                                UMShareToWechatFavorite,nil]
                                       delegate:self];
//    self.tabBarController.tabBar.hidden = YES;
//        [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
