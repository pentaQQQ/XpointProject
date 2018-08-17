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
        
    } Failure:^(NSError *error) {
        
    }];
    
}


@end
