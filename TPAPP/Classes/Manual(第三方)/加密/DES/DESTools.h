//
//  DESTools.h
//  66666
//
//  Created by George on 16/10/28.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESTools : NSObject

//字符串加密
+(NSString *)doEncryptStr:(NSString *)originalStr;
//字符串解密
+(NSString*)doDecEncryptStr:(NSString *)encryptStr;

@end
