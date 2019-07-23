//
//  radioContentView.m
//  IMSDK-OC
//
//  Created by lishuijiao on 2019/1/10.
//  Copyright © 2019年 HCF. All rights reserved.
//

#import "radioContentView.h"
#import "QMAlert.h"

@interface radioContentView() {
    CGFloat minWidth;
    CGFloat maxWidth;
    CGFloat buttonHeight;
    CGFloat buttonMargin;
    CGFloat titleMargin;
    int startTag;
    NSArray *_reason;
}

@property (nonatomic, strong) UIButton *selectedButton;

@property (nonatomic, strong) NSMutableArray *selectedArray;

@end

@implementation radioContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        minWidth = [QMAlert calcLabelHeight:@"宽度" font:[UIFont systemFontOfSize:14]] + 2 * 10;
        maxWidth = kScreenWidth - 110;
        buttonHeight = 24;
        buttonMargin = 12;
        titleMargin = 10;
        startTag = 700;
    }
    return self;
}

- (void)loadData:(NSArray *)reason {
    _reason = reason;
    
    self.selectedArray = [[NSMutableArray alloc] init];
    
    CGFloat originX = 0;
    CGFloat originY = 0;
    
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    for (int i = 0; i < reason.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.layer.borderColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0].CGColor;
        button.layer.borderWidth = 0.5;
        button.layer.cornerRadius = 2;
        button.layer.masksToBounds = true;
        button.tag = startTag + i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:reason[i] forState:UIControlStateNormal];
        [button setTitleColor: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:243/255.0 green:147/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        CGFloat titleWidth = [QMAlert calcLabelHeight:reason[i] font:[UIFont systemFontOfSize:14]];
        CGFloat buttonWidth = titleWidth + 2 * titleMargin;
        if ((originX + buttonWidth) > maxWidth) {
            originX = 0;
            originY += buttonHeight + buttonMargin;
            button.frame = CGRectMake(originX, originY, buttonWidth, buttonHeight);
        }else {
            button.frame = CGRectMake(originX, originY, buttonWidth, buttonHeight);
        }
        originX += buttonWidth + buttonMargin;
    }
}

- (void)selectAction:(UIButton *)button {
    if (button.selected) {
        button.selected = NO;
        button.layer.borderColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0].CGColor;
        if ([self.selectedArray containsObject:button.titleLabel.text]) {
            [self.selectedArray removeObject:button.titleLabel.text];
        }
    }else{
        button.selected = YES;
        button.layer.borderColor = [UIColor colorWithRed:243/255.0 green:147/255.0 blue:0/255.0 alpha:1.0].CGColor;
        
        if (![self.selectedArray containsObject:button.titleLabel.text]) {
            [self.selectedArray addObject:button.titleLabel.text];
        }
    }
        
    self.selectRadio(self.selectedArray);
}

@end
