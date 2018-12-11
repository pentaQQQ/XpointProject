//
//  TransportationSeationView.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "TransportationSeationView.h"

@implementation TransportationSeationView
- (IBAction)rotaBtnSender:(id)sender {
}

-(void)setBottomview:(UIView *)bottomview{
    _bottomview = bottomview;
    ViewBorderRadius(bottomview, 20, 1, [UIColor clearColor]);
}
@end
