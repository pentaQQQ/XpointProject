//
//  MyCouponsCell.m
//  TPAPP
//
//  Created by Frank on 2019/1/21.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import "MyCouponsCell.h"

@implementation MyCouponsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = colorWithRGB(0xFFFFFF);
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
    CGFloat width_sw = (kScreenWidth-30*2);
    
    self.bgImageview = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bgImageview];
    self.bgImageview.image = [UIImage imageNamed:@"优惠券"];
    self.bgImageview.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 30)
    .rightSpaceToView(self.contentView, 30)
    .bottomSpaceToView(self.contentView, 0);
    
    self.moneyLabel = [[UILabel alloc] init];
    self.moneyLabel.textColor = [UIColor whiteColor];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.moneyLabel];
    self.moneyLabel.sd_layout
    .topSpaceToView(self.contentView, 25)
    .leftSpaceToView(self.contentView, 30)
    .widthIs(width_sw/3)
    .heightIs(30);
    self.moneyLabel.font = [UIFont systemFontOfSize:30];
    self.moneyLabel.text = @"¥50";
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.detailLabel];
    self.detailLabel.sd_layout
    .topSpaceToView(self.moneyLabel, 10)
    .leftSpaceToView(self.contentView, 30)
    .widthIs(width_sw/3)
    .heightIs(30);
    self.detailLabel.adjustsFontSizeToFitWidth = YES;
    self.detailLabel.font = [UIFont systemFontOfSize:19];
    self.detailLabel.text = @"满199抵用";
    
    
    
    
    

    
   
    
    
//    self.couponsTypeLabel = [[UILabel alloc] init];
//    self.couponsTypeLabel.textColor = [UIColor whiteColor];
//    self.couponsTypeLabel.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:self.couponsTypeLabel];
//    self.couponsTypeLabel.sd_layout
//    .topSpaceToView(self.couponsLabel, 10)
//    .leftSpaceToView(self.contentView, 40)
//    .widthIs(80)
//    .heightIs(30);
//    self.couponsTypeLabel.adjustsFontSizeToFitWidth = YES;
//    self.couponsTypeLabel.font = [UIFont systemFontOfSize:18];
//    self.couponsTypeLabel.text = @"可使用";
    
    
    
    
    
    
    
    
    self.merchantNameLabel = [[UILabel alloc] init];
    self.merchantNameLabel.textColor = [UIColor blackColor];
    self.merchantNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.merchantNameLabel];
    self.merchantNameLabel.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.detailLabel, 0)
    .rightSpaceToView(self.contentView, 30)
    .heightIs(30);
    self.merchantNameLabel.font = [UIFont systemFontOfSize:35];
    self.merchantNameLabel.text = @"田洋仓";
    self.merchantNameLabel.adjustsFontSizeToFitWidth = YES;
    
    
    
    self.dateTimeLabel = [[UILabel alloc] init];
    self.dateTimeLabel.textColor = [UIColor blackColor];
    self.dateTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.dateTimeLabel];
    self.dateTimeLabel.sd_layout
    .topSpaceToView(self.merchantNameLabel, 10)
    .leftSpaceToView(self.detailLabel, 0)
    .rightSpaceToView(self.contentView, 30)
    .heightIs(20);
    self.dateTimeLabel.font = [UIFont systemFontOfSize:14];
    self.dateTimeLabel.text = @"2019.01.01-2019.01.28";
    self.dateTimeLabel.adjustsFontSizeToFitWidth = YES;
    
    self.couponsLabel = [[UILabel alloc] init];
    self.couponsLabel.textColor = [UIColor blackColor];
    self.couponsLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.couponsLabel];
    self.couponsLabel.sd_layout
    .topSpaceToView(self.dateTimeLabel, 10)
    .leftSpaceToView(self.detailLabel, 0)
    .rightSpaceToView(self.contentView, 30)
    .heightIs(20);
    self.couponsLabel.adjustsFontSizeToFitWidth = YES;
    self.couponsLabel.font = [UIFont systemFontOfSize:19];
    self.couponsLabel.text = @"优惠券";
}
#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString
{
    CGSize size = CGSizeMake(self.contentView.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    return rect.size.width+10;
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
