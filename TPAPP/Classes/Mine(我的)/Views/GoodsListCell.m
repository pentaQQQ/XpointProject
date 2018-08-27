//
//  GoodsListCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/24.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "GoodsListCell.h"

@implementation GoodsListCell
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
    
    self.goodIcon = [[UIImageView alloc] init];
    self.goodIcon.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.goodIcon];
    self.goodIcon.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(50)
    .heightIs(50);
    
    self.goodPrice = [[UILabel alloc] init];
    self.goodPrice.text = @"¥1000";
    self.goodPrice.textAlignment = NSTextAlignmentRight;
    self.goodPrice.textColor = colorWithRGB(0xFF6B24);
    self.goodPrice.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.goodPrice];
    self.goodPrice.sd_layout
    .topSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .widthIs(100)
    .heightIs(20);
    
    self.goodName = [[UILabel alloc] init];
    self.goodName.text = @"商品名称";
    self.goodName.textColor = [UIColor blackColor];
    self.goodName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.goodName];
    self.goodName.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.goodIcon, 10)
    .rightSpaceToView(self.goodPrice, 10)
    .heightIs(20);
    
    self.goodSize = [[UILabel alloc] init];
    self.goodSize.text = @"规格: S码";
    self.goodSize.textColor = [UIColor grayColor];
    self.goodSize.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goodSize];
    self.goodSize.sd_layout
    .topSpaceToView(self.goodName, 5)
    .leftSpaceToView(self.goodIcon, 10)
    .widthIs(180)
    .heightIs(10);
    
    self.goodNumber = [[UILabel alloc] init];
    self.goodNumber.textAlignment = NSTextAlignmentRight;
    self.goodNumber.text = @"x1";
    self.goodNumber.textColor = [UIColor grayColor];
    self.goodNumber.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goodNumber];
    self.goodNumber.sd_layout
    .topSpaceToView(self.goodPrice, 5)
    .leftSpaceToView(self.goodSize, 10)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(10);
    
    self.upLineView = [[UIView alloc] init];
    self.upLineView.backgroundColor = colorWithRGB(0xEEEEEE);
    [self.contentView addSubview:self.upLineView];
    self.upLineView.sd_layout
    .topSpaceToView(self.goodIcon, 15)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(1);
    
    
    self.goodOrder = [[UILabel alloc] init];
    self.goodOrder.textAlignment = NSTextAlignmentLeft;
    self.goodOrder.text = @"订单号: ";
    self.goodOrder.textColor = [UIColor blackColor];
    self.goodOrder.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.goodOrder];
    self.goodOrder.sd_layout
    .topSpaceToView(self.upLineView, 10)
    .leftSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:@"订单号: " withFont:13])
    .heightIs(10);
    
    self.goodOrderNumber = [[UILabel alloc] init];
    self.goodOrderNumber.textAlignment = NSTextAlignmentLeft;
    self.goodOrderNumber.text = @"13556654";
    self.goodOrderNumber.textColor = [UIColor blackColor];
    self.goodOrderNumber.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.goodOrderNumber];
    self.goodOrderNumber.sd_layout
    .topSpaceToView(self.upLineView, 10)
    .leftSpaceToView(self.goodOrder, 0)
    .widthIs([self widthLabelWithModel:@"13556654" withFont:13])
    .heightIs(10);
    
    self.allGoodPrice = [[UILabel alloc] init];
    self.allGoodPrice.textAlignment = NSTextAlignmentRight;
    self.allGoodPrice.text = @"¥1000";
    self.allGoodPrice.textColor = colorWithRGB(0xFF6B24);
    self.allGoodPrice.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.allGoodPrice];
    self.allGoodPrice.sd_layout
    .topSpaceToView(self.upLineView, 10)
    .rightSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:@"¥1000" withFont:13])
    .heightIs(10);
    
    self.paymentSum = [[UILabel alloc] init];
    self.paymentSum.textAlignment = NSTextAlignmentRight;
    self.paymentSum.text = @"结算金额: ";
    self.paymentSum.textColor = [UIColor blackColor];
    self.paymentSum.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.paymentSum];
    self.paymentSum.sd_layout
    .topSpaceToView(self.upLineView, 10)
    .rightSpaceToView(self.allGoodPrice, 0)
    .widthIs([self widthLabelWithModel:@"结算金额: " withFont:13])
    .heightIs(10);
    
    self.allGoodNumber = [[UILabel alloc] init];
    self.allGoodNumber.textAlignment = NSTextAlignmentRight;
    self.allGoodNumber.text = @"共1件";
    self.allGoodNumber.textColor = [UIColor blackColor];
    self.allGoodNumber.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.allGoodNumber];
    self.allGoodNumber.sd_layout
    .topSpaceToView(self.upLineView, 10)
    .rightSpaceToView(self.paymentSum, 10)
    .leftSpaceToView(self.goodOrderNumber, 10)
    .heightIs(10);
    
    
    self.downLineView = [[UIView alloc] init];
    self.downLineView.backgroundColor = colorWithRGB(0xEEEEEE);
    [self.contentView addSubview:self.downLineView];
    self.downLineView.sd_layout
    .topSpaceToView(self.goodOrder, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(1);
    
    self.goodStatus = [[UILabel alloc] init];
    self.goodStatus.textAlignment = NSTextAlignmentLeft;
    self.goodStatus.text = @"已完成";
    self.goodStatus.textColor = colorWithRGB(0xFF6B24);
    self.goodStatus.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.goodStatus];
    self.goodStatus.sd_layout
    .topSpaceToView(self.downLineView, 10)
    .leftSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:@"已完成" withFont:15])
    .heightIs(20);
    
    self.applyBtn = [[UIButton alloc] init];
    self.applyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.applyBtn setTitle:@"申请售后" forState:UIControlStateNormal];
    [self.applyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.applyBtn addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.applyBtn];
    self.applyBtn.sd_layout
    .topSpaceToView(self.downLineView, 10)
    .rightSpaceToView(self.contentView, 15)
    .widthIs(70)
    .heightIs(20);
    self.applyBtn.layer.cornerRadius = 10;
    self.applyBtn.layer.masksToBounds = YES;
    self.applyBtn.layer.borderWidth = .5;
    self.applyBtn.layer.borderColor = [UIColor grayColor].CGColor;
}
- (void)applyBtnAction
{
    self.selectBlock(self);
}
#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString withFont:(NSInteger)font
{
    CGSize size = CGSizeMake(self.contentView.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width+5;
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
