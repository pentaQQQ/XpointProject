//
//  ServiceTypeCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "ServiceTypeCell.h"

@implementation ServiceTypeCell
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
    
   
    
    self.serviceType = [[UILabel alloc] init];
    self.serviceType.text = @"服务类型";
    self.serviceType.textAlignment = NSTextAlignmentLeft;
    self.serviceType.textColor = [UIColor blackColor];
    self.serviceType.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.serviceType];
    self.serviceType.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 20)
    .widthIs(100)
    .heightIs(30);
    
    
    self.retureGood = [[UIButton alloc] init];
    self.retureGood.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.retureGood setTitle:@"退货" forState:UIControlStateNormal];
    [self.retureGood setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.retureGood addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.retureGood];
    self.retureGood.sd_layout
    .topSpaceToView(self.serviceType, 10)
    .leftSpaceToView(self.contentView, 30)
    .widthIs(70)
    .heightIs(25);
    self.retureGood.layer.borderWidth = 1.0;
    self.retureGood.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.changeGood = [[UIButton alloc] init];
    self.changeGood.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.changeGood setTitle:@"换货" forState:UIControlStateNormal];
    [self.changeGood setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.changeGood addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.changeGood];
    self.changeGood.sd_layout
    .topSpaceToView(self.serviceType, 10)
    .leftSpaceToView(self.retureGood, 10)
    .widthIs(70)
    .heightIs(25);
    self.changeGood.layer.borderWidth = 1.0;
    self.changeGood.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    self.retureMoney = [[UIButton alloc] init];
    self.retureMoney.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.retureMoney setTitle:@"退款" forState:UIControlStateNormal];
    [self.retureMoney setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.retureMoney addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.retureMoney];
    self.retureMoney.sd_layout
    .topSpaceToView(self.serviceType, 10)
    .leftSpaceToView(self.changeGood, 10)
    .widthIs(70)
    .heightIs(25);
    self.retureMoney.layer.borderWidth = 1.0;
    self.retureMoney.layer.borderColor = [UIColor lightGrayColor].CGColor;
}
- (void)applyBtnAction
{
    //    [self.delegate SelectedCell:self];
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
