//
//  TuYeTextField.m
//  impi
//
//  Created by Chris on 15/4/15.
//  Copyright (c) 2015年 Zoimedia. All rights reserved.
//

#import "TuYeTextField.h"

#define PlaceholderColor UIColorFromRGB(0xd2d2d2);
//#define FocusColor [UIColor colorWithRed:255.0/255.0 green:97.0/255.0 blue:97.0/255.0 alpha:1.0f];
#define FocusColor [UIColor darkGrayColor];
@interface TuYeTextField()<UITextFieldDelegate>{
}

@end

@implementation TuYeTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//    self.font = [UIFont systemFontOfSize:18];
//    self.tintColor = FocusColor;
//    self.textColor = [UIColor blackColor];
//    self.borderStyle = UITextBorderStyleNone;
//    self.backgroundColor = [UIColor whiteColor];
    rect.origin.x += 5;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:254/255 green:253/255 blue:248/255 alpha:0.1].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.8, CGRectGetWidth(self.frame), 0.8));
    
//    self.leftView.frame = CGRectMake(0, 0, 23, 23);
//    self.leftViewMode = UITextFieldViewModeAlways;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.enablesReturnKeyAutomatically = YES;
}

//编辑文本的位置
//-(CGRect)editingRectForBounds:(CGRect)bounds{
//    CGRect inset = CGRectMake(bounds.origin.x + 28, bounds.origin.y, bounds.size.width, bounds.size.height);
//    return inset;
//}

//显示文本的位置
//-(CGRect)textRectForBounds:(CGRect)bounds{
//    CGRect inset = CGRectMake(bounds.origin.x + 28, bounds.origin.y, bounds.size.width, bounds.size.height);
//    return inset;
//}

- (CGRect) rightViewRectForBounds:(CGRect)bounds {
    CGRect textRect = [super rightViewRectForBounds:bounds];
    textRect.origin.x -= 10;
    return textRect;
}

- (CGRect) leftViewRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super leftViewRectForBounds:bounds];
    textRect.origin.x += 10;
    return textRect;
}

/*override leftview frame*/
//- (CGRect)leftViewRectForBounds:(CGRect)bounds{
//    CGRect leftViewRect = CGRectMake(bounds.origin.x, bounds.origin.y + 6, 23, 23);
//    return leftViewRect;
//}

/*override placeholder*/
//- (void)drawPlaceholderInRect:(CGRect)rect{
//    rect.origin.y += 10;
//    UIColor *placeholderColor = PlaceholderColor;
//    [[self placeholder] drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:placeholderColor}];
//}

@end
