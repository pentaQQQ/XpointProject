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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    // 侧拉VC
    SideViewController *leftViewController = [[SideViewController alloc] init];
    //市场人员
    BaseTabBarController *tabar = [[BaseTabBarController alloc] init];
    
    // 初始化XYSideViewController 设置为window.rootViewController
    XYSideViewController *rootViewController = [[XYSideViewController alloc] initWithSideVC:leftViewController currentVC:tabar];
    
    self.window.rootViewController = rootViewController;
    
    return YES;
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
