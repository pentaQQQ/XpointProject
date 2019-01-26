//
//  fenxiangTanchuangView.m
//  TPAPP
//
//  Created by 崔文龙 on 2019/1/2.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import "fenxiangTanchuangView.h"

@implementation fenxiangTanchuangView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)setShareBtn:(UIButton *)shareBtn{
    _shareBtn = shareBtn;
    
    ViewBorderRadius(shareBtn, 5, 1, [UIColor orangeColor]);
}

@end
