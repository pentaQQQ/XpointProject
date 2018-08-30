//
//  SVProgressHUD+DoAnythingAfter.h
//  DHERSS
//
//  Created by 江奔 on 2017/3/26.
//  Copyright © 2017年 liaoyuan. All rights reserved.
//

#import "SVProgressHUD.h"
@interface SVProgressHUD (DoAnythingAfter)
+ (void)doAnythingWithHUDMessage:(NSString *)message; // 网络请求提示
+ (void)doAnythingSuccessWithHUDMessage:(NSString *)message;// 成功提示
+ (void)doAnythingFailedWithHUDMessage:(NSString *)message;// 错误提示
+ (void)doAnythingSuccessWithHUDMessage:(NSString *)message withDuration:(CGFloat)duration;// 成功提示带时间
+ (void)doAnythingFailedWithHUDMessage:(NSString *)message withDuration:(CGFloat)duration;// 错误提示带时间
+ (void)doAnyRemindWithHUDMessage:(NSString *)message withDuration:(CGFloat)duration;// 提醒带时间
@end
