//
//  PerformaceHeaderCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/23.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerformaceHeaderCell : UITableViewCell
@property (nonatomic, strong)UILabel *marketTitleLabel;
@property (nonatomic, strong)UILabel *buyTitleLabel;
@property (nonatomic, strong)UILabel *allMoneyLabel;
@property (nonatomic, strong)UILabel *marketLabel;
@property (nonatomic, strong)UILabel *buyLabel;
- (void)configWithModel:(NSMutableArray *)arr;
@end
