//
//  pingpaiCell.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "pingpaiCell.h"

@implementation pingpaiCell

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
    ViewBorderRadius(imageview, 5, 1, [UIColor groupTableViewBackgroundColor]);
}
@end
