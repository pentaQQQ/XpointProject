//
//  LYAccount.m
//  LY_Citizen
//
//  Created by 江奔 on 2017/3/27.
//  Copyright © 2017年 江奔. All rights reserved.
//

#import "LYAccount.h"
#import "AddressModel.h"
@implementation LYAccount
static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+ (instancetype)shareAccount
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}
@end
