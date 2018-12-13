//
//  ServiceTypeCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceTypeCell : UITableViewCell
@property (nonatomic, strong)UILabel *serviceType;
@property (nonatomic, strong)UIButton *retureGood;
@property (nonatomic, strong)UIButton *changeGood;
@property (nonatomic, strong)UIButton *retureMoney;
@property (nonatomic, strong)void(^selectTypeBlock)(ServiceTypeCell *,NSInteger );
- (void)configWithModel:(ApplyReturnGoodsModel *)minModel;
@end
