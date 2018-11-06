//
//  SearchHeaderView.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "SearchHeaderView.h"

@implementation SearchHeaderView



-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    
    return self;
}



- (void)setFrame:(CGRect)frame {
    
    [super setFrame:CGRectMake(0, 0, self.superview.frame.size.width, self.superview.bounds.size.height)];
}




-(void)setBottomView:(UIView *)bottomView{
    
    _bottomView = bottomView;
    
//    ViewBorderRadius(bottomView, 20, 1, [UIColor groupTableViewBackgroundColor]);
}



-(CGSize)intrinsicContentSize
{
    if (false) {
        return CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
    } else {
        return CGSizeMake(kScreenWidth/3*2, 30);
    }
}



@end
