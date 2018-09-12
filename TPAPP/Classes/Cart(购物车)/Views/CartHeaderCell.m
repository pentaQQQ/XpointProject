//
//  CartHeaderCell.m
//  TPAPP
//
//  Created by frank on 2018/8/26.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "CartHeaderCell.h"

@implementation CartHeaderCell
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor = colorWithRGB(0xEEEEEE);
//        [self createUI];
//    }
//    return self;
//}
//- (void)createUI
//{
//    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    self.lineImageView = [[UIImageView alloc] init];
//    self.lineImageView.image = [UIImage imageNamed:@"icon_mine_line"];
//    [self.contentView addSubview:self.lineImageView];
//    self.lineImageView.sd_layout
//    .topSpaceToView(self.contentView, 20)
//    .leftSpaceToView(self.contentView, 15)
//    .widthIs(3)
//    .heightIs(20);
//
//    self.buyLabel = [[UILabel alloc] init];
//    self.buyLabel.text = @"代购编号:";
//    self.buyLabel.textAlignment = NSTextAlignmentLeft;
//    self.buyLabel.textColor = [UIColor blackColor];
//    self.buyLabel.font = [UIFont systemFontOfSize:15];
//    [self.contentView addSubview:self.buyLabel];
//    self.buyLabel.sd_layout
//    .topSpaceToView(self.contentView,20)
//    .leftSpaceToView(self.lineImageView, 10)
//    .widthIs([self widthLabelWithModel:@"代购编号:" withFont:15])
//    .heightIs(20);
//
//    self.buy_number = [[UILabel alloc] init];
//    self.buy_number.text = @"6496";
//    self.buy_number.textColor = [UIColor blackColor];
//    self.buy_number.font = [UIFont systemFontOfSize:15];
//    [self.contentView addSubview:self.buy_number];
//    self.buy_number.sd_layout
//    .topSpaceToView(self.contentView, 20)
//    .leftSpaceToView(self.buyLabel, 5)
//    .widthIs(100)
//    .heightIs(20);
//
//
//    self.retureList = [[UIButton alloc] init];
//    self.retureList.titleLabel.font = [UIFont systemFontOfSize:14];
//    [self.retureList setTitle:@"回收清单" forState:UIControlStateNormal];
//    [self.retureList setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [self.retureList addTarget:self action:@selector(retureListAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:self.retureList];
//    self.retureList.sd_layout
//    .topSpaceToView(self.contentView, 20)
//    .rightSpaceToView(self.contentView, 15)
//    .widthIs([self widthLabelWithModel:@"回收清单" withFont:14]+30)
//    .heightIs(20);
//    self.retureList.layer.cornerRadius = 10;
//    self.retureList.layer.masksToBounds = YES;
//    self.retureList.layer.borderWidth = .5;
//    self.retureList.layer.borderColor = [UIColor grayColor].CGColor;
//
//
//    self.address_button = [[UIButton alloc] init];
//    self.address_button.backgroundColor = colorWithRGB(0xEEEEEE);
//    self.address_button.titleLabel.font = [UIFont systemFontOfSize:15];
//    [self.address_button setTitle:@"管理收件地址" forState:UIControlStateNormal];
//    [self.address_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [self.address_button addTarget:self action:@selector(addressAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:self.address_button];
//    self.address_button.sd_layout
//    .topSpaceToView(self.buyLabel, 20)
//    .rightSpaceToView(self.contentView, 15)
//    .leftSpaceToView(self.contentView, 15)
//    .heightIs(40);
//    self.address_button.layer.cornerRadius = 20;
//    self.address_button.layer.masksToBounds = YES;
//    [self.address_button setImage:[UIImage imageNamed:@"icon_addres"] forState:UIControlStateNormal];
//
//
//}
//- (void)retureListAction
//{
//    self.selectBlock(0);
//}
//- (void)addressAction
//{
//    self.selectBlock(1);
//}
//#pragma mark-字体宽度自适应
//- (CGFloat)widthLabelWithModel:(NSString *)titleString withFont:(NSInteger)font
//{
//    CGSize size = CGSizeMake(self.contentView.bounds.size.width, MAXFLOAT);
//    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
//    return rect.size.width+5;
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation CartHeaderAddressCell
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

-(void)withData:(LYAccount *)info
{
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.lineImageView = [[UIImageView alloc] init];
    self.lineImageView.image = [UIImage imageNamed:@"icon_mine_line"];
    [self.contentView addSubview:self.lineImageView];
    self.lineImageView.sd_layout
    .topSpaceToView(self.contentView, 20)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(3)
    .heightIs(20);
    
    self.buyLabel = [[UILabel alloc] init];
    self.buyLabel.text = @"代购编号:";
    self.buyLabel.textAlignment = NSTextAlignmentLeft;
    self.buyLabel.textColor = [UIColor blackColor];
    self.buyLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.buyLabel];
    self.buyLabel.sd_layout
    .topSpaceToView(self.contentView,20)
    .leftSpaceToView(self.lineImageView, 10)
    .widthIs([self widthLabelWithModel:@"代购编号:" withFont:15])
    .heightIs(20);
    
    self.retureList = [[UIButton alloc] init];
    self.retureList.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.retureList setTitle:@"回收清单" forState:UIControlStateNormal];
    [self.retureList setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.retureList addTarget:self action:@selector(retureListClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.retureList];
    self.retureList.sd_layout
    .topSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:@"回收清单" withFont:14]+30)
    .heightIs(20);
    
    self.buy_number = [[UILabel alloc] init];
     self.buy_number.text = info.buyNo;
    self.buy_number.textColor = [UIColor blackColor];
    self.buy_number.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.buy_number];
    self.buy_number.sd_layout
    .topSpaceToView(self.contentView, 20)
    .leftSpaceToView(self.buyLabel, 5)
    .rightSpaceToView(self.retureList, 5)
    .heightIs(20);
    
    
    
    
    self.retureList.layer.cornerRadius = 10;
    self.retureList.layer.masksToBounds = YES;
    self.retureList.layer.borderWidth = .5;
    self.retureList.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    AddressModel *addressModel = [AddressModel mj_objectWithKeyValues:info.defaultAddress];
    if ([addressModel.id length] == 0) {
        [self.contentView addSubview:self.lineView];
        self.lineView.sd_layout
        .topSpaceToView(self.contentView, 20+40)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        [self.contentView addSubview:self.getAddess];
        self.getAddess.text = @"收货地址";
        self.getAddess.sd_layout
        .topSpaceToView(self.lineView, 10)
        .leftSpaceToView(self.contentView, 15)
        .widthIs([self widthLabelWithModel:@"收货地址" withFont:15])
        .heightIs(20);
        
        self.chooseAddress = [[UIControl alloc] init];
        [self.contentView addSubview:self.chooseAddress];
        [self.chooseAddress addTarget:self action:@selector(chooseAddressAction) forControlEvents:UIControlEventTouchUpInside];
        self.chooseAddress.sd_layout
        .topSpaceToView(self.lineView, 10)
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
    }else{
        [self.contentView addSubview:self.localImageView];
        UIImage *image = [UIImage imageNamed:@"icon_addres"];
        self.localImageView.image = image;
        
        
        
        [self.contentView addSubview:self.buyUserName];
        
        
        
        [self.contentView addSubview:self.buyUserTelephone];
        
        
        
        [self.contentView addSubview:self.defaultImageView];
        UIImage *image1 = [UIImage imageNamed:@"tag_moren"];
        
        [self.contentView addSubview:self.buyUserAddess];
        
        
        [self.contentView addSubview:self.lineView];
        
        
        [self.contentView addSubview:self.getAddess];
        self.getAddess.text = @"收货地址";
        
        
        self.chooseAddress = [[UIControl alloc] init];
        [self.contentView addSubview:self.chooseAddress];
        [self.chooseAddress addTarget:self action:@selector(chooseAddressAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIImageView *myImageview = [[UIImageView alloc] init];
        myImageview.image = [UIImage imageNamed:@"编辑"];
        [self.chooseAddress addSubview:myImageview];
        
        
        UILabel *chooseLabel = [[UILabel alloc] init];
        chooseLabel.text = @"选择";
        [self.chooseAddress addSubview:chooseLabel];
        chooseLabel.font = [UIFont systemFontOfSize:14];
        chooseLabel.textColor = [UIColor lightGrayColor];
        chooseLabel.textAlignment = NSTextAlignmentRight;
        
        DefaultAddressMessage *addressMess = [DefaultAddressMessage shareDefaultAddressMessage];
        if ([addressMess.id length] == 0) {
            self.buyUserName.text = addressModel.recNickName;
            NSString *str1 = [addressModel.recPhone substringToIndex:3];
            NSString *str2 = [addressModel.recPhone substringFromIndex:6];
            self.buyUserTelephone.text = [NSString stringWithFormat:@"%@****%@",str1,str2];
            self.buyUserAddess.text = [NSString stringWithFormat:@"%@ %@ %@ %@",addressModel.recProv,addressModel.recCity,addressModel.recArea,addressModel.recAddress];
        }else{
            self.buyUserName.text = addressMess.recNickName;
            NSString *str1 = [addressMess.recPhone substringToIndex:3];
            NSString *str2 = [addressMess.recPhone substringFromIndex:6];
            self.buyUserTelephone.text = [NSString stringWithFormat:@"%@****%@",str1,str2];
            self.buyUserAddess.text = [NSString stringWithFormat:@"%@ %@ %@ %@",addressMess.recProv,addressMess.recCity,addressMess.recArea,addressMess.recAddress];
        }
        
        self.localImageView.sd_layout
        .topSpaceToView(self.contentView, 28+40)
        .leftSpaceToView(self.contentView, 15)
        .widthIs(15)
        .heightIs(15*image.size.height/image.size.width);
        self.buyUserName.sd_layout
        .topSpaceToView(self.contentView, 20+40)
        .leftSpaceToView(self.contentView, 40)
        .widthIs([self widthLabelWithModel:self.buyUserName.text withFont:15])
        .heightIs(20);
        
        self.buyUserTelephone.sd_layout
        .topSpaceToView(self.contentView, 20+40)
        .leftSpaceToView(self.buyUserName, 30)
        .widthIs([self widthLabelWithModel:self.buyUserTelephone.text withFont:15])
        .heightIs(20);
        self.defaultImageView.image = image1;
        self.defaultImageView.sd_layout
        .topSpaceToView(self.contentView, 20+40)
        .leftSpaceToView(self.buyUserTelephone, 5)
        .widthIs(50)
        .heightIs(20);
        self.buyUserAddess.sd_layout
        .topSpaceToView(self.buyUserTelephone, 5)
        .leftSpaceToView(self.contentView, 40)
        .rightSpaceToView(self.contentView, 40)
        .heightIs(20);
        self.lineView.sd_layout
        .topSpaceToView(self.buyUserAddess, 10)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(1);
        self.getAddess.sd_layout
        .topSpaceToView(self.lineView, 10)
        .leftSpaceToView(self.contentView, 15)
        .widthIs([self widthLabelWithModel:@"收货地址" withFont:15])
        .heightIs(20);
        self.chooseAddress.sd_layout
        .topSpaceToView(self.lineView, 10)
        .rightSpaceToView(self.contentView, 15)
        .widthIs(55)
        .heightIs(20);
        myImageview.sd_layout
        .topEqualToView(self.chooseAddress)
        .leftEqualToView(self.chooseAddress)
        .heightIs(20)
        .widthIs(20);
        chooseLabel.sd_layout
        .topEqualToView(self.chooseAddress)
        .rightEqualToView(self.chooseAddress)
        .heightIs(20)
        .widthIs(35);
        
       
    }
   
 
}

- (void)retureListClickAction
{
    self.selectButtonBlock(0);
}

- (void)chooseAddressAction
{
    self.selectButtonBlock(1);
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
- (UILabel *)getAddess {
    if (!_getAddess) {
        _getAddess= [[UILabel alloc] init];
        _getAddess.font = [UIFont systemFontOfSize:14];
        _getAddess.textColor = [UIColor lightGrayColor];
        _getAddess.textAlignment = NSTextAlignmentLeft;
    }
    return _getAddess;
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
        _buyUserAddess.font = [UIFont systemFontOfSize:14];
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
#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString withFont:(NSInteger)font
{
    CGSize size = CGSizeMake(self.contentView.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width+5;
}
@end
