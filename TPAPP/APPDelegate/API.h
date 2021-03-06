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
#define AliSchemeKey @"tianyangcangappalipay"
#define WeChateSecret   @"844ce927ffd81e5eee4c936e84c37da3"//微信开发者账号Secret
#define WeChateappid    @"wxf366f6ce13931de9"//微信开发者账号appid
#define QMChatSDKAppKey    @"5f12e670-c334-11e8-b0e0-5f753912b765"//七陌客服AppKey

//AppID  :wx32d968fae8531d0a   AppSecret:a5315115b905a26a31e02ad5659fa22a










//#define kBaseUrl           @"http://47.92.193.30/"
//#define kBaseUrl           @"https://pay.shty518.com"
#define kBaseUrl           @"http://pay.shty518.com:9999"








//获取首页标签及内容
#define getMainResources [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/main/getMainResources"]
//根据活动查询商品信息，返回所有已上架商品
#define getProductByActivityId [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/main/getProductByActivityId"]
//获取验证码
#define getSecurityCode [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/eshopUser/send/login"]
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
#define getProductByMerchantId [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/main/getProductByActivityId"]
//上传身份证信息
#define uploadIdeniti [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/eshopUser/ideniti"]
//上传身份证信息
#define fileUploadFile [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/file/uploadFile"]
//根据商户查询活动信息,前端拿到数据需判断活动结束时间
#define getActivityByMerchantId [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/merchant/getMerchantMain"]





//根据关键词和商户ID搜索商品,返回所有已上架商品
#define getsearchProductByKeyword [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/merchant/searchProductByKeyword"]

//获取转发的h5
#define geth5forgoods [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/merchant/getH5Address"]




//app退出登陆
#define getexit [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/eshopUser/exit"]
//编辑用户信息
#define editUserMessage [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/eshopUser/edit"]


//订单接口
//快递查询，传入物流公司代码，快递单号进行查询
#define getLogisticsInfo [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/order/LogisticsInfo"]
//取消订单 传入用户id，订单id
#define cancelOrderInfo [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/order/cancel"]
//确认收货 传入用户id 订单id
#define confirmReceipt [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/order/confirmReceipt"]
//获取订单详情，可通过订单id(必传)，用户id(必传)等查询
#define getOrderDetailInfo [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/order/detail"]
//获取所有订单信息，可通过用户id(必传字段)，订单号等查询
#define getOrderListInfo [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/order/list"]
//下单 基本数据必传
#define makeOrder [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/order/makeOrder"]
//订单支付 传入订单id 用户id 支付渠道(若为第三方支付，则传入第三方支付流水)
#define orderPayInfo [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/order/pay"]
//确认发货校验+计算支付运费 订单id集合，逗号隔开
#define confirmDelivery [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/order/confirmDelivery"]
//确认发货无需支付只改订单状态
#define confirmDeliverySubmit [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/order/confirmDeliverySubmit"]
//确认发货需要支付-微信
#define confirmDeliverySubmitPay [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/order/confirmDeliverySubmitPay"]
//确认发货需要支付-支付宝
#define confirmDeliverySubmitPayAli [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/order/confirmDeliverySubmitPayAli"]


//批量更新订单地址信息
#define updateOrderAddress [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/order/updateOrderAddress"]
//获取支付页面数据，订单id集合，逗号隔开
#define makeOrderDetail [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/order/makeOrderDetail"]

//获取首页轮播广告（已排序）
#define getAdvertising [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/main/getAdvertising"]
//申请售后的接口
//提交售后申请
#define orderReturnsApply [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/orderReturns/applyReturns"]
//取消售后
#define cancelOrderReturnsApply [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/orderReturns/cancelReturns"]
//获取售后列表
#define getOrderReturnsList [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/orderReturns/list"]

//获取售后详情
#define getReturnDetail [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/orderReturns/returnDetail"]

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

//业绩统计接口
#define transSumAmount [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/transSum/transSumAmount"]
//支付宝接口
#define aliPayByOrder [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/aliPay/getAliPayOrderStr"]
//微信接口
#define wechatPayByOrder [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/weixinPay/getWeChatPreyIdByOrder"]

//APP优惠券
//根据userId查询不可用优惠券
#define getUnuseCouponListByUserId [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/coupon/getUnuseCouponListByUserId"]
//根据userId查询可用优惠券
#define getUseCouponListByUserId [NSString stringWithFormat:@"%@%@",kBaseUrl,@"/api/coupon/getUseCouponListByUserId"]


#endif /* API_h */
