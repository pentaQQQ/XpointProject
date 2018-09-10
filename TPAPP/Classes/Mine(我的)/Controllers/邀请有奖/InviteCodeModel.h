//
//  InviteCodeModel.h
//  TPAPP
//
//  Created by Frank on 2018/9/5.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InviteCodeModel : NSObject

@property (nonatomic, copy)NSString *createDataTime;
@property (nonatomic, copy)NSString *endDate;
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *inviteCode;
@property (nonatomic, copy)NSString *isDelete;
@property (nonatomic, copy)NSString *isEnable;
@property (nonatomic, copy)NSString *lastUpdTime;
@property (nonatomic, copy)NSString *owner;
@property (nonatomic, copy)NSString *ownerPhone;
@property (nonatomic, copy)NSString *startDate;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *userPhone;

+ (instancetype)statusWithDict:(NSDictionary *)dict;

@end
