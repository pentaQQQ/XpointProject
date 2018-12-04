//
//  MouthPerformanceController.h
//  TPAPP
//
//  Created by Frank on 2018/12/4.
//  Copyright © 2018 cbl－　点硕. All rights reserved.
//

#import "BaseViewController.h"
#import "MineBaseController.h"
#import "MinePerformanceController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MouthPerformanceController : BaseViewController<SelecteMouthNumDelegate>
@property (nonatomic, assign)NSInteger firstCtrl;
@property (nonatomic, assign)NSInteger secondCtrl;
@end

NS_ASSUME_NONNULL_END
