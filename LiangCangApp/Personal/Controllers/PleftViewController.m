//
//  PleftViewController.m
//  LiangCang
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "PleftViewController.h"
#import "PleftViewCell.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
@interface PleftViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataSource;
    NSArray *_imageSource;
    NSArray *_selectedImageSource;

    UITableView *_tableView;
}
@end

@implementation PleftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUi];
    // Do any additional setup after loading the view.
}
-(void)initData{
    _dataSource = [[NSArray alloc]init];
    _imageSource = [[NSArray alloc]init];
    _selectedImageSource = [[NSArray alloc]init];


    _dataSource = @[@"个人",@"设置"];
    _imageSource = @[@"sidebar_personal_news@2x.png",@"sidebar_personal_personal@2x.png",@"sldebar_personal_address@2x.png",@"sldebar_personal_orders@2x.png",@"sldebar_personal_settings@2x.png"];
    _selectedImageSource = @[@"sidebar_personal_news_h@2x.png",@"sidebar_personal_personal_h@2x.png",@"sldebar_personal_address_h@2x.png",@"sldebar_personal_orders_h@2x.png",@"sldebar_personal_settings_h@2x.png"];


}
-(void)initUi{
    self.view.backgroundColor = [UIColor blackColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH - 120, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"PleftViewCell" bundle:nil] forCellReuseIdentifier:@"PleftViewCell"];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PleftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PleftViewCell"];
    if (!cell) {
        cell = [[PleftViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PleftViewCell"];
    }
    [cell refreshWith:_imageSource[indexPath.row] and:_selectedImageSource[indexPath.row] and:_dataSource[indexPath.row]];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 64;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DDMenuController *dd = (DDMenuController *)((AppDelegate*)[[UIApplication sharedApplication]delegate].window.rootViewController.childViewControllers[4]);
    [dd showRootController:YES];
    if (indexPath.row == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName object:nil userInfo:@{@"type":@"PersonalView"}];

    }



    if (indexPath.row == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName object:nil userInfo:@{@"type":@"SettingView"}];

    }



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
