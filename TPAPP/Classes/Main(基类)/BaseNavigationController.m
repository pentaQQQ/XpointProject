//
//  BaseNavigationController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "BaseNavigationController.h"
#import "GoodsDetailViewController.h"
#import "MerchanDetailViewController.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UINavigationBar *navBar = [UINavigationBar appearance];
    //navBar.translucent = NO;
//    navBar.barTintColor = colorWithRGB(0x00A9EB);
//    navBar.barTintColor = colorWithRGB(0xFF6B24);
    navBar.tintColor = [UIColor blackColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:17 weight:UIFontWeightBold]}];
//    [navBar setShadowImage:[UIImage new]];
}

//hide  tabbar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        if ([viewController isKindOfClass:[GoodsDetailViewController class]] || [viewController isKindOfClass:[MerchanDetailViewController class]]) {
            viewController.hidesBottomBarWhenPushed = NO;
        }else{
            viewController.hidesBottomBarWhenPushed = YES;
        }
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
