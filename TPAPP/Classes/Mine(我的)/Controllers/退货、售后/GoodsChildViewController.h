//
//  GoodsChildViewController.h
//  TPAPP
//
//  Created by frank on 2018/8/25.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineBaseController.h"
#import "BaseViewController.h"

@interface GoodsChildViewController : BaseViewController<SelecteTypeNumberDelegate>
@property (nonatomic, assign)NSInteger selectCtrl;
@end
