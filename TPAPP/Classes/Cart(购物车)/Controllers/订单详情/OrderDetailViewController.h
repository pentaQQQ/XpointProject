//
//  OrderDetailViewController.h
//  TPAPP
//
//  Created by Frank on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MineIndentModel.h"
@interface OrderDetailViewController : BaseViewController
@property (nonatomic, strong)MineIndentModel *model;
@property (nonatomic, assign)BOOL pushCtrl;
@end
