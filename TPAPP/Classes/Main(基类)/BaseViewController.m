//
//  BaseViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "BaseViewController.h"
#import "UIBarButtonItem+Create.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
   // [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    UIBarButtonItem *gap = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    gap.width = -6;
    UIBarButtonItem *set = [[UIBarButtonItem alloc] initWithImage:@"back" complete:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];

    self.navigationItem.leftBarButtonItems = @[gap, set];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
