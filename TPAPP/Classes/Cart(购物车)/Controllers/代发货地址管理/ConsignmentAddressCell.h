//
//  ConsignmentAddressCell.h
//  TPAPP
//
//  Created by frank on 2018/9/14.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
@interface ConsignmentAddressCell : UITableViewCell
@property (nonatomic,strong)UIImageView *recLocalImageView;
@property (nonatomic,strong)UILabel *recUserNameLabel;
@property (nonatomic,strong)UILabel *recIphoneLabel;
@property (nonatomic,strong)UILabel *recAddressLabel;
@property (nonatomic,strong)UILabel *recDetailAddressLabel;
@property (nonatomic,strong)UIImageView *recStatusImageView;
@property (nonatomic,strong)UIView *topLineView;

@property (nonatomic,strong)UIImageView *sendLocalImageView;
@property (nonatomic,strong)UILabel *sendUserNameLabel;
@property (nonatomic,strong)UILabel *sendIphoneLabel;
@property (nonatomic,strong)UILabel *sendAddressLabel;
@property (nonatomic,strong)UILabel *sendDetailAddressLabel;
@property (nonatomic,strong)UIImageView *sendStatusImageView;
@property (nonatomic,strong)UIView *bottomLineView;


@property (nonatomic,strong)UIButton *editBtn;
@property (nonatomic,strong)UILabel *defaultLabel;
@property (nonatomic,strong)UIButton *defaultImageView;
@property (nonatomic,strong)void(^selectBlcok)(NSInteger, AddressModel *);
@property (nonatomic,strong)AddressModel *addressModel;
- (void)configWithModel:(AddressModel *)model withBool:(BOOL)isCartType;
@end
