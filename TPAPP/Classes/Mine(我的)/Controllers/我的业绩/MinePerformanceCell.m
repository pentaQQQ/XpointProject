//
//  MinePerformanceCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/23.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "MinePerformanceCell.h"

@implementation MinePerformanceCell
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
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.textColor = [UIColor grayColor];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.dateLabel];
    self.dateLabel.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(20);
    
    self.marketLabel = [[UILabel alloc] init];
    self.marketLabel.textColor = colorWithRGB(0xFF5760);
    self.marketLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.marketLabel];
    self.marketLabel.textAlignment = NSTextAlignmentCenter;
    self.marketLabel.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.dateLabel, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(20);
    
    self.buyLabel = [[UILabel alloc] init];
    self.buyLabel.textColor = colorWithRGB(0xFF5760);
    self.buyLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.buyLabel];
    self.buyLabel.textAlignment = NSTextAlignmentCenter;
    self.buyLabel.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.marketLabel, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(20);
}
-(void)configWithModel:(PerformanceModel *)model
{
    self.dateLabel.text = model.date;
    self.marketLabel.text = model.amount;
    self.buyLabel.text = model.discountAmount;
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
