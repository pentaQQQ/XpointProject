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
@interface AddAddressCell ()<UITextViewDelegate>
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
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
}

- (void)configWithModel:(NSMutableArray *)arr
{
    if ([arr[2] intValue] == 0) {
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.text = arr[0];
        self.titleLabel.sd_layout
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.contentView, 15)
        .widthIs([self widthLabelWithModel:arr[0] withFont:14])
        .heightIs(20);
        
        [self.contentView addSubview:self.myTextField];
        self.myTextField.font = [UIFont systemFontOfSize:15];
//        self.myTextField.placeholder = arr[1];
        self.myTextField.sd_layout
        .topSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.titleLabel, 30)
        .heightIs(20);
        //    self.roomNameTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
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
        
        // same font
        self.myTextView.font = [UIFont systemFontOfSize:14.f];
        placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
        [self.myTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
//        self.myTextView.text = arr[0];
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
        self.defaultSwitch.sd_layout
        .topSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 10)
        .widthIs(40)
        .heightIs(20);
    }
}
- (void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
    }else {
    }
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
        // 通过运行时，发现UITextView有一个叫做“_placeHolderLabel”的私有变量
//        unsigned int count = 0;
//        Ivar *ivars = class_copyIvarList([UITextView class], &count);
//
//        for (int i = 0; i < count; i++) {
//            Ivar ivar = ivars[i];
//            const char *name = ivar_getName(ivar);
//            NSString *objcName = [NSString stringWithUTF8String:name];
//            NSLog(@"%d : %@",i,objcName);
//        }
        _myTextView = [[UITextView alloc] init];
//        _myTextView.font = [UIFont systemFontOfSize:14];
        // _placeholderLabel
       
//        _myTextView.zw_placeHolder = @"请输入详细地址";
//        _myTextView.zw_limitCount = 30;
//        _myTextView.zw_placeHolderColor = [UIColor lightGrayColor];
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
