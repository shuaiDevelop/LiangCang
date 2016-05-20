//
//  WsDetailsViewController.m
//  LiangCangApp
//
//  Created by 李健 on 16/5/17.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "WsDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "PayViewController.h"
@interface WsDetailsViewController ()
{
    UIScrollView *_scrollView;
    UIImageView *_imageView;
    UILabel *_priceLabel;
    UILabel *_nameLabel;
    UILabel *_miaoShuLabel;
    UILabel *_miaoShuContent;
    UILabel *_tuiJianLabel;
    UIImageView *_headerImage;
    UILabel *_jingXLabel;
    UILabel *_detailLabel;
    UILabel *_pingPaiLabel;
    UILabel *_miniLabel;
    UILabel *_buyWayLabel;
    UILabel *_cccLabel;
    UIButton *_addTocarBtn;
    UIButton *_zhiJieGouMaiBtn;
    BOOL _isSelelcted;
     NSArray *_busSource;
}
@end

@implementation WsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUi];
}

- (void)createUi
{
    //1
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:14], NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[self.storemodel.brand_info objectForKey:@"brand_desc"] attributes:dict];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.maximumLineHeight = 24;
    paragraphStyle.lineSpacing = 5;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [[self.storemodel.brand_info objectForKey:@"brand_desc"]length])];
    CGRect contextrect = [attributedString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-10, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    
    //2
    NSString *str = @"所有商品均为正品保证，下单后四个工作日内发货。中国大陆地区免运费，默认发顺丰或圆通快递。\r\n蜡烛、液态品、手表等含电池产品无法空运，运输时间相较普通空运件会更久。\r\n如出现产品质量问题请在签收后72小时内联系客服。";
    NSDictionary * dict1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:14], NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:str attributes:dict1];
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.alignment = NSTextAlignmentLeft;
    paragraphStyle1.maximumLineHeight = 24;
    paragraphStyle1.lineSpacing = 5;
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    CGRect contextrect1 = [attributedString1 boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-10, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    
    
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50);
   
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,SCREEN_WIDTH*9/16 + 25 + 25 + 25 + 10 +contextrect.size.height + 30 + 60 + 10 +contextrect.size.height + 30 + 40 +30 +10 +contextrect1.size.height);
    [self.view addSubview:_scrollView];
    
    
    // 150;
    _imageView = ({
        UIImageView *imageview= [[UIImageView alloc]init];
        [_scrollView addSubview:imageview];
        imageview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*9/16);
        [imageview setImageWithURL:[NSURL URLWithString:self.storemodel.goods_image]];
        imageview;
    });
    //20+5
    _priceLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        [_scrollView addSubview:label];
        CGSize priceLabelSize = [[NSString stringWithFormat:@"%@",self.storemodel.price] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
        label.frame = CGRectMake(5, CGRectGetMaxY(_imageView.frame)+5, priceLabelSize.width, 20);
        label.text = [NSString stringWithFormat:@"%@",self.storemodel.price];
        label;
    });
    //20+5
    _nameLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor colorWithRed:0/255.0f green:122.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
        [_scrollView addSubview:label];
        CGSize nameLabelSize = [[NSString stringWithFormat:@"%@",self.storemodel.goods_name] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
        label.frame = CGRectMake(5, CGRectGetMaxY(_priceLabel.frame)+5, nameLabelSize.width, 20);
        label.text = [NSString stringWithFormat:@"%@",self.storemodel.goods_name];
        label;
    });
    //20+5
    _miaoShuLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        [_scrollView addSubview:label];
        label.frame = CGRectMake(5, CGRectGetMaxY(_nameLabel.frame)+5, 70, 20);
        label.text = @"商品描述";
        label;
    });
    //10+contextrect.size.height
    _miaoShuContent = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        label.numberOfLines = 0;
        [_scrollView addSubview:label];
        label.frame = CGRectMake(5, CGRectGetMaxY(_miaoShuLabel.frame)+10, SCREEN_WIDTH-10, contextrect.size.height);
        label.text = [self.storemodel.brand_info objectForKey:@"brand_desc"];
        label;
    });
    //10+20
    _tuiJianLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        [_scrollView addSubview:label];
        label.frame = CGRectMake(5, CGRectGetMaxY(_miaoShuContent.frame)+10, 70, 20);
        label.text = @"推荐自";
        label;
    });
    
    //10+50
    _headerImage = ({
        UIImageView *header = [[UIImageView alloc]init];
        [_scrollView addSubview:header];
        header.frame = CGRectMake(5, CGRectGetMaxY(_tuiJianLabel.frame)+10, 50, 50);
        //        header.userInteractionEnabled = YES;
        header.image = [UIImage imageNamed:@"5.jpg"];
        header.layer.masksToBounds = YES;
        header.layer.cornerRadius = 25;
        header;
    });
    _jingXLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        [_scrollView addSubview:label];
        label.frame = CGRectMake(CGRectGetMaxX(_headerImage.frame)+10, CGRectGetMaxY(_tuiJianLabel.frame)+25, 70, 20);
        label.text = @"良仓精选";
        label;
    });
    
    // 10+contextrect.size.height
    _detailLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        label.numberOfLines = 0;
        [_scrollView addSubview:label];
        label.frame = CGRectMake(5, CGRectGetMaxY(_headerImage.frame)+10, SCREEN_WIDTH-10, contextrect.size.height);
        label.text = [self.storemodel.brand_info objectForKey:@"brand_desc"];
        label;
    });
    /*
     UILabel *_pingPaiLabel;
     UILabel *_miniLabel;
     UILabel *_buyWayLabel;
     UILabel *_cccLabel;
     */
    
    // 20+10
    _pingPaiLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        [_scrollView addSubview:label];
        label.frame = CGRectMake(5, CGRectGetMaxY(_detailLabel.frame)+10, 70, 20);
        label.text = @"商品品牌";
        label;
    });
    
    //10+30
    _miniLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.textColor = [UIColor colorWithRed:0/255.0f green:122.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
        [_scrollView addSubview:label];
        CGSize miniLabelSize = [[NSString stringWithFormat:@"%@",self.storemodel.goods_name] sizeWithAttributes:@{                                                                                                                  NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}];
        label.frame = CGRectMake(8, CGRectGetMaxY(_pingPaiLabel.frame)+10, miniLabelSize.width, 30);
        label.text = [NSString stringWithFormat:@"%@",self.storemodel.goods_name];
        label;
    });
    //10+20
    _buyWayLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        [_scrollView addSubview:label];
        label.frame = CGRectMake(5, CGRectGetMaxY(_miniLabel.frame)+10, 70, 20);
        label.text = @"购物指南";
        label;
    });
    //5+contextrect1.size.height
    _cccLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        label.numberOfLines = 0;
        [_scrollView addSubview:label];
        
        label.frame = CGRectMake(5, CGRectGetMaxY(_buyWayLabel.frame)+5, SCREEN_WIDTH-10, contextrect1.size.height);
        label.text = str;
        label;
    });
    
    
    _addTocarBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-50-64, SCREEN_WIDTH/2,50);
        [btn setTitle:@"直接购买" forState:UIControlStateNormal];
                btn.titleLabel.textColor = [UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
                btn.backgroundColor = [UIColor colorWithRed:128.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:10.0f];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    _zhiJieGouMaiBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(0, SCREEN_HEIGHT-50-64, SCREEN_WIDTH/2,50);
        [btn setTitle:@"加入购物车" forState:UIControlStateNormal];
                [btn setTintColor:[UIColor whiteColor]];
                btn.backgroundColor = [UIColor colorWithRed:128.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:10.0f];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn addTarget:self action:@selector(btnssss:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    

}

- (void)btnAction1:(UIButton *)btn
{
    NSLog(@"直接购买");
    PayViewController *pay = [[PayViewController alloc]init];
    pay.paymodel = self.storemodel;
    
    [self.navigationController pushViewController:pay animated:YES];
}

- (void)btnssss:(UIButton *)btn
{
    NSLog(@"");
    _isSelelcted = !_isSelelcted;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (_isSelelcted) {
        [btn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [ud removeObjectForKey:self.storemodel.goods_id];
        [ud synchronize];
        
    }else{
        [btn setTitle:@"取消加入" forState:UIControlStateNormal];
        StoreModel *model = self.storemodel;
        NSString *idd = model.goods_id;
        
        
        [[SingleTon sharedSingleTon].iddarr addObject:idd];
        NSString *price = self.storemodel.price;
        NSString *name = self.storemodel.goods_name;
        NSString *imageurl = [self.storemodel.brand_info objectForKey:@"brand_logo"];
        
        _busSource = @[price,name,imageurl];
        [ud setObject:_busSource forKey:idd];
        [ud synchronize];
        
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
