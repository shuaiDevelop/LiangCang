//
//  YLStoreTwoViewController.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/11.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "YLStoreTwoViewController.h"
#import "LCStoreDetailViewController.h"
@interface YLStoreTwoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL selected[10];

}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray * dataSource;
@end

@implementation YLStoreTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (NSArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StoreTwo" ofType:@"plist"]];
    }


    return _dataSource;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49 - 40) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB_COLOR(21, 21, 21, 1);
    }


    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return self.dataSource.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSDictionary * dic = [self.dataSource objectAtIndex:section];
    
    NSArray * list = [dic objectForKey:@"list"];
    
    if (selected[section] == NO) {
        return 0;
    }
    

    return list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{



    static NSString *identifier=@"Friend_cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.backgroundColor = RGB_COLOR(21, 21, 21, 1);

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary * dic = [self.dataSource objectAtIndex:indexPath.section];
    
    NSArray * list = [dic objectForKey:@"list"];

    cell.textLabel.text=list[indexPath.row];
    cell.textLabel.textColor = [UIColor lightGrayColor];

    return cell;
    

}
//组的头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*9/16)];
    
//    [imageview setImage:[UIImage imageNamed:[[self.dataSource objectAtIndex:section] objectForKey:@"pic"]]];
    imageview.userInteractionEnabled = YES;
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=imageview.frame;
    
    NSArray * array = @[@"1230.jpg",@"1231.jpg",@"1232.jpg",@"1233.jpg",@"1234.jpg"];
//    [button setBackgroundImage:[UIImage imageNamed:[[self.dataSource objectAtIndex:section] objectForKey:@"pic"]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:array[section]] forState:UIControlStateNormal];

    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    button.tag=section;
    
    [imageview addSubview:button];

    
    return button;
}

-(void)buttonAction:(UIButton *)btn{
    
    selected[btn.tag]=!selected[btn.tag];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationNone];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LCStoreDetailViewController *detailVc = [LCStoreDetailViewController new];
    detailVc.section = indexPath.section;
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            detailVc.Presentid = 5;
        }else{
        
            detailVc.Presentid = indexPath.row + 1;

        }
        detailVc.section = indexPath.section;
        detailVc.titlee = @"家居";
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            detailVc.Presentid = 10009;
        }
        
        if (indexPath.row == 1) {
            detailVc.Presentid = 10010;
        }

        if (indexPath.row == 2) {
            
            detailVc.Presentid = 10027;
            
        }

        detailVc.section = indexPath.section;
        detailVc.titlee = @"服饰";
    }
    if (indexPath.section == 2) {
        detailVc.Presentid = indexPath.row + 19;
        detailVc.section = indexPath.section;
        detailVc.titlee = @"其他";
    }
    if (indexPath.section ==3) {
        detailVc.Presentid = indexPath.row + 6;
        detailVc.section = indexPath.section;
        detailVc.titlee = @"艺术";
    }
    if (indexPath.section == 4) {
        detailVc.Presentid = indexPath.row + 6;
        detailVc.section = indexPath.section;
        detailVc.titlee = @"礼物";
        
    }
    
    [self.navigationController pushViewController:detailVc animated:NO];

    
    
    

}

//组头视图的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SCREEN_WIDTH*9/16;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{


    return 1.0f;
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
