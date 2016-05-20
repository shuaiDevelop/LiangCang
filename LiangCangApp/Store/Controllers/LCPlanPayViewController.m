//
//  LCPlanPayViewController.m
//  LiangCangApp
//
//  Created by 王帅 on 16/5/20.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "LCPlanPayViewController.h"
#import "LCStoreDetailModel.h"
#import "UILabel+Category.h"
#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"
//#import "UITableView+SDAutoTableViewCellHeight.h"
@interface LCPlanPayViewController ()

@end

@implementation LCPlanPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNavBar];
    
    
}
- (void)createViews:(LCStoreDetailModel *)model{

    CGFloat padding = 20.0f;
    UILabel * colorLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:17.0f] textColor:RGB_COLOR(174, 183, 185, 1) numberOfLines:1 textAlignment:NSTextAlignmentLeft];
    
    
    colorLabel.text = [[model.sku_info firstObject] objectForKey:@"type_name"];
    [self.view addSubview:colorLabel];
    colorLabel.sd_layout.leftSpaceToView(self.view,padding/2).topSpaceToView(self.view,padding/2).widthIs(SCREEN_WIDTH/2).heightIs(padding);
    
    if ([[[[[model.sku_info firstObject] objectForKey:@"attrList"] firstObject] objectForKey:@"img_path"] isEqual:NULL] ||[[[[[model.sku_info firstObject] objectForKey:@"attrList"] firstObject] objectForKey:@"img_path"] isKindOfClass:[NSNull class]] ) {
        UILabel * label = [UILabel labelWithFont:[UIFont boldSystemFontOfSize:15.0f] textColor:RGB_COLOR(109, 160, 169, 1) numberOfLines:1 textAlignment:NSTextAlignmentCenter];
        label.text = [[[[model.sku_info firstObject] objectForKey:@"attrList"] firstObject] objectForKey:@"attr_name"];
        label.clipsToBounds = YES;
        label.layer.cornerRadius = 1;
        label.layer.borderWidth = 1.0f;
        label.layer.borderColor = RGB_COLOR(109, 160, 169, 1).CGColor;
        [self.view addSubview:label];
        label.sd_layout.leftEqualToView(colorLabel).topSpaceToView(colorLabel,padding/2).widthIs(40).heightIs(padding);
        
       
        UILabel * line = [UILabel labelWithFont:[UIFont boldSystemFontOfSize:15.0f] textColor:RGB_COLOR(174, 183, 185, 1)  numberOfLines:1 textAlignment:NSTextAlignmentCenter];
        line.backgroundColor = RGB_COLOR(174, 183, 185, 1) ;
        [self.view addSubview:line];
        line.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).heightIs(0.5f).topSpaceToView(label,padding);
        
        
        
        UILabel * numLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:17.0f] textColor:RGB_COLOR(174, 183, 185, 1) numberOfLines:1 textAlignment:NSTextAlignmentLeft];
        numLabel.text = @"数量:";
        [self.view addSubview:numLabel];
        numLabel.sd_layout.leftSpaceToView(self.view,padding/2).topSpaceToView(line,padding/2).widthIs(42).heightIs(padding);
        
        UITextField * field = [[UITextField alloc] init];
        field.backgroundColor = [UIColor whiteColor];
        field.textAlignment = NSTextAlignmentCenter;
        field.text = @"1";
        [self.view addSubview:field];
        field.sd_layout.leftSpaceToView(numLabel,2.0f).topEqualToView(numLabel).widthIs(padding).heightIs(padding);
        
        UILabel * line1 = [UILabel labelWithFont:[UIFont boldSystemFontOfSize:15.0f] textColor:RGB_COLOR(174, 183, 185, 1)  numberOfLines:1 textAlignment:NSTextAlignmentCenter];
        line1.backgroundColor = RGB_COLOR(174, 183, 185, 1) ;
        [self.view addSubview:line1];
        line1.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).heightIs(0.5f).topSpaceToView(field,padding/3);
        


    }
    else {
        UIImageView * imageView = [[UIImageView alloc] init];
        [imageView setImageWithURL:[NSURL URLWithString:[[[[model.sku_info firstObject] objectForKey:@"attrList"] firstObject] objectForKey:@"img_path"]]];
        [self.view addSubview:imageView];
        imageView.sd_layout.leftEqualToView(colorLabel).topSpaceToView(colorLabel,padding/2).heightIs(40).widthIs(40);
        
        UILabel * label = [UILabel labelWithFont:[UIFont boldSystemFontOfSize:13.0f] textColor:RGB_COLOR(109, 160, 169, 1) numberOfLines:1 textAlignment:NSTextAlignmentCenter];
        label.text = [[[[model.sku_info firstObject] objectForKey:@"attrList"] firstObject] objectForKey:@"attr_name"];
        [self.view addSubview:label];
        label.sd_layout.leftEqualToView(imageView).topSpaceToView(imageView,padding/4).widthIs(40).heightIs(padding);
        
        
        UILabel * line = [UILabel labelWithFont:[UIFont boldSystemFontOfSize:15.0f] textColor:RGB_COLOR(174, 183, 185, 1)  numberOfLines:1 textAlignment:NSTextAlignmentCenter];
        line.backgroundColor = RGB_COLOR(174, 183, 185, 1) ;
        [self.view addSubview:line];
        line.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).heightIs(0.5f).topSpaceToView(label,padding);
        
        
        UILabel * numLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:17.0f] textColor:RGB_COLOR(174, 183, 185, 1) numberOfLines:1 textAlignment:NSTextAlignmentLeft];
        numLabel.text = @"数量:";
        [self.view addSubview:numLabel];
        numLabel.sd_layout.leftSpaceToView(self.view,padding/2).topSpaceToView(line,padding/2).widthIs(42).heightIs(padding);
        
        UITextField * field = [[UITextField alloc] init];
        field.backgroundColor = [UIColor whiteColor];
        field.textAlignment = NSTextAlignmentCenter;
        field.text = @"1";
        [self.view addSubview:field];
        field.sd_layout.leftSpaceToView(numLabel,padding/2).topEqualToView(numLabel).widthIs(padding).heightIs(padding);
        
        
        UILabel * line1 = [UILabel labelWithFont:[UIFont boldSystemFontOfSize:15.0f] textColor:RGB_COLOR(174, 183, 185, 1)  numberOfLines:1 textAlignment:NSTextAlignmentCenter];
        line1.backgroundColor = RGB_COLOR(174, 183, 185, 1) ;
        [self.view addSubview:line1];
        line1.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).heightIs(0.5f).topSpaceToView(field,padding/3);
        
        
    
    }
    


}
- (void)btnleft:(UIButton *)btn{

    if ([_type isEqualToString:@"pop"]) {

        [UILabel showStats:@"添加成功" atView:self.view];
    }
    if ([_type isEqualToString:@"push"]) {
        
        [UILabel showStats:@"购买成功" atView:self.view];
    }



}
- (void)setModel:(LCStoreDetailModel *)model{

    _model = model;
    [self createViews:model];

}

- (void)createNavBar{
       self.view.backgroundColor = RGB_COLOR(57, 57, 63, 1);
//    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 5, 30, 30);
    UIImage * Sizeimage =[Tools imageWithImageSimple:[UIImage imageNamed:@"fanhui@2x.png"] scaledToSize:CGSizeMake(16, 18)];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        [btn setImage:Sizeimage forState:UIControlStateNormal];
        
    }else{
        
        [btn setImage:[UIImage imageNamed:@"fanhui@2x.png"] forState:UIControlStateNormal];
    }
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backbtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = backbtn;

    
    UIButton *btnleft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnleft setTitleColor:RGB_COLOR(109, 160, 169, 1) forState:UIControlStateNormal];
    
    if ([_type isEqualToString:@"pop"]) {
        [btnleft setTitle:@"添加到购物车" forState:UIControlStateNormal];
        
    }
    if ([_type isEqualToString:@"push"]) {
        [btnleft setTitle:@"直接购买" forState:UIControlStateNormal];
        
    }
    btnleft.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [btnleft addTarget:self action:@selector(btnleft:) forControlEvents:UIControlEventTouchUpInside];
    [btnleft setBackgroundColor:RGB_COLOR(32, 35, 39, 1)];
    [self.view addSubview:btnleft];
    
    
    btnleft.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).heightIs(49).bottomSpaceToView(self.view,0);
    



}
- (void)onClick{
    
    if ([_type isEqualToString:@"pop"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if ([_type isEqualToString:@"push"]) {
    [self.navigationController popViewControllerAnimated:YES];
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
