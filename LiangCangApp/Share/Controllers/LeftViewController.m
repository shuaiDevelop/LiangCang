//
//  LeftViewController.m
//  LiangCangApp
//
//  Created by MS on 15/10/12.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "LeftViewController.h"
#import "AppDelegate.h"
#import "DDMenuController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSArray *_dataSourceSec;
    NSArray *_dataSourceShare;
    NSArray *_dataSourcePrice;
    UITableView *_tableView;
    BOOL _isSected;

    UITextField *_textField;
    UIButton *_btn;
}@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];

    [self initData];
    [self initUi];
}
-(void)initData{
    self.isOpen = NO;
    _dataSourceSec = [[NSArray alloc]init];
    _dataSourceShare = [[NSArray alloc]init];
    _dataSourcePrice = [[NSArray alloc]init];
    _dataSourceSec = @[@"商店",@"分享",@"价格"];
    _dataSourceShare = @[@"全部",@"男士",@"女士",@"家居",@"数码",@"工具",@"玩具",@"美容",@"孩子",@"宠物",@"运动",@"饮食",@"文化"];
    _dataSourcePrice = @[@"全部",@"0-200",@"201-500",@"501-1000",@"1001-3000",@"3000以上"];

}
-(void)initUi{


    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH-120, SCREEN_HEIGHT-49 - 30) style:UITableViewStyleGrouped];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = RGB_COLOR(26, 28, 31, 1);

    [self.view addSubview:_tableView];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(5, 25, SCREEN_WIDTH - 120, 30)];;
    _textField.placeholder = @"搜索";
//    _textField.backgroundColor = RGB_COLOR(26, 28, 31, 1);
    
    _textField.textColor = RGB_COLOR(165, 173, 174, 1);
    [_textField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_textField];
    
  
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textField endEditing:YES];


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataSourceSec.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {


        return (_isOpen ? _dataSourceShare.count:0);



    }
    if (section == 2) {


        return (_isup ? _dataSourcePrice.count:0);


    }
    return 0;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = RGB_COLOR(26, 28, 31, 1);
    if (indexPath.section == 1) {
        cell.textLabel.text = _dataSourceShare[indexPath.row];
        cell.textLabel.textColor = RGB_COLOR(165, 173, 174, 1);

    }
    if (indexPath.section ==2) {
        cell.textLabel.textColor = RGB_COLOR(165, 173, 174, 1);

        cell.textLabel.text = _dataSourcePrice[indexPath.row];

    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {

        UIView *View = [[UIView alloc]init];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        label.text = _dataSourceSec[section];
        label.textColor =RGB_COLOR(165, 173, 174, 1);
        [View addSubview:label];
        return View;
    }
    else{
        UIView *View = [[UIView alloc]init];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        label.text = _dataSourceSec[section];
        label.textColor =RGB_COLOR(165, 173, 174, 1);

        [View addSubview:label];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(CGRectGetMaxY(label.frame)+50, 0, 30, 30);
        btn.tag = 10+section;

        [btn setImage:[UIImage imageNamed:@"icn_accessory@2x.png"] forState:UIControlStateNormal];
        if (btn.tag == 11) {
            if (_isOpen) {

                [btn setImage:[UIImage imageNamed:@"icn_accessory_down@2x.png"] forState:UIControlStateNormal];

            }else{

                [btn setImage:[UIImage imageNamed:@"icn_accessory@2x.png"] forState:UIControlStateNormal];

            }

        }
        if (btn.tag == 12) {
            if (_isup) {

                [_btn setImage:[UIImage imageNamed:@"icn_accessory_down@2x.png"] forState:UIControlStateNormal];

            }else{

                [_btn setImage:[UIImage imageNamed:@"icn_accessory@2x.png"] forState:UIControlStateNormal];

            }

        }

        [btn addTarget:self action:@selector(actionbutton:) forControlEvents:UIControlEventTouchUpInside];
        [View addSubview:btn];
        return View;
    }
}
-(void)actionbutton:(UIButton *)btn{



    if (btn.tag == 11) {
        _isOpen = !_isOpen;
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag - 10] withRowAnimation:UITableViewRowAnimationFade];

    }
    if (btn.tag == 12) {
        _isup = !_isup;
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag - 10] withRowAnimation:UITableViewRowAnimationFade];


    }




}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
#pragma mark - 列表响应  发送通知
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DDMenuController *dd = (DDMenuController *)((AppDelegate*)[[UIApplication sharedApplication]delegate].window.rootViewController.childViewControllers[2]);

    [dd showRootController:YES];
    if ((indexPath.section == 1) && indexPath.row==0) {

        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName object:nil userInfo:@{@"type":@"100"}];

    }

    if ((indexPath.section == 1) && indexPath.row!=0) {

        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName object:nil userInfo:@{@"type":[NSString stringWithFormat:@"%ld",indexPath.row]}];

    }



    if ((indexPath.section == 2) && indexPath.row == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName object:nil userInfo:@{@"min":@"0",@"max":@"200"}];

    }
    if ((indexPath.section == 2) && indexPath.row == 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName object:nil userInfo:@{@"min":@"201",@"max":@"500"}];

    }
    if ((indexPath.section == 2) && indexPath.row == 3) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName object:nil userInfo:@{@"min":@"501",@"max":@"1000"}];

    }
    if ((indexPath.section == 2) && indexPath.row == 4) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName object:nil userInfo:@{@"min":@"1001",@"max":@"3000"}];

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
