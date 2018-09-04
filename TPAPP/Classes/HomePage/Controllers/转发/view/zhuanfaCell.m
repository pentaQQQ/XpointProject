//
//  zhuanfaCell.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/23.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "zhuanfaCell.h"

@implementation zhuanfaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(shanghuModel *)model{
    
    _model = model;
    self.title.text = model.merchantName;
    
    
}

@end
