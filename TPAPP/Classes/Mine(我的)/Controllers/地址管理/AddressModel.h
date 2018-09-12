//
//  AddressModel.h
//  TPAPP
//
//  Created by frank on 2018/9/2.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

/**
 创建时间
 */
@property (nonatomic, copy)NSString *createDataTime;

@property (nonatomic, copy)NSString *endDate;

/**
 地址id,新增时不传入
 */
@property (nonatomic, copy)NSString *id;

/**
 默认收货地址 0-不是默认 1-默认
 */
@property (nonatomic, copy)NSString *isDefault;

/**
 是否删除
 */
@property (nonatomic, copy)NSString *isDelete;
/**
 是否代发地址 :0-普通地址 1-代发
 */
@property (nonatomic, copy)NSString *isGeneration;

/**
  更新时间
 */
@property (nonatomic, copy)NSString *lastUpdTime;

/**
  收件人地址
 */
@property (nonatomic, copy)NSString *recAddress;

/**
  收件人区
 */
@property (nonatomic, copy)NSString *recArea;

/**
 收件人市
 */
@property (nonatomic, copy)NSString *recCity;

/**
  收件人身份证号
 */
@property (nonatomic, copy)NSString *recIdentityCardNo;

/**
  收件人姓名
 */
@property (nonatomic, copy)NSString *recNickName;

/**
  收件人手机号
 */
@property (nonatomic, copy)NSString *recPhone;

/**
  收件人省
 */
@property (nonatomic, copy)NSString *recProv;

/**
 寄件人地址
 */
@property (nonatomic, copy)NSString *senderAddress;

/**
  寄件人区
 */
@property (nonatomic, copy)NSString *senderArea;

/**
  寄件人市
 */
@property (nonatomic, copy)NSString *senderCity;

/**
  寄件人身份证号
 */
@property (nonatomic, copy)NSString *senderIdentityCardNo;

/**
  寄件人姓名
 */
@property (nonatomic, copy)NSString *senderNickName;

/**
  寄件人手机号
 */
@property (nonatomic, copy)NSString *senderPhone;

/**
  寄件人省
 */
@property (nonatomic, copy)NSString *senderProv;

/**
 
 */
@property (nonatomic, copy)NSString *startDate;

/**
 用户ID
 */
@property (nonatomic, copy)NSString *userId;

+ (instancetype)statusWithDict:(NSDictionary *)dict;
@end
