//
//  LoginViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *bottomview;
@property (weak, nonatomic) IBOutlet UITextField *phonetextField;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengmaField;
@property (weak, nonatomic) IBOutlet UIButton *yanzhengmaBtn;
@property (weak, nonatomic) IBOutlet UIButton *quanBtn;
@property (weak, nonatomic) IBOutlet UILabel *xieyiLab;
@property (weak, nonatomic) IBOutlet UIButton *boardBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ViewBorderRadius(self.bottomview, 0, 1, [UIColor groupTableViewBackgroundColor]);
    ViewBorderRadius(self.boardBtn,5, 1, [UIColor clearColor]);
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
