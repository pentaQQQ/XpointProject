//
//  AddressTableViewCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/22.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell
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
    
    self.localImageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"icon_addres"];
    self.localImageView.image = image;
    [self.contentView addSubview:self.localImageView];
    self.localImageView.sd_layout
    .topSpaceToView(self.contentView, 26)
    .leftSpaceToView(self.contentView, 20)
    .widthIs(15)
    .heightIs(15*image.size.height/image.size.width);
    
    self.userNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.userNameLabel];
    self.userNameLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 45)
    .widthIs(100)
    .heightIs(30);
    
    self.iphoneLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.iphoneLabel];
    self.iphoneLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.userNameLabel, 45)
    .widthIs(120)
    .heightIs(30);
    
    self.statusImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.statusImageView];
    self.statusImageView.sd_layout
    .topSpaceToView(self.contentView, 30)
    .rightSpaceToView(self.contentView, 20)
    .widthIs(20)
    .heightIs(20);
    
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.font = [UIFont systemFontOfSize:15];
    self.addressLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.addressLabel];
    self.addressLabel.sd_layout
    .topSpaceToView(self.userNameLabel, 5)
    .leftSpaceToView(self.contentView, 45)
    .widthIs(120)
    .heightIs(20);
    
    self.detailAddressLabel = [[UILabel alloc] init];
    self.detailAddressLabel.font = [UIFont systemFontOfSize:14];
    self.detailAddressLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.detailAddressLabel];
    self.detailAddressLabel.sd_layout
    .topSpaceToView(self.userNameLabel, 5)
    .leftSpaceToView(self.contentView, 130+10+25)
    .widthIs(120)
    .heightIs(20);
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = colorWithRGB(0xEEEEEE);
    
    [self.contentView addSubview:self.lineView];
    self.lineView.sd_layout
    .topSpaceToView(self.detailAddressLabel, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(1);
    
    self.defaultSwitch = [[UISwitch alloc] init];
    [self.defaultSwitch setOn:NO];
    self.defaultSwitch.onTintColor = colorWithRGB(0xFF6B24);
    self.defaultSwitch.transform = CGAffineTransformMakeScale(.8, .8);
    self.defaultSwitch.layer.anchorPoint = CGPointMake(0, 0);
    [self.defaultSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.defaultSwitch];
    self.defaultSwitch.sd_layout
    .topSpaceToView(self.lineView, 12)
    .rightSpaceToView(self.contentView, 10)
    .widthIs(40)
    .heightIs(20);
   
    self.defaultLabel = [[UILabel alloc] init];
    self.defaultLabel.text = @"默认";
    self.defaultLabel.font = [UIFont systemFontOfSize:15];
    self.defaultLabel.textAlignment = NSTextAlignmentCenter;
    self.defaultLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.defaultLabel];
    self.defaultLabel.sd_layout
    .topSpaceToView(self.lineView, 15)
    .rightSpaceToView(self.defaultSwitch, 5)
    .widthIs(40)
    .heightIs(20);
    
    self.editBtn = [[UIButton alloc] init];
    self.editBtn.backgroundColor = colorWithRGB(0xFF6B24);
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.editBtn];
    self.editBtn.sd_layout
    .topSpaceToView(self.lineView, 15)
    .rightSpaceToView(self.defaultLabel, 5)
    .widthIs(40)
    .heightIs(20);
    self.editBtn.layer.cornerRadius = 3;
    self.editBtn.layer.masksToBounds = YES;
    
}
-(void)editBtnAction
{
    self.selectBlcok(0);
}
- (void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
    }else {
    }
}
- (void)configWithModel:(NSMutableArray *)arr
{
    self.userNameLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 45)
    .widthIs([self widthLabelWithModel:arr[0] withFont:17])
    .heightIs(30);
    self.userNameLabel.text = arr[0];
    
    self.iphoneLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.userNameLabel, 10)
    .widthIs([self widthLabelWithModel:arr[1] withFont:17])
    .heightIs(30);
    self.iphoneLabel.text = arr[1];
    
    self.addressLabel.sd_layout
    .topSpaceToView(self.userNameLabel, 5)
    .leftSpaceToView(self.contentView, 45)
    .widthIs([self widthLabelWithModel:arr[2] withFont:15])
    .heightIs(20);
    self.addressLabel.text = arr[2];
    
    self.detailAddressLabel.sd_layout
    .topSpaceToView(self.userNameLabel, 5)
    .leftSpaceToView(self.contentView, [self widthLabelWithModel:arr[2] withFont:15]+10+15+25)
    .widthIs([self widthLabelWithModel:arr[3] withFont:14])
    .heightIs(20);
    self.detailAddressLabel.text = arr[3];
    
    if ([arr[4] intValue] == 1) {
       self.statusImageView.image = [UIImage imageNamed:@"已选中"];
    }else{
        self.statusImageView.image = [UIImage imageNamed:@"未选中"];
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
