//
//  PayIndentCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/28.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "PayIndentCell.h"
#define YSScreenWidth  [UIScreen mainScreen].bounds.size.width
#define YSLeftGap 15
@implementation PayIndentCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}
- (void)createUI
{
   [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.contentView addSubview:self.localImageView];
    UIImage *image = [UIImage imageNamed:@"icon_addres"];
    self.localImageView.image = image;
    self.localImageView.sd_layout
    .topSpaceToView(self.contentView, 28)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(15)
    .heightIs(15*image.size.height/image.size.width);
    
    
    [self.contentView addSubview:self.buyUserName];
    self.buyUserName.text = @"Alan";
    self.buyUserName.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 40)
    .widthIs([self widthLabelWithModel:@"Alan" withFont:15])
    .heightIs(30);
    
   
    [self.contentView addSubview:self.buyUserTelephone];
    self.buyUserTelephone.text = @"18501605966";
    self.buyUserTelephone.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.buyUserName, 30)
    .widthIs([self widthLabelWithModel:@"18501605966" withFont:15])
    .heightIs(30);
    
    [self.contentView addSubview:self.defaultImageView];
    UIImage *image1 = [UIImage imageNamed:@"tag_moren"];
    self.defaultImageView.image = image1;
    self.defaultImageView.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.buyUserTelephone, 5)
    .widthIs(50)
    .heightIs(20);
    
    
    [self.contentView addSubview:self.buyUserAddess];
    self.buyUserAddess.text = @"上海市宝山区沪太路3100号A座";
    self.buyUserAddess.sd_layout
    .topSpaceToView(self.buyUserTelephone, 0)
    .leftSpaceToView(self.contentView, 40)
    .rightSpaceToView(self.contentView, 80)
    .heightIs(20);
    
    [self.contentView addSubview:self.changeAddressBtn];
    UIImage *image2 = [UIImage imageNamed:@"icon_qiehuan"];
    self.changeAddressBtn.sd_layout
    .topSpaceToView(self.contentView, 25+(40-(15*image2.size.height/image2.size.width+20))/2)
    .rightSpaceToView(self.contentView, 10)
    .widthIs(40)
    .heightIs(15*image2.size.height/image2.size.width+20);
    
    
    [self.contentView addSubview:self.lineView];
    self.lineView.sd_layout
    .topSpaceToView(self.buyUserAddess, 15)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(1);
    
    
    [self.contentView addSubview:self.defaultLabel];
    self.defaultLabel.text = @"是否代发货";
    self.defaultLabel.sd_layout
    .topSpaceToView(self.lineView, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:@"是否代发货" withFont:15])
    .heightIs(20);
    
    
    [self.contentView addSubview:self.defaultSwitch];
     [self.defaultSwitch setOn:NO];
     self.defaultSwitch.onTintColor = colorWithRGB(0xFF6B24);
     self.defaultSwitch.transform = CGAffineTransformMakeScale(.8, .8);
     self.defaultSwitch.layer.anchorPoint = CGPointMake(0, 0);
    self.defaultSwitch.sd_layout
    .topSpaceToView(self.lineView, 15)
    .rightSpaceToView(self.contentView, 5)
    .widthIs(40)
    .heightIs(20);
}

#pragma mark - 懒加载
- (UIImageView *)localImageView {
    if (!_localImageView) {
        _localImageView = [[UIImageView alloc] init];
    }
    return _localImageView;
}

- (UIImageView *)defaultImageView {
    if (!_defaultImageView) {
        _defaultImageView = [[UIImageView alloc] init];
    }
    return _defaultImageView;
}

- (UILabel *)buyUserName {
    if (!_buyUserName) {
        _buyUserName= [[UILabel alloc] init];
        _buyUserName.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
        _buyUserName.textColor = [UIColor blackColor];
        _buyUserName.textAlignment = NSTextAlignmentLeft;
    }
    return _buyUserName;
}
- (UILabel *)buyUserTelephone {
    if (!_buyUserTelephone) {
        _buyUserTelephone= [[UILabel alloc] init];
        _buyUserTelephone.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
        _buyUserTelephone.textColor = [UIColor blackColor];
        _buyUserTelephone.textAlignment = NSTextAlignmentLeft;
    }
    return _buyUserTelephone;
}

- (UILabel *)buyUserAddess {
    if (!_buyUserAddess) {
        _buyUserAddess= [[UILabel alloc] init];
        _buyUserAddess.font = [UIFont systemFontOfSize:15];
        _buyUserAddess.textColor = [UIColor lightGrayColor];
        _buyUserAddess.textAlignment = NSTextAlignmentLeft;
    }
    return _buyUserAddess;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = colorWithRGB(0xEEEEEE);
    }
    return _lineView;
}


- (UILabel *)defaultLabel {
    if (!_defaultLabel) {
        _defaultLabel= [[UILabel alloc] init];
        _defaultLabel.font = [UIFont systemFontOfSize:15];
        _defaultLabel.textColor = [UIColor blackColor];
        _defaultLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _defaultLabel;
}

- (ChangeAddressButton *)changeAddressBtn {
    if (!_changeAddressBtn) {
        _changeAddressBtn = [[ChangeAddressButton alloc] init];
        [_changeAddressBtn addTarget:self action:@selector(changeAddressBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeAddressBtn;
}
- (void)changeAddressBtnAction:(UIButton*)btn
{
    
}

- (UISwitch *)defaultSwitch {
    if (!_defaultSwitch) {
        _defaultSwitch = [[UISwitch alloc] init];
        [_defaultSwitch addTarget:self action:@selector(switchTouched:) forControlEvents:UIControlEventValueChanged];
    }
    return _defaultSwitch;
}
- (void)switchTouched:(UISwitch *)mySwitch
{
    
}
#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString withFont:(NSInteger)font
{
    CGSize size = CGSizeMake(self.contentView.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width+5;
}
@end

@implementation PayIndentDefaultCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView,15)
    .widthIs((kScreenWidth-30)/2)
    .heightIs(30);
    
    
    [self.contentView addSubview:self.priceLabel];
    self.priceLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 15)
    .widthIs((kScreenWidth-30)/2)
    .heightIs(30);
}

- (void)configWithModel:(NSMutableArray *)model
{
    self.titleLabel.text = model[0];
    self.priceLabel.text = model[1];
    if ([model[0] isEqualToString:@"应付金额"]) {
        self.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
        self.priceLabel.textColor = colorWithRGB(0xFF6B24);
    }
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel= [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textColor = [UIColor lightGrayColor];
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel= [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}




@end


@implementation PayIndentButtonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    [self.contentView addSubview:self.payTypeImageView];
    
    self.payTypeImageView.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(30)
    .heightIs(30);
    
    
    [self.contentView addSubview:self.payTypeLabel];
    self.payTypeLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.payTypeImageView, 10)
    .widthIs(120)
    .heightIs(30);
    
    [self.contentView addSubview:self.choosePayTypeButton];
    [self.choosePayTypeButton setImage:[UIImage imageNamed:@"未选中支付"] forState:UIControlStateNormal];
    self.choosePayTypeButton.sd_layout
    .topSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .widthIs(20)
    .heightIs(20);
}

- (void)configWithModel:(NSMutableArray *)model
{
    self.payTypeImageView.image = [UIImage imageNamed:model[0]];
    self.payTypeLabel.text = model[1];
//    if ([model[1] isEqualToString:@"微信支付"]) {
//        [self.choosePayTypeButton setImage:[UIImage imageNamed:@"选中支付"] forState:UIControlStateNormal];
//    }
}

#pragma mark - 懒加载
- (UILabel *)payTypeLabel {
    if (!_payTypeLabel) {
        _payTypeLabel= [[UILabel alloc] init];
        _payTypeLabel.font = [UIFont systemFontOfSize:15];
        _payTypeLabel.textColor = [UIColor blackColor];
        _payTypeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _payTypeLabel;
}
- (UIImageView *)payTypeImageView {
    if (!_payTypeImageView) {
        _payTypeImageView = [[UIImageView alloc] init];
    }
    return _payTypeImageView;
}

- (UIButton *)choosePayTypeButton {
    if (!_choosePayTypeButton) {
        _choosePayTypeButton = [[UIButton alloc] init];
        [_choosePayTypeButton addTarget:self action:@selector(choosePayTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _choosePayTypeButton;
}

- (void)choosePayTypeButtonAction:(UIButton *)sender{
    self.isSelect = !self.isSelect;
    if (self.qhxSelectBlock) {
        self.qhxSelectBlock(self.isSelect,sender.tag);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@implementation ChangeAddressButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
}
- (void)createUI
{
    UIImage *image = [UIImage imageNamed:@"icon_qiehuan"];
    self.changeAddressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12.5, 0, 15, 15*image.size.height/image.size.width)];
    self.changeAddressImageView.image = [UIImage imageNamed:@"icon_qiehuan"];
    [self addSubview:self.changeAddressImageView];
    
    self.changeAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.changeAddressImageView.frame), 40, 20)];
    self.changeAddressLabel.font = [UIFont systemFontOfSize:12];
    self.changeAddressLabel.textColor = [UIColor lightGrayColor];
    self.changeAddressLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.changeAddressLabel];
    self.changeAddressLabel.text = @"切换";
}

@end

