//
//  CouponsViewCell.m
//  TPAPP
//
//  Created by Frank on 2019/1/17.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import "CouponsViewCell.h"

@implementation CouponsViewCell
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
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    bgView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(50);
   
    UIView *lineView = [[UIView alloc] init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = colorWithRGB(0xbfbfbf);
    lineView.sd_layout
    .topSpaceToView(bgView, 49.5)
    .leftEqualToView(bgView)
    .rightEqualToView(bgView)
    .heightIs(.5);
    
    UIImageView *lineImgeView = [[UIImageView alloc] init];
    [bgView addSubview:lineImgeView];
    lineImgeView.image = [UIImage imageNamed:@"icon_mine_line"];
    lineImgeView.sd_layout
    .topSpaceToView(bgView, 15)
    .leftSpaceToView(bgView, 15)
    .bottomSpaceToView(bgView, 15)
    .widthIs(3);
    
    UILabel *listLabel = [[UILabel alloc] init];
    [bgView addSubview:listLabel];
    listLabel.sd_layout
    .topSpaceToView(bgView, 15)
    .leftSpaceToView(lineImgeView, 5)
    .widthIs(150)
    .heightIs(20);
    listLabel.font = [UIFont systemFontOfSize:15];
    listLabel.text = @"我的优惠券";
    
    UIImageView *imgeView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-20, 10, 10, 10)];
    [bgView addSubview:imgeView];
    imgeView.image = [UIImage imageNamed:@"icon_mine_arrow"];
    imgeView.sd_layout
    .topSpaceToView(bgView, 20)
    .rightSpaceToView(bgView, 15)
    .widthIs(10)
    .heightIs(10);
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:detailLabel];
    detailLabel.sd_layout
    .topSpaceToView(bgView, 15)
    .rightSpaceToView(imgeView, 5)
    .widthIs([self widthLabelWithModel:@"更多"]+10)
    .heightIs(20);
    detailLabel.font = [UIFont systemFontOfSize:12];
    detailLabel.textColor = colorWithRGB(0xbfbfbf);
    detailLabel.text = @"更多";
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
