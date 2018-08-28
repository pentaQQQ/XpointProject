//
//  jiajiaView.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/28.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "jiajiaView.h"

@implementation jiajiaView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self layoutAllSubviews];
        
       
    }
    return self;
}

- (void)layoutAllSubviews{
    
    CGPoint accountCenter = self.center;
    accountCenter.y += 250;
    self.center =accountCenter;
    accountCenter.y -= 250;
    [jiajiaView animateWithDuration:0.5 animations:^{
        self.center = accountCenter;
        
        
    }];
}

-(void)removeView{
    
    CGPoint accountCenter = self.center;
    accountCenter.y -= 0;
    self.center =accountCenter;
    accountCenter.y += 250;
    [jiajiaView animateWithDuration:0.5 animations:^{
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
        
     
        
        [weakSelf removeView];
        
        if (weakSelf.jiajiaBlock) {
            weakSelf.jiajiaBlock(@"不加价", @"所有商品以平台播货价格转发");
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:@"不加价" forKey:@"jiajia"];
        [[NSUserDefaults standardUserDefaults]setObject:@"所有商品以平台播货价格转发" forKey:@"detailjiajia"];
        
    }];
}



-(void)setSecongView:(UIView *)secongView{
    _secongView = secongView;
    __weak __typeof(self) weakSelf = self;
    
    [weakSelf.secongView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
       
        
        [weakSelf removeView];
        if (weakSelf.jiajiaBlock) {
            weakSelf.jiajiaBlock(@"+5元", @"所有商品在平台播货价基础上+5元转发");
        }
        [[NSUserDefaults standardUserDefaults]setObject:@"+5元" forKey:@"jiajia"];
        [[NSUserDefaults standardUserDefaults]setObject:@"所有商品在平台播货价基础上+5元转发" forKey:@"detailjiajia"];
    }];
}



-(void)setThirdView:(UIView *)thirdView{
    
    _thirdView = thirdView;
    __weak __typeof(self) weakSelf = self;
    [thirdView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
      
        
        [weakSelf removeView];
        if (weakSelf.jiajiaBlock) {
            weakSelf.jiajiaBlock(@"+10元", @"所有商品在平台播货价基础上+10元转发");
        }
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"+10元" forKey:@"jiajia"];
        [[NSUserDefaults standardUserDefaults]setObject:@"所有商品在平台播货价基础上+10元转发" forKey:@"detailjiajia"];
        
    }];
    
}



-(void)setFourthView:(UIView *)fourthView{
    _fourthView = fourthView;
    __weak __typeof(self) weakSelf = self;
    [weakSelf.fourthView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
       
        
        [weakSelf removeView];
        if (weakSelf.jiajiaBlock) {
            weakSelf.jiajiaBlock(@"", @"");
        }
       
    }];
    
}



- (IBAction)cancelBtnClick:(id)sender {
    [self removeView];
    [self removeMengbanBlock];
}


@end
