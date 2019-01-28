//
//  MyCouponsCell.h
//  TPAPP
//
//  Created by Frank on 2019/1/21.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCouponsCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *bgImageview;

@property (strong, nonatomic)  UILabel *couponsLabel;
@property (strong, nonatomic)  UILabel *couponsTypeLabel;
@property (strong, nonatomic)  UILabel *detailLabel;

@property (strong, nonatomic)  UIImageView *rightImageview;

@property (strong, nonatomic)  UILabel *moneyLabel;
@property (strong, nonatomic)  UILabel *merchantNameLabel;
@property (strong, nonatomic)  UILabel *dateTimeLabel;
@end

NS_ASSUME_NONNULL_END
