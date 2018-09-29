//
//  QMLeaveMessageCell.m
//  IMSDK-OC
//
//  Created by haochongfeng on 2017/11/27.
//  Copyright © 2017年 HCF. All rights reserved.
//

#import "QMLeaveMessageCell.h"

@interface QMLeaveMessageCell ()

@end

@implementation QMLeaveMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.fieldLabel = [[UILabel alloc] init];
    self.fieldLabel.frame = CGRectMake(15, 7, 100, 30);
    self.fieldLabel.backgroundColor = [UIColor clearColor];
    self.fieldLabel.font = [UIFont systemFontOfSize:14];
    self.fieldLabel.text = NSLocalizedString(@"title.phoneNumber", nil);
    self.fieldLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self.contentView addSubview:self.fieldLabel];

    self.textField = [[UITextField alloc] init];
    self.textField.frame = CGRectMake(15 + 100, 7, kScreenWidth - 30 - 100, 30);
    self.textField.backgroundColor = [UIColor clearColor];
    self.textField.textAlignment = NSTextAlignmentRight;
    self.textField.font = [UIFont systemFontOfSize:16];
    self.textField.placeholder = NSLocalizedString(@"title.selection", nil);
    [self.contentView addSubview:self.textField];
    
    [self.textField addTarget:self action:@selector(change:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setData: (NSDictionary *)information defaultValue: (NSString *)value {
    self.textField.text = @"";
    if (information[@"name"]) {
        self.fieldLabel.text = information[@"name"];
    }
    
    if (information[@"required"]) {
        BOOL required = [[information objectForKey:@"required"] boolValue];
        if (required == YES) {
            self.textField.placeholder = NSLocalizedString(@"title.required", nil);
        }else {
            self.textField.placeholder = NSLocalizedString(@"title.selection", nil);
        }
    }else {
        self.textField.placeholder = NSLocalizedString(@"title.selection", nil);
    }
    
    if (value) {
        self.textField.text = value;
    }
}

- (void)change: (UITextField *)textF {
    self.backInformation(textF.text);
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
