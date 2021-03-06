//
//  AddressTableViewCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/22.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
@interface AddressTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *localImageView;
@property (nonatomic,strong)UILabel *userNameLabel;
@property (nonatomic,strong)UILabel *iphoneLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UILabel *detailAddressLabel;

@property (nonatomic,strong)UIImageView *statusImageView;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIButton *editBtn;
@property (nonatomic,strong)UILabel *defaultLabel;
@property (nonatomic,strong)UIButton *defaultImageView;
@property (nonatomic,strong)void(^selectBlcok)(NSInteger, AddressModel *);
@property (nonatomic,strong)AddressModel *addressModel;
- (void)configWithModel:(AddressModel *)model withBool:(BOOL)isCartType;
@end
