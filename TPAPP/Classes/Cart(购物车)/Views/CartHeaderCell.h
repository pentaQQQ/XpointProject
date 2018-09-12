//
//  CartHeaderCell.h
//  TPAPP
//
//  Created by frank on 2018/8/26.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddressModel.h"
@interface CartHeaderCell : UITableViewCell
///**
// *  左侧标记线
// */
//@property (nonatomic, retain)UIImageView *lineImageView;
///**
// *  代购编号
// */
//@property (nonatomic, retain)UILabel *buyLabel;
///**
// *  编号
// */
//@property (nonatomic, retain)UILabel *buy_number;
///**
// *  回收清单按钮
// */
//@property (nonatomic, retain)UIButton *retureList;
///**
// *地址管理按钮
// */
//@property (nonatomic, retain)UIButton *address_button;
//@property (nonatomic, strong)void(^selectBlock)(NSInteger);
@end

@interface CartHeaderAddressCell : UITableViewCell

/**
 *  左侧标记线
 */
@property (nonatomic, retain)UIImageView *lineImageView;
/**
 *  代购编号
 */
@property (nonatomic, retain)UILabel *buyLabel;
/**
 *  编号
 */
@property (nonatomic, retain)UILabel *buy_number;
/**
 *  回收清单按钮
 */
@property (nonatomic, retain)UIButton *retureList;

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
 *  地址
 */
@property (nonatomic, retain)UILabel *buyUserAddess;
/**
 *  分割线
 */
@property (nonatomic, retain)UIView *lineView;
/**
 *  地址
 */
@property (nonatomic, retain)UILabel *getAddess;

/**
 *  选择地址
 */
@property (nonatomic, retain)UIControl *chooseAddress;

@property (nonatomic, strong)void(^selectButtonBlock)(NSInteger);
-(void)withData:(LYAccount *)info;

@end
