//
//  AddressModel.m
//  TPAPP
//
//  Created by frank on 2018/9/2.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel
MJCodingImplementation

+ (instancetype)statusWithDict:(NSDictionary *)dict
{
    AddressModel *status = [[self alloc] init];
    
    [status setValuesForKeysWithDictionary:dict];
    
    return status;
}

@end
