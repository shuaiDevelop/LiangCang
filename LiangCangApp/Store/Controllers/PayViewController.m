//
//  PayViewController.m
//  LiangCang
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 11111111. All rights reserved.
//

#import "PayViewController.h"
#import "NetMannager.h"
#import "AppdelegateTool.h"
#import "WXApi.h"
#import "SaleViewController.h"
//#import "Pingpp.h"
@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createpaybtn];
    [self creatNavbar];
    // Do any additional setup after loading the view from its nib.
}

-(void)createpaybtn{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-120, SCREEN_WIDTH, 49);
    [btn setTitle:@"直接购买" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buyButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    

}
-(void)creatNavbar{

    //    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_backNormal@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(barbtn)];

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

- (void)buyButtonClicked{

    NSString *orderNo = @"109080701010206"; // orderNo 一般在服务器生成
    NSArray *contents = @[
                          @[
                              @"商品", @[@"Kaico 搪瓷水壶 x 1", @"橡胶花瓶 x 1", @"扫把和簸箕 x 1"]
                              ],
                          @[
                              @"运费", @[@"¥ 0.00"]
                              ]
                          ];
    

//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"海淀",@"area",@"小黄",@"receiptName",@"13241959749",@"receiptPhone",@"北京市海淀区",@"address", nil];
//
//
//    NSMutableDictionary *parmDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
//    NSError *error = nil;
//
//    NSData *data = [NSJSONSerialization dataWithJSONObject:parmDic options:NSJSONWritingPrettyPrinted error:&error];
//
//    if (error ==  nil  && data.length != 0) {
//        NSString *jsonstr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//
//
//        NSLog(@"  json   %@",jsonstr);
//
//        NSDictionary *parmDic  = [NSDictionary dictionaryWithObjectsAndKeys:@"51102",@"productId",jsonstr,@"receipt",@"wedding",@"type",@"1200",@"userId", nil];
//        NSLog(@"数据参数:%@",parmDic);
//
//
//        [NetMannager requestWithUrlString:ConfirmOrder parms:parmDic responseType:@"text/html" finishedBlock:^(AFHTTPRequestOperation *operation, id responsObj) {
//            NSLog(@"请求返回的数据:%@",responsObj);
//
//            [self openWeiChatPayWith:[responsObj objectForKey:@"order"]];
//
//
//
//        } failedBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//            NSLog(@"error %@",error.localizedDescription);
//            
//        }];
//        
//    }

}

/**
 *   请求微信支付所需要的参数
 */
- (void) openWeiChatPayWith:(id) parms
{

    NSString *orderId =[NSString stringWithFormat:@"%@", [parms objectForKey:@"id"]];

    NSDictionary *parm = [NSDictionary dictionaryWithObjectsAndKeys:orderId,@"orderId",@"APP",@"trade_type",@"wedding",@"type", @"1200",@"userId",nil];

    [NetMannager requestWithUrlString:D_payUrl parms:parm responseType:@"text/html" finishedBlock:^(AFHTTPRequestOperation *operation, id responsObj)
     {

         if ([responsObj objectForKey:@"success"]) {

             /**
              *  注意我们这里返回是字典，才能正常运行；
              */
             [AppdelegateTool openWeiChatWith:responsObj];


         }


     } failedBlock:^(AFHTTPRequestOperation *operation, NSError *error)


     {




     }];


    
    
    
    
    
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
