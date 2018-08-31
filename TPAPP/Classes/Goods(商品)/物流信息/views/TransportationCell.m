//
//  TransportationCell.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "TransportationCell.h"

@implementation TransportationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setBottomview:(UIView *)bottomview{
    _bottomview = bottomview;
    ViewBorderRadius(bottomview, 20, 1, [UIColor clearColor]);
}
@end
