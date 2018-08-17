//
//  Validate.h
//  Choose
//
//  Created by George on 16/11/30.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validate : NSObject

//验证输入的是否是手机号码（非电话号码）
+(BOOL)ValidateMobileNumber:(NSString *)text;

//邮箱地址的正则表达式
+ (BOOL)ValidateEmail:(NSString *)email;



@end
