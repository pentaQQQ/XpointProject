//
//  LoginViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "LoginViewController.h"
#import "WeChateBoardViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)zhanghaobtnClick:(id)sender {
    
//    //  来吧旋转动画
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.view.layer.transform = CATransform3DMakeRotation(M_PI/2.0, 0, 1, 0);  // 当前view，这句代码可以不要。这是我的需求
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        window.layer.transform = CATransform3DMakeRotation(M_PI/2.0, 0, 1, 0);
    } completion:^(BOOL finished) {
        WeChateBoardViewController *newVC =[WeChateBoardViewController new];
        [weakSelf presentViewController:newVC animated:NO completion:nil];
    }];
    
   
    
}


@end
