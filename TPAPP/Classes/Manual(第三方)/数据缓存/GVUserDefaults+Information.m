//
//  GVUserDefaults+Information.m
//  OA
//
//  Created by George on 16/10/31.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "GVUserDefaults+Information.h"

@implementation GVUserDefaults (Information)
@dynamic login;
@dynamic account;
@dynamic password;
@dynamic personal;
@dynamic accessToken;
@dynamic memberId;   //会员ID
@dynamic memberName; //会员姓名
@dynamic mobile;     //手机号
@dynamic email;      //邮箱
@dynamic portrail;   //头像
@dynamic drop_tag;
@dynamic shoppingList_type;

- (NSDictionary *)setupDefaults {
    return @{
//             @"account": @"default account"
             @"personal":@(NO),
             };
}

-(void)cleanData {
//    self.studentId = 0;
//    self.account = @"";
//    self.password = @"";
//    self.haveLogin = NO;
    self.login = NO;
    self.password = @"";
    self.personal = YES;
}

- (NSString *)transformKey:(NSString *)key {
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] uppercaseString]];
    return [NSString stringWithFormat:@"NSUserDefault%@", key];
}

@end
