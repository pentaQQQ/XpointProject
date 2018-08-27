//
//  CartHeaderCell.h
//  TPAPP
//
//  Created by frank on 2018/8/26.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CartHeaderCell : UITableViewCell
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
 *地址管理按钮
 */
@property (nonatomic, retain)UIButton *address_button;
@property (nonatomic, strong)void(^selectBlock)(NSInteger);
@end
