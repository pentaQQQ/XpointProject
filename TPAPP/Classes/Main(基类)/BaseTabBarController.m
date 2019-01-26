//
//  BaseTabBarController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()
@property (nonatomic, assign)NSInteger goodListNum;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    self.tabBar.tintColor = colorWithRGB(0x1D99D4);
    [self customizeTabBarAppearance:self];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getShopCarNumberAction:)name:@"getShopCarNumber"object:nil];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.view layoutSubviews];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getShopCarNumber" object:nil];
}
#pragma mark - 获取购物车的值
-(void)getShopCarNumberAction:(NSNotification *)noti
{
    [self loadNewTopic];
//    NSDictionary * dic = [noti userInfo];
    
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
    if ([item.title isEqualToString:@"购物车"]) {
        [item setBadgeValue:nil];
    }else{
       [self loadNewTopic];
    }
}
- (void)makeUI {
    HomePageController *firstViewController = [[HomePageController alloc] init];
    firstViewController.title=@"首页";
    firstViewController.tabBarItem.image=[[UIImage imageNamed:@"icon_foot_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    firstViewController.tabBarItem.selectedImage =[[UIImage imageNamed:@"icon_foot_home_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *firstNavigationController = [[BaseNavigationController alloc]
                                                           initWithRootViewController:firstViewController];
    
    GoodsViewController *c6=[[GoodsViewController alloc]init];
    c6.title=@"客服";
    c6.tabBarItem.image=[[UIImage imageNamed:@"icon_foot_jsxd"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c6.tabBarItem.selectedImage =[[UIImage imageNamed:@"icon_foot_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //c6.tabBarItem.selectedImage =[[UIImage imageNamed:@"tab_market_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *fourthNavigationController = [[BaseNavigationController alloc] initWithRootViewController:c6];
    
    SearchViewController *searchCtrl = [[SearchViewController alloc] init];
    searchCtrl.title=@"搜索";
    searchCtrl.tabBarItem.image=[[UIImage imageNamed:@"icon_search_unselect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    searchCtrl.tabBarItem.selectedImage =[[UIImage imageNamed:@"icon_search_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *searchNavigationController = [[BaseNavigationController alloc]
                                                           initWithRootViewController:searchCtrl];
    
    
    
//    FindViewController *secondViewController = [[FindViewController alloc] init];
//    secondViewController.title=@"发现";
//    secondViewController.tabBarItem.image=[[UIImage imageNamed:@"icon_foot_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    secondViewController.tabBarItem.selectedImage =[[UIImage imageNamed:@"icon_foot_home_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    BaseNavigationController *secondNavigationController = [[BaseNavigationController alloc]
//                                                            initWithRootViewController:secondViewController];
    
    CartViewController *c4=[[CartViewController alloc]init];
    c4.title=@"购物车";
//    c4.hidesBottomBarWhenPushed = YES;
//    c4.tabBarController.tabBar.hidden = YES;
    c4.tabBarItem.image=[[UIImage imageNamed:@"icon_foot_buy"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c4.tabBarItem.selectedImage =[[UIImage imageNamed:@"icon_foot_buy_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *thirdNavigationController = [[BaseNavigationController alloc] initWithRootViewController:c4];
    
    
    
    
    MineViewController *c7=[[MineViewController alloc]init];
    c7.title=@"我的";
    c7.tabBarItem.image=[[UIImage imageNamed:@"icon_foot_mine"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c7.tabBarItem.selectedImage =[[UIImage imageNamed:@"icon_foot_mine_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *sevenNavigationController = [[BaseNavigationController alloc] initWithRootViewController:c7];
    
    
//    NSArray *viewControllers = @[
//                                 firstNavigationController,
//                                 fourthNavigationController,
//                                 secondNavigationController,
//                                 thirdNavigationController,
//                                 sevenNavigationController
//                                 ];
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 fourthNavigationController,
                                 searchNavigationController,
                                 thirdNavigationController,
                                 sevenNavigationController
                                 ];
    self.viewControllers = viewControllers;
    [self loadNewTopic];
    
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
    selectedAttrs[NSForegroundColorAttributeName] = colorWithRGB(0xFF6B24);
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
   
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
}

#pragma mark - 数据
- (void)loadNewTopic
{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    LYAccount *lyAccount = [LYAccount shareAccount];
    [dataDict setValue:lyAccount.id forKey:@"userId"];
    [dataDict setValue:@"0" forKey:@"status"];
    [LYTools postBossDemoWithUrl:cartList param:dataDict success:^(NSDictionary *dict) {
        NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            self.goodListNum =  [dict[@"data"][@"cartDetails"] count];
            if (self.goodListNum == 0) {
                CartViewController *cartCtrl = self.viewControllers[3];
                [cartCtrl.tabBarItem setBadgeValue:nil];
            }else{
                CartViewController *cartCtrl = self.viewControllers[3];
                [cartCtrl.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%ld",self.goodListNum]];
            }
            
        }else if([dict[@"code"]longValue] == 500){
            self.goodListNum = 0;
            CartViewController *cartCtrl = self.viewControllers[3];
            [cartCtrl.tabBarItem setBadgeValue:nil];
           
        }
    } fail:^(NSError *error) {
        self.goodListNum = 0;
        CartViewController *cartCtrl = self.viewControllers[3];
        [cartCtrl.tabBarItem setBadgeValue:nil];
        
    }];
}


@end
