//
//  LoginViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "LoginViewController.h"
#import "WeChateBoardViewController.h"
#import "registViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *bottomview;


@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;


@property (weak, nonatomic) IBOutlet UITextField *codeField;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (weak, nonatomic) IBOutlet UIButton *boardBtn;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    
}



- (IBAction)zhanghaobtnClick:(id)sender {
    
    //    //  来吧旋转动画
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.view.layer.transform = CATransform3DMakeRotation(M_PI/2.0, 0, 1, 0);  // 当前view，这句代码可以不要。这是我的需求
        
    } completion:^(BOOL finished) {
        WeChateBoardViewController *newVC =[WeChateBoardViewController new];
        [weakSelf presentViewController:newVC animated:NO completion:nil];
    }];
    
}



- (IBAction)codeBtnClick:(id)sender {
    
    if (!self.phoneNumberField.text.length) {
        [SVProgressHUD doAnyRemindWithHUDMessage:@"输入电话号码不能为空" withDuration:1.5];
        return;
    }
    if (![LYTools isTelphoneWithPhonenum:self.phoneNumberField.text]) {
        [SVProgressHUD doAnyRemindWithHUDMessage:@"请输入正确的电话号码" withDuration:1.5];
        return;
    }
    
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.phoneNumberField.text forKey:@"phone"];
    [dic setValue:@"register" forKey:@"method"];
    NSString*url = [NSString stringWithFormat:@"%@/%@",getSecurityCode,self.phoneNumberField.text];
    [[NetworkManager sharedManager]getWithUrl:url param:dic success:^(id json) {
        NSLog(@"%@",json);
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            
            [self.codeBtn  startWithTime:60 title:@"获取验证码" countDownTitle:@"s后重新获取" mainColor:[UIColor redColor] countColor:kRGBAColor(150, 150, 150, 0.8) titleColor:kRGBColor(250, 250, 250)];
            
            
        }else{
            [SVProgressHUD doAnyRemindWithHUDMessage:json[@"respMessage"] withDuration:1.5];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}







- (IBAction)boardBtnClick:(id)sender {
    
    if (!self.phoneNumberField.text.length) {
        [SVProgressHUD doAnyRemindWithHUDMessage:@"输入电话号码不能为空" withDuration:1.5];
        return;
    }
    if (![LYTools isTelphoneWithPhonenum:self.phoneNumberField.text]) {
        [SVProgressHUD doAnyRemindWithHUDMessage:@"请输入正确的电话号码" withDuration:1.5];
        return;
    }
    if (!self.codeField.text) {
        [SVProgressHUD doAnyRemindWithHUDMessage:@"输入验证码不能为空" withDuration:1.5];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.phoneNumberField.text forKey:@"phone"];
    [dic setValue:self.codeField.text forKey:@"validCode"];
    [dic setValue:@"login" forKey:@"method"];
    [dic setValue:@"1" forKey:@"type"];
    [[NetworkManager sharedManager]postWithUrl:getlogin param:dic success:^(id json) {
        NSLog(@"%@",json);
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            NSString *data = [NSString stringWithFormat:@"%@",json[@"data"]];
            [[NSUserDefaults standardUserDefaults]setValue:data forKey:@"token"];
            
            [self getPeopleInfomation];
        }else if ([respCode isEqualToString:@"99999"]){
            registViewController *vc = [[registViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [SVProgressHUD doAnyRemindWithHUDMessage:json[@"respMessage"] withDuration:1.5];
        }
    } failure:^(NSError *error) {
        
    }];
}





//获取用户信息
-(void)getPeopleInfomation{
    
    
    [[NetworkManager sharedManager]getWithUrl:getinfomation param:nil success:^(id json) {
        NSLog(@"%@",json);
        
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]){
            
            // 单例赋值
            [LYAccount mj_objectWithKeyValues:json[@"data"]];
            [LYTools setUpTabbarController];
        }else{
            [SVProgressHUD doAnythingFailedWithHUDMessage:json[@"respMessage"] withDuration:1.5];
        }
    } failure:^(NSError *error) {
        
        
    }];
    
}





@end
