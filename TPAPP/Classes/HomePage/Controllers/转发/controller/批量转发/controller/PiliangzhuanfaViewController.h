//
//  PiliangzhuanfaViewController.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/9/7.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "BaseViewController.h"
#import "releaseActivitiesModel.h"
@interface PiliangzhuanfaViewController : BaseViewController

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *merchantId;

@property(nonatomic,strong)releaseActivitiesModel *model;
@end
