//
//  pickzhuangaView.m
//  TPAPP
//
//  Created by 崔文龙 on 2019/4/11.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import "pickzhuangaView.h"

@implementation pickzhuangaView

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
    accountCenter.y += 171+SafeAreaBottomHeight;
    self.center =accountCenter;
    accountCenter.y -= 171+SafeAreaBottomHeight;
    [pickzhuangaView animateWithDuration:0.5 animations:^{
        self.center = accountCenter;
        
        
    }];
}

-(void)removeView{
    
    CGPoint accountCenter = self.center;
    accountCenter.y -= 0;
    self.center =accountCenter;
    accountCenter.y += 171+SafeAreaBottomHeight;
    [pickzhuangaView animateWithDuration:0.5 animations:^{
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


- (IBAction)buzhuanfaClick:(id)sender {
    
    if (self.buzhuanfaBlock) {
        self.buzhuanfaBlock();
    }
    [self removeView];
    [self removeMengbanBlock];
    
}

- (IBAction)zhuanfaClick:(id)sender {
    if (self.zhuanfaBlock) {
        self.zhuanfaBlock();
    }
    [self removeView];
    [self removeMengbanBlock];
    
}


- (IBAction)quxiaoClick:(id)sender {
   
    if (self.quxiaoBlock) {
        self.quxiaoBlock();
    }
    
    
    [self removeView];
    [self removeMengbanBlock];
    
}

@end
