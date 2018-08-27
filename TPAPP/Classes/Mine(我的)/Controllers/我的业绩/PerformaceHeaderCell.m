//
//  PerformaceHeaderCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/23.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "PerformaceHeaderCell.h"

@implementation PerformaceHeaderCell
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
    
    self.marketTitleLabel = [[UILabel alloc] init];
    self.marketTitleLabel.textColor = [UIColor blackColor];
    self.marketTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    self.marketTitleLabel.text = @"销售额";
    self.marketTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.marketTitleLabel];
    self.marketTitleLabel.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, kScreenWidth/3)
    .widthIs(kScreenWidth/3)
    .heightIs(20);
    
    self.buyTitleLabel = [[UILabel alloc] init];
    self.buyTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    self.buyTitleLabel.textColor = [UIColor blackColor];
    self.buyTitleLabel.text = @"代购费";
    [self.contentView addSubview:self.buyTitleLabel];
    self.buyTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.buyTitleLabel.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.marketTitleLabel, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(20);
    
    
    self.allMoneyLabel = [[UILabel alloc] init];
    self.allMoneyLabel.textColor = colorWithRGB(0xFF5760);
    self.allMoneyLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    self.allMoneyLabel.text = @"合计业绩";
    self.allMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.allMoneyLabel];
    self.allMoneyLabel.sd_layout
    .topSpaceToView(self.buyTitleLabel, 15)
    .leftSpaceToView(self.contentView, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(20);
    
    self.marketLabel = [[UILabel alloc] init];
    self.marketLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    self.marketLabel.textColor = colorWithRGB(0xFF5760);
    [self.contentView addSubview:self.marketLabel];
    self.marketLabel.textAlignment = NSTextAlignmentCenter;
    self.marketLabel.sd_layout
    .topSpaceToView(self.marketTitleLabel, 15)
    .leftSpaceToView(self.allMoneyLabel, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(20);
    
    self.buyLabel = [[UILabel alloc] init];
    self.buyLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    self.buyLabel.textColor = colorWithRGB(0xFF5760);
    [self.contentView addSubview:self.buyLabel];
    self.buyLabel.textAlignment = NSTextAlignmentCenter;
    self.buyLabel.sd_layout
    .topSpaceToView(self.buyTitleLabel, 15)
    .leftSpaceToView(self.marketLabel, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(20);
}
-(void)configWithModel:(NSMutableArray *)arr
{
    self.marketLabel.text = arr[0];
    self.buyLabel.text = arr[1];
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
