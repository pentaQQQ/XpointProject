//
//  ApplyDeatailCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "ApplyDeatailCell.h"

@implementation ApplyDeatailCell
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
    .widthIs(100)
    .heightIs(100);
    
    self.goodPrice = [[UILabel alloc] init];
    self.goodPrice.text = @"¥1000";
    self.goodPrice.textAlignment = NSTextAlignmentRight;
    self.goodPrice.textColor = colorWithRGB(0xFF6B24);
    self.goodPrice.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.goodPrice];
    self.goodPrice.sd_layout
    .topSpaceToView(self.contentView, 25)
    .rightSpaceToView(self.contentView, 15)
    .widthIs(100)
    .heightIs(20);
    
    self.goodName = [[UILabel alloc] init];
    self.goodName.text = @"商品名称";
    self.goodName.textColor = [UIColor blackColor];
    self.goodName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.goodName];
    self.goodName.sd_layout
    .topSpaceToView(self.contentView, 25)
    .leftSpaceToView(self.goodIcon, 10)
    .rightSpaceToView(self.goodPrice, 10)
    .heightIs(20);
    
    self.goodSize = [[UILabel alloc] init];
    self.goodSize.text = @"规格: S码";
    self.goodSize.textColor = [UIColor grayColor];
    self.goodSize.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goodSize];
    self.goodSize.sd_layout
    .topSpaceToView(self.goodName, 10)
    .leftSpaceToView(self.goodIcon, 10)
    .widthIs(180)
    .heightIs(20);
    
    self.goodNumber = [[UILabel alloc] init];
    self.goodNumber.textAlignment = NSTextAlignmentRight;
    self.goodNumber.text = @"x1";
    self.goodNumber.textColor = [UIColor grayColor];
    self.goodNumber.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goodNumber];
    self.goodNumber.sd_layout
    .topSpaceToView(self.goodPrice, 10)
    .leftSpaceToView(self.goodSize, 10)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(20);
    
    
    self.remarksLabel = [[UILabel alloc] init];
    self.remarksLabel.textAlignment = NSTextAlignmentLeft;
    self.remarksLabel.text = @"备注: ";
    self.remarksLabel.textColor = colorWithRGB(0xFF6B24);
    self.remarksLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.remarksLabel];
    self.remarksLabel.sd_layout
    .topSpaceToView(self.goodSize, 10)
    .leftSpaceToView(self.goodIcon, 10)
    .widthIs([self widthLabelWithModel:@"备注: " withFont:13])
    .heightIs(20);
    
    self.remarksDeatail = [[UILabel alloc] init];
    self.remarksDeatail.textAlignment = NSTextAlignmentLeft;
    self.remarksDeatail.text = @"已发货";
    self.remarksDeatail.textColor = colorWithRGB(0xFF6B24);
    self.remarksDeatail.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.remarksDeatail];
    self.remarksDeatail.sd_layout
    .topSpaceToView(self.goodSize, 10)
    .leftSpaceToView(self.remarksLabel, 0)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(20);
    
    
    
//    self.downBtn = [[UIButton alloc] init];
//    self.downBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [self.downBtn setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
//
//    [self.downBtn addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:self.downBtn];
//    self.downBtn.sd_layout
//    .bottomSpaceToView(self.contentView, 15)
//    .rightSpaceToView(self.contentView, 15)
//    .widthIs(20)
//    .heightIs(20);
}
//- (void)applyBtnAction
//{
//    [self.delegate SelectedCell:self];
//}

-(void)configWithModel:(ApplyReturnGoodsModel *)minModel
{
    ApplyReturnDetailResultModel *model = minModel.detailResult[0];
    [self.goodIcon sd_setImageWithURL:[NSURL URLWithString:model.productImg]];
    self.goodName.text = [NSString stringWithFormat:@"%@",model.productName];
    self.goodSize.text = [NSString stringWithFormat:@"规格: %@",model.size];
    self.goodNumber.text = [NSString stringWithFormat:@"x%ld",model.number];
    self.goodPrice.text = [NSString stringWithFormat:@"%.2lf元",model.totalAmount];
    if (model.remark.length != 0) {
        self.remarksDeatail.text = [NSString stringWithFormat:@"%@",model.remark];
    }
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
