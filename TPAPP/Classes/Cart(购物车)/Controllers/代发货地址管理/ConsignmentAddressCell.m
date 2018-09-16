//
//  ConsignmentAddressCell.m
//  TPAPP
//
//  Created by frank on 2018/9/14.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "ConsignmentAddressCell.h"
#import "AddressModel.h"
@implementation ConsignmentAddressCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    
    
}


- (void)defaultImageViewAction:(UIButton *)btn
{
    self.selectBlcok(1,self.addressModel);
}
-(void)editBtnAction:(UIButton *)btn
{
    self.selectBlcok(0,self.addressModel);
}
- (void)configWithModel:(AddressModel *)model withBool:(BOOL)isCartType
{
    self.addressModel = model;
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
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
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
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
    .topSpaceToView(self.recDetailAddressLabel, 10)
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .heightIs(1);
    
    
    
    self.defaultImageView = [[UIButton alloc] init];
    [self.defaultImageView addTarget:self action:@selector(defaultImageViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.defaultImageView setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.defaultImageView];
    UIImage *image1 = [UIImage imageNamed:@"icon_close"];
    self.defaultImageView.sd_layout
    .topSpaceToView(self.bottomLineView, 10)
    .rightSpaceToView(self.contentView, 20)
    .widthIs(20*(image1.size.width/image1.size.height))
    .heightIs(20);
    
    
    self.defaultLabel = [[UILabel alloc] init];
    self.defaultLabel.text = @"默认";
    self.defaultLabel.font = [UIFont systemFontOfSize:15];
    self.defaultLabel.textAlignment = NSTextAlignmentCenter;
    self.defaultLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.defaultLabel];
    self.defaultLabel.sd_layout
    .topSpaceToView(self.bottomLineView, 10)
    .rightSpaceToView(self.defaultImageView, 5)
    .widthIs(40)
    .heightIs(20);
    
    self.editBtn = [[UIButton alloc] init];
    self.editBtn.backgroundColor = colorWithRGB(0xFF6B24);
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.editBtn];
    self.editBtn.sd_layout
    .topSpaceToView(self.bottomLineView, 10)
    .rightSpaceToView(self.defaultLabel, 5)
    .widthIs(40)
    .heightIs(20);
    self.editBtn.layer.cornerRadius = 3;
    self.editBtn.layer.masksToBounds = YES;
    if ([model.isDefault intValue] == 1) {
        [self.defaultImageView setImage:[UIImage imageNamed:@"icon_open"] forState:UIControlStateNormal];
    }else{
        [self.defaultImageView setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
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
