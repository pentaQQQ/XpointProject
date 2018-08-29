//
//  CustomerReDeatailCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "CustomerReDeatailCell.h"

@implementation CustomerReDeatailCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}
///**
// *  左侧位置icon
// */
//@property (nonatomic, retain)UIImageView *goodImageView;
///**
// *  名称
// */
//@property (nonatomic, retain)UILabel *goodName;
///**
// *  尺码
// */
//@property (nonatomic, retain)UILabel *goodSize;
///**
// *  款式
// */
//@property (nonatomic, retain)UILabel *goodStyle;
///**
// *  款号
// */
//@property (nonatomic, retain)UILabel *goodStyleNumber;
///**
// *  条码
// */
//@property (nonatomic, retain)UILabel *goodBarCode;
///**
// *  大小
// */
//@property (nonatomic, retain)UILabel *buyGoodSize;
///**
// *  结算价格
// */
//@property (nonatomic, retain)UILabel *buyGoodPrice;
///**
// *  购买状态
// */
//@property (nonatomic, retain)UILabel *buyGoodStatus;
//
//
///**
// *  备注
// */
//@property (nonatomic, retain)UILabel *RemarksLabel;
///**
// * 备注按钮
// */
//@property (nonatomic, retain)UIButton *Remarks_button;

- (void)createUI
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    self.goodImageView = [[UIImageView alloc] init];
//    self.goodImageView.backgroundColor = [UIColor grayColor];
//    [self.contentView addSubview:self.goodImageView];
//    self.goodImageView.sd_layout
//    .topSpaceToView(self.contentView, 10)
//    .leftSpaceToView(self.contentView, 10)
//    .widthIs(80)
//    .heightIs(80);
//    
//    self.goodName = [[UILabel alloc] init];
//    self.goodName.text = @"¥1000";
//    self.goodName.textAlignment = NSTextAlignmentRight;
//    self.goodName.textColor = colorWithRGB(0xFF6B24);
//    self.goodName.font = [UIFont systemFontOfSize:14];
//    [self.contentView addSubview:self.goodName];
//    self.goodName.sd_layout
//    .topSpaceToView(self.contentView, 15)
//    .rightSpaceToView(self.contentView, 15)
//    .widthIs(100)
//    .heightIs(20);
    
}


-(void)configWithModel:(NSMutableArray *)model{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
