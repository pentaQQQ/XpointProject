//
//  QMTextModel.m
//  IMSDK-OC
//
//  Created by haochongfeng on 2018/1/23.
//  Copyright © 2018年 HCF. All rights reserved.
//

#import "QMTextModel.h"

@implementation QMTextModel

// 计算文本图片混合高度
+ (CGFloat)calcRobotHeight: (NSString *)htmlString {
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"</br>" withString:@"\n"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];

    __block CGFloat height = 0;
    __block NSString *tempString = htmlString;
    
    NSRegularExpression *regularExpretion = [[NSRegularExpression alloc] initWithPattern:@"<[^>]*>" options:NSRegularExpressionCaseInsensitive error:nil];
    [regularExpretion enumerateMatchesInString:htmlString options:NSMatchingReportProgress range:NSMakeRange(0, [htmlString length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        if (result.range.length != 0) {
            NSString *actionString = [NSString stringWithFormat:@"%@",[htmlString substringWithRange:result.range]];
            
            NSRange range = [tempString rangeOfString:actionString];
            
            // 判断知否包含图片资源
            NSArray *components = nil;
            if ([actionString rangeOfString:@"src=\""].location != NSNotFound) {
                components = [actionString componentsSeparatedByString:@"src=\""];
            }else if ([actionString rangeOfString:@"src="].location != NSNotFound) {
                components = [actionString componentsSeparatedByString:@"src="];
            }
            
            if (components.count >= 2) {
                
                // 文本高度计算
                height += [QMTextModel calcTextHeight:[tempString substringToIndex:range.location]];
                
                // 图片高度固定
                height += 100;
                
                tempString = [tempString substringFromIndex:range.location+range.length];
            }else {
                tempString = [tempString stringByReplacingCharactersInRange:range withString:@""];
            }
        }
    }];
    
    // 文本高度计算
    height += [QMTextModel calcTextHeight:tempString];
    
    return height;
}

// 计算文本高度
+ (CGFloat)calcTextHeight: (NSString *)text {
    MLEmojiLabel *tLabel = [MLEmojiLabel new];
    tLabel.numberOfLines = 0;
    tLabel.font = [UIFont systemFontOfSize:14.0f];
    tLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    tLabel.disableEmoji = NO;
    tLabel.disableThreeCommon = NO;
    tLabel.isNeedAtAndPoundSign = YES;
    tLabel.customEmojiRegex = @"\\:[^\\:]+\\:";
    tLabel.customEmojiPlistName = @"expressionImage.plist";
    tLabel.customEmojiBundleName = @"QMEmoticon.bundle";
    tLabel.text = text;
    CGSize size = [tLabel preferredSizeWithMaxWidth: [UIScreen mainScreen].bounds.size.width - 160];
    return size.height;
}

@end
