//
//  Validate.m
//  Choose
//
//  Created by George on 16/11/30.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "Validate.h"

@implementation Validate



//验证输入的是否是手机号码（非电话号码）
+(BOOL)ValidateMobileNumber:(NSString *)text
{
    // 130-139  150-153,155-159  180-189  145,147  170,171,173,176,177,178
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:text];
}

//邮箱地址的正则表达式
+ (BOOL)ValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



@end
