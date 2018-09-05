//
//  InviteCodeModel.m
//  TPAPP
//
//  Created by Frank on 2018/9/5.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "InviteCodeModel.h"

@implementation InviteCodeModel
MJCodingImplementation

+ (instancetype)statusWithDict:(NSDictionary *)dict
{
    InviteCodeModel *status = [[self alloc] init];
    
    [status setValuesForKeysWithDictionary:dict];
    
    return status;
}
@end
