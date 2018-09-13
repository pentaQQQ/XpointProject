//
//  PayIndentCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/28.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPageTitleView.h"
@class ChangeAddressButton;
@interface PayIndentCell : UITableViewCell
/**
 *  左侧位置icon
 */
@property (nonatomic, retain)UIImageView *localImageView;
/**
 *  姓名
 */
@property (nonatomic, retain)UILabel *buyUserName;
/**
 *  手机号
 */
@property (nonatomic, retain)UILabel *buyUserTelephone;

/**
 *  默认图标
 */
@property (nonatomic, retain)UIImageView *defaultImageView;
/**
 * 切换地址按钮
 */
@property (nonatomic, retain)ChangeAddressButton *changeAddressBtn;
/**
 *  地址
 */
@property (nonatomic, retain)UILabel *buyUserAddess;
/**
 *  分割线
 */
@property (nonatomic, retain)UIView *lineView;
/**
 *  是否代发货
 */
@property (nonatomic, retain)UILabel *defaultLabel;
/**
 *  是否代发货
 */
@property (nonatomic, retain)UISwitch *defaultSwitch;

@property (nonatomic, strong)void(^selectBlock)(NSInteger);
@property (nonatomic,strong)AddressModel *model;
- (void)withAddressModel:(AddressModel *)model;


@end
@interface PayIndentDefaultCell : UITableViewCell
/**
 * 名称
 */
@property (nonatomic, retain)UILabel *titleLabel;
/**
 *  价格
 */
@property (nonatomic, retain)UILabel *priceLabel;

- (void)configWithModel:(NSMutableArray *)model;

@end
@interface PayIndentButtonCell : UITableViewCell
/**
 *  左侧图标
 */
@property (nonatomic, retain)UIImageView *payTypeImageView;
/**
 *  支付方式
 */
@property (nonatomic, retain)UILabel *payTypeLabel;
/**
 *  选择支付方式
 */
@property (nonatomic, retain)UIButton *choosePayTypeButton;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, copy) void(^qhxSelectBlock)(BOOL choice,NSInteger btntag);
- (void)configWithModel:(NSMutableArray *)model;
@end


@interface ChangeAddressButton : UIControl
/**
 *  图标
 */
@property (nonatomic, retain)UIImageView *changeAddressImageView;
/**
 *  支付方式
 */
@property (nonatomic, retain)UILabel *changeAddressLabel;


@end
