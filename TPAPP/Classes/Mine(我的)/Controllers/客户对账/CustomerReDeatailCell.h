//
//  CustomerReDeatailCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerReDeatailCell : UITableViewCell
/**
 *  左侧位置icon
 */
@property (nonatomic, retain)UIImageView *goodImageView;
/**
 *  名称
 */
@property (nonatomic, retain)UILabel *goodName;
/**
 *  尺码
 */
@property (nonatomic, retain)UILabel *goodSize;
/**
 *  款式
 */
@property (nonatomic, retain)UILabel *goodStyle;
/**
 *  款号
 */
@property (nonatomic, retain)UILabel *goodStyleNumber;
/**
 *  条码
 */
@property (nonatomic, retain)UILabel *goodBarCode;
/**
 *  大小
 */
@property (nonatomic, retain)UILabel *buyGoodSize;
/**
 *  结算价格
 */
@property (nonatomic, retain)UILabel *buyGoodPrice;
/**
 *  购买状态
 */
@property (nonatomic, retain)UILabel *buyGoodStatus;


/**
 *  备注
 */
@property (nonatomic, retain)UILabel *RemarksLabel;
/**
 * 备注按钮
 */
@property (nonatomic, retain)UIButton *Remarks_button;
- (void)configWithModel:(NSMutableArray *)model;
@end
