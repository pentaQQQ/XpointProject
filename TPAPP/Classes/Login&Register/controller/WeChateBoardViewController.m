//
//  WeChateBoardViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "WeChateBoardViewController.h"
#import "LoginViewController.h"
@interface WeChateBoardViewController ()

@end

@implementation WeChateBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}




//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [UIView animateWithDuration:0 animations:^{
//        self.view.layer.transform = CATransform3DMakeRotation(3*M_PI/2, 0, 1, 0);// 先将页面翻转270度。此时是你看不见这个控制器的，设置了alpha
//    } completion:^(BOOL finished) {
//        self.view.alpha = 1;
//        [UIView animateWithDuration:0.5 animations:^{
//            // 先将window 翻转270.
////            UIWindow *window = [UIApplication sharedApplication].keyWindow;
////            window.layer.transform = CATransform3DRotate(window.layer.transform,M_PI*3/2.0, 0, 1, 0);
//            self.view.layer.transform = CATransform3DRotate(self.view.layer.transform, M_PI/2, 0, 1, 0);
//        } completion:^(BOOL finished) {
//        }];
//    }];
//}



- (IBAction)qianhuanBtnClick:(id)sender {
    
    //    //  来吧旋转动画
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.view.layer.transform = CATransform3DMakeRotation(M_PI/2.0, 0, 1, 0);  // 当前view，这句代码可以不要。这是我的需求
        //        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //        window.layer.transform = CATransform3DMakeRotation(M_PI/2.0, 0, 1, 0);
    } completion:^(BOOL finished) {
        LoginViewController *newVC =[LoginViewController new];
        [weakSelf presentViewController:newVC animated:NO completion:nil];
    }];

    
       

}


    
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
