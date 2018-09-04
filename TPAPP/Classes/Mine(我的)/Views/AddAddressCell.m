//
//  AddAddressCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/22.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "AddAddressCell.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "AddressModel.h"
@interface AddAddressCell ()<UITextViewDelegate,UITextFieldDelegate>
@end
@implementation AddAddressCell
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

- (void)configWithModel:(NSMutableArray *)arr withModelData:(NSMutableArray *)modelArr
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if ([arr[2] intValue] == 0) {
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.text = arr[0];
        self.titleLabel.sd_layout
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.contentView, 15)
        .widthIs([self widthLabelWithModel:arr[0] withFont:14])
        .heightIs(20);
        
        [self.contentView addSubview:self.myTextField];
        self.myTextField.delegate = self;
        self.myTextField.font = [UIFont systemFontOfSize:15];
        self.myTextField.sd_layout
        .topSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.titleLabel, 30)
        .heightIs(20);
        self.myTextField.textAlignment = NSTextAlignmentRight;
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentRight;
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:arr[1] attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
        self.myTextField.attributedPlaceholder = attri;
        
    }else if ([arr[2] intValue] == 1){
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.text = arr[0];
        self.titleLabel.sd_layout
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.contentView, 15)
        .widthIs([self widthLabelWithModel:arr[0] withFont:14])
        .heightIs(20);
        
        [self.contentView addSubview:self.addressLabel];
        self.addressLabel.text = nil;
        self.addressLabel.textAlignment = NSTextAlignmentRight;
        self.addressLabel.sd_layout
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.titleLabel, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(20);
        
    }else if ([arr[2] intValue] == 2){
        [self.contentView addSubview:self.myTextView];
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"请输入详细地址";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor lightGrayColor];
        [placeHolderLabel sizeToFit];
        [self.myTextView addSubview:placeHolderLabel];
        self.myTextView.delegate = self;
        // same font
        self.myTextView.font = [UIFont systemFontOfSize:14.f];
        placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
        [self.myTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
        self.myTextView.sd_layout
        .topSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.contentView, 10)
        .widthIs(kScreenWidth-20)
        .heightIs(50);
        
    }else if ([arr[2] intValue] == 3){
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.text = arr[0];
        self.titleLabel.sd_layout
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.contentView, 15)
        .widthIs([self widthLabelWithModel:arr[0] withFont:14])
        .heightIs(20);
        
        [self.contentView addSubview:self.defaultSwitch];
        self.myBlock(@{@"isDefault":[NSString stringWithFormat:@"%d",[self.defaultSwitch isOn]]});
        self.defaultSwitch.sd_layout
        .topSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 10)
        .widthIs(40)
        .heightIs(20);
    }
    if (modelArr.count != 0) {
        if ([arr[2] intValue] == 0) {
            self.myTextField.text = modelArr[0];
//            if ([self.titleLabel.text isEqualToString:@"收货人:"]) {
//                self.myBlock(@{@"recNickName":self.myTextField.text});
//            }else if ([self.titleLabel.text isEqualToString:@"电    话:"]){
//                self.myBlock(@{@"recPhone":self.myTextField.text});
//            }else if ([self.titleLabel.text isEqualToString:@"身份证号码:"]){
//                self.myBlock(@{@"recIdentityCardNo":self.myTextField.text});
//            }
        }else if ([arr[2] intValue] == 1){
            self.addressLabel.text =modelArr[0];
        }else if ([arr[2] intValue] == 2){
            self.myTextView.text = modelArr[0];
//            NSArray *addArr = [modelArr[0] componentsSeparatedByString:@" "];
            
//            self.myBlock(@{@"recAddress":self.myTextView.text});
        }else if ([arr[2] intValue] == 3){
            if ([modelArr[0] intValue] == 0) {
                [self.defaultSwitch setOn:NO animated:YES];
            }else{
                [self.defaultSwitch setOn:YES animated:YES];
            }
            self.myBlock(@{@"isDefault":[NSString stringWithFormat:@"%d",[self.defaultSwitch isOn]]});
        }
    }
}
- (void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    self.myBlock(@{@"isDefault":[NSString stringWithFormat:@"%d",isButtonOn]});
    if (isButtonOn) {
    }else {
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
     NSLog(@"textField12 ________%@",textField.text);
    if ([self.titleLabel.text isEqualToString:@"收货人:"]) {
        self.myBlock(@{@"recNickName":self.myTextField.text});
    }else if ([self.titleLabel.text isEqualToString:@"电    话:"]){
         self.myBlock(@{@"recPhone":self.myTextField.text});
    }else if ([self.titleLabel.text isEqualToString:@"身份证号码:"]){
         self.myBlock(@{@"recIdentityCardNo":self.myTextField.text});
    }
}


-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"textView1 ==%@",textView.text);
    self.myBlock(@{@"recAddress":self.myTextView.text});
}



#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString withFont:(NSInteger)font
{
    CGSize size = CGSizeMake(self.contentView.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width+5;
}
- (UISwitch *)defaultSwitch
{
    if (_defaultSwitch == nil) {
        _defaultSwitch = [[UISwitch alloc] init];
        [_defaultSwitch setOn:NO];
        _defaultSwitch.onTintColor = colorWithRGB(0xFF6B24);
        _defaultSwitch.transform = CGAffineTransformMakeScale(.8, .8);
        _defaultSwitch.layer.anchorPoint = CGPointMake(0, 0);
         [_defaultSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _defaultSwitch;
}
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}
- (UILabel *)addressLabel
{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:13];
    }
    return _addressLabel;
}
-(UITextField *)myTextField
{
    if (_myTextField == nil) {
        _myTextField = [[UITextField alloc] init];
    }
    return _myTextField;
}
-(UITextView *)myTextView
{
    if (_myTextView == nil) {
        _myTextView = [[UITextView alloc] init];
    }
    return _myTextView;
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
