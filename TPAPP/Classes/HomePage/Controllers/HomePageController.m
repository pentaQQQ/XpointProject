//
//  HomePageController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//hshfljdhkjashkad

#import "HomePageController.h"

@interface HomePageController ()

@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
}


//网络请求实列
- (void)lodaData
{
    [[NetworkManager sharedManager] postCityData:@"" Success:^(id json) {
        
        //保存一次全局都能用
        USERINFO.password = @"";
        //颜色
        //colorWithRGB(0x000000)
        //字体
        //font(12);
        //宽 高  适配比列
        //SCREEN_WIDTH
        //SCREEN_HEIGHT
        //SCREEN_PRESENT
   
    } Failure:^(NSError *error) {
        
    }];
    
}


//各种用法请看宏定义 关于常用色值 字体等
@end
