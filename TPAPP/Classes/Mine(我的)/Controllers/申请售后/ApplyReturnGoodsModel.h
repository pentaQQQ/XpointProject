//
//  ApplyReturnGoodsModel.h
//  TPAPP
//
//  Created by Frank on 2018/12/13.
//  Copyright © 2018 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ApplyReturnDetailResultModel,ApplyReturnGoodsImagesModel;
@interface ApplyReturnGoodsModel : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *orderNo;
@property (nonatomic, copy)NSString *orderDetailId;
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *state;
@property (nonatomic, copy)NSString *productStatus;
@property (nonatomic, copy)NSString *why;
@property (nonatomic, copy)NSString *checkStatus;
@property (nonatomic, copy)NSString *auditTime;

@property (nonatomic, copy)NSString *auditWhy;
@property (nonatomic, copy)NSString *remark;
@property (nonatomic, copy)NSString *createDataTime;
@property (nonatomic, strong)NSMutableArray<ApplyReturnDetailResultModel*> *detailResult;
@property (nonatomic, strong)NSMutableArray<ApplyReturnGoodsImagesModel*> *images;

@end
@interface ApplyReturnDetailResultModel : NSObject
@property (nonatomic, copy)NSString *startDate;
@property (nonatomic, copy)NSString *endDate;
@property (nonatomic, copy)NSString *isDelete;
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *orderId;
@property (nonatomic, copy)NSString *productId;
@property (nonatomic, copy)NSString *specId;
@property (nonatomic, copy)NSString *size;
@property (nonatomic, copy)NSString *productName;
@property (nonatomic, copy)NSString *productAmount;
@property (nonatomic, strong)NSString *productImg;
@property (nonatomic, copy)NSString *productDesc;
@property (nonatomic, copy)NSString *discountRate;
@property (nonatomic, assign)double discountAmount;
@property (nonatomic, assign)long number;
@property (nonatomic, assign)double totalAmount;
@property (nonatomic, copy)NSString *remark;
@property (nonatomic, copy)NSString *createDataTime;
@property (nonatomic, copy)NSString *lastUpdTime;
@property (nonatomic, copy)NSString *returnStatus;

@end
@interface ApplyReturnGoodsImagesModel : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *businessId;
@property (nonatomic, copy)NSString *imgUrl;
@end

