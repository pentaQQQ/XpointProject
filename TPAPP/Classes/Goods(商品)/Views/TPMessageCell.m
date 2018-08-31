//
//  TPMessageCell.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "TPMessageCell.h"

@implementation TPMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setImageview:(UIImageView *)imageview{
    _imageview = imageview;
    ViewBorderRadius(imageview, 30, 1, [UIColor lightGrayColor]);
}

@end
