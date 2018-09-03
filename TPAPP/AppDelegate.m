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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self chooseTheRootViewController];
    
    
    [self initKeyboard];
    
    [WXApi startLogByLevel:WXLogLevelNormal logBlock:^(NSString *log) {
        NSLog(@"log : %@", log);
    }];
    
    [WXApi registerApp:WeChateappid enableMTA:YES];
    
    
    //向微信注册支持的文件类型
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    
    [WXApi registerAppSupportContentFlag:typeFlag];
    
    return YES;
}





-(void)chooseTheRootViewController{
    
//    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
//    if (token.length>6) {
//        // 侧拉VC
//        SideViewController *leftViewController = [[SideViewController alloc] init];
//        //市场人员
//        BaseTabBarController *tabar = [[BaseTabBarController alloc] init];
//
//        // 初始化XYSideViewController 设置为window.rootViewController
//        XYSideViewController *rootViewController = [[XYSideViewController alloc] initWithSideVC:leftViewController currentVC:tabar];
//
//        self.window.rootViewController = rootViewController;
//
//
//    }else{
    
        LoginViewController*vc = [[LoginViewController alloc]init];
        RTRootNavigationController *rootVC= [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:vc];
        rootVC.rt_disableInteractivePop = YES ;
        self.window.rootViewController = rootVC;
//    }
    
    
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

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
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
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
