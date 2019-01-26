//
//  BuyGoodsListController.h
//  TPAPP
//
//  Created by frank on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddressModel.h"
@interface BuyGoodsListController : BaseViewController
@property (nonatomic, strong)NSMutableArray *goodsListArray;
@property (nonatomic, strong)AddressModel *addressModel;
@property (nonatomic, strong)MineIndentModel *minModel;
@property (nonatomic, assign)int goodsNum;
@property (nonatomic, strong)NSString *goodsPrice;
@property (nonatomic, assign)NSInteger pushCtrl;

@property (nonatomic, strong)NSMutableArray *orderListArray;


@end
