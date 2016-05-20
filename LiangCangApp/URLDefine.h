//
//  URLDefine.h
//  LiangCangApp
//
//  Created by MS on 15/10/12.
//  Copyright © 2015年 WS. All rights reserved.
//

#ifndef URLDefine_h
#define URLDefine_h

// 注册通知Name
#define NSNotificationName @"NSNotificationName"
#define NSNotificationName2 @"NSNotificationName2"

// 标识
#define Identifier @"cellID"


// 杂志主界面
#define MagazineUrlString @"http://app.iliangcang.com/topic/listinfo?app_key=Android&build=2015091501&v=1.0"

//商店

#define shop_mainURL @"http://api.iliangcang.com/i/appshophome?app_key=iphone&build=170&osVersion=93&v=2.5.0"

//商店专题

#define shop_Maga_URL @"http://api.iliangcang.com/i/appshopmaga?app_key=iphone&build=170&osVersion=93&v=2.5.0"
//粮仓清单
#define ShopList_url @"http://www.iliangcang.com/i/topicapp/201510122623"
//上面的4个按钮

#define  FourBtn_url @"http://app.iliangcang.com/goods/class?app_key=iphone&build=148&count=12&coverId=%ld&osVersion=71&page=%ld"

#define home__Url  @"http://app.iliangcang.com/goods/class?app_key=iphone&build=170&cat_code=0002001%ld&count=12&list_id=222&osVersion=93&page=%ld&self_host=1&v=2.5.0"

//礼物
#define Present_url @"http://app.iliangcang.com/goods/class?app_key=iphone&build=170&cat_code=0005000%ld&count=12&list_id=222&osVersion=93&page=%ld&self_host=1&v=2.5.0"
//服饰
#define Clothe_url @"http://app.iliangcang.com/goods/class?app_key=iphone&build=170&cat_code=000%ld&count=12&list_id=222&osVersion=93&page=%ld&self_host=1&v=2.5.0"
//家居
#define Home_url @"http://app.iliangcang.com/goods/class?app_key=iphone&build=148&cat_code=0002001%ld&count=12&osVersion=71&page=%ld"

// 购买

#define store_pay_detail @"http://app.iliangcang.com/goods?app_key=iphone&build=170&goods_id=249842&osVersion=93&v=2.5.0"

//艺术
#define ART_url @"http://app.iliangcang.com/goods/class?app_key=iphone&build=170&cat_code=0003001%ld&count=12&list_id=222&osVersion=93&page=%ld&self_host=1&v=2.5.0"

//其他
#define Other_url @" http://app.iliangcang.com/goods/class?app_key=iphone&build=170&cat_code=000400%ld&count=12&list_id=222&osVersion=93&page=%ld&self_host=1&v=2.5.0"

#define LCStoreDetail_URL @"http://api.iliangcang.com/i/appshopgoods?app_key=iphone&build=170&count=12&list_id=%ld&page=%ld&self_host=1&v=2.5.0"
//拼接
#define Path @"&self_host=1&sig=347531465%7C3c227abfa2e1ecfda1bc055c53e5ab0d5705a301&user_id=347531465&v=2.2.5"

//价格

#define price_url @"http://app.iliangcang.com/goods/class?app_key=iphone&build=148&cat_code=00050006&count=20&max=%ld&min=0&orderby=price&osVersion=71&page=%ld"
//购买界面

#define Sale_url @"http://app.iliangcang.com/goods?app_key=iphone&build=148&goods_id=%ld"
#define Sale_path @"&osVersion=71&sig=347531465%7C3c227abfa2e1ecfda1bc055c53e5ab0d5705a301&user_id=347531465&v=2.2.5"


// 分享(Share)主界面    实现刷新功能
#define ShareUrlString @"http://app.iliangcang.com/goods/class?type=%ld&app_key=Android&build=2015092501&count=20&page=%ld&self_host=0&v=1.0"

// 分享 抽屉 价格

#define PriceUrlString @"http://app.iliangcang.com/goods/class?type=15goods/class?type=100&orderby=price&min=%ld&max=%ld&app_key=Android&build=2015091501&count=20&page=%ld&self_host=0&v=1.0"

// 分享详情页面(子页面) 评论
#define ShareDetailUrlStr @"http://app.iliangcang.com/goods/commentsnew?app_key=Android&build=2015091501&count=3&goods_id=%@&page=1&v=1.0"
// 分享详情(子页面) 列表 Header
#define  ShareDetailHeaderUrlStr @"http://app.iliangcang.com/goods?app_key=Android&build=2015091501&goods_id=%@&v=1.0"

// 分享详情子页面  user 信息 4个网址 分别对应 喜欢 推荐 关注 粉丝
// 喜欢
#define UserLikeUrlStr @"http://app.iliangcang.com/user/like?app_key=Android&build=2015091501&count=18&owner_id=%@&page=1&v=1.0"
// 推荐
#define UserRecommendUrlStr @"http://app.iliangcang.com/user/recommendation?app_key=Android&build=2015091501&count=18&owner_id=%@&page=1&v=1.0"
// 关注
#define UserFollowingUrlStr @"http://app.iliangcang.com/user/following?app_key=Android&build=2015091501&count=18&owner_id=%@&page=1&v=1.0"

// 粉丝
#define UserFollowedUrlStr @"http://app.iliangcang.com/user/followed?app_key=Android&build=2015091501&count=18&owner_id=%@&page=1&v=1.0"


// 达人(Expert)主界面
#define ExpertUrlString @"http://app.iliangcang.com/expert?app_key=Android&build=2015091501&count=18&page=%ld&v=1.0"

#endif /* URLDefine_h */
