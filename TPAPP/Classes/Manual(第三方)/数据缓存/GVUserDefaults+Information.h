//
//  GVUserDefaults+Information.h
//  OA
//
//  Created by George on 16/10/31.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <GVUserDefaults/GVUserDefaults.h>
#define USERINFO [GVUserDefaults standardUserDefaults]

@interface GVUserDefaults (Information)

@property (nonatomic, copy)   NSString *account;                  //账号
@property (nonatomic, copy)   NSString *password;                  //使用aes加密后的密码

@property (nonatomic, assign, getter=isLogin) BOOL login;                      //是否登录
@property (nonatomic, assign, getter=isPsersonal) BOOL personal;               //个人帐户登录

@property (nonatomic, copy)   NSString *accessToken;                  //请求接口的access Token

@property (nonatomic, copy)   NSString *memberId;   //会员ID
@property (nonatomic, copy)   NSString *memberName; //会员姓名
@property (nonatomic, copy)   NSString *mobile;     //手机号
@property (nonatomic, copy)   NSString *email;      //邮箱
@property (nonatomic, copy)   NSString *portrail;   //头像


@property (nonatomic,assign) NSInteger drop_tag;     /*下拉按钮的tag值*/
@property (nonatomic,assign) NSInteger shoppingList_type; /*购物车列表页cell的类型*/


-(void)cleanData;


@end
