//
//  SettingView.m
//  LiangCang
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "SettingView.h"
#import "UMSocial.h"
#import "SVProgressHUD.h"

@interface SettingView ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *_tableView;
    NSArray *_SettingSource;
}
@end

@implementation SettingView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initData];
        [self creatUi];
    }
   
    return self;
}
-(void)initData{
   _SettingSource = @[@[@"编辑个人资料",@"选择模版",@"消息推送",@"退出"],
                      @[@"去APP STORE为良仓打气",@"分享良仓好友",@"关注良仓"],
                      @[@"关注良仓",@"意见反馈",@"清除缓存"]];

}

-(void)creatUi{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _SettingSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [_SettingSource[section] count];
    }
    if (section == 1) {
         return [_SettingSource[section] count];
    }
     return [_SettingSource[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"setcell"];
    }
    cell.textLabel.text = _SettingSource[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section == 0){

        if (indexPath.row == 3) {

            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"退出" message:@"您确定要退出好良仓吗?" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];


            [alert show];
        }


    }




    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            [self.delegate UmengPresent];
            
        }
        
    }

    if (indexPath.section == 2) {
        if (indexPath.row == 2) {


            sleep(3);
            [SVProgressHUD showSuccessWithStatus:@"清除缓存成功"];

        }

    }


}

@end
