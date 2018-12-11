//
//  MineIndentViewController.h
//  TPAPP
//
//  Created by Frank on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineBaseController.h"
#import "BaseViewController.h"
@protocol SelecteNumberDelegate <NSObject>
- (void)selecteNumber:(NSInteger)index;
@end
//待支付
@protocol GenerationPaymentDelegate <NSObject>
- (void)selecteGenerationPayment:(NSInteger)index;
@end

//已支付
@protocol HavePayDelegate <NSObject>
- (void)selecteHavePay:(NSInteger)index;
@end

//待发货
@protocol WaitDeliveryDelegate <NSObject>
- (void)selecteWaitDelivery:(NSInteger)index;
@end

//已发货
@protocol HasBeenShippedDelegate <NSObject>
- (void)selecteHasBeenShipped:(NSInteger)index;
@end

//已完成
@protocol HasBeenCompletedDelegate <NSObject>
- (void)selecteHasBeenCompleted:(NSInteger)index;
@end
//已取消
@protocol HasBeenCancelledDelegate <NSObject>
- (void)selecteHasBeenCancelled:(NSInteger)index;
@end
//售后
@protocol AfterSalesDelegate <NSObject>
- (void)selecteAfterSales:(NSInteger)index;
@end

@interface MineIndentViewController : BaseViewController
@property (nonatomic, assign)NSInteger selectIndex;
// 在这里定义一个属性，注意这里的修饰词要用weak
@property(nonatomic,weak)id<SelecteNumberDelegate>selecteDelegate;
@property(nonatomic,weak)id<GenerationPaymentDelegate>generationPaymentDelegate;
@property(nonatomic,weak)id<HavePayDelegate>havePayDelegate;
@property(nonatomic,weak)id<WaitDeliveryDelegate>waitDeliveryDelegate;
@property(nonatomic,weak)id<HasBeenShippedDelegate>hasBeenShippedDelegate;
@property(nonatomic,weak)id<HasBeenCompletedDelegate>hasBeenCompletedDelegate;
@property(nonatomic,weak)id<HasBeenCancelledDelegate>hasBeenCancelledDelegate;
@property(nonatomic,weak)id<AfterSalesDelegate>afterSalesDelegate;
@property (nonatomic, assign)BOOL isPushCtrl;
@end
