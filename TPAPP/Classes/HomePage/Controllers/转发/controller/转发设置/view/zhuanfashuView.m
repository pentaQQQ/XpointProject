//
//  zhuanfashuView.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/28.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "zhuanfashuView.h"

@implementation zhuanfashuView

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
    [zhuanfashuView animateWithDuration:0.5 animations:^{
        self.center = accountCenter;
        
        
    }];
}

-(void)removeView{
    
    CGPoint accountCenter = self.center;
    accountCenter.y -= 0;
    self.center =accountCenter;
    accountCenter.y += 250;
    [zhuanfashuView animateWithDuration:0.5 animations:^{
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
        
        if (weakSelf.zhuanfashuBlock) {
            weakSelf.zhuanfashuBlock(@"4件", @"批量转发自定义4件");
        }
        
        
    }];
}



-(void)setSecongView:(UIView *)secongView{
    _secongView = secongView;
    __weak __typeof(self) weakSelf = self;
    
    [weakSelf.secongView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        
        [weakSelf removeView];
        if (weakSelf.zhuanfashuBlock) {
            weakSelf.zhuanfashuBlock(@"6件", @"批量转发自定义6件");
        }
       
    }];
}



-(void)setThirdView:(UIView *)thirdView{
    
    _thirdView = thirdView;
    __weak __typeof(self) weakSelf = self;
    [thirdView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        
        [weakSelf removeView];
        if (weakSelf.zhuanfashuBlock) {
            weakSelf.zhuanfashuBlock(@"9件", @"批量转发自定义9件");
        }
        
      
    }];
    
}



-(void)setFourthView:(UIView *)fourthView{
    _fourthView = fourthView;
    __weak __typeof(self) weakSelf = self;
    [weakSelf.fourthView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        
        [weakSelf removeView];
        if (weakSelf.zhuanfashuBlock) {
            weakSelf.zhuanfashuBlock(@"", @"");
        }
        
    }];
    
}



- (IBAction)cancelBtnClick:(id)sender {
    [self removeView];
    [self removeMengbanBlock];
}


@end
