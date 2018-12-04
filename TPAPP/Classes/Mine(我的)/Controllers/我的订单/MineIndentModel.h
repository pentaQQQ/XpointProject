//
//  MineIndentModel.h
//  TPAPP
//
//  Created by Frank on 2018/9/11.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderDetailModel;
@interface MineIndentModel : NSObject
@property (nonatomic, strong)AddressModel *addressInfo;
@property (nonatomic, copy)NSString *afterStatus;//用户售后状态 0 未发起售后 1 申请售后 3 售后已取消 4 处理中 5 处理完毕 ,
@property (nonatomic, copy)NSString *createDataTime;//创建时间 ,
@property (nonatomic, copy)NSString *deliveryTime;//发货时间 ,
@property (nonatomic, copy)NSString *escrowTradeNo;//第三方支付流水号 ,
@property (nonatomic, copy)NSString *id;//订单id(唯一主键) ,
@property (nonatomic, assign)double logisticsFee;//运费 ,
@property (nonatomic, copy)NSString *merchantId;//品牌商ID ,
@property (nonatomic, copy)NSString *merchantLogo;//品牌商LOGO ,
@property (nonatomic, copy)NSString *merchantName;//品牌商名称 ,
@property (nonatomic, assign)double orderAmountTotal;//订单实际付款金额 ,
@property (nonatomic, copy)NSString *orderLogistics;
@property (nonatomic, copy)NSString *orderSettlementStatus;//订单结算状态 0未结算 1已结算 ,
@property (nonatomic, copy)NSString *payChannel;//支付渠道 0余额 1微信 2支付宝 ,
@property (nonatomic, copy)NSString *payTime;//付款时间 ,
@property (nonatomic, assign)double productAmountTotal;//商品总金额 ,
@property (nonatomic, assign)long productCount;//商品数量 ,
@property (nonatomic, copy)NSString *status;//订单状态 0未付款,1已付款,2已发货,3已签收,-1退货申请,-2退货中,-3已退货,-4取消交易 -5退款申请 -6已退款
@property (nonatomic, copy)NSString *total;
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, strong)NSMutableArray<OrderDetailModel*> *orderDetailList;
@end

@interface OrderDetailModel : NSObject
@property (nonatomic, copy)NSString *createDataTime;
@property (nonatomic, assign)double discountAmount;
@property (nonatomic, copy)NSString *discountRate;
@property (nonatomic, copy)NSString *endDate;
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *isDelete;
@property (nonatomic, assign)long number;
@property (nonatomic, copy)NSString *orderId;
@property (nonatomic, copy)NSString *productAmount;
@property (nonatomic, copy)NSString *productDesc;
@property (nonatomic, copy)NSString *productId;
@property (nonatomic, copy)NSString *productImg;
@property (nonatomic, strong)NSString *productName;
@property (nonatomic, copy)NSString *remark;
@property (nonatomic, copy)NSString *returnStatus;
@property (nonatomic, copy)NSString *size;
@property (nonatomic, copy)NSString *specId;
@property (nonatomic, copy)NSString *startDate;
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, assign)double totalAmount;

@end
