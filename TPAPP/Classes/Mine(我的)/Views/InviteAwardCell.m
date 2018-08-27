//
//  InviteAwardCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/24.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "InviteAwardCell.h"

@implementation InviteAwardCell
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
    
    self.inviteCodeLabel = [[UILabel alloc] init];
    self.inviteCodeLabel.text = @"您的邀请码:";
    self.inviteCodeLabel.textColor = [UIColor blackColor];
    self.inviteCodeLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.inviteCodeLabel];
    self.inviteCodeLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:self.inviteCodeLabel.text withFont:15])
    .heightIs(30);
    
    self.registeLabel = [[UILabel alloc] init];
    self.registeLabel.font = [UIFont systemFontOfSize:15];
    self.registeLabel.textAlignment = NSTextAlignmentRight;
    self.registeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.registeLabel];
    self.registeLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 15)
    .widthIs(120)
    .heightIs(30);
    
    self.codeLabel = [[UILabel alloc] init];
    self.codeLabel.font = [UIFont systemFontOfSize:15];
    self.codeLabel.textAlignment = NSTextAlignmentLeft;
    self.codeLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.codeLabel];
    self.codeLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.inviteCodeLabel, 5)
    .rightSpaceToView(self.registeLabel, 10)
    .heightIs(30);
    
}

- (void)configWithModel:(NSMutableArray *)arr
{
    self.codeLabel.text = arr[0];
    if ([arr[1] intValue] == 1) {
        self.registeLabel.text = @"已注册";
        self.registeLabel.sd_layout
        .topSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 15)
        .widthIs(120)
        .heightIs(30);
    }else{
        self.registeLabel.sd_layout
        .topSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 0)
        .widthIs(120)
        .heightIs(30);
        self.registeLabel.text = @"立即注册";
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
