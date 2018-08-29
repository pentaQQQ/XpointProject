//
//  CustomerReCell.h
//  TPAPP
//
//  Created by frank on 2018/8/28.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerReCell : UITableViewCell
/**
 *  左侧位置icon
 */
@property (nonatomic, retain)UIImageView *goodImageView;
/**
 *  姓名
 */
@property (nonatomic, retain)UILabel *goodName;
/**
 *  手机号
 */
@property (nonatomic, retain)UILabel *buyGoodDate;
- (void)configWithModel:(NSMutableArray *)model;
@end
