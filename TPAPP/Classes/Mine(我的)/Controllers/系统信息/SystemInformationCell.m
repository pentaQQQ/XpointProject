//
//  SystemInformationCell.m
//  TPAPP
//
//  Created by frank on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "SystemInformationCell.h"

@implementation SystemInformationCell
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
    
    self.imageIcon = [[UIImageView alloc] init];
    self.imageIcon.image = [UIImage imageNamed:@"icon_xiaoxi"];
    [self.contentView addSubview:self.imageIcon];
    self.imageIcon.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(20)
    .heightIs(20);
    
    self.messageName = [[UILabel alloc] init];
//    self.messageName.text = @"¥1000";
    self.messageName.textAlignment = NSTextAlignmentLeft;
    self.messageName.textColor = [UIColor blackColor];
    self.messageName.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.messageName];
    self.messageName.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.imageIcon, 10)
    .rightSpaceToView(self.contentView, 100)
    .heightIs(20);
    
    self.messageDeatail = [[UILabel alloc] init];
    self.messageDeatail.numberOfLines = 0;
//    self.messageDeatail.text = @"商品名称";
    self.messageDeatail.textColor = [UIColor blackColor];
    self.messageDeatail.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.messageDeatail];
    self.messageDeatail.sd_layout
    .topSpaceToView(self.messageName, 5)
    .leftSpaceToView(self.contentView, 45)
    .rightSpaceToView(self.contentView, 15)
    .bottomSpaceToView(self.contentView, 15);
    
    self.messageDate = [[UILabel alloc] init];
//    self.messageDate.text = @"2018-07-23";
    self.messageDate.textAlignment = NSTextAlignmentLeft;
    self.messageDate.textColor = [UIColor grayColor];
    self.messageDate.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.messageDate];
    self.messageDate.sd_layout
    .topSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.messageName, 0)
    .heightIs(20);

    self.messageUnread = [[UIImageView alloc] init];
    self.messageUnread.image = [UIImage imageNamed:@"icon-new"];
    [self.contentView addSubview:self.messageUnread];
    self.messageUnread.sd_layout
    .topSpaceToView(self.contentView, 8)
    .rightSpaceToView(self.contentView, 8)
    .widthIs(10)
    .heightIs(10);
}
- (void)configWithModel:(NSMutableArray *)arr
{
    self.messageName.text = arr[0];
    self.messageDate.text = arr[2];
    self.messageDeatail.text = arr[1];
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
