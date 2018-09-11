//
//  VipHeaderCell.m
//  TPAPP
//
//  Created by frank on 2018/8/25.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "VipHeaderCell.h"

@implementation VipHeaderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createHeaderBgViewChilds];
    }
    return self;
}


-(void)createHeaderBgViewChilds
{
    LYAccount *lyAccount = [LYAccount shareAccount];
    self.headerImageView = [[UIImageView alloc] init];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:lyAccount.headUrl]];
    [self.contentView addSubview:self.headerImageView];
    self.headerImageView.sd_layout
    .topSpaceToView(self.contentView, 20)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(70)
    .heightIs(70);
    self.headerImageView.layer.cornerRadius = 35;
    self.headerImageView.layer.masksToBounds =  YES;
    
    self.vipBtn = [[UIButton alloc] init];
    [self.contentView addSubview:self.vipBtn];
    self.vipBtn.backgroundColor = [UIColor whiteColor];
    self.vipBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.headerImageView,10)
    .widthIs(70)
    .heightIs(30);
    [self.vipBtn setBackgroundImage:[UIImage imageNamed:@"icon_mine_vip"] forState:UIControlStateNormal];
    [self.vipBtn addTarget:self action:@selector(vipAction) forControlEvents:UIControlEventTouchUpInside];
    [self.vipBtn setTitle:[NSString stringWithFormat:@"VIP%@",lyAccount.level] forState:UIControlStateNormal];
    [self.vipBtn setTitleColor:colorWithRGB(0xFF6B24) forState:UIControlStateNormal];
    self.vipBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    self.vipBtn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 10);
    self.vipBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight ;
    
    
    
    
    self.userNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.userNameLabel];
    self.userNameLabel.sd_layout
    .topSpaceToView(self.vipBtn, 5)
    .leftEqualToView(self.vipBtn)
    .widthIs(self.vipBtn.frame.size.width)
    .heightIs(30);
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    self.userNameLabel.textColor = [UIColor blackColor];
    self.userNameLabel.text = lyAccount.nickName;
    self.userNameLabel.font = [UIFont systemFontOfSize:19];
    
    self.moneyBgView = [[UIView alloc] init];
    self.moneyBgView.backgroundColor = colorWithRGB(0xEEEEEE);
    [self.contentView addSubview:self.moneyBgView];
    self.moneyBgView.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.vipBtn, 10)
    .heightIs(30);
    self.moneyBgView.layer.cornerRadius = 15;
    self.moneyBgView.layer.masksToBounds = YES;
    
    
    self.moneyView = [[UIView alloc] init];
    self.moneyView.backgroundColor = colorWithRGB(0xFF6B24);
    [self.moneyBgView addSubview:self.moneyView];
    self.moneyView.sd_layout
    .topSpaceToView(self.moneyBgView, 0)
    .leftSpaceToView(self.moneyBgView, 0)
    .widthIs(100)
    .heightIs(30);
    self.moneyView.layer.cornerRadius = 15;
    self.moneyView.layer.masksToBounds = YES;
    
    self.moneyLabel = [[UILabel alloc] init];
    self.moneyLabel.backgroundColor = colorWithRGB(0xFF6B24);
    [self.moneyView addSubview:self.moneyLabel];
    self.moneyLabel.sd_layout
    .topSpaceToView(self.moneyView, 5)
    .rightSpaceToView(self.moneyView, 10)
    .widthIs(self.moneyView.frame.size.width-10)
    .heightIs(20);
    self.moneyLabel.layer.cornerRadius = 10;
    self.moneyLabel.layer.masksToBounds = YES;
    self.moneyLabel.textAlignment = NSTextAlignmentRight;
    self.moneyLabel.textColor = [UIColor whiteColor];
    self.moneyLabel.text = @"¥50";
    self.moneyLabel.font = [UIFont systemFontOfSize:12];
    
    
    self.distanceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.distanceLabel];
    self.distanceLabel.sd_layout
    .topSpaceToView(self.moneyBgView, 5)
     .leftSpaceToView(self.vipBtn, 10)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(30);
    self.distanceLabel.textAlignment = NSTextAlignmentCenter;
    self.distanceLabel.textColor = [UIColor blackColor];
    self.distanceLabel.text = @"距离升级还差 ¥100";
    self.distanceLabel.font = [UIFont systemFontOfSize:13];
}
- (void)vipAction
{
    
}
#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString
{
    CGSize size = CGSizeMake(self.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil];
    return rect.size.width;
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
