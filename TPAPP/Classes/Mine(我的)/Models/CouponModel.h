//
//  CouponModel.h
//  TPAPP
//
//  Created by Frank on 2019/1/21.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CouponModel : NSObject
@property (nonatomic, copy)NSString *couponMerchantId;
@property (nonatomic, copy)NSString *couponMerchantName;
@property (nonatomic, copy)NSString *couponName;
@property (nonatomic, copy)NSString *couponProductId;
@property (nonatomic, copy)NSString *couponSn;
@property (nonatomic, copy)NSString *couponTime;
@property (nonatomic, copy)NSString *createBy;
@property (nonatomic, copy)NSString *createTime;
@property (nonatomic, copy)NSString *flag;
@property (nonatomic, assign)double discountMoney;
@property (nonatomic, copy)NSString *enableTime;
@property (nonatomic, copy)NSString *endDate;
@property (nonatomic, assign)double fullReduction;
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *isDelete;
@property (nonatomic, copy)NSString *isMerchant;
@property (nonatomic, copy)NSString *loseTime;
@property (nonatomic, copy)NSString *moreOrder;
@property (nonatomic, copy)NSString *orderLogistic;
@property (nonatomic, copy)NSDictionary *params;
@property (nonatomic, copy)NSString *remark;
@property (nonatomic, copy)NSString *searchValue;
@property (nonatomic, copy)NSString *startDate;
@property (nonatomic, copy)NSString *updateBy;
@property (nonatomic, copy)NSString *updateTime;
@end

NS_ASSUME_NONNULL_END
