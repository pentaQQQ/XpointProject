//
//  GoodLogisticsModel.h
//  TPAPP
//
//  Created by Frank on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LogisticsListModel;
@interface GoodLogisticsModel : NSObject

/**
 商品图片
 */
@property (nonatomic, strong)NSString *goodIcon;

/**
 商品名称
 */
@property (nonatomic, strong)NSString *goodName;

/**
 商品尺码
 */
@property (nonatomic, strong)NSString *goodSize;

/**
 商品价格
 */
@property (nonatomic, strong)NSString *goodPrice;

/**
 商品个数
 */
@property (nonatomic, strong)NSString *goodNumber;


/**
 备注
 */
@property (nonatomic, strong)NSString *goodRemark;


/**
 快递logo
 */
@property (nonatomic, strong)NSString *expressIcon;

/**
 快递名称
 */
@property (nonatomic, strong)NSString *expressName;

/**
 快递单号
 */
@property (nonatomic, strong)NSString *expressNumber;
@property (nonatomic, strong)NSMutableArray<LogisticsListModel*>*listArray;
/**
 是否展开
 */
@property (nonatomic, assign)BOOL isShow;
@end
@interface LogisticsListModel : NSObject
/**
 运输时间
 */
@property (nonatomic, strong)NSString *expressDate;

/**
 运输状态
 */
@property (nonatomic, strong)NSString *expressStatus;

/**
 运输地址
 */
@property (nonatomic, strong)NSString *expressAddress;
/**
 是否签收
 */
@property (nonatomic, assign)BOOL isReceived;

@end
