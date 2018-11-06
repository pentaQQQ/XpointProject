//
//  WeChateBoardViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "WeChateBoardViewController.h"
#import "LoginViewController.h"
#import "WXApi.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "WechatAuthSDK.h"

#import "registViewController.h"
@interface WeChateBoardViewController ()<WXApiManagerDelegate,WechatAuthAPIDelegate>

@end

@implementation WeChateBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [WXApiManager sharedManager].delegate = self;
}



- (IBAction)qianhuanBtnClick:(id)sender {
    
    //    //  来吧旋转动画
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.view.layer.transform = CATransform3DMakeRotation(M_PI/2.0, 0, 1, 0);  // 当前view，这句代码可以不要。这是我的需求
    } completion:^(BOOL finished) {
        LoginViewController *newVC =[LoginViewController new];
        [weakSelf presentViewController:newVC animated:NO completion:nil];
    }];
 
}



- (IBAction)wechateBtnClick:(id)sender {
    
    
    [WXApiRequestHandler sendAuthRequestScope: @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"
                                        State:@"doulong"
                                       OpenID:WeChateappid
                             InViewController:self];
    
    
    
}



- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    
    [self getAccess_tokenWithCode:response.code];
    
}

-(void)getAccess_tokenWithCode:(NSString*)code{
    
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WeChateappid,WeChateSecret,code];
    
    
    [[NetworkManager sharedManager]getWithUrl:url param:nil success:^(id json) {
        
        NSLog(@"%@",json);
        
        
        NSString *access_token = [NSString stringWithFormat:@"%@",json[@"access_token"]];
        NSString *openid = [NSString stringWithFormat:@"%@",json[@"openid"]];
        
        [self getPeopleinfomationWithOpenid:openid AndAccess_token:access_token];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}




-(void)getPeopleinfomationWithOpenid:(NSString*)openid AndAccess_token:(NSString*)access_token{
    
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?openid=%@&access_token=%@",openid,access_token];
    
    [[NetworkManager sharedManager]getWithUrl:url param:nil success:^(id json) {
        
        NSLog(@"%@",json);
        
        
        [self thirdloginAppWithOpenid:json[@"openid"]];
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)thirdloginAppWithOpenid:(NSString*)openid{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:openid forKey:@"openId"];
    [dic setValue:@"3" forKey:@"type"];
    [[NetworkManager sharedManager]postWithUrl:getlogin param:dic success:^(id json) {
        NSLog(@"%@",json);
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            NSString *data = [NSString stringWithFormat:@"%@",json[@"data"]];
            [[NSUserDefaults standardUserDefaults]setValue:data forKey:@"token"];

            [self getPeopleInfomation];
        }else if ([respCode isEqualToString:@"99999"]){
//            registViewController *vc = [[registViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
        }else if ([respCode isEqualToString:@"500"]){//微信未注册
           
            [LYTools showTextFiledAlertControllerWithTitle:@"请输入邀请码" msg:@"" tfSetting:^(UITextField *textField) {
                
            } onController:self action:^(NSString *tfValue) {
                registViewController *vc = [[registViewController alloc]init];
                
                [self.navigationController pushViewController:vc animated:YES];
            }];
          
        }
        
        
        
        
        else{
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
