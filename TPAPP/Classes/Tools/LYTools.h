//
//  LYTools.h
//  LYSmartCommunity-owner
//
//  Created by xiaocui on 17/3/6.
//  Copyright © 2017年 liaoyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XYSideViewController.h"
#import "SideViewController.h"
#import "BaseTabBarController.h"
#import "LoginViewController.h"
@interface LYTools : NSObject
//通过RGB取颜色
+ (UIColor *)getColorFromRGB:(NSString *)inColorString;
// 通过hex取色
+ (UIColor *)colorWithHexString:(NSString *)color;
// 生成富文本字符串
+ (NSAttributedString *)attributedStringWithFont:(CGFloat)font color:(UIColor *)color string:(NSString *)string;
//lab根据字体的多少计算高度
+(CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width ;
//lab根据字体的多少计算宽度
+(CGFloat) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height;
// 字典和字符串互转
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dict;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;
+ (NSString *)jsonStringWithArray:(NSArray *)arr;
//字符串比较
+(BOOL)compareString:(NSString *)string WithAnotherString:(NSString *)otherString;
//判断是否为手机号码
+(BOOL)isTelphoneWithPhonenum:(NSString *)phonenumber;
//获取当前的日期  返回的是时间戳
+(NSString *)catchTheStartTime;
//获取当前的日期
+(NSString *)catchThecurrentTime;
+(NSString *)catchCurrentTime;
+(NSString *)catchCurrentHourAndMin;
// 字符串转base64
+ (NSString *)base64StringFromText:(NSString *)text;
// 将image转为base64 string
+ (NSString *)transImageToBase64Str:(UIImage *)newImage;
// 车牌号校验
+ (BOOL)checkCarID:(NSString *)carID;
// 读取json文件
+ (NSArray *)getAllTextValuesFromJsonFile:(NSString *)jsonFileName;
/** 提示框 无操作 */
+ (void)showAlertControllerWithTitle:(NSString *)title msg:(NSString *)message onController:(UIViewController *)vc;
/** 提示框 */
+ (void)showAlertControllerWithTitle:(NSString *)title msg:(NSString *)message onController:(UIViewController *)vc action:(void(^)(void))sureAction;

/** 带txt的提示框 */
+ (void)showTextFiledAlertControllerWithTitle:(NSString *)title
                                          msg:(NSString *)message
                                    tfSetting:(void(^)(UITextField *textField))tfSetting
                                 onController:(UIViewController *)vc
                                       action:(void(^)(NSString *tfValue))sureAction;



/** 十进制转二进制*/
+ (NSString *)decimalTOBinary:(uint16_t)tmpid backLength:(int)length;
//邮箱正则
+ (BOOL) validateEmail:(NSString *)email;

+ (UIImage *)qrCodeImageWithInfo:(NSString *)info  width:(CGFloat)width;
+(void)mySort:(NSMutableArray*)mutArray andInterger:(NSInteger)interger;
+(void)setUpTabbarController;
+(void)ToLogin;
@end
