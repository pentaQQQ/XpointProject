//
//  GoodsCartModel.h
//  TPAPP
//
//  Created by frank on 2018/9/5.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimilarProductModel.h"
@class GoodsLikeModel,CartDetailsModel;
@interface GoodsCartModel : NSObject
/**
 *  id
 */
@property (nonatomic, copy)NSString *id;
/**
 *  购物明细列表
 */

@property (nonatomic, copy)NSArray <CartDetailsModel *>* cartDetails;
/**
 *  用户id
 */
@property (nonatomic, copy)NSString *userId;

/**
 *关注列表
 */
@property (nonatomic, copy)NSArray <GoodsLikeModel *>* likes;
@end


@interface GoodsLikeModel : NSObject

@property (nonatomic, copy)NSString *endDate;
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *isDelete;
@property (nonatomic, copy)SimilarProductModel* productForm;//产品form ,
@property (nonatomic, copy)NSString *productId;
@property (nonatomic, copy)NSString *sizes;
@property (nonatomic, copy)NSString *startDate;
@property (nonatomic, copy)NSString *userId;

@end


@interface CartDetailsModel : NSObject
@property (nonatomic, copy)NSString *amount;//价格
@property (nonatomic, copy)NSString *cartId ;//购物车ID
@property (nonatomic, copy)NSString *createDataTime;
@property (nonatomic, assign)NSInteger delNum; //删除一次加1，次数为2时不能重新添加回购物车 ,
@property (nonatomic, copy)NSString *endDate;
@property (nonatomic, copy)NSString *id;//购物车明细id ,
@property (nonatomic, copy)NSString *isDelete;//0-未删除 1删除 ,
@property (nonatomic, copy)NSString *lastUpdTime;
@property (nonatomic, copy)NSString *merchantId;//品牌商ID ,
@property (nonatomic, assign)NSInteger number;//商品数量 ,
@property (nonatomic, strong)SimilarProductModel* productForm;//产品form ,
@property (nonatomic, copy)NSString *productId;//商品ID ,
@property (nonatomic, copy)NSString *productImg;//商品快照 ,
@property (nonatomic, copy)NSString *productName;//商品名称 ,
@property (nonatomic, copy)NSString *remark;//下单备注 ,
@property (nonatomic, copy)NSString *size;//尺码 ,
@property (nonatomic, copy)NSString *specId;//规格ID ,
@property (nonatomic, copy)NSString *startDate;
@property (nonatomic, copy)NSString *status;//是否回收 0正常 1回收 ,
@property (nonatomic, copy)NSString *userId;//用户id


@property (nonatomic, copy)NSString *SelectedType;//未选中或已选中图标
@property (nonatomic, copy)NSString *Type;
@property (nonatomic, copy)NSString *CheckAll;
@property (nonatomic, copy)NSString *Edit;
@property (nonatomic, copy)NSString *EditBtn;
@end
              

              
              
              
              
              
              
              
