//
//  ApplyDeatailCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyDeatailCell : UITableViewCell
@property (nonatomic, strong)UIImageView *goodIcon;
@property (nonatomic, strong)UILabel *goodName;
@property (nonatomic, strong)UILabel *goodSize;
@property (nonatomic, strong)UILabel *goodPrice;
@property (nonatomic, strong)UILabel *goodNumber;
@property (nonatomic, strong)UILabel *remarksLabel;

@property (nonatomic, strong)UILabel *remarksDeatail;

@property (nonatomic, strong)UIButton *downBtn;
- (void)configWithModel:(ApplyReturnGoodsModel *)minModel;
@end
