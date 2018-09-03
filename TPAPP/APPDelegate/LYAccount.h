//
//  LYAccount.h
//  LY_Citizen
//
//  Created by 江奔 on 2017/3/27.
//  Copyright © 2017年 江奔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYAccount : NSObject
+ (instancetype)shareAccount;
@property (nonatomic, copy) NSString *buyNo;
@property (nonatomic, copy) NSString *createBy;
@property (nonatomic, copy) NSString *createDataTime;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *identit;
@property (nonatomic, copy) NSString *identitPicF;
@property (nonatomic, copy) NSString *identitPicZ;
@property (nonatomic, copy) NSString *isRemark;
@property (nonatomic, copy) NSString *lastUpdTime;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *openId;
@property (nonatomic, copy) NSString *params;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *searchValue;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *trueName;
@property (nonatomic, copy) NSString *updateBy;
@property (nonatomic, copy) NSString *updateTime;

@end
