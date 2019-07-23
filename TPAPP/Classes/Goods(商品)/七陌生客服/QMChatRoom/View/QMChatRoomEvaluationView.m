//
//  QMChatRoomEvaluationView.m
//  IMSDK-OC
//
//  Created by lishuijiao on 2019/1/9.
//  Copyright © 2019年 HCF. All rights reserved.
//

#import "QMChatRoomEvaluationView.h"
#import "QMAlert.h"
//#import "radioContentView.h"


@interface QMChatRoomEvaluationView()<UITextViewDelegate>

@property (nonatomic, copy) NSArray *radioValue;

@property (nonatomic, copy) NSString *optionName;

@property (nonatomic, copy) NSString *optionValue;

@property (nonatomic, assign) CGFloat optionHeight;

@end

@implementation QMChatRoomEvaluationView

- (void)createUI {
    
    self.coverView = [[UIView alloc] initWithFrame: [UIScreen mainScreen].bounds];

    self.coverView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.coverView addGestureRecognizer:tapGesture];

    self.backView = [[UIView alloc] initWithFrame:CGRectMake(30, 65, kScreenWidth - 60, 376)];
    self.backView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *backTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.coverView addGestureRecognizer:backTapGesture];
    [self.coverView addSubview:self.backView];
    
    self.titleLabel = [[UILabel alloc] init];
    NSString *str = self.evaluation.title ?: NSLocalizedString(@"button.chat_title", nil);
    self.titleLabel.text = str;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    CGFloat titleHeight = [QMAlert calculateRowHeight:str fontSize:14];
    self.titleLabel.frame = CGRectMake(25, 25, self.backView.frame.size.width - 50., titleHeight);

    [self.backView addSubview:self.titleLabel];

    CGFloat originX = 15;
    CGFloat originY = CGRectGetMaxY(self.titleLabel.frame)+27;
    CGFloat maxWidth = kScreenWidth - 110;
    CGFloat titleMargin = 20; //圆圈宽度
    CGFloat buttonMargin = 15;//button间距
    CGFloat buttonHeight = 21;//button高度
    
    for (int i = 0; i < self.evaluation.evaluats.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:[NSString stringWithFormat:@" %@", self.evaluation.evaluats[i].name] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"evaluat_icon_nor"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"evaluat_icon_sel"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat titleWidth = [QMAlert calcLabelHeight:self.evaluation.evaluats[i].name font:[UIFont systemFontOfSize:14]];
        CGFloat buttonWidth = titleWidth + titleMargin + 5;

        if ((originX + buttonWidth) > maxWidth) {
            originX = 15;
            originY += buttonHeight + buttonMargin;
            button.frame = CGRectMake(originX + 10, originY, buttonWidth, buttonHeight);
        }else {
            button.frame = CGRectMake(originX + 10, originY, buttonWidth, buttonHeight);
        }

        originX += buttonWidth + buttonMargin;
        
        [self.backView addSubview:button];
    }
    
    self.optionHeight = originY + buttonHeight;
    
    self.textView = [[UITextView alloc] init];
    self.textView.frame = CGRectMake(25, originY + buttonHeight + 30, self.backView.frame.size.width - 50, 75);
    self.textView.layer.borderColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0].CGColor;
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.cornerRadius = 2;
    self.textView.layer.masksToBounds = true;
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    [self.backView addSubview:self.textView];
    
    self.sendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backView.frame.size.width/2-85, CGRectGetMaxY(self.textView.frame)+25, 80, 30)];
    [self.sendButton setTitle:@"提交评价" forState:UIControlStateNormal];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.sendButton.backgroundColor = [UIColor colorWithRed:243/255.0 green:147/255.0 blue:0/255.0 alpha:1.0];
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.sendButton];
    
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(self.backView.frame.size.width/2+5, CGRectGetMaxY(self.textView.frame)+25, 50, 30)];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.cancelButton.backgroundColor = [UIColor colorWithRed:243/255.0 green:147/255.0 blue:0/255.0 alpha:1.0];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.cancelButton];
    
    self.backView.frame = CGRectMake(30, 65, kScreenWidth - 60, CGRectGetMaxY(self.cancelButton.frame) + 25);

    [self addSubview:self.coverView];
}

- (void)buttonAction:(UIButton *)button {
    
    [self.textView resignFirstResponder];
    
    if (button == self.selectedButton) {

    }else{
        self.selectedButton.selected = NO;
        button.selected = YES;
        self.selectedButton = button;
        [self.radioView removeFromSuperview];
        [self createReason:button.tag - 100];
    }

        self.optionValue = self.evaluation.evaluats[button.tag - 100].value;
        self.optionName = self.evaluation.evaluats[button.tag - 100].name;
}

- (void)createReason:(NSInteger)number {
    __weak typeof(self) weakSelf = self;

    NSMutableArray * array = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.evaluation.evaluats.count; i++) {
        [array addObject:self.evaluation.evaluats[i].name];
    }
    
    self.radioView = [[radioContentView alloc] initWithFrame:CGRectZero];

    [self.radioView loadData:self.evaluation.evaluats[number].reason];
    self.radioView.frame = CGRectMake(25, self.optionHeight + 25, kScreenWidth - 60 - 50, [self calcHeight:self.evaluation.evaluats[number].reason]);

    self.radioView.selectRadio = ^(NSArray * arr) {
        _radioValue = arr;
        [weakSelf.textView resignFirstResponder];
    };
    [self.backView addSubview:self.radioView];
    if (self.radioView.frame.size.height == 0) {
        self.textView.frame = CGRectMake(25, CGRectGetMaxY(self.radioView.frame) + 5, self.backView.frame.size.width - 50, 75);
    }else {
        self.textView.frame = CGRectMake(25, CGRectGetMaxY(self.radioView.frame) + 30, self.backView.frame.size.width - 50, 75);
    }
    self.sendButton.frame = CGRectMake(self.backView.frame.size.width/2-85, CGRectGetMaxY(self.textView.frame)+25, 80, 30);
    self.cancelButton.frame = CGRectMake(self.backView.frame.size.width/2+5, CGRectGetMaxY(self.textView.frame)+25, 50, 30);
    self.backView.frame = CGRectMake(30, 65, kScreenWidth - 60, CGRectGetMaxY(self.cancelButton.frame) + 25);
}

- (void)sendAction:(UIButton *)button {
    
    if (self.optionName != nil && ![self.optionName  isEqual: @""]) {
        self.sendSelect(self.optionName, self.optionValue, self.radioValue, self.textView.text);
    }else{
        [QMAlert showMessage:@"请选择满意度"];
    }
    
}

- (void)cancelAction:(UIButton *)button {
    self.cancelSelect();
}

- (CGFloat)calcHeight:(NSArray *)array {

    CGFloat maxWidth = kScreenWidth - 110;
    CGFloat buttonHeight = 24;
    CGFloat buttonMargin = 12;
    CGFloat titleMargin = 10;
    CGFloat originX = 15;
    CGFloat originY = 0;
    
    if (array.count == 0) {
        return 0;
    }
        
    for (int i = 0; i < array.count; i++) {
        CGFloat titleWidth = [QMAlert calcLabelHeight:array[i] font:[UIFont systemFontOfSize:14]];
        CGFloat buttonWidth = titleWidth + titleMargin;
        if ((originX + buttonWidth) > maxWidth) {
            originX = 15;
            originY += buttonHeight + buttonMargin;
        }
        originX += buttonWidth + buttonMargin;
    }
    
    return originY + buttonHeight;
}

- (void)tapAction{
    [self.textView resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.frame = CGRectMake(30, 65, kScreenWidth - 60, CGRectGetMaxY(self.cancelButton.frame) + 25);
    }];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.frame = CGRectMake(30, 0, kScreenWidth - 60, CGRectGetMaxY(self.cancelButton.frame) + 25);
    }];
    return true;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self tapAction];
}
@end

