//
//  GoodLogisticsHeaderView.h
//  TPAPP
//
//  Created by Frank on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodLogisticsModel.h"
@interface GoodLogisticsHeaderView : UIView
@property (nonatomic, strong)UIImageView *goodIcon;
@property (nonatomic, strong)UILabel *goodName;

@property (nonatomic, strong)UILabel *goodSizeTitle;
@property (nonatomic, strong)UILabel *goodSize;

@property (nonatomic, strong)UILabel *goodPrice;
@property (nonatomic, strong)UILabel *goodNumber;

@property (nonatomic, strong)UILabel *goodRemarkTitle;
@property (nonatomic, strong)UILabel *goodRemark;

@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UIImageView *expressIcon;
@property (nonatomic, strong)UILabel *expressName;
@property (nonatomic, strong)UILabel *expressNumberTtitle;
@property (nonatomic, strong)UILabel *expressNumber;
- (void)configWithModel:(GoodLogisticsModel *)model;
@end
