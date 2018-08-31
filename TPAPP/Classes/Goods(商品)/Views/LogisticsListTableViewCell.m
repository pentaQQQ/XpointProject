//
//  LogisticsListTableViewCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "LogisticsListTableViewCell.h"

@implementation LogisticsListTableViewCell
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
    self.expressDate = [[UILabel alloc] init];
    self.expressDate.text = @"2018-08-28 10:23:49";
    self.expressDate.textAlignment = NSTextAlignmentCenter;
    self.expressDate.textColor = colorWithRGB(0xFF6B24);
    self.expressDate.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.expressDate];
    self.expressDate.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(100)
    .heightIs(20);
    
    self.expressIcon = [[UIImageView alloc] init];
    self.expressIcon.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.expressIcon];
    self.expressIcon.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(60)
    .heightIs(60);
    
    self.expressStatus = [[UILabel alloc] init];
    self.expressStatus.textColor = [UIColor blackColor];
    self.expressStatus.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.expressStatus];
    self.expressStatus.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(20);
    
    self.expressAddress = [[UILabel alloc] init];
    self.expressAddress.text = @"";
    self.expressAddress.textColor = [UIColor grayColor];
    self.expressAddress.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.expressAddress];
    self.expressAddress.sd_layout
    .topSpaceToView(self.contentView, 5)
    .leftSpaceToView(self.contentView, 10)
    .widthIs([self widthLabelWithModel:@"" withFont:12])
    .heightIs(10);
}
-(void)configWithModel:(LogisticsListModel *)model
{
    self.expressDate.text = model.expressDate;
    self.expressStatus.text = model.expressStatus;
    self.expressAddress.text = model.expressAddress;
    if (model.isReceived) {
        self.expressIcon.image = [UIImage imageNamed:@""];
    }else{
        self.expressIcon.image = [UIImage imageNamed:@""];
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
