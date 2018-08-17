//
//  UIAppearance.m
//  GoodDemo
//
//  Created by George on 16/8/26.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "UIAppearance.h"

@implementation UIAppearance




/**
 *  字体
 */
#pragma mark - 
#pragma mark - 字体相关的常用函数

/**
 *  系统字体的尺寸
 */
UIFont *font (CGFloat size) {
    return fontNameAndSize(@"Helvetica", size);
}

/**
 *  系统的字体
 */
UIFont *systemsFontSize(CGFloat size) {
    return [UIFont systemFontOfSize:size];
}

/**
 *  设置字体的名称和颜色
 */
UIFont *fontNameAndSize (NSString *name, CGFloat size) {
    
    return [UIFont fontWithName:name size:size];
}

UIFont *fontWithUltraLightSize(CGFloat size)    {return [UIFont systemFontOfSize:size weight:UIFontWeightUltraLight];}
UIFont *fontWithThinSize(CGFloat size)          {return [UIFont systemFontOfSize:size weight:UIFontWeightThin];}
UIFont *fontWithLightSize(CGFloat size)         {return [UIFont systemFontOfSize:size weight:UIFontWeightLight];}
UIFont *fontWithRegularSize(CGFloat size)       {return [UIFont systemFontOfSize:size weight:UIFontWeightRegular];}
UIFont *fontWithMediumSize(CGFloat size)        {return [UIFont systemFontOfSize:size weight:UIFontWeightMedium];}
UIFont *fontWithSemiboldSize(CGFloat size)      {return [UIFont systemFontOfSize:size weight:UIFontWeightSemibold];}
UIFont *fontWithBoldSize(CGFloat size)          {return [UIFont systemFontOfSize:size weight:UIFontWeightBold];}
UIFont *fontWithHeavySize(CGFloat size)         {return [UIFont systemFontOfSize:size weight:UIFontWeightHeavy];}
UIFont *fontWithBlackSize(CGFloat size)         {return [UIFont systemFontOfSize:size weight:UIFontWeightBlack];}






/**
 *  颜色
 */
#pragma mark -
#pragma mark - 颜色相关的常用函数

/**
 *  生成随机色
 */
UIColor *randomColor() {
    
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0
                           green:arc4random_uniform(256)/255.0
                            blue:arc4random_uniform(256)/255.0
                           alpha:1];
}

/**
 *  分割线的颜色
 */
UIColor *lineColor() {
    
    return colorWithRGB(0xc7c7c7);
}

/**
 *  边框的颜色
 */
UIColor *borderColor() {
    
    return colorWithRGB(0xC7C7C7);
}

/**
 *  不透明的RGB颜色
 */
UIColor *colorWithRGB(NSInteger color) {
    
    return colorWithRGBA(color, 1);
}

/** 
 *  下划线的颜色
 */
UIColor *tableviewSeparatorColor() {
    return colorWithRGB(0xE6E6E6);
}

/**
 *  几种常见的颜色
 */
UIColor *black_Color(){
    return colorWithRGB(0x000000);
}
UIColor *darkGray_Color(){
     return colorWithRGB(0x333333);
}
UIColor *gray_Color(){
     return colorWithRGB(0x666666);
}
UIColor *lightGray_Color(){
     return colorWithRGB(0x999999);
}
UIColor *lightRedColor(){
    return colorWithRGB(0xEF898F);
}



/**
 *  带透明度的RGBA的颜色
 */
UIColor *colorWithRGBA(NSInteger color, CGFloat alpha) {
    
    float red = ((color & 0xFF0000) >> 16)/255.0;
    float green = ((color &0xFF00) >> 8)/255.0;
    float blue = (color & 0xFF)/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];

}


CGFloat scale(CGFloat x) {
    return screenWidth()/375.0*x;
}

CGFloat screenWidth() {
    return [UIScreen mainScreen].bounds.size.width;
}

CGFloat screenHeight() {
    return [UIScreen mainScreen].bounds.size.height;
}




#pragma mark - 富文本高度计算

CGFloat attributeTextHeight(NSString *str, CGFloat width) {
    
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = 5;
    NSDictionary *dic = @{NSFontAttributeName:font(15), NSParagraphStyleAttributeName:style};
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}


@end
