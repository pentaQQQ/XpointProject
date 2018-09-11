//
//  MineIndentModel.h
//  TPAPP
//
//  Created by Frank on 2018/9/11.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineIndentModel : NSObject
@property (nonatomic, copy)NSString *afterStatus;//用户售后状态 0 未发起售后 1 申请售后 3 售后已取消 4 处理中 5 处理完毕 ,
@property (nonatomic, copy)NSString *createDataTime;//创建时间 ,
@property (nonatomic, copy)NSString *deliveryTime;//发货时间 ,
@property (nonatomic, copy)NSString *escrowTradeNo;//第三方支付流水号 ,
@property (nonatomic, copy)NSString *id;//订单id(唯一主键) ,
@property (nonatomic, copy)NSString *logisticsFee;//运费 ,
@property (nonatomic, copy)NSString *merchantId;//品牌商ID ,
@property (nonatomic, copy)NSString *merchantLogo;//品牌商LOGO ,
@property (nonatomic, copy)NSString *merchantName;//品牌商名称 ,
@property (nonatomic, copy)NSString *orderAmountTotal;//订单实际付款金额 ,
@property (nonatomic, copy)NSString *orderSettlementStatus;//订单结算状态 0未结算 1已结算 ,
@property (nonatomic, copy)NSString *payChannel;//支付渠道 0余额 1微信 2支付宝 ,
@property (nonatomic, copy)NSString *payTime;//付款时间 ,
@property (nonatomic, copy)NSString *productAmountTotal;//商品总金额 ,
@property (nonatomic, assign)long productCount;//商品数量 ,
@property (nonatomic, copy)NSString *status;//订单状态 0未付款,1已付款,2已发货,3已签收,-1退货申请,-2退货中,-3已退货,-4取消交易 -5退款申请 -6已退款

@end
