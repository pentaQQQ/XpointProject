//
//  API.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#ifndef API_h
#define API_h



//#define WeChateSecret   @"045dd77a293df7f7dc340fc69211d097"//微信开发者账号Secret
//#define WeChateappid    @"wx354bd4644a16d2e1"//微信开发者账号appid

#define WeChateSecret   @"112c2f14829cb6552c30e3ba9510d077"//微信开发者账号Secret
#define WeChateappid    @"wxe18e2ff7e93e4253"//微信开发者账号appid



#define kBaseUrl           @"http://47.92.193.30/"



//获取首页标签及内容
#define getMainResources [NSString stringWithFormat:@"%@%@",kBaseUrl,@"api/main/getMainResources"]

//根据活动查询商品信息，返回所有已上架商品
#define getProductByActivityId [NSString stringWithFormat:@"%@%@",kBaseUrl,@"api/main/getProductByActivityId"]

//获取验证码
#define getSecurityCode [NSString stringWithFormat:@"%@%@",kBaseUrl,@"api/eshopUser/send/login"]

//登陆
#define getlogin [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/eshopUser/login"]

//微信登陆
#define getweChatelogin [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/eshopUser/wxlogin"]

//注册
#define getreg [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/eshopUser/reg"]

//获取用户信息
#define getinfomation [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/eshopUser/"]

//获取用户转发配置
#define getUserForwardConfi [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/eshopUser/getUserForwardConfi"]

//获取商户列表
#define getMerchantList [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/main/getMerchantList"]

//根据商户查询商品信息,返回所有已上架商品
#define getProductByMerchantId [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/merchant/getProductByMerchantId"]
















//删除地址
#define deleteAddress [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/address/delete"]
//获取地址列表
#define getAddressList [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/address/list"]
//新增地址
#define saveAddress [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/address/save"]
//修改地址
#define updateAddress [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/address/update"]



#endif /* API_h */
