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

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation registViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationController.navigationBar.hidden = YES;
    
    [self setuptabbarview];
    self.phoneLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneLabelGes)];
    [self.phoneLabel addGestureRecognizer:tapGes];
}
- (void)phoneLabelGes
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18101697060"] options:@{} completionHandler:nil];
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



-(void)setuptabbarview{
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight)];
    vi.backgroundColor = [UIColor clearColor];
    [self.view addSubview:vi];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, vi.frame.size.height-44, 44, 44)];
    [vi addSubview:btn];
    
    [btn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
    [btn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}




@end
