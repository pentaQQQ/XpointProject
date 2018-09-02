//
//  SVProgressHUD+DoAnythingAfter.m
//  DHERSS
//
//  Created by 江奔 on 2017/3/26.
//  Copyright © 2017年 liaoyuan. All rights reserved.
//

#import "SVProgressHUD+DoAnythingAfter.h"

@implementation SVProgressHUD (DoAnythingAfter)


// 网络请求提示
+ (void)doAnythingWithHUDMessage:(NSString *)message{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:message];
    
}
// 成功提示
+ (void)doAnythingSuccessWithHUDMessage:(NSString *)message{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showSuccessWithStatus:message];
    
}

// 错误提示
+ (void)doAnythingFailedWithHUDMessage:(NSString *)message{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showErrorWithStatus:message];
}

// 成功提示带时间
+ (void)doAnythingSuccessWithHUDMessage:(NSString *)message withDuration:(CGFloat)duration
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showSuccessWithStatus:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}

// 错误提示带时间
+ (void)doAnythingFailedWithHUDMessage:(NSString *)message withDuration:(CGFloat)duration
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showErrorWithStatus:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

// 提醒带时间
+ (void)doAnyRemindWithHUDMessage:(NSString *)message withDuration:(CGFloat)duration
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showInfoWithStatus:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
