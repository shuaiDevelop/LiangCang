//
//  EnterView.m
//  LiangCang
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "EnterView.h"
#import "UMSocial.h"

@interface EnterView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataSource;
    NSInteger _index;
    UITableView *_tableView;
}
@end

@implementation EnterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initData];
        [self createView];
        
    }

    return self;

}
-(void)initData{
  
    _dataSource = @[@[@"登录／注册",@"退出"],
                       @[@"去APP STORE为良仓打气",@"分享良仓好友",@"关注良仓"],
                       @[@"关注良仓",@"意见反馈"]];
}
-(void)createView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataSource.count;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [_dataSource[section] count];
    }
    if (section == 1) {
        return [_dataSource[section] count];
    }


    return [_dataSource[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  =[ tableView dequeueReusableCellWithIdentifier:@"entercell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"entercell"];
    }
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.delegate Enterview];
            
        }
    }

}

- (void)btnClicked{
    NSLog(@"微博");
    [self.delegate Enterview];
       
}



@end
