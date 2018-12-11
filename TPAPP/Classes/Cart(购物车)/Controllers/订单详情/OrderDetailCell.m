//
//  OrderDetailCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "OrderDetailCell.h"
#import "AddressModel.h"
@implementation OrderDetailCell
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
    
    self.goodIcon = [[UIImageView alloc] init];
    self.goodIcon.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.goodIcon];
    self.goodIcon.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(60)
    .heightIs(60);
    
    self.goodPrice = [[UILabel alloc] init];
    self.goodPrice.text = @"¥1000";
    self.goodPrice.textAlignment = NSTextAlignmentRight;
    self.goodPrice.textColor = colorWithRGB(0xFF6B24);
    self.goodPrice.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.goodPrice];
    self.goodPrice.sd_layout
    .topSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .widthIs(100)
    .heightIs(20);
    
    self.goodName = [[UILabel alloc] init];
//    self.goodName.text = @"商品名称";
    self.goodName.textColor = [UIColor blackColor];
    self.goodName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.goodName];
    self.goodName.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.goodIcon, 10)
    .rightSpaceToView(self.goodPrice, 10)
    .heightIs(20);
    
    self.goodSizeTitle = [[UILabel alloc] init];
    self.goodSizeTitle.text = @"规格:";
    self.goodSizeTitle.textColor = [UIColor grayColor];
    self.goodSizeTitle.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goodSizeTitle];
    self.goodSizeTitle.sd_layout
    .topSpaceToView(self.goodName, 5)
    .leftSpaceToView(self.goodIcon, 10)
    .widthIs([self widthLabelWithModel:@"规格:" withFont:12])
    .heightIs(10);
    
    self.goodSize = [[UILabel alloc] init];
    self.goodSize.textColor = [UIColor grayColor];
    self.goodSize.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goodSize];
    self.goodSize.sd_layout
    .topSpaceToView(self.goodName, 5)
    .leftSpaceToView(self.goodSizeTitle, 5)
    .rightSpaceToView(self.contentView, 60)
    .heightIs(10);
    
    self.goodNumber = [[UILabel alloc] init];
    self.goodNumber.textAlignment = NSTextAlignmentRight;
    self.goodNumber.text = @"x1";
    self.goodNumber.textColor = [UIColor grayColor];
    self.goodNumber.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goodNumber];
    self.goodNumber.sd_layout
    .topSpaceToView(self.goodPrice, 5)
    .leftSpaceToView(self.goodSize, 10)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(10);
    
    self.goodRemarkTitle = [[UILabel alloc] init];
    self.goodRemarkTitle.textAlignment = NSTextAlignmentLeft;
    self.goodRemarkTitle.text = @"备注:";
    self.goodRemarkTitle.textColor = colorWithRGB(0xFF6B24);
    self.goodRemarkTitle.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goodRemarkTitle];
    self.goodRemarkTitle.sd_layout
    .topSpaceToView(self.contentView, 15+40)
    .leftSpaceToView(self.goodIcon, 10)
    .widthIs([self widthLabelWithModel:@"备注:" withFont:12])
    .heightIs(20);
    
    self.goodRemark = [[UILabel alloc] init];
    self.goodRemark.textAlignment = NSTextAlignmentLeft;
    self.goodRemark.textColor = colorWithRGB(0xFF6B24);
    self.goodRemark.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goodRemark];
    self.goodRemark.sd_layout
    .topSpaceToView(self.contentView, 15+40)
    .leftSpaceToView(self.goodRemarkTitle, 5)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(20);
    
}

-(void)configWithModel:(OrderDetailModel *)model
{
    [self.goodIcon sd_setImageWithURL:[NSURL URLWithString:model.productImg]];
    self.goodName.text = model.productName;
    self.goodSize.text = model.size;
    self.goodPrice.text = model.productAmount;
    self.goodNumber.text = [NSString stringWithFormat:@"x%ld",model.number];
    self.goodRemark.text = model.remark;
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
@implementation OrderDetailAddressCell
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
    
    self.localImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.localImageView];
    UIImage *image = [UIImage imageNamed:@"icon_addres"];
    self.localImageView.image = image;
    self.localImageView.sd_layout
    .topSpaceToView(self.contentView, 28)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(15)
    .heightIs(15*image.size.height/image.size.width);
    
    self.buyUserTitle = [[UILabel alloc] init];
    self.buyUserTitle.font = [UIFont systemFontOfSize:14];
    self.buyUserTitle.textColor = [UIColor blackColor];
    self.buyUserTitle.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.buyUserTitle];
//    self.buyUserTitle.text = @"代购人:";
    self.buyUserTitle.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 40)
    .widthIs([self widthLabelWithModel:@"代购人:" withFont:14])
    .heightIs(30);
    
    self.buyUserName= [[UILabel alloc] init];
    self.buyUserName.font = [UIFont systemFontOfSize:14];
    self.buyUserName.textColor = [UIColor blackColor];
    self.buyUserName.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.buyUserName];
//    self.buyUserName.text = @"Alan";
//    self.buyUserName.sd_layout
//    .topSpaceToView(self.contentView, 10)
//    .leftSpaceToView(self.buyUserTitle, 5)
//    .heightIs([self widthLabelWithModel:@"Alan" withFont:14])
//    .heightIs(30);
    self.buyUserName.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.buyUserTitle, 5)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(30);
    
//    self.buyUserTelephone= [[UILabel alloc] init];
//    self.buyUserTelephone.font = [UIFont systemFontOfSize:14];
//    self.buyUserTelephone.textColor = [UIColor blackColor];
//    self.buyUserTelephone.textAlignment = NSTextAlignmentLeft;
//    [self.contentView addSubview:self.buyUserTelephone];
//    self.buyUserTelephone.text = @"18501605966";
//    self.buyUserTelephone.sd_layout
//    .topSpaceToView(self.contentView, 10)
//    .leftSpaceToView(self.buyUserName, 10)
//    .widthIs([self widthLabelWithModel:@"18501605966" withFont:14])
//    .heightIs(30);
    
    
    
    self.buyAddessTitle= [[UILabel alloc] init];
    self.buyAddessTitle.font = [UIFont systemFontOfSize:14];
    self.buyAddessTitle.textColor = [UIColor blackColor];
    self.buyAddessTitle.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.buyAddessTitle];
//    self.buyAddessTitle.text = @"代购人:";
    self.buyAddessTitle.sd_layout
    .topSpaceToView(self.buyUserName, 0)
    .leftSpaceToView(self.contentView, 40)
    .widthIs([self widthLabelWithModel:@"收货地址:" withFont:14])
    .heightIs(20);
    
    self.buyUserAddess= [[UILabel alloc] init];
    self.buyUserAddess.font = [UIFont systemFontOfSize:14];
    self.buyUserAddess.textColor = [UIColor blackColor];
    self.buyUserAddess.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.buyUserAddess];
    self.buyUserAddess.text = @"上海市宝山区沪太路3100号A座";
    self.buyUserAddess.sd_layout
    .topSpaceToView(self.buyUserName, 0)
    .leftSpaceToView(self.buyAddessTitle, 5)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(20);
    
}
-(void)configWithModel:(MineIndentModel *)model
{
    self.buyUserTitle.text = @"收货人: ";
//    self.buyUserName.text = model.addressInfo.recNickName;
//    self.buyUserTelephone.text = model.addressInfo.recPhone;
    self.buyUserName.text = [NSString stringWithFormat:@"%@ %@",model.addressInfo.recNickName,model.addressInfo.recPhone];
    self.buyAddessTitle.text = @"收货地址: ";
    self.buyUserAddess.text = [NSString stringWithFormat:@"%@%@%@%@",model.addressInfo.recProv,model.addressInfo.recCity,model.addressInfo.recArea,model.addressInfo.recAddress];
   
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

@implementation OrderDetailMessageCell
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

    
    
    self.goodOrder = [[UILabel alloc] init];
    self.goodOrder.text = @"订单号:";
    self.goodOrder.textAlignment = NSTextAlignmentLeft;
//    self.goodOrder.textColor = colorWithRGB(0xFF6B24);
    self.goodOrder.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.goodOrder];
    self.goodOrder.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:@"订单号:" withFont:14])
    .heightIs(20);
    
    self.goodOrderNumber = [[UILabel alloc] init];
//    self.goodOrderNumber.text = @"3363655";
    self.goodOrderNumber.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.goodOrderNumber];
    self.goodOrderNumber.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.goodOrder, 5)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(20);
    
    self.buyDate = [[UILabel alloc] init];
    self.buyDate.text = @"下单时间:";
//    self.buyDate.textColor = [UIColor grayColor];
    self.buyDate.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.buyDate];
    self.buyDate.sd_layout
    .topSpaceToView(self.goodOrder, 5)
    .leftSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:@"下单时间:" withFont:14])
    .heightIs(20);
    
    self.buyGoodTime = [[UILabel alloc] init];
//    self.buyGoodTime.textAlignment = NSTextAlignmentRight;
//    self.buyGoodTime.text = @"2018-07-22 15:40:22";
    self.buyGoodTime.textColor = [UIColor grayColor];
    self.buyGoodTime.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.buyGoodTime];
    self.buyGoodTime.sd_layout
    .topSpaceToView(self.goodOrder, 5)
    .leftSpaceToView(self.buyDate, 5)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(20);
    
    self.goodStatus = [[UILabel alloc] init];
    self.goodStatus.textAlignment = NSTextAlignmentRight;
//    self.goodStatus.text = @"交易完成";
    self.goodStatus.textColor = [UIColor grayColor];
    self.goodStatus.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.goodStatus];
    self.goodStatus.sd_layout
    .topSpaceToView(self.contentView, 27.5)
    .rightSpaceToView(self.contentView, 15)
    .widthIs([self widthLabelWithModel:@"交易完" withFont:13])
    .heightIs(20);
    
    self.statusIcon = [[UIImageView alloc] init];
    self.statusIcon.image = [UIImage imageNamed:@"已选中"];
//    self.statusIcon.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.statusIcon];
    self.statusIcon.sd_layout
    .topSpaceToView(self.contentView, 27.5)
    .rightSpaceToView(self.goodStatus, 0)
    .widthIs(20)
    .heightIs(20);
}
-(void)configWithModel:(MineIndentModel *)model
{
    self.goodOrderNumber.text = model.id;
    self.buyGoodTime.text = model.createDataTime;
    if ([model.status isEqualToString:@"0"]) {
        self.goodStatus.text = @"待支付";
    }else if ([model.status isEqualToString:@"1"]){
        self.goodStatus.text = @"已支付";
    }else if ([model.status isEqualToString:@"2"]){
        self.goodStatus.text = @"已支付";
    }else if ([model.status isEqualToString:@"3"]){
        self.goodStatus.text = @"已支付";
    }else if ([model.status isEqualToString:@"4"]){
        self.goodStatus.text = @"已支付";
    }else if ([model.status isEqualToString:@"5"]){
        self.goodStatus.text = @"已取消";
    }else if ([model.status isEqualToString:@"6"]){
        self.goodStatus.text = @"已支付";
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
