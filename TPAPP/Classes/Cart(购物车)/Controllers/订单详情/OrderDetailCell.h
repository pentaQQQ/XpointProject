//
//  OrderDetailCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailCell : UITableViewCell
@property (nonatomic, strong)UIImageView *goodIcon;
@property (nonatomic, strong)UILabel *goodName;

@property (nonatomic, strong)UILabel *goodSizeTitle;
@property (nonatomic, strong)UILabel *goodSize;

@property (nonatomic, strong)UILabel *goodPrice;
@property (nonatomic, strong)UILabel *goodNumber;

@property (nonatomic, strong)UILabel *goodRemarkTitle;
@property (nonatomic, strong)UILabel *goodRemark;
- (void)configWithModel:(NSMutableArray *)model;
@end

@interface OrderDetailAddressCell : UITableViewCell
/**
 *  左侧位置icon
 */
@property (nonatomic, retain)UIImageView *localImageView;
/**
 *
 */
@property (nonatomic, retain)UILabel *buyUserTitle;
/**
 *  姓名
 */
@property (nonatomic, retain)UILabel *buyUserName;
/**
 *  手机号
 */
@property (nonatomic, retain)UILabel *buyUserTelephone;
/**
 *
 */
@property (nonatomic, retain)UILabel *buyAddessTitle;
/**
 *  地址
 */
@property (nonatomic, retain)UILabel *buyUserAddess;
- (void)configWithModel:(NSMutableArray *)model;
@end

@interface OrderDetailMessageCell : UITableViewCell
@property (nonatomic, strong)UILabel *goodOrder;
@property (nonatomic, strong)UILabel *goodOrderNumber;

@property (nonatomic, strong)UIImageView *statusIcon;
@property (nonatomic, strong)UILabel *goodStatus;

@property (nonatomic, strong)UILabel *buyDate;
@property (nonatomic, strong)UILabel *buyGoodTime;
- (void)configWithModel:(NSMutableArray *)model;
@end
