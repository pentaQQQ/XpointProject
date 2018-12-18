//
//  FXPayTypeView.m
//  Fxapp
//
//  Created by 琅琊 on 2018/10/6.
//  Copyright © 2018年 琅琊. All rights reserved.
//

#define itemH 55.5
//根据屏幕的比例计算距离
#define WH(R) (R)*(SCREEN_WIDTH)/375.0
#import "FXPayTypeView.h"
#import "FXPayTypeItemView.h"

@interface FXPayTypeView()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *exitBtn;

@property (nonatomic, strong) FXPayTypeItemView *wxPayView;
@property (nonatomic, strong) FXPayTypeItemView *aliPayView;

@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, assign) NSInteger selectType;

@end

@implementation FXPayTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 210)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    _topView = [UIView new];
    [_contentView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self->_contentView);
        make.height.mas_equalTo(40);
    }];
    
    _exitBtn = [UIButton new];
    [_exitBtn setImage:[UIImage imageNamed:@"close_black"] forState:UIControlStateNormal];
    [_topView addSubview:_exitBtn];
    [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self->_topView);
        make.width.mas_equalTo(54);
    }];
    [_exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UILabel *title = [UILabel new];
    title.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    title.font = [UIFont systemFontOfSize:14];
    title.text = @"选择支付方式";
    [_topView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self->_topView);
        make.centerY.mas_equalTo(self->_topView);
    }];
    
    UIView *line = [UIView new];
    
    line.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0];
    [_contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self->_contentView);
        make.top.mas_equalTo(self->_topView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    _wxPayView = [[FXPayTypeItemView alloc] init];
    _wxPayView.imageName = @"wxPay";
    _wxPayView.title = @"微信支付";
    _wxPayView.subTitle = @"推荐安装微信用户使用";
    [_contentView addSubview:_wxPayView];
    [_wxPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self->_contentView);
        make.top.mas_equalTo(line.mas_bottom);
        make.height.mas_equalTo(itemH);
    }];
    [_wxPayView.backBtn addTarget:self action:@selector(wxPayViewClick) forControlEvents:UIControlEventTouchUpInside];
    _aliPayView = [[FXPayTypeItemView alloc] init];
    _aliPayView.imageName = @"aliPay";
    _aliPayView.title = @"支付宝支付";
    _aliPayView.subTitle = @"推荐有支付宝账号的用户使用";
    [_contentView addSubview:_aliPayView];
    [_aliPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self->_contentView);
        make.top.mas_equalTo(self->_wxPayView.mas_bottom);
        make.height.mas_equalTo(itemH);
    }];
    [_aliPayView.backBtn addTarget:self action:@selector(aliPayViewClick) forControlEvents:UIControlEventTouchUpInside];
    _wxPayView.selectImageName = @"round_check_fill";
    _aliPayView.selectImageName = @"round";
    _selectType = 2;
    
    _sureBtn = [UIButton new];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureBtn setBackgroundColor:[UIColor colorWithRed:2/255.0 green:115/255.0 blue:238/255.0 alpha:1.0]];
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _sureBtn.layer.cornerRadius = 5;
    _sureBtn.layer.shadowColor =[UIColor colorWithRed:5/255.0 green:117/255.0 blue:239/255.0 alpha:1.0].CGColor;
    _sureBtn.layer.shadowOffset = CGSizeMake(0, 1);
    _sureBtn.layer.shadowOpacity = 0.4;
    _sureBtn.layer.shadowRadius = 2;
    [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_contentView addSubview:_sureBtn];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_contentView).offset(WH(20));
        make.right.mas_equalTo(self->_contentView).offset(WH(-20));
        make.bottom.mas_equalTo(self->_contentView).offset(-10);
        make.height.mas_equalTo(38);
    }];
    [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)show {
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self->_contentView.frame;
        rect.origin.y = SCREEN_HEIGHT - 210;
        self->_contentView.frame = rect;
    }];
}

- (void)hide{
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self->_contentView.frame;
        rect.origin.y = SCREEN_HEIGHT;
        self->_contentView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)sureBtnClick {
    NSLog(@"--- exitBtnClick ---");
    self.selectTypeBlock(_selectType);
    [self hide];
}
- (void)exitBtnClick {
    NSLog(@"--- exitBtnClick ---");
    [self hide];
}

- (void)wxPayViewClick {
    NSLog(@"--- wxPayViewClick ---");
    _wxPayView.selectImageName = @"round_check_fill";
    _aliPayView.selectImageName = @"round";
    _selectType = 2;
}

- (void)aliPayViewClick {
    NSLog(@"--- aliPayViewClick ---");
    _wxPayView.selectImageName = @"round";
    _aliPayView.selectImageName = @"round_check_fill";
    _selectType = 1;
}

@end
