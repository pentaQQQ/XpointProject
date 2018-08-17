//
//  AESTools.m
//  66666
//
//  Created by George on 16/10/28.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "AESTools.h"

#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "NSData+CommonCrypto.h"

@implementation AESTools

//密匙 key
#define DESKey            @"Kyle_Chu"


//字符串加密
+(NSString *)doEncryptStr:(NSString *)originalStr {
    NSData *data = [originalStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [data AES256EncryptedDataUsingKey:DESKey error:nil];
    NSString *base64encodedstr = [NSString base64StringFromData:encryptedData length:encryptedData.length];
    return base64encodedstr;
}

//字符串解密
+(NSString*)doDecEncryptStr:(NSString *)encryptStr {
    NSData *encryptedData = [NSData base64DataFromString:encryptStr];
    NSData *decryptedData = [encryptedData decryptedAES256DataUsingKey:DESKey error:nil];
    NSString *result = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    return result;
}

@end
