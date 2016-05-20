//
//  ExpertLeftController.m
//  LiangCangApp
//
//  Created by MS on 15/10/12.
//  Copyright © 2015年 WS. All rights reserved.
//

#import "ExpertLeftController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
@interface ExpertLeftController () <UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_tableView;
    UITextField *_textField;
    NSArray * _dataSource;

}
@end

@implementation ExpertLeftController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSArray arrayWithObjects:@"默认推荐",@"最多推荐",@"最受欢迎",@"最新推荐",@"最新加入",nil];
    self.view.backgroundColor = [UIColor blackColor];
    [self initUi];
}

-(void)initUi{


    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH-120, SCREEN_HEIGHT-49 - 30) style:UITableViewStyleGrouped];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_tableView];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(5, 25, SCREEN_WIDTH - 120, 30)];;
    _textField.placeholder = @"搜索";
//    _textField.backgroundColor = RGB_COLOR(26, 28, 31, 1);
    
    _textField.textColor = RGB_COLOR(165, 173, 174, 1);
    _tableView.backgroundColor = RGB_COLOR(26, 28, 31, 1);
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


#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

      static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];

    }
    cell.backgroundColor = RGB_COLOR(26, 28, 31, 1);
    cell.textLabel.textColor = RGB_COLOR(165, 173, 174, 1);

    cell.textLabel.text = _dataSource[indexPath.row];


    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    DDMenuController * dd = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate].window.rootViewController.childViewControllers[3]);

    [dd showRootController:YES];

    if (indexPath.row == 0) {

        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName2 object:nil userInfo:@{@"insert":@"http://app.iliangcang.com/expert?app_key=Android&build=2015092501&count=18&page=%ld&v=1.0"}];
}
    if (indexPath.row == 1) {

        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName2 object:nil userInfo:@{@"insert":@"http://app.iliangcang.com/expert?orderby=goods_sum&app_key=Android&build=2015092501&count=18&page=%ld&v=1.0"}];
    }
    
    if (indexPath.row == 2) {

        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName2 object:nil userInfo:@{@"insert":@"http://app.iliangcang.com/expert?orderby=followers&app_key=Android&build=2015092501&count=18&page=%ld&v=1.0"}];
    }
    
    if (indexPath.row == 3) {

        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName2 object:nil userInfo:@{@"insert":@"http://app.iliangcang.com/expert?orderby=action_time&app_key=Android&build=2015092501&count=18&page=%ld&v=1.0"}];
    }
    
    if (indexPath.row == 4) {

        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationName2 object:nil userInfo:@{@"insert":@"http://app.iliangcang.com/expert?orderby=reg_time&app_key=Android&build=2015092501&count=18&page=%ld&v=1.0"}];
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
