//
//  UIButton+LYCountDownButton.h
//  LYSmartCommunity-owner
//
//  Created by 江奔 on 2017/3/7.
//  Copyright © 2017年 liaoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LYCountDownButton)

/**
 倒计时按钮

 @param timeLine 倒计时最大数
 @param title 未计时时title
 @param subTitle 计时时title
 @param mColor 未计时时按钮背景色
 @param color 计时时按钮背景色
 @param titleColor 标题颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color titleColor:(UIColor *)titleColor;
@end
