//
//  MBCircleView.m
//  ca
//
//  Created by George on 16/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MBCircleView.h"

@implementation MBCircleView


static inline CGFloat degrees(CGFloat value) {
    return M_PI*value/180;
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.tintColor = [UIColor blueColor];
    self.circleWidth = 2;
}

-(void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    [self setNeedsDisplay];
}

-(void)setCircleWidth:(CGFloat)circleWidth {
    _circleWidth = circleWidth;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat width = self.frame.size.width;
    CAShapeLayer *layer =[CAShapeLayer layer];
    layer.lineWidth = self.circleWidth;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = self.tintColor.CGColor;
    layer.frame = CGRectMake(0, 0, width, width);
    layer.lineCap = kCALineCapRound;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2.0, width/2.0) radius:width/2.0 startAngle:degrees(270) endAngle:degrees(180) clockwise:YES];
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    
    //画一个圆
    CAKeyframeAnimation *strokeEndAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = 0.5;
    strokeEndAnimation.values = @[@0.0, @1];
    strokeEndAnimation.keyTimes = @[@0.0,@1];
    
    //旋转2圈
    CABasicAnimation *rotaAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotaAni.fromValue = @(degrees(0));
    rotaAni.toValue = @(degrees(720));
    rotaAni.autoreverses = YES;
    
    //最后填充颜色
    //创建一个CABasicAnimation对象
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //设置颜色
    animation.toValue=(id)[UIColor blackColor].CGColor; //必须要用黑色
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.repeatCount = INFINITY;
    group.duration = 2;
    group.animations = @[strokeEndAnimation,rotaAni,animation];
    
    
    [layer addAnimation:group forKey:nil];
}


@end
