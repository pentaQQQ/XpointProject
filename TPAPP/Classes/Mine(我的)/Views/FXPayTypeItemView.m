//
//  FXPayTypeItemView.m
//  Fxapp
//
//  Created by 琅琊 on 2018/10/6.
//  Copyright © 2018年 琅琊. All rights reserved.
//
//根据屏幕的比例计算距离
#define WH(R) (R)*(SCREEN_WIDTH)/375.0
#import "FXPayTypeItemView.h"

@interface FXPayTypeItemView()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *subTitleL;
@property (nonatomic, strong) UIImageView *roundIcon;

@end

@implementation FXPayTypeItemView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self addSubview:_icon];
    
    _titleL = [UILabel new];
    _titleL.textColor = [LYTools colorWithHexString:@"333333"];
    _titleL.font = [UIFont systemFontOfSize:14];
    _titleL.text = @"微信支付";
    [self addSubview:_titleL];
    
    _subTitleL = [UILabel new];
    _subTitleL.textColor = [LYTools colorWithHexString:@"999999"];
    _subTitleL.font = [UIFont systemFontOfSize:12];
    _subTitleL.text = @"推荐安装微信用户使用";
    [self addSubview:_subTitleL];
    
    _roundIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"round"]];
    [self addSubview:_roundIcon];
    
    _backBtn = [UIButton new];
    [self addSubview:_backBtn];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(WH(20));
        make.height.width.mas_equalTo(32);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_icon.mas_top);
        make.left.mas_equalTo(_icon.mas_right).offset(9);
    }];
    
    [_subTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_icon.mas_bottom);
        make.left.mas_equalTo(_icon.mas_right).offset(9);
    }];
    
    [_roundIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(-20);
        make.height.width.mas_equalTo(16);
    }];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    _icon.image = [UIImage imageNamed:imageName];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleL.text = title;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    _subTitleL.text = subTitle;
}

- (void)setSelectImageName:(NSString *)selectImageName {
    _selectImageName = selectImageName;
    _roundIcon.image = [UIImage imageNamed:selectImageName];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
