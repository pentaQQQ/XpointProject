//
//  VipDeatailCell.m
//  TPAPP
//
//  Created by frank on 2018/8/25.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "VipDeatailCell.h"

@implementation VipDeatailCell
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
    
    self.oneTitleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.oneTitleLabel];
    self.oneTitleLabel.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(180)
    .heightIs(20);
    self.oneTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.oneTitleLabel.textColor = [UIColor blackColor];
    self.oneTitleLabel.text = @"(1) 注册有礼";
    self.oneTitleLabel.font = [UIFont systemFontOfSize:15];
    
    
    self.oneDeatailLabel1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.oneDeatailLabel1];
    self.oneDeatailLabel1.sd_layout
    .topSpaceToView(self.oneTitleLabel, 0)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(kScreenWidth-40)
    .heightIs(20);
    self.oneDeatailLabel1.textAlignment = NSTextAlignmentLeft;
    self.oneDeatailLabel1.textColor = [UIColor blackColor];
    self.oneDeatailLabel1.text = @"权益内容：赠送100个牛大头；";
    self.oneDeatailLabel1.font = [UIFont systemFontOfSize:15];
    
    
    self.oneDeatailLabel2 = [[UILabel alloc] init];
    [self.contentView addSubview:self.oneDeatailLabel2];
    self.oneDeatailLabel2.sd_layout
    .topSpaceToView(self.oneDeatailLabel1, 0)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(kScreenWidth-40)
    .heightIs(20);
    self.oneDeatailLabel2.textAlignment = NSTextAlignmentLeft;
    self.oneDeatailLabel2.textColor = [UIColor blackColor];
    self.oneDeatailLabel2.text = @"权益对象：所有注册会员。";
    self.oneDeatailLabel2.font = [UIFont systemFontOfSize:15];
    
    
    self.twoTitleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.twoTitleLabel];
    self.twoTitleLabel.sd_layout
    .topSpaceToView(self.oneDeatailLabel2, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(180)
    .heightIs(20);
    self.twoTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.twoTitleLabel.textColor = [UIColor blackColor];
    self.twoTitleLabel.text = @"(2) 会员升级";
    self.twoTitleLabel.font = [UIFont systemFontOfSize:15];
    
    
    self.twoDeatailLabel1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.twoDeatailLabel1];
    self.twoDeatailLabel1.sd_layout
    .topSpaceToView(self.twoTitleLabel, 0)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(kScreenWidth-40)
    .heightIs(20);
    self.twoDeatailLabel1.textAlignment = NSTextAlignmentLeft;
    self.twoDeatailLabel1.textColor = [UIColor blackColor];
    self.twoDeatailLabel1.text = @"权益有效时间：在升级后一周内；";
    self.twoDeatailLabel1.font = [UIFont systemFontOfSize:15];
    
    
    self.twoDeatailLabel2 = [[UILabel alloc] init];
    [self.contentView addSubview:self.twoDeatailLabel2];
    self.twoDeatailLabel2.sd_layout
    .topSpaceToView(self.twoDeatailLabel1, 0)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(kScreenWidth-40)
    .heightIs(40);
    self.twoDeatailLabel2.numberOfLines = 2;
    self.twoDeatailLabel2.textAlignment = NSTextAlignmentLeft;
    self.twoDeatailLabel2.textColor = [UIColor blackColor];
    self.twoDeatailLabel2.text = @"权益内容：你将额外获取100个成长值和100个牛大头，并获得对应等级所享有的权益；";
    self.twoDeatailLabel2.font = [UIFont systemFontOfSize:15];
    
    self.twoDeatailLabel3 = [[UILabel alloc] init];
    [self.contentView addSubview:self.twoDeatailLabel3];
    self.twoDeatailLabel3.sd_layout
    .topSpaceToView(self.twoDeatailLabel2, 0)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(kScreenWidth-40)
    .heightIs(20);
    self.twoDeatailLabel3.numberOfLines = 2;
    self.twoDeatailLabel3.textAlignment = NSTextAlignmentLeft;
    self.twoDeatailLabel3.textColor = [UIColor blackColor];
    self.twoDeatailLabel3.text = @"权益对象：途牛一星及以上会员。";
    self.twoDeatailLabel3.font = [UIFont systemFontOfSize:15];
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
