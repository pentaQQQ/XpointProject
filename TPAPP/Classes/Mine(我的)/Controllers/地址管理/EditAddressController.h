//
//  EditAddressController.h
//  TPAPP
//
//  Created by Frank on 2018/8/22.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddressModel.h"
@interface EditAddressController : BaseViewController
@property (nonatomic, strong)AddressModel *addressModel;
@property (nonatomic, assign)BOOL isCartCtrl;
@end
