//
//  UIAppearance.h
//  GoodDemo
//
//  Created by George on 16/8/26.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIAppearance : NSObject

/**
 *  字体
 */
UIFont *font (CGFloat size);
UIFont *systemsFontSize(CGFloat size);
UIFont *fontNameAndSize (NSString *name, CGFloat size);

UIFont *fontWithUltraLightSize(CGFloat size);
UIFont *fontWithThinSize(CGFloat size);
UIFont *fontWithLightSize(CGFloat size);
UIFont *fontWithRegularSize(CGFloat size);
UIFont *fontWithMediumSize(CGFloat size);
UIFont *fontWithSemiboldSize(CGFloat size);
UIFont *fontWithBoldSize(CGFloat size);
UIFont *fontWithHeavySize(CGFloat size);
UIFont *fontWithBlackSize(CGFloat size);


/**
 *  颜色
 */
UIColor *randomColor();
UIColor *lineColor();
UIColor *colorWithRGB(NSInteger color);
UIColor *colorWithRGBA(NSInteger color, CGFloat alpha);
UIColor *tableviewSeparatorColor();
UIColor *black_Color();
UIColor *darkGray_Color();
UIColor *gray_Color();
UIColor *lightGray_Color();
UIColor *lightRedColor();

CGFloat scale(CGFloat x);
CGFloat screenWidth();
CGFloat screenHeight();



#pragma mark - 富文本高度计算
CGFloat attributeTextHeight(NSString *str, CGFloat width);


@end
