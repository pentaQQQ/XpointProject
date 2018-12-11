//
//  EditConsignmentAddressController.h
//  TPAPP
//
//  Created by frank on 2018/9/14.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressModel.h"
@interface EditConsignmentAddressController : BaseViewController
@property (nonatomic, strong)AddressModel *addressModel;
@property (nonatomic, assign)BOOL isCartCtrlType;
@end
