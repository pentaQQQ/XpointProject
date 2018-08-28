//
//  chimasetview.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/28.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "chimasetview.h"

@implementation chimasetview


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self layoutAllSubviews];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setData];
        });
        
    }
    return self;
}

- (void)layoutAllSubviews{
    
    CGPoint accountCenter = self.center;
    accountCenter.y += 250;
    self.center =accountCenter;
    accountCenter.y -= 250;
    [chimasetview animateWithDuration:0.5 animations:^{
        self.center = accountCenter;
        
        
    }];
}




-(void)setData{
    
    NSString *title = [[NSUserDefaults standardUserDefaults]objectForKey:@"chima"];
    NSString *detailTitle = [[NSUserDefaults standardUserDefaults]objectForKey:@"detailChima"];
    
    
    if ([title isEqualToString:@"不转发"]) {
        
        self.firstImage.hidden = NO;
        self.secondImage.hidden = YES;
        self.thirdImage.hidden = YES;
        self.fourthImage.hidden = YES;
        
        self.firstContentLab.textColor = [UIColor redColor];
        self.secondContentLab.textColor = [UIColor darkGrayColor];
        self.thirdContentLab.textColor = [UIColor darkGrayColor];
        self.fourthContentLab.textColor = [UIColor darkGrayColor];
        
    }else if ([title isEqualToString:@"始终转发"]){
        self.firstImage.hidden = YES;
        self.secondImage.hidden = NO;
        self.thirdImage.hidden = YES;
        self.fourthImage.hidden = YES;
        
        self.firstContentLab.textColor = [UIColor darkGrayColor];
        self.secondContentLab.textColor = [UIColor redColor];
        self.thirdContentLab.textColor = [UIColor darkGrayColor];
        self.fourthContentLab.textColor = [UIColor darkGrayColor];
    }else if ([title isEqualToString:@"活动1小时内转发"]){
        self.firstImage.hidden = YES;
        self.secondImage.hidden = YES;
        self.thirdImage.hidden = NO;
        self.fourthImage.hidden = YES;
        
        self.firstContentLab.textColor = [UIColor darkGrayColor];
        self.secondContentLab.textColor = [UIColor darkGrayColor];
        self.thirdContentLab.textColor = [UIColor redColor];
        self.fourthContentLab.textColor = [UIColor darkGrayColor];
        
    }else if ([title isEqualToString:@"活动2小时内转发"]){
        
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
    [chimasetview animateWithDuration:0.5 animations:^{
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
        
        if (weakSelf.chimaBlock) {
            weakSelf.chimaBlock(@"不转发", @"不转发缺货尺码");
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:@"不转发" forKey:@"chima"];
        [[NSUserDefaults standardUserDefaults]setObject:@"不转发缺货尺码" forKey:@"detailChima"];
        
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
        if (weakSelf.chimaBlock) {
            weakSelf.chimaBlock(@"始终转发", @"始终转发缺货尺码");
        }
        [[NSUserDefaults standardUserDefaults]setObject:@"始终转发" forKey:@"chima"];
        [[NSUserDefaults standardUserDefaults]setObject:@"始终转发缺货尺码" forKey:@"detailChima"];
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
        if (weakSelf.chimaBlock) {
            weakSelf.chimaBlock(@"活动1小时内", @"活动开始1小时内 转发缺货尺码");
        }
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"活动1小时内转发" forKey:@"chima"];
        [[NSUserDefaults standardUserDefaults]setObject:@"活动开始1小时内 转发缺货尺码" forKey:@"detailChima"];
        
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
        if (weakSelf.chimaBlock) {
            weakSelf.chimaBlock(@"活动2小时内", @"活动开始2小时内 转发缺货尺码");
        }
        [[NSUserDefaults standardUserDefaults]setObject:@"活动2小时内转发" forKey:@"chima"];
        [[NSUserDefaults standardUserDefaults]setObject:@"活动开始2小时内 转发缺货尺码" forKey:@"detailChima"];
    }];
    
}



- (IBAction)cancelBtnClick:(id)sender {
    [self removeView];
    [self removeMengbanBlock];
}


@end
