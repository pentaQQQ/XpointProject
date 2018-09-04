//
//  SimilarProductModel.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimilarProductModel : NSObject<MJKeyValue>

@property(nonatomic,copy)NSString *design;
@property(nonatomic,copy)NSString *designCode;
@property(nonatomic,copy)NSString *discountAmount;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,strong)NSArray *imagesList;
@property(nonatomic,copy)NSString *logisticsFee;
@property(nonatomic,copy)NSString *marketAmount;
@property(nonatomic,copy)NSString *merchantCode;
@property(nonatomic,copy)NSString *merchantId;
@property(nonatomic,copy)NSString *merchantName;
@property(nonatomic,copy)NSString *productCode;
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *realAmount;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,strong)NSArray *specs;
@property(nonatomic,copy)NSString *status;

@end
