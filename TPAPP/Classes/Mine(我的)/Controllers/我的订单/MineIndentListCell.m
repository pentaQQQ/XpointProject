//
//  MineIndentListCell.m
//  TPAPP
//
//  Created by frank on 2018/9/1.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "MineIndentListCell.h"

@implementation MineIndentListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
//    self.storeName = [[UILabel alloc] init];
//    self.storeName.textAlignment = NSTextAlignmentLeft;
//    self.storeName.textColor = colorWithRGB(0xFF6B24);
//    self.storeName.font = [UIFont systemFontOfSize:14];
//    [self.contentView addSubview:self.storeName];
//    self.storeName.sd_layout
//    .topSpaceToView(self.contentView, 10)
//    .leftSpaceToView(self.contentView, 15)
//    .widthIs(100)
//    .heightIs(20);
//
//    self.upLineView = [[UIImageView alloc] init];
//    self.upLineView.image = [UIImage imageNamed:@"我的订单_line"];
//    [self.contentView addSubview:self.upLineView];
//    self.upLineView.sd_layout
//    .topSpaceToView(self.storeName, 10)
//    .leftSpaceToView(self.contentView, 0)
//    .rightSpaceToView(self.contentView, 0)
//    .heightIs(1);
//
    
    
    self.goodIcon = [[UIImageView alloc] init];
    self.goodIcon.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.goodIcon];
    self.goodIcon.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(80)
    .heightIs(80);
    
//    self.goodArrow = [[UIImageView alloc] init];
//    self.goodArrow.image = [UIImage imageNamed:@"我的订单_07"];
//    [self.contentView addSubview:self.goodArrow];
//    self.goodArrow.sd_layout
//    .topSpaceToView(self.contentView, 10)
//    .rightSpaceToView(self.contentView, 15)
//    .widthIs(15.33)
//    .heightIs(20);
    self.storeName = [[UILabel alloc] init];
    self.storeName.textAlignment = NSTextAlignmentRight;
    self.storeName.text = @"¥1000";
    self.storeName.textColor = colorWithRGB(0xFF6B24);
    self.storeName.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.storeName];
    self.storeName.sd_layout
    .topSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:@"¥1000" withFont:12])
    .heightIs(15);
    
    
    
    self.goodName = [[UILabel alloc] init];
    self.goodName.text = @"花花公子男士上衣新款休闲";
    self.goodName.textColor = [UIColor blackColor];
    self.goodName.font = [UIFont systemFontOfSize:16];
    self.goodName.numberOfLines = 2;
    [self.contentView addSubview:self.goodName];
    self.goodName.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.goodIcon, 10)
    .rightSpaceToView(self.storeName, 10)
    .heightIs(20);
    self.goodSize = [[UILabel alloc] init];
    self.goodSize.text = @"规格: L码";
    
    self.goodSize.textColor = [UIColor grayColor];
    self.goodSize.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goodSize];
    self.goodSize.sd_layout
    .topSpaceToView(self.goodName, 10)
    .leftSpaceToView(self.goodIcon, 10)
    .widthIs(180)
    .heightIs(15);
    
    self.remarkLabel = [[UILabel alloc] init];
    self.remarkLabel.textAlignment = NSTextAlignmentLeft;
    self.remarkLabel.text = @"备注: 无";
    
    self.remarkLabel.textColor = colorWithRGB(0xFF6B24);
    self.remarkLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.remarkLabel];
    self.remarkLabel.sd_layout
    .topSpaceToView(self.goodSize, 10)
    .leftSpaceToView(self.goodIcon, 10)
    .rightSpaceToView(self.contentView, 30)
    .heightIs(20);
    
    
    self.goodNumber = [[UILabel alloc] init];
    self.goodNumber.textAlignment = NSTextAlignmentRight;
    self.goodNumber.text = @"x1";
    
    self.goodNumber.textColor = [UIColor grayColor];
    self.goodNumber.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goodNumber];
    self.goodNumber.sd_layout
    .topSpaceToView(self.goodName, 10)
    .leftSpaceToView(self.goodSize, 10)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(15);
    
    
    
    
    self.goodOrder = [[UILabel alloc] init];
    self.goodOrder.textAlignment = NSTextAlignmentLeft;
    self.goodOrder.text = @"订单号: ";
    self.goodOrder.textColor = [UIColor blackColor];
    self.goodOrder.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.goodOrder];
    self.goodOrder.sd_layout
    .topSpaceToView(self.goodIcon, 10)
    .leftSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:@"订单号: " withFont:13])
    .heightIs(10);
    
    
    
    self.allGoodPrice = [[UILabel alloc] init];
    self.allGoodPrice.textAlignment = NSTextAlignmentRight;
    self.allGoodPrice.text = @"¥10000元";
    
    self.allGoodPrice.textColor = colorWithRGB(0xFF6B24);
    self.allGoodPrice.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.allGoodPrice];
    self.allGoodPrice.sd_layout
    .topSpaceToView(self.goodIcon, 10)
    .rightSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:@"¥10000元" withFont:12])
    .heightIs(10);
    
    self.paymentSum = [[UILabel alloc] init];
    self.paymentSum.textAlignment = NSTextAlignmentRight;
    self.paymentSum.text = @"结算金额:";
    self.paymentSum.textColor = [UIColor blackColor];
    self.paymentSum.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.paymentSum];
    self.paymentSum.sd_layout
    .topSpaceToView(self.goodIcon, 10)
    .rightSpaceToView(self.allGoodPrice, 0)
    .widthIs([self widthLabelWithModel:@"结算金额:" withFont:13])
    .heightIs(10);
    
    self.allGoodNumber = [[UILabel alloc] init];
    self.allGoodNumber.textAlignment = NSTextAlignmentRight;
    self.allGoodNumber.text = @"共100件";
    self.allGoodNumber.textColor = [UIColor blackColor];
    self.allGoodNumber.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.allGoodNumber];
    self.allGoodNumber.sd_layout
    .topSpaceToView(self.goodIcon, 10)
    .rightSpaceToView(self.paymentSum, 5)
    .widthIs([self widthLabelWithModel:@"共100件" withFont:12])
    .heightIs(10);
    self.goodOrderNumber = [[UILabel alloc] init];
    self.goodOrderNumber.textAlignment = NSTextAlignmentLeft;
    self.goodOrderNumber.text = @"519581205461602304";
    
    self.goodOrderNumber.textColor = [UIColor blackColor];
    self.goodOrderNumber.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goodOrderNumber];
    self.goodOrderNumber.sd_layout
    .topSpaceToView(self.goodIcon, 10)
    .leftSpaceToView(self.goodOrder, 0)
    .rightSpaceToView(self.allGoodNumber, 5)
    .heightIs(10);
    
//    self.downLineView = [[UIImageView alloc] init];
//    self.downLineView.image = [UIImage imageNamed:@"我的订单_line"];
//    [self.contentView addSubview:self.downLineView];
//    self.downLineView.sd_layout
//    .topSpaceToView(self.goodOrder, 10)
//    .leftSpaceToView(self.contentView, 0)
//    .rightSpaceToView(self.contentView, 0)
//    .heightIs(0.5);
    
//    self.goodStatus = [[UILabel alloc] init];
//    self.goodStatus.textAlignment = NSTextAlignmentLeft;
//    self.goodStatus.textColor = colorWithRGB(0xFF6B24);
//    self.goodStatus.font = [UIFont systemFontOfSize:15];
//    [self.contentView addSubview:self.goodStatus];
//    self.goodStatus.sd_layout
//    .topSpaceToView(self.downLineView, 15)
//    .leftSpaceToView(self.contentView, 15)
//    .widthIs([self widthLabelWithModel:@"商家已发货" withFont:15])
//    .heightIs(20);
    
}
- (void)applyBtnAction
{
//    self.selectBlock(self);
}
#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString withFont:(NSInteger)font
{
    CGSize size = CGSizeMake(self.contentView.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width;
}

-(void)configWithModel:(OrderDetailModel *)model andMineIndentModel:(MineIndentModel *)minModel
{
    self.orderDetailModel = model;
    [self.paymentBtn removeFromSuperview];
    [self.cancelGoodsBtn removeFromSuperview];
    [self.deliverGoodsBtn removeFromSuperview];
    [self.collectGoodsBtn removeFromSuperview];
    [self.lookLogisticsBtn removeFromSuperview];
    [self.mineReminderBtn removeFromSuperview];
    [self.goodIcon sd_setImageWithURL:[NSURL URLWithString:model.productImg]];
    self.goodName.text = [NSString stringWithFormat:@"%@",model.productName];
    self.goodSize.text = [NSString stringWithFormat:@"规格: %@",model.size];
    self.goodNumber.text = [NSString stringWithFormat:@"x%ld",model.number];
    self.goodOrderNumber.text = model.orderId;
    self.allGoodPrice.text = [NSString stringWithFormat:@"%.2lf元",model.totalAmount];
    self.storeName.text = model.productAmount;
    self.allGoodNumber.text = [NSString stringWithFormat:@"共%ld件",model.number];
    if (model.remark.length != 0) {
        self.remarkLabel.text = [NSString stringWithFormat:@"备注:%@",model.remark];
    }
    
    

//    if ([minModel.status isEqualToString:@"0"]) {
//        self.goodStatus.text = @"待支付";
//        self.paymentBtn = [[UIButton alloc] init];
//        self.paymentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        self.paymentBtn.backgroundColor =colorWithRGB(0xFF6B24);
//        [self.paymentBtn setTitle:@"去支付" forState:UIControlStateNormal];
//        [self.paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.paymentBtn addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:self.paymentBtn];
//        self.paymentBtn.sd_layout
//        .topSpaceToView(self.downLineView, 10)
//        .rightSpaceToView(self.contentView, 15)
//        .widthIs(70)
//        .heightIs(30);
//
//
//        self.cancelGoodsBtn = [[UIButton alloc] init];
//        self.cancelGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        self.cancelGoodsBtn.backgroundColor =colorWithRGB(0xFF6B24);
//        [self.cancelGoodsBtn setTitle:@"取消交易" forState:UIControlStateNormal];
//        [self.cancelGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.cancelGoodsBtn addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:self.cancelGoodsBtn];
//        self.cancelGoodsBtn.sd_layout
//        .topSpaceToView(self.downLineView, 10)
//        .rightSpaceToView(self.paymentBtn, 10)
//        .widthIs(70)
//        .heightIs(30);
//    }else if ([minModel.status isEqualToString:@"1"]){
//        self.goodStatus.text = @"已支付";
//        self.deliverGoodsBtn = [[UIButton alloc] init];
//        self.deliverGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        self.deliverGoodsBtn.backgroundColor =colorWithRGB(0xFF6B24);
//        [self.deliverGoodsBtn setTitle:@"确认发货" forState:UIControlStateNormal];
//        [self.deliverGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.deliverGoodsBtn addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:self.deliverGoodsBtn];
//        self.deliverGoodsBtn.sd_layout
//        .topSpaceToView(self.downLineView, 10)
//        .rightSpaceToView(self.contentView, 15)
//        .widthIs(70)
//        .heightIs(30);
//    }else if ([minModel.status isEqualToString:@"2"]){
//        self.goodStatus.text = @"代发货";
////        self.lookLogisticsBtn.alpha = 0;
////        self.mineReminderBtn.alpha = 0;
////        self.collectGoodsBtn.alpha = 0;
////        self.paymentBtn.alpha = 0;
////        self.cancelGoodsBtn.alpha = 0;
////        self.deliverGoodsBtn.alpha = 0;
//    }else if ([minModel.status isEqualToString:@"3"]){
//        self.goodStatus.text = @"已发货";
//        self.collectGoodsBtn = [[UIButton alloc] init];
//        self.collectGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        self.collectGoodsBtn.backgroundColor =colorWithRGB(0xFF6B24);
//        [self.collectGoodsBtn setTitle:@"确认收货" forState:UIControlStateNormal];
//        [self.collectGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.collectGoodsBtn addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:self.collectGoodsBtn];
//        self.collectGoodsBtn.sd_layout
//        .topSpaceToView(self.downLineView, 10)
//        .rightSpaceToView(self.contentView, 15)
//        .widthIs(70)
//        .heightIs(30);
//
//
//        self.lookLogisticsBtn = [[UIButton alloc] init];
//        self.lookLogisticsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        self.lookLogisticsBtn.backgroundColor =colorWithRGB(0xFF6B24);
//        [self.lookLogisticsBtn setTitle:@"查看物流" forState:UIControlStateNormal];
//        [self.lookLogisticsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.lookLogisticsBtn addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:self.lookLogisticsBtn];
//        self.lookLogisticsBtn.sd_layout
//        .topSpaceToView(self.downLineView, 10)
//        .rightSpaceToView(self.collectGoodsBtn, 10)
//        .widthIs(70)
//        .heightIs(30);
//
//        self.mineReminderBtn = [[UIButton alloc] init];
//        self.mineReminderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        self.mineReminderBtn.backgroundColor =colorWithRGB(0xFF6B24);
//        [self.mineReminderBtn setTitle:@"我要催单" forState:UIControlStateNormal];
//        [self.mineReminderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.mineReminderBtn addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:self.mineReminderBtn];
//        self.mineReminderBtn.sd_layout
//        .topSpaceToView(self.downLineView, 10)
//        .rightSpaceToView(self.lookLogisticsBtn, 15)
//        .widthIs(70)
//        .heightIs(30);
//    }else if ([minModel.status isEqualToString:@"4"]){
//        self.goodStatus.text = @"已完成";
//
//    }else if ([minModel.status isEqualToString:@"5"]){
//        self.goodStatus.text = @"已取消";
//
//    }else if ([minModel.status isEqualToString:@"6"]){
//
//        self.goodStatus.text = @"售后";
//    }
    
    
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
