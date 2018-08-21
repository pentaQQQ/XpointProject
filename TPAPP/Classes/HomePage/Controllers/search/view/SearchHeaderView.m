//
//  SearchHeaderView.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "SearchHeaderView.h"

@implementation SearchHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(void)setBottomView:(UIView *)bottomView{
    
    _bottomView = bottomView;
    
    ViewBorderRadius(bottomView, 20, 1, [UIColor groupTableViewBackgroundColor]);
}

@end
