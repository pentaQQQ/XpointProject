//
//  CartHeaderCell.m
//  TPAPP
//
//  Created by frank on 2018/8/26.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "CartHeaderCell.h"

@implementation CartHeaderCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = colorWithRGB(0xEEEEEE);
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.lineImageView = [[UIImageView alloc] init];
    self.lineImageView.image = [UIImage imageNamed:@"icon_mine_line"];
    [self.contentView addSubview:self.lineImageView];
    self.lineImageView.sd_layout
    .topSpaceToView(self.contentView, 25)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(3)
    .heightIs(20);
    
    self.buyLabel = [[UILabel alloc] init];
    self.buyLabel.text = @"代购编号:";
    self.buyLabel.textAlignment = NSTextAlignmentLeft;
    self.buyLabel.textColor = [UIColor blackColor];
    self.buyLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.buyLabel];
    self.buyLabel.sd_layout
    .topSpaceToView(self.contentView,20)
    .leftSpaceToView(self.lineImageView, 10)
    .widthIs([self widthLabelWithModel:@"代购编号:" withFont:17])
    .heightIs(30);
    
    self.buy_number = [[UILabel alloc] init];
    self.buy_number.text = @"6496";
    self.buy_number.textColor = [UIColor blackColor];
    self.buy_number.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.buy_number];
    self.buy_number.sd_layout
    .topSpaceToView(self.contentView, 20)
    .leftSpaceToView(self.buyLabel, 5)
    .widthIs(100)
    .heightIs(30);
    
    
    self.retureList = [[UIButton alloc] init];
    self.retureList.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.retureList setTitle:@"回收清单" forState:UIControlStateNormal];
    [self.retureList setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.retureList addTarget:self action:@selector(retureListAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.retureList];
    self.retureList.sd_layout
    .topSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:@"回收清单" withFont:17]+30)
    .heightIs(30);
    self.retureList.layer.cornerRadius = 15;
    self.retureList.layer.masksToBounds = YES;
    self.retureList.layer.borderWidth = .5;
    self.retureList.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    self.address_button = [[UIButton alloc] init];
    self.address_button.backgroundColor = colorWithRGB(0xEEEEEE);
    self.address_button.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.address_button setTitle:@"管理收件地址" forState:UIControlStateNormal];
    [self.address_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.address_button addTarget:self action:@selector(addressAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.address_button];
    self.address_button.sd_layout
    .topSpaceToView(self.buyLabel, 15)
    .rightSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .heightIs(50);
    self.address_button.layer.cornerRadius = 25;
    self.address_button.layer.masksToBounds = YES;
    [self.address_button setImage:[UIImage imageNamed:@"icon_addres"] forState:UIControlStateNormal];


}
- (void)btnAction
{
    self.selectBlock(0);
}
- (void)addressAction
{
    self.selectBlock(1);
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
