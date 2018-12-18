//
//  MineIndentListCell.h
//  TPAPP
//
//  Created by frank on 2018/9/1.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineIndentModel.h"
@interface MineIndentListCell : UITableViewCell
@property (nonatomic, strong)UILabel *storeName;
@property (nonatomic, strong)UILabel *remarkLabel;
@property (nonatomic, strong)UIImageView *upLineView;
@property (nonatomic, strong)UIImageView *goodIcon;
@property (nonatomic, strong)UILabel *goodName;
@property (nonatomic, strong)UILabel *goodSize;
@property (nonatomic, strong)UIImageView *goodArrow;
@property (nonatomic, strong)UILabel *goodNumber;
@property (nonatomic, strong)UILabel *goodOrder;
@property (nonatomic, strong)UILabel *goodOrderNumber;
@property (nonatomic, strong)UILabel *allGoodNumber;
@property (nonatomic, strong)UILabel *paymentSum;
@property (nonatomic, strong)UILabel *allGoodPrice;
@property (nonatomic, strong)UILabel *goodStatus;
@property (nonatomic, strong)UIButton *lookLogisticsBtn;//查看物流
@property (nonatomic, strong)UIButton *mineReminderBtn;//我要催单
@property (nonatomic, strong)UIButton *collectGoodsBtn;//确认收货
@property (nonatomic, strong)UIButton *paymentBtn;//去付款
@property (nonatomic, strong)UIButton *cancelGoodsBtn;//取消付款
@property (nonatomic, strong)UIButton *deliverGoodsBtn;//提醒发货
@property (nonatomic, strong)UIImageView *downLineView;
@property (nonatomic, strong)OrderDetailModel *orderDetailModel;
@property (nonatomic, strong)void(^selectBlock)(NSInteger ,MineIndentListCell *);

-(void)configWithModel:(OrderDetailModel *)model andMineIndentModel:(MineIndentModel *)minModel;

@end
