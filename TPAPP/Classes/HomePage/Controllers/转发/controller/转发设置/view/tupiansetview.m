//
//  tupiansetview.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/28.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "tupiansetview.h"
#import "zhuanfaModel.h"
@implementation tupiansetview


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self layoutAllSubviews];
        
        [self getTheUserForwardConfiSuccess:^(zhuanfaModel *zhuanfamodel) {
            
            [self setBtnStateWithzhuanfaModel:zhuanfamodel];
            
        }];
        
        
    }
    return self;
}

- (void)layoutAllSubviews{
    
    CGPoint accountCenter = self.center;
    accountCenter.y += 250;
    self.center =accountCenter;
    accountCenter.y -= 250;
    [tupiansetview animateWithDuration:0.5 animations:^{
        self.center = accountCenter;
        
        
    }];
}




-(void)setBtnStateWithzhuanfaModel:(zhuanfaModel*)model{
    
   
    
    if ([model.defaultImg isEqualToString:@"3"]) {
        
        self.firstImage.hidden = NO;
        self.secondImage.hidden = YES;
        self.thirdImage.hidden = YES;
        self.fourthImage.hidden = YES;
        
        self.firstContentLab.textColor = [UIColor redColor];
        self.secondContentLab.textColor = [UIColor darkGrayColor];
        self.thirdContentLab.textColor = [UIColor darkGrayColor];
        self.fourthContentLab.textColor = [UIColor darkGrayColor];
        
    }else if ([model.defaultImg isEqualToString:@"0"]){
        self.firstImage.hidden = YES;
        self.secondImage.hidden = NO;
        self.thirdImage.hidden = YES;
        self.fourthImage.hidden = YES;
        
        self.firstContentLab.textColor = [UIColor darkGrayColor];
        self.secondContentLab.textColor = [UIColor redColor];
        self.thirdContentLab.textColor = [UIColor darkGrayColor];
        self.fourthContentLab.textColor = [UIColor darkGrayColor];
    }else if ([model.defaultImg isEqualToString:@"1"]){
        self.firstImage.hidden = YES;
        self.secondImage.hidden = YES;
        self.thirdImage.hidden = NO;
        self.fourthImage.hidden = YES;
        
        self.firstContentLab.textColor = [UIColor darkGrayColor];
        self.secondContentLab.textColor = [UIColor darkGrayColor];
        self.thirdContentLab.textColor = [UIColor redColor];
        self.fourthContentLab.textColor = [UIColor darkGrayColor];
        
    }else if ([model.defaultImg isEqualToString:@"2"]){
        
        self.firstImage.hidden = YES;
        self.secondImage.hidden = YES;
        self.thirdImage.hidden = YES;
        self.fourthImage.hidden = NO;
        
        self.firstContentLab.textColor = [UIColor darkGrayColor];
        self.secondContentLab.textColor = [UIColor darkGrayColor];
        self.thirdContentLab.textColor = [UIColor darkGrayColor];
        self.fourthContentLab.textColor = [UIColor redColor];
        
    }else{
        
        self.firstImage.hidden = NO;
        self.secondImage.hidden = YES;
        self.thirdImage.hidden = YES;
        self.fourthImage.hidden = YES;
        
        self.firstContentLab.textColor = [UIColor redColor];
        self.secondContentLab.textColor = [UIColor darkGrayColor];
        self.thirdContentLab.textColor = [UIColor darkGrayColor];
        self.fourthContentLab.textColor = [UIColor darkGrayColor];
        
        
    }
    
    
}









-(void)removeView{
    
    CGPoint accountCenter = self.center;
    accountCenter.y -= 0;
    self.center =accountCenter;
    accountCenter.y += 250;
    [tupiansetview animateWithDuration:0.5 animations:^{
        self.center = accountCenter;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }];
}
-(void)removeMengbanBlock{
    
    if (self.removeBlock) {
        self.removeBlock();
    }
    
}


-(void)setFirstView:(UIView *)firstView{
    _firstView = firstView;
    __weak __typeof(self) weakSelf = self;
    [weakSelf.firstView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        weakSelf.firstImage.hidden = NO;
        weakSelf.secondImage.hidden = YES;
        weakSelf.thirdImage.hidden = YES;
        weakSelf.fourthImage.hidden = YES;
        
        weakSelf.firstContentLab.textColor = [UIColor redColor];
        weakSelf.secondContentLab.textColor = [UIColor darkGrayColor];
        weakSelf.thirdContentLab.textColor = [UIColor darkGrayColor];
        weakSelf.fourthContentLab.textColor = [UIColor darkGrayColor];
        
        [weakSelf removeView];
        
        if (weakSelf.TupianviewBlock) {
            weakSelf.TupianviewBlock(@"合成图（新版四图组合+描述）", @"新版四张商品图片和描述文字合成一张图片再转发");
        }
        
        
    }];
}



-(void)setSecongView:(UIView *)secongView{
    _secongView = secongView;
    __weak __typeof(self) weakSelf = self;
    
    [weakSelf.secongView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakSelf.firstImage.hidden = YES;
        weakSelf.secondImage.hidden = NO;
        weakSelf.thirdImage.hidden = YES;
        weakSelf.fourthImage.hidden = YES;
        
        weakSelf.firstContentLab.textColor = [UIColor darkGrayColor];
        weakSelf.secondContentLab.textColor = [UIColor redColor];
        weakSelf.thirdContentLab.textColor = [UIColor darkGrayColor];
        weakSelf.fourthContentLab.textColor = [UIColor darkGrayColor];
        
        
        [weakSelf removeView];
        if (weakSelf.TupianviewBlock) {
            weakSelf.TupianviewBlock(@"单张图（商品首图+描述）", @"商品第一张图和描述文字合成一张图片再转发");
        }
        
    }];
}



-(void)setThirdView:(UIView *)thirdView{
    
    _thirdView = thirdView;
    __weak __typeof(self) weakSelf = self;
    [thirdView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakSelf.firstImage.hidden = YES;
        weakSelf.secondImage.hidden = YES;
        weakSelf.thirdImage.hidden = NO;
        weakSelf.fourthImage.hidden = YES;
        
        weakSelf.firstContentLab.textColor = [UIColor darkGrayColor];
        weakSelf.secondContentLab.textColor = [UIColor darkGrayColor];
        weakSelf.thirdContentLab.textColor = [UIColor redColor];
        weakSelf.fourthContentLab.textColor = [UIColor darkGrayColor];
        
        [weakSelf removeView];
        if (weakSelf.TupianviewBlock) {
            weakSelf.TupianviewBlock(@"四张图（描述默认复制）", @"仅转发商品图片，描述文字需手动复制粘贴");
        }
        
        
    }];
    
}



-(void)setFourthView:(UIView *)fourthView{
    _fourthView = fourthView;
    __weak __typeof(self) weakSelf = self;
    [weakSelf.fourthView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakSelf.firstImage.hidden = YES;
        weakSelf.secondImage.hidden = YES;
        weakSelf.thirdImage.hidden = YES;
        weakSelf.fourthImage.hidden = NO;
        
        weakSelf.firstContentLab.textColor = [UIColor darkGrayColor];
        weakSelf.secondContentLab.textColor = [UIColor darkGrayColor];
        weakSelf.thirdContentLab.textColor = [UIColor darkGrayColor];
        weakSelf.fourthContentLab.textColor = [UIColor redColor];
        
        
        [weakSelf removeView];
        if (weakSelf.TupianviewBlock) {
            weakSelf.TupianviewBlock(@"合成图（四图组合+描述）", @"旧版四张商品图片和描述文字合成一张图片再转发");
        }
    }];
    
}



- (IBAction)cancelBtnClick:(id)sender {
    [self removeView];
    [self removeMengbanBlock];
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


@end
