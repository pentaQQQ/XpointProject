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

//修改转发配置
#define updateUserForwardConfi [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/eshopUser/updateUserForwardConfi"]

//获取商户列表
#define getMerchantList [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/main/getMerchantList"]

//根据商户查询商品信息,返回所有已上架商品
#define getProductByMerchantId [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/merchant/getProductByMerchantId"]
<<<<<<< HEAD
//上传身份证信息
#define uploadIdeniti [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/eshopUser/ideniti"]
=======

//根据商户查询活动信息,前端拿到数据需判断活动结束时间
#define getActivityByMerchantId [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/merchant/getActivityByMerchantId"]

>>>>>>> a440277c99c2ec24dd0ea88d5406b3f4448b3f83














//申请售后的接口
//提交售后申请
#define orderReturnsApply [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/orderReturns/applyReturns"]
//取消售后
#define cancelOrderReturnsApply [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/orderReturns/cancelReturns"]
//获取售后列表
#define getOrderReturnsList [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/orderReturns/list"]





//购物车管理接口
//新增关注
#define cartAddLike [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/cart/addLike"]
//添加商品到购物车
#define cartAddProduct [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/cart/addProduct"]
//取消关注
#define cartCancelLike [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/cart/cancelLike"]
//删除购物车商品
#define cartDelProduct [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/cart/delProduct"]
//获取所有购物车信息,包含购物车信息，关注信息 回收列表
#define cartList [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/cart/list"]
//重新下单
#define cartReAddProduct [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/cart/reAddProduct"]
//备注
#define cartRemark [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/cart/remark"]








//地址管理接口
//删除地址
#define deleteAddress [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/address/delete"]
//获取地址列表
#define getAddressList [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/address/list"]
//新增地址
#define saveAddress [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/address/save"]
//修改地址
#define updateAddress [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/address/update"]

//邀请码接口
//注册邀请码
#define inviteAdd [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/invite/add"]

//获取邀请码列表
#define inviteList [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/invite/list"]



#endif /* API_h */
