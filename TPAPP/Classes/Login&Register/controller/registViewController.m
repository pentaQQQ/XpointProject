//
//  registViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/9/3.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "registViewController.h"

@interface registViewController ()
@property (weak, nonatomic) IBOutlet UIView *bottomview;


@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;


@property (weak, nonatomic) IBOutlet UITextField *codeField;

@property (weak, nonatomic) IBOutlet UITextField *yaoqingField;


@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@end

@implementation registViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [dic setValue:@"login" forKey:@"method"];
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




- (IBAction)registBtnClick:(id)sender {
    
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
    [dic setValue:self.codeField.text forKey:@"validCode"];//验证码
    [dic setValue:self.yaoqingField.text forKey:@"inviteCode"];//邀请码
    [dic setValue:@"register" forKey:@"method"];
    [dic setValue:@"1" forKey:@"type"];
    [[NetworkManager sharedManager]postWithUrl:getreg param:dic success:^(id json) {
        NSLog(@"%@",json);
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            [SVProgressHUD doAnythingSuccessWithHUDMessage:@"注册成功" withDuration:1.5];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD doAnyRemindWithHUDMessage:json[@"respMessage"] withDuration:1.5];
        }
    } failure:^(NSError *error) {
        
    }];
}


@end
