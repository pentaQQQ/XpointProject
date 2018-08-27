//
//  IndentControl.m
//  TPAPP
//
//  Created by Frank on 2018/8/20.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "IndentControl.h"

@implementation IndentControl
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.headIamgeView = [[UIImageView alloc] init];
        [self addSubview:self.headIamgeView];
//        self.headIamgeView.backgroundColor = [UIColor grayColor];
        self.headIamgeView.sd_layout
        .topSpaceToView(self, 10)
        .centerXEqualToView(self)
        .widthIs(30)
        .heightIs(30);
        
        self.indentTypeLabel = [[UILabel alloc] init];
        self.indentTypeLabel.textColor = [UIColor blackColor];
        [self addSubview:self.indentTypeLabel];
        self.indentTypeLabel.textAlignment = NSTextAlignmentCenter;
        self.indentTypeLabel.sd_layout
        .topSpaceToView(self.headIamgeView, 10)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(20);
        
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
