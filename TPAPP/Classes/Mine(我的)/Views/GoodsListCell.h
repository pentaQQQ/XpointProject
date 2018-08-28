//
//  GoodsListCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/24.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsListCell : UITableViewCell
@property (nonatomic, strong)UIImageView *goodIcon;
@property (nonatomic, strong)UILabel *goodName;
@property (nonatomic, strong)UILabel *goodSize;
@property (nonatomic, strong)UILabel *goodPrice;
@property (nonatomic, strong)UILabel *goodNumber;
@property (nonatomic, strong)UILabel *goodOrder;
@property (nonatomic, strong)UILabel *goodOrderNumber;
@property (nonatomic, strong)UILabel *allGoodNumber;
@property (nonatomic, strong)UILabel *paymentSum;
@property (nonatomic, strong)UILabel *allGoodPrice;
@property (nonatomic, strong)UILabel *goodStatus;
@property (nonatomic, strong)UIButton *applyBtn;
@property (nonatomic, strong)UIView *upLineView;
@property (nonatomic, strong)UIView *downLineView;

@property (nonatomic, strong)void(^selectBlock)(GoodsListCell *);

@end
