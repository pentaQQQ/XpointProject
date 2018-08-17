//
//  BaseTabBarController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    self.tabBar.tintColor = colorWithRGB(0x1D99D4);
}


- (void)makeUI {
    HomePageController *firstViewController = [[HomePageController alloc] init];
    firstViewController.title=@"首页";
    firstViewController.tabBarItem.image=[UIImage imageNamed:@"tab_index_nor"];
    BaseNavigationController *firstNavigationController = [[BaseNavigationController alloc]
                                                           initWithRootViewController:firstViewController];
    
    FindViewController *secondViewController = [[FindViewController alloc] init];
    secondViewController.title=@"客服";
    secondViewController.tabBarItem.image=[UIImage imageNamed:@"tab_index_nor"];
    BaseNavigationController *secondNavigationController = [[BaseNavigationController alloc]
                                                            initWithRootViewController:secondViewController];
    
    CartViewController *c4=[[CartViewController alloc]init];
    c4.title=@"发现";
    c4.tabBarItem.image=[UIImage imageNamed:@"tab_index_nor"];
    BaseNavigationController *thirdNavigationController = [[BaseNavigationController alloc] initWithRootViewController:c4];
    
    GoodsViewController *c6=[[GoodsViewController alloc]init];
    c6.title=@"购物车";
    c6.tabBarItem.image=[UIImage imageNamed:@"tab_index_nor"];
    //c6.tabBarItem.selectedImage =[[UIImage imageNamed:@"tab_market_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *fourthNavigationController = [[BaseNavigationController alloc] initWithRootViewController:c6];
    
    
    MineViewController *c7=[[MineViewController alloc]init];
    c7.title=@"我的";
    c7.tabBarItem.image=[UIImage imageNamed:@"tab_index_nor"];
    BaseNavigationController *sevenNavigationController = [[BaseNavigationController alloc] initWithRootViewController:c7];
    
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 fourthNavigationController,
                                 sevenNavigationController
                                 ];
    
    self.viewControllers = viewControllers;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(UITabBarController *)tabBarController {

    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = colorWithRGB(0x333333);
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = colorWithRGB(0x0099E3);
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
   
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
   
}




@end
