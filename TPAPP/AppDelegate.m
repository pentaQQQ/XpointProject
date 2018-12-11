//
//  AppDelegate.m
//  TPAPP
//
//  Created by 上海点硕 on 2017/7/18.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "XYSideViewController.h"
#import "SideViewController.h"
#import "IQKeyboardManager.h"
#import "LoginViewController.h"
#import "WXApiManager.h"
#import "AddressModel.h"

#import "QMProfileManager.h"
#import <UserNotifications/UserNotifications.h>
#import <QMChatSDK/QMChatSDK.h>
#import <QMChatSDK/QMChatSDK-Swift.h>
#import "QMManager.h"

#import "NewLoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self chooseTheRootViewController];
   
    
    [self initKeyboard];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isMyCtrl"];
    
    
    [WXApi startLogByLevel:WXLogLevelNormal logBlock:^(NSString *log) {
        NSLog(@"log : %@", log);
    }];
    
    [WXApi registerApp:WeChateappid enableMTA:YES];
    
    
    //向微信注册支持的文件类型
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    
    [WXApi registerAppSupportContentFlag:typeFlag];
    
    
    
    
    
    
     [self registerUserNotification];
    
    /**
     创建文件管理类
     name: 可随便填写
     password: 可随便填写
     */
    QMProfileManager *manger = [QMProfileManager sharedInstance];
    [manger loadProfile:@"moor" password:@"123456"];
    
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    return YES;
}





-(void)chooseTheRootViewController{
    
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token.length>6) {
        // 侧拉VC
        SideViewController *leftViewController = [[SideViewController alloc] init];
        //市场人员
        BaseTabBarController *tabar = [[BaseTabBarController alloc] init];

        // 初始化XYSideViewController 设置为window.rootViewController
        XYSideViewController *rootViewController = [[XYSideViewController alloc] initWithSideVC:leftViewController currentVC:tabar];

        self.window.rootViewController = rootViewController;
        
        [self getPeopleInfomation];


    }else{
    
        NewLoginViewController*vc = [[NewLoginViewController alloc]init];
        RTRootNavigationController *rootVC= [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:vc];
        rootVC.rt_disableInteractivePop = YES ;
        self.window.rootViewController = rootVC;
    }
    
    
}








-(void)initKeyboard
{
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    manager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    manager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    manager.keyboardDistanceFromTextField = 10.0f;
    
    
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPaytype" object:resultDic];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        //        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
        //            NSLog(@"result = %@",resultDic);
        //            // 解析 auth code
        //            NSString *result = resultDic[@"result"];
        //            NSString *authCode = nil;
        //            if (result.length>0) {
        //                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
        //                for (NSString *subResult in resultArr) {
        //                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
        //                        authCode = [subResult substringFromIndex:10];
        //                        break;
        //                    }
        //                }
        //            }
        //            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        //        }];
    }
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPaytype" object:resultDic];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        //        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
        //            NSLog(@"result = %@",resultDic);
        //            // 解析 auth code
        //            NSString *result = resultDic[@"result"];
        //            NSString *authCode = nil;
        //            if (result.length>0) {
        //                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
        //                for (NSString *subResult in resultArr) {
        //                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
        //                        authCode = [subResult substringFromIndex:10];
        //                        break;
        //                    }
        //                }
        //            }
        //            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        //        }];
    }
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}



-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *rep = (SendAuthResp*)resp;
        if (rep.errCode == 0) {//成功
            [[NSNotificationCenter defaultCenter]postNotificationName:@"WXAuthorizationSuccess" object:@{@"code":rep.code}];
        }
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    //断开连接
    [QMConnect logout];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}
//获取用户信息
-(void)getPeopleInfomation{
    
    [[NetworkManager sharedManager]getWithUrl:getinfomation param:nil success:^(id json) {
        NSLog(@"%@",json);
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]){
            // 单例赋值
            [LYAccount mj_objectWithKeyValues:json[@"data"]];
        }
    } failure:^(NSError *error) {
    }];
    
}






















- (void)registerUserNotification {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
    
}

// 远程通知注册成功委托
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"注册deviceToken");
    [QMConnect setServerToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@" userinfo ===== %@", userInfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSString *messageAlert = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
    
    if (application.applicationState == UIApplicationStateActive) {
        [application setApplicationIconBadgeNumber:0];
        //弹框通知
        UIAlertController * stateAlert = [UIAlertController alertControllerWithTitle:@"客服新消息" message:messageAlert preferredStyle:UIAlertControllerStyleAlert];
        [stateAlert addAction:[UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [QMConnect registerSDKWithAppKey:@"" userName:@"" userId:@""];
        }]];
        [stateAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self.window.rootViewController presentViewController:stateAlert animated:YES completion:nil];
    }else {
        [QMConnect registerSDKWithAppKey:@"" userName:@"" userId:@""];
    }
    
    [QMManager defaultManager].selectedPush = YES;
}




@end
