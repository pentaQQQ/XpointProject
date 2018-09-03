//
//  MinePerformanceChildController.h
//  TPAPP
//
//  Created by Frank on 2018/8/23.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineBaseController.h"
#import "BaseViewController.h"
#import "MinePerformanceController.h"
@interface MinePerformanceChildController : BaseViewController<SelecteNumDelegate>
@property (nonatomic, assign)NSInteger firstCtrl;
@property (nonatomic, assign)NSInteger secondCtrl;
@end
