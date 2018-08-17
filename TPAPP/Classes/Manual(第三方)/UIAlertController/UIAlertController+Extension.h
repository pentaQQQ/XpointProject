//
//  UIAlertController+Extension.h
//  LifeStyle
//
//  Created by liuxiaowu on 16/9/22.
//  Copyright © 2016年 liuxiaowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Extension)

//UIAlertControllerStyleAlert
+ (nonnull instancetype)alertStyleControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

//UIAlertControllerStyleActionSheet
+ (nonnull instancetype)actionSheetStyleControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

//default
- (void)addActionWithTitle:(nonnull NSString *)title handler:(void (^ __nullable)( UIAlertAction * _Nonnull action))handler;
//cancel
- (void)addCancelActionWithTitle:(nonnull NSString *)title handler:(void (^ __nullable)(UIAlertAction * _Nonnull action))handler;
//destructive
- (void)addDestructiveActionWithTitle:(nonnull NSString *)title handler:(void (^ __nullable)(UIAlertAction  * _Nonnull action))handler;
//show alert, default has animation
- (void)showWithController:(nonnull UIViewController *)controller;
//show alert
- (void)showWithController:(nonnull UIViewController *)controller animation:(BOOL)animation;

@end
