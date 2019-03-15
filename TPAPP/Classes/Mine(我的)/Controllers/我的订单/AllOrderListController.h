//
//  AllOrderListController.h
//  TPAPP
//
//  Created by Frank on 2019/3/11.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import "BaseViewController.h"
#import "MineIndentViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface AllOrderListController : BaseViewController<AllOrderListDelegate>
@property (nonatomic, assign)NSInteger selectCtrl;
@property (nonatomic, assign)BOOL pushCtrl;
@end

NS_ASSUME_NONNULL_END
