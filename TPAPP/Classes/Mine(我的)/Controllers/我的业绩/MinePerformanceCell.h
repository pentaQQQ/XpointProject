//
//  MinePerformanceCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/23.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerformanceModel.h"
@interface MinePerformanceCell : UITableViewCell
@property (nonatomic, strong)UILabel *dateLabel;
@property (nonatomic, strong)UILabel *marketLabel;
@property (nonatomic, strong)UILabel *buyLabel;
- (void)configWithModel:(PerformanceModel *)model;
@end
