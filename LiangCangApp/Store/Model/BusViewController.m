//
//  BusViewController.m
//  LiangCang
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "BusViewController.h"
#import "StoreModel.h"
#import "buscell.h"
@interface BusViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSource;
    UITableView *_tableView;
 
}
@end

@implementation BusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavbar];
    [self initData];
    [self initUi];
    NSLog(@"%ld",_dataSource.count);
    NSLog(@"%@",_dataSource[0]);
    // Do any additional setup after loading the view.
}
-(void)creatNavbar{
    
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"filterSelected@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(barbtn)];
    self.navigationItem.leftBarButtonItem = barbtn;
    
}
-(void)barbtn{
   
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)initData{
    
    _dataSource = [[NSMutableArray alloc]init];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    for (NSString *idd in [SingleTon sharedSingleTon].iddarr){
       NSArray *arr =[ud objectForKey:idd];
        if (arr.count == 0) {
            _dataSource = nil;
        }
        
        [_dataSource addObject:arr];
    }
    if (_dataSource.count == 0) {
        _dataSource = nil;
        [_tableView reloadData];
    }
    
    
}
-(void)initUi{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"buscell" bundle:nil] forCellReuseIdentifier:@"buscell"];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    buscell *cell = [tableView dequeueReusableCellWithIdentifier:@"buscell"];
    if (!cell) {
        cell = [[buscell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"buscell"];
    }
    
  NSArray *arr = _dataSource[indexPath.row];
    [cell refreshWithModel:arr];
    

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
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
