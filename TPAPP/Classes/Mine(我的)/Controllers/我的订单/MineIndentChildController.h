//
//  MineIndentChildController.h
//  TPAPP
//
//  Created by Frank on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineBaseController.h"
#import "BaseViewController.h"
#import "MineIndentViewController.h"
@interface MineIndentChildController : BaseViewController<SelecteNumberDelegate>
@property (nonatomic, assign)NSInteger selectCtrl;
@end
