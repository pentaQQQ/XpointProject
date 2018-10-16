//
//  QMAlert.m
//  IMSDK-OC
//
//  Created by haochongfeng on 2017/5/17.
//  Copyright © 2017年 HCF. All rights reserved.
//

#import "QMAlert.h"

@implementation QMAlert

+ (UIWindow *)mainWindow {
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)]) {
        return [app.delegate window];
    }
    else{
        return [app keyWindow];
    }
}

+ (UIWindow *)lastWindow {
    UIApplication *app = [UIApplication sharedApplication];
    return app.windows.lastObject;
}

+(void)showMessage:(NSString *)message{
    UIWindow * window = [self mainWindow];
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.alpha = 0.8;
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize LabelSize = [message boundingRectWithSize:CGSizeMake(kScreenWidth - 100, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    [showview addSubview:label];
    showview.frame = CGRectMake((kScreenWidth - LabelSize.width - 20)/2, kScreenHeight - label.frame.size.height - 80, LabelSize.width + 20, LabelSize.height + 10);
    [UIView animateWithDuration:5 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

//计算文字高度
+ (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 180, 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}

@end
