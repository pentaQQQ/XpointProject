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
   
    
    self.bgImageview = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bgImageview];
    self.bgImageview.image = [UIImage imageNamed:@"优惠券"];
    self.bgImageview.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .bottomSpaceToView(self.contentView, 0);
    
    self.couponsLabel = [[UILabel alloc] init];
    self.couponsLabel.textColor = [UIColor whiteColor];
    self.couponsLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.couponsLabel];
    self.couponsLabel.sd_layout
    .topSpaceToView(self.contentView, 20)
    .leftSpaceToView(self.contentView, 40)
    .widthIs(80)
    .heightIs(50);
    self.couponsLabel.adjustsFontSizeToFitWidth = YES;
    self.couponsLabel.font = [UIFont systemFontOfSize:28];
    self.couponsLabel.text = @"优惠券";

    
    self.couponsTypeLabel = [[UILabel alloc] init];
    self.couponsTypeLabel.textColor = [UIColor whiteColor];
    self.couponsTypeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.couponsTypeLabel];
    self.couponsTypeLabel.sd_layout
    .topSpaceToView(self.couponsLabel, 10)
    .leftSpaceToView(self.contentView, 40)
    .widthIs(80)
    .heightIs(30);
    self.couponsTypeLabel.adjustsFontSizeToFitWidth = YES;
    self.couponsTypeLabel.font = [UIFont systemFontOfSize:18];
    self.couponsTypeLabel.text = @"可使用";
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.detailLabel];
    self.detailLabel.sd_layout
    .topSpaceToView(self.couponsTypeLabel, 10)
    .leftSpaceToView(self.contentView, 40)
    .widthIs(80)
    .heightIs(30);
    self.detailLabel.adjustsFontSizeToFitWidth = YES;
    self.detailLabel.font = [UIFont systemFontOfSize:18];
    self.detailLabel.text = @"满199可用";
    
    
    self.moneyLabel = [[UILabel alloc] init];
    self.moneyLabel.textColor = [UIColor whiteColor];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.moneyLabel];
    self.moneyLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.detailLabel, 0)
    .rightSpaceToView(self.contentView, 40)
    .heightIs(70);
    self.moneyLabel.font = [UIFont systemFontOfSize:48];
    self.moneyLabel.text = @"50RMB";
    
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    
    self.merchantNameLabel = [[UILabel alloc] init];
    self.merchantNameLabel.textColor = [UIColor whiteColor];
    self.merchantNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.merchantNameLabel];
    self.merchantNameLabel.sd_layout
    .topSpaceToView(self.moneyLabel, 0)
    .leftSpaceToView(self.detailLabel, 0)
    .rightSpaceToView(self.contentView, 40)
    .heightIs(30);
    self.merchantNameLabel.font = [UIFont systemFontOfSize:18];
    self.merchantNameLabel.text = @"田洋仓";
    
    self.merchantNameLabel.adjustsFontSizeToFitWidth = YES;
    
    self.dateTimeLabel = [[UILabel alloc] init];
    self.dateTimeLabel.textColor = [UIColor whiteColor];
    self.dateTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.dateTimeLabel];
    self.dateTimeLabel.sd_layout
    .topSpaceToView(self.merchantNameLabel, 10)
    .leftSpaceToView(self.detailLabel, 0)
    .rightSpaceToView(self.contentView, 40)
    .heightIs(30);
    self.dateTimeLabel.font = [UIFont systemFontOfSize:15];
    self.dateTimeLabel.text = @"2019.01.01-2019.01.28";
    
    self.dateTimeLabel.adjustsFontSizeToFitWidth = YES;
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
