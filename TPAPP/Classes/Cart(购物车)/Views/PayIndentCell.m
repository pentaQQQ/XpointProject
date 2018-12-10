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
   
}
-(void)withAddressModel:(AddressModel *)model
{
    self.model = model;
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (self.isSender) {
        if ([model.isGeneration isEqualToString:@"1"]) {
            self.sendLocalImageView = [[UIImageView alloc] init];
            UIImage *image = [UIImage imageNamed:@"icon_addres"];
            self.sendLocalImageView.image = image;
            [self.contentView addSubview:self.sendLocalImageView];
            self.sendLocalImageView.sd_layout
            .topSpaceToView(self.contentView, 21)
            .leftSpaceToView(self.contentView, 20)
            .widthIs(15)
            .heightIs(15*image.size.height/image.size.width);
            
            self.sendUserNameLabel = [[UILabel alloc] init];
            [self.contentView addSubview:self.sendUserNameLabel];
            self.sendUserNameLabel.sd_layout
            .topSpaceToView(self.contentView, 10)
            .leftSpaceToView(self.contentView, 45)
            .widthIs([self widthLabelWithModel:model.senderNickName withFont:17])
            .heightIs(25);
            self.sendUserNameLabel.text = model.senderNickName;
            self.sendUserNameLabel.adjustsFontSizeToFitWidth = YES;
            
            self.sendIphoneLabel = [[UILabel alloc] init];
            [self.contentView addSubview:self.sendIphoneLabel];
            self.sendIphoneLabel.sd_layout
            .topSpaceToView(self.contentView, 10)
            .leftSpaceToView(self.sendUserNameLabel, 10)
            .widthIs([self widthLabelWithModel:model.senderPhone withFont:17])
            .heightIs(25);
            self.sendIphoneLabel.text = model.senderPhone;
            self.sendIphoneLabel.adjustsFontSizeToFitWidth = YES;
            
            
            self.sendStatusImageView = [[UIImageView alloc] init];
            self.sendStatusImageView.image = [UIImage imageNamed:@"tag_ji"];
            [self.contentView addSubview:self.sendStatusImageView];
            self.sendStatusImageView.sd_layout
            .topSpaceToView(self.contentView, 17.5)
            .rightSpaceToView(self.contentView, 20)
            .widthIs(30)
            .heightIs(30);
            
            
            self.sendAddressLabel = [[UILabel alloc] init];
            self.sendAddressLabel.font = [UIFont systemFontOfSize:14];
            self.sendAddressLabel.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:self.sendAddressLabel];
            self.sendAddressLabel.sd_layout
            .topSpaceToView(self.sendUserNameLabel, 0)
            .leftSpaceToView(self.contentView, 45)
            .widthIs([self widthLabelWithModel:[NSString stringWithFormat:@"%@ %@ %@",model.senderProv,model.senderCity,model.senderArea] withFont:14])
            .heightIs(20);
            self.sendAddressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.senderProv,model.senderCity,model.senderArea];
            
            
            self.sendDetailAddressLabel = [[UILabel alloc] init];
            self.sendDetailAddressLabel.font = [UIFont systemFontOfSize:14];
            self.sendDetailAddressLabel.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:self.sendDetailAddressLabel];
            self.sendDetailAddressLabel.sd_layout
            .topSpaceToView(self.sendUserNameLabel, 0)
            .leftSpaceToView(self.sendAddressLabel,5)
            .rightSpaceToView(self.sendStatusImageView, 10)
            .heightIs(20);
            self.sendDetailAddressLabel.text = model.senderAddress;
            
            
            self.topLineView = [[UIView alloc] init];
            self.topLineView.backgroundColor = colorWithRGB(0xEEEEEE);
            [self.contentView addSubview:self.topLineView];
            self.topLineView.sd_layout
            .topSpaceToView(self.sendDetailAddressLabel, 10)
            .leftSpaceToView(self.contentView, 0)
            .rightSpaceToView(self.contentView, 0)
            .heightIs(1);
            
            
            self.recLocalImageView = [[UIImageView alloc] init];
            self.recLocalImageView.image = image;
            [self.contentView addSubview:self.recLocalImageView];
            self.recLocalImageView.sd_layout
            .topSpaceToView(self.topLineView, 21)
            .leftSpaceToView(self.contentView, 20)
            .widthIs(15)
            .heightIs(15*image.size.height/image.size.width);
            
            self.recUserNameLabel = [[UILabel alloc] init];
            [self.contentView addSubview:self.recUserNameLabel];
            self.recUserNameLabel.sd_layout
            .topSpaceToView(self.topLineView, 10)
            .leftSpaceToView(self.contentView, 45)
            .widthIs([self widthLabelWithModel:model.recNickName withFont:17])
            .heightIs(25);
            self.recUserNameLabel.text = model.recNickName;
            self.recUserNameLabel.adjustsFontSizeToFitWidth = YES;
            
            self.recIphoneLabel = [[UILabel alloc] init];
            [self.contentView addSubview:self.recIphoneLabel];
            self.recIphoneLabel.sd_layout
            .topSpaceToView(self.topLineView, 10)
            .leftSpaceToView(self.recUserNameLabel, 10)
            .widthIs([self widthLabelWithModel:model.recPhone withFont:17])
            .heightIs(25);
            self.recIphoneLabel.text = model.recPhone;
            self.recIphoneLabel.adjustsFontSizeToFitWidth = YES;
            
            
            self.recStatusImageView = [[UIImageView alloc] init];
            self.recStatusImageView.image = [UIImage imageNamed:@"tag_shou"];
            [self.contentView addSubview:self.recStatusImageView];
            self.recStatusImageView.sd_layout
            .topSpaceToView(self.topLineView, 17.5)
            .rightSpaceToView(self.contentView, 20)
            .widthIs(30)
            .heightIs(30);
            
            
            self.recAddressLabel = [[UILabel alloc] init];
            self.recAddressLabel.font = [UIFont systemFontOfSize:14];
            self.recAddressLabel.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:self.recAddressLabel];
            self.recAddressLabel.sd_layout
            .topSpaceToView(self.recUserNameLabel, 0)
            .leftSpaceToView(self.contentView, 45)
            .widthIs([self widthLabelWithModel:[NSString stringWithFormat:@"%@ %@ %@",model.recProv,model.recCity,model.recArea] withFont:14])
            .heightIs(20);
            self.recAddressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.recProv,model.recCity,model.recArea];
            
            
            self.recDetailAddressLabel = [[UILabel alloc] init];
            self.recDetailAddressLabel.font = [UIFont systemFontOfSize:14];
            self.recDetailAddressLabel.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:self.recDetailAddressLabel];
            self.recDetailAddressLabel.sd_layout
            .topSpaceToView(self.recUserNameLabel, 0)
            .leftSpaceToView(self.recAddressLabel,5)
            .rightSpaceToView(self.recStatusImageView, 10)
            .heightIs(20);
            self.recDetailAddressLabel.text = model.recAddress;
            
            
            self.bottomLineView = [[UIView alloc] init];
            self.bottomLineView.backgroundColor = colorWithRGB(0xEEEEEE);
            [self.contentView addSubview:self.bottomLineView];
            self.bottomLineView.sd_layout
            .topSpaceToView(self.contentView, 131)
            .leftSpaceToView(self.contentView, 0)
            .rightSpaceToView(self.contentView, 0)
            .heightIs(1);
            
            [self.contentView addSubview:self.getAddess];
            self.getAddess.text = @"代发货地址";
            self.getAddess.sd_layout
            .topSpaceToView(self.contentView, 141)
            .leftSpaceToView(self.contentView, 15)
            .widthIs([self widthLabelWithModel:@"代发货地址" withFont:15])
            .heightIs(20);
            
            self.chooseAddress = [[UIControl alloc] init];
            [self.contentView addSubview:self.chooseAddress];
            [self.chooseAddress addTarget:self action:@selector(chooseAddressAction) forControlEvents:UIControlEventTouchUpInside];
            self.chooseAddress.sd_layout
            .topSpaceToView(self.contentView, 141)
            .rightSpaceToView(self.contentView, 15)
            .widthIs(55)
            .heightIs(20);
            
            UIImageView *myImageview = [[UIImageView alloc] init];
            myImageview.image = [UIImage imageNamed:@"编辑"];
            [self.chooseAddress addSubview:myImageview];
            myImageview.sd_layout
            .topEqualToView(self.chooseAddress)
            .leftEqualToView(self.chooseAddress)
            .heightIs(20)
            .widthIs(20);
            
            UILabel *chooseLabel = [[UILabel alloc] init];
            chooseLabel.text = @"选择";
            [self.chooseAddress addSubview:chooseLabel];
            chooseLabel.font = [UIFont systemFontOfSize:14];
            chooseLabel.textColor = [UIColor lightGrayColor];
            chooseLabel.textAlignment = NSTextAlignmentRight;
            chooseLabel.sd_layout
            .topEqualToView(self.chooseAddress)
            .rightEqualToView(self.chooseAddress)
            .heightIs(20)
            .widthIs(35);
            
            self.lineView = [[UIView alloc] init];
            self.lineView.backgroundColor = colorWithRGB(0xEEEEEE);
            [self.contentView addSubview:self.lineView];
            self.lineView.sd_layout
            .topSpaceToView(self.contentView, 171)
            .leftSpaceToView(self.contentView, 0)
            .rightSpaceToView(self.contentView, 0)
            .heightIs(1);
            
            [self.contentView addSubview:self.defaultLabel];
            self.defaultLabel.text = @"是否代发货";
            self.defaultLabel.sd_layout
            .topSpaceToView(self.contentView, 191)
            .leftSpaceToView(self.contentView, 15)
            .widthIs([self widthLabelWithModel:@"是否代发货" withFont:15])
            .heightIs(20);
            
            [self.contentView addSubview:self.defaultSwitch];
            [self.defaultSwitch setOn:self.isSender];
            self.defaultSwitch.onTintColor = colorWithRGB(0xFF6B24);
            //self.defaultSwitch.transform = CGAffineTransformMakeScale(.8, .8);
            //self.defaultSwitch.layer.anchorPoint = CGPointMake(0, 0);
            self.defaultSwitch.sd_layout
            .topSpaceToView(self.contentView, 188)
            .rightSpaceToView(self.contentView, 5)
            .widthIs(40)
            .heightIs(20);
            
        }else{
            [self.contentView addSubview:self.getAddess];
            self.getAddess.text = @"代发货地址";
            self.getAddess.sd_layout
            .topSpaceToView(self.contentView, 10)
            .leftSpaceToView(self.contentView, 15)
            .widthIs([self widthLabelWithModel:@"代发货地址" withFont:15])
            .heightIs(20);
            
            self.chooseAddress = [[UIControl alloc] init];
            [self.contentView addSubview:self.chooseAddress];
            [self.chooseAddress addTarget:self action:@selector(chooseAddressAction) forControlEvents:UIControlEventTouchUpInside];
            self.chooseAddress.sd_layout
            .topSpaceToView(self.contentView, 10)
            .rightSpaceToView(self.contentView, 15)
            .widthIs(55)
            .heightIs(20);
            
            UIImageView *myImageview = [[UIImageView alloc] init];
            myImageview.image = [UIImage imageNamed:@"编辑"];
            [self.chooseAddress addSubview:myImageview];
            myImageview.sd_layout
            .topEqualToView(self.chooseAddress)
            .leftEqualToView(self.chooseAddress)
            .heightIs(20)
            .widthIs(20);
            
            UILabel *chooseLabel = [[UILabel alloc] init];
            chooseLabel.text = @"选择";
            [self.chooseAddress addSubview:chooseLabel];
            chooseLabel.font = [UIFont systemFontOfSize:14];
            chooseLabel.textColor = [UIColor lightGrayColor];
            chooseLabel.textAlignment = NSTextAlignmentRight;
            chooseLabel.sd_layout
            .topEqualToView(self.chooseAddress)
            .rightEqualToView(self.chooseAddress)
            .heightIs(20)
            .widthIs(35);
            
            self.lineView = [[UIView alloc] init];
            self.lineView.backgroundColor = colorWithRGB(0xEEEEEE);
            [self.contentView addSubview:self.lineView];
            self.lineView.sd_layout
            .topSpaceToView(self.chooseAddress, 10)
            .leftSpaceToView(self.contentView, 0)
            .rightSpaceToView(self.contentView, 0)
            .heightIs(1);
            [self.contentView addSubview:self.defaultLabel];
            self.defaultLabel.text = @"是否代发货";
            self.defaultLabel.sd_layout
            .topSpaceToView(self.chooseAddress, 31)
            .leftSpaceToView(self.contentView, 15)
            .widthIs([self widthLabelWithModel:@"是否代发货" withFont:15])
            .heightIs(20);
            
            
            [self.contentView addSubview:self.defaultSwitch];
            [self.defaultSwitch setOn:self.isSender];
            self.defaultSwitch.onTintColor = colorWithRGB(0xFF6B24);
            //        self.defaultSwitch.transform = CGAffineTransformMakeScale(.8, .8);
            //        self.defaultSwitch.layer.anchorPoint = CGPointMake(0, 0);
            self.defaultSwitch.sd_layout
            .topSpaceToView(self.chooseAddress, 28)
            .rightSpaceToView(self.contentView, 5)
            .widthIs(40)
            .heightIs(20);
            
            
        }
        
    }else{
        [self.contentView addSubview:self.localImageView];
        UIImage *image = [UIImage imageNamed:@"icon_addres"];
        self.localImageView.image = image;
        self.localImageView.sd_layout
        .topSpaceToView(self.contentView, 28)
        .leftSpaceToView(self.contentView, 15)
        .widthIs(15)
        .heightIs(15*image.size.height/image.size.width);
        
        
        [self.contentView addSubview:self.buyUserName];
        self.buyUserName.text = model.recNickName;
        self.buyUserName.sd_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 40)
        .widthIs([self widthLabelWithModel:self.buyUserName.text withFont:15])
        .heightIs(30);
        
        
        [self.contentView addSubview:self.buyUserTelephone];
        self.buyUserTelephone.text = model.recPhone;
        self.buyUserTelephone.sd_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.buyUserName, 30)
        .widthIs([self widthLabelWithModel:self.buyUserTelephone.text withFont:15])
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
        self.buyUserAddess.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.recProv,model.recCity,model.recArea,model.recAddress];
        self.buyUserAddess.sd_layout
        .topSpaceToView(self.buyUserTelephone, 0)
        .leftSpaceToView(self.contentView, 40)
        .rightSpaceToView(self.contentView, 60)
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
        .topSpaceToView(self.buyUserAddess, 30)
        .leftSpaceToView(self.contentView, 15)
        .widthIs([self widthLabelWithModel:@"是否代发货" withFont:15])
        .heightIs(20);
        
        
        [self.contentView addSubview:self.defaultSwitch];
        [self.defaultSwitch setOn:NO];
        self.defaultSwitch.onTintColor = colorWithRGB(0xFF6B24);
        self.defaultSwitch.transform = CGAffineTransformMakeScale(.8, .8);
        self.defaultSwitch.layer.anchorPoint = CGPointMake(0, 0);
        self.defaultSwitch.sd_layout
        .topSpaceToView(self.buyUserAddess, 30)
        .rightSpaceToView(self.contentView, 5)
        .widthIs(40)
        .heightIs(20);
    }
    
    
    
    
}

#pragma mark - 选择代发货地址
- (void)chooseAddressAction
{
    self.selectBlock(1);
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
- (UILabel *)getAddess {
    if (!_getAddess) {
        _getAddess= [[UILabel alloc] init];
        _getAddess.font = [UIFont systemFontOfSize:14];
        _getAddess.textColor = [UIColor lightGrayColor];
        _getAddess.textAlignment = NSTextAlignmentLeft;
    }
    return _getAddess;
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
    self.selectBlock(0);
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
    self.isSender = mySwitch.isOn;
    self.selectSenderBlock(self.isSender);
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
    
}

- (void)configWithModel:(NSMutableArray *)model
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView,15)
    .widthIs([self widthLabelWithModel:model[0] withFont:15])
    .heightIs(30);
    
    
    [self.contentView addSubview:self.priceLabel];
    self.priceLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:model[1] withFont:15])
    .heightIs(30);
    
    self.titleLabel.text = model[0];
    self.priceLabel.text = model[1];
    if ([model[0] isEqualToString:@"应付金额"]) {
        self.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
        self.priceLabel.textColor = colorWithRGB(0xFF6B24);
    }else if ([model[0] isEqualToString:@"运费"]){
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"(运费规则)" forState:UIControlStateNormal];
        [btn setTitleColor:colorWithRGB(0xFF6B24) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(yunfeiAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        btn.sd_layout
        .topSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.titleLabel, 0)
        .widthIs([self widthLabelWithModel:@"(运费规则)" withFont:15])
        .heightIs(50);
    }
}

- (void)yunfeiAction
{
    self.yfBlock(0);
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


#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString withFont:(NSInteger)font
{
    CGSize size = CGSizeMake(self.contentView.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width+5;
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
        self.qhxSelectBlock(self.isSelect,sender.tag,self.payTypeLabel.text);
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

