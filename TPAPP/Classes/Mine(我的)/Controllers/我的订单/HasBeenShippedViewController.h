//
//  HasBeenShippedViewController.h
//  TPAPP
//
//  Created by Frank on 2018/12/5.
//  Copyright © 2018 cbl－　点硕. All rights reserved.
//

#import "BaseViewController.h"
#import "MineIndentViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface HasBeenShippedViewController : BaseViewController<HasBeenShippedDelegate>
@property (nonatomic, assign)NSInteger selectCtrl;
@property (nonatomic, assign)BOOL pushCtrl;
@end

NS_ASSUME_NONNULL_END
