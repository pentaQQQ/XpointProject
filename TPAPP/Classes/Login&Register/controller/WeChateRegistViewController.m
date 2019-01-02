//
//  WeChateRegistViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/11/5.
//  Copyright © 2018 cbl－　点硕. All rights reserved.
//

#import "WeChateRegistViewController.h"

@interface WeChateRegistViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;


@property (weak, nonatomic) IBOutlet UITextField *codeField;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@end

@implementation WeChateRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    [self setuptabbarview];
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
    [dic setValue:self.phoneNumberField.text forKey:@"phone"];//电话号码
    [dic setValue:self.codeField.text forKey:@"validCode"];//验证码
    [dic setValue:self.code forKey:@"inviteCode"];//邀请码
    [dic setValue:self.openId forKey:@"openId"];
    [dic setValue:@"register" forKey:@"method"];
    [dic setValue:@"3" forKey:@"type"];
    [[NetworkManager sharedManager]postWithUrl:getreg param:dic success:^(id json) {
        NSLog(@"%@",json);
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            [SVProgressHUD doAnythingSuccessWithHUDMessage:@"注册成功" withDuration:1.5];
            NSString *data = [NSString stringWithFormat:@"%@",json[@"data"]];
            [[NSUserDefaults standardUserDefaults]setValue:data forKey:@"token"];
            [self getPeopleInfomation];
        }else{
            [SVProgressHUD doAnyRemindWithHUDMessage:json[@"respMessage"] withDuration:1.5];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
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
