//
//  UIAlertController+Extension.m
//  LifeStyle
//
//  Created by liuxiaowu on 16/9/22.
//  Copyright © 2016年 liuxiaowu. All rights reserved.
//

#import "UIAlertController+Extension.h"

@implementation UIAlertController (Extension)

//UIAlertControllerStyleAlert
+ (instancetype)alertStyleControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message
{
    return [UIAlertController alertControllerWithTitle:title
                                               message:message
                                        preferredStyle:UIAlertControllerStyleAlert];
}

//UIAlertControllerStyleActionSheet
+ (instancetype)actionSheetStyleControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message
{
    return [UIAlertController alertControllerWithTitle:title
                                               message:message
                                        preferredStyle:UIAlertControllerStyleActionSheet];
}

//default
- (void)addActionWithTitle:(nonnull NSString *)title handler:(void (^ __nullable)( UIAlertAction * _Nonnull action))handler{
    [self addActionWithTitle:title
                       style:UIAlertActionStyleDefault
                     handler:handler];
}

//cancel
- (void)addCancelActionWithTitle:(nonnull NSString *)title handler:(void (^ __nullable)(UIAlertAction * _Nonnull action))handler{
    [self addActionWithTitle:title
                       style:UIAlertActionStyleCancel
                     handler:handler];
}

//destructive
- (void)addDestructiveActionWithTitle:(nonnull NSString *)title handler:(void (^ __nullable)(UIAlertAction  * _Nonnull action))handler{
    [self addActionWithTitle:title
                       style:UIAlertActionStyleDestructive
                     handler:handler];
}

//add action
- (void)addActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction * _Nonnull))handler
{
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:title
                                                          style:style
                                                        handler:handler];
    [self addAction:alertAction];
}

//show alert, default has animation
- (void)showWithController:(UIViewController *)controller
{
    [self showWithController:controller animation:YES];
}

//show alert
- (void)showWithController:(UIViewController *)controller animation:(BOOL)animation{
    [controller presentViewController:self animated:animation completion:nil];
}

@end
