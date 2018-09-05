//
//  ZhuanfaOtherView.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/9/5.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "ZhuanfaOtherView.h"

@implementation ZhuanfaOtherView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self getTheUserForwardConfiSuccess:^(zhuanfaModel *zhuanfamodel) {
            
            [self setBtnStateWithzhuanfaModel:zhuanfamodel];
            
        }];
        
    }
    return self;
}


//获取配置设置
-(void)getTheUserForwardConfiSuccess:(void(^)(zhuanfaModel*model))success{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *userId = [NSString stringWithFormat:@"%@",[LYAccount shareAccount].id];
    [dic setValue:userId forKey:@"userId"];
    
    [[NetworkManager sharedManager]getWithUrl:getUserForwardConfi param:dic success:^(id json) {
        NSLog(@"%@",json);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]){
            zhuanfaModel*model = [zhuanfaModel mj_objectWithKeyValues:json[@"data"]];
            success(model);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)setBtnStateWithzhuanfaModel:(zhuanfaModel*)model{
    
    
    if ([model.defaultImg isEqualToString:@"0"]) {
        
        [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.secondBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
        [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.fourthBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        
        
        
    }else if ([model.defaultImg isEqualToString:@"1"]){
        
        [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.thirdBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
        [self.fourthBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        
        
        
    }else if ([model.defaultImg isEqualToString:@"2"]){
        
        [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.fourthBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
        
        
    }else if ([model.defaultImg isEqualToString:@"3"]){
        
        [self.firstBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
        [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.fourthBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        
    }
    
    
}
- (IBAction)firstBtnClick:(id)sender {
    
    [self.firstBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
    [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.fourthBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    
}

- (IBAction)secondBtnClick:(id)sender {
    [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.secondBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
    [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.fourthBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    
}

- (IBAction)thirdBtnClick:(id)sender {
    
    [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.thirdBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
    [self.fourthBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    
    
}


- (IBAction)fourthBtnClick:(id)sender {
    
    [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.fourthBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
    
    
}

@end
