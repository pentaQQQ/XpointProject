//
//  SGNormalPickerView.h
//  Choose
//
//  Created by George on 2016/12/7.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGNormalPickerView : UIView

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle sureButtonTitle:(NSString *)sureButtonTitle dataArray:(NSArray *)dataArray selectBlock:(void(^)(NSString *text))selectBlock;

//@property (nonatomic, copy  ) NSString *preSelectStr;//默认选中的值
@property (nonatomic, copy  ) NSString *selectedString;

- (void)show;
@end
