//
//  MarketControl.m
//  TPAPP
//
//  Created by Frank on 2018/8/20.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "MarketControl.h"

@implementation MarketControl
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.marketLimitLabel = [[UILabel alloc] init];
        [self addSubview:self.marketLimitLabel];
        self.marketLimitLabel.textAlignment = NSTextAlignmentCenter;
        self.marketLimitLabel.sd_layout
        .topSpaceToView(self, 10)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(30);
        
        self.marketTypeLabel = [[UILabel alloc] init];
        self.marketTypeLabel.textColor = [UIColor blackColor];
        [self addSubview:self.marketTypeLabel];
        self.marketTypeLabel.textAlignment = NSTextAlignmentCenter;
        self.marketTypeLabel.sd_layout
        .topSpaceToView(self.marketLimitLabel, 0)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(30);
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
