//
//  LogisticsListTableViewCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodLogisticsModel.h"
@interface LogisticsListTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *expressIcon;
@property (nonatomic, strong)UILabel *expressDate;
@property (nonatomic, strong)UILabel *expressStatus;
@property (nonatomic, strong)UILabel *expressAddress;
- (void)configWithModel:(LogisticsListModel *)model;
@end
