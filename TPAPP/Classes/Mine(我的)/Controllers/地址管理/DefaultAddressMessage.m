//
//  DefaultAddressMessage.m
//  TPAPP
//
//  Created by frank on 2018/9/11.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "DefaultAddressMessage.h"
//static dispatch_once_t onceToken;
@implementation DefaultAddressMessage
static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+ (instancetype)shareDefaultAddressMessage
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

//+(void)clear
//{
//    onceToken = 0;
//}

@end
