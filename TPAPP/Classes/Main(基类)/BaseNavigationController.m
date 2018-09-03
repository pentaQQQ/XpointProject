//
//  BaseNavigationController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UINavigationBar *navBar = [UINavigationBar appearance];
    //navBar.translucent = NO;
    navBar.barTintColor = colorWithRGB(0x00A9EB);
    navBar.tintColor = [UIColor whiteColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:17 weight:UIFontWeightLight]}];
    [navBar setShadowImage:[UIImage new]];
}



//hide  tabbar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


//status  become  white
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}




+(instancetype)navigationRootController:(UIViewController *)root {
    return [[BaseNavigationController alloc] initWithRootViewController:root];
}



@end
