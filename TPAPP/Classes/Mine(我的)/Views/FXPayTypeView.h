//
//  FXPayTypeView.h
//  Fxapp
//
//  Created by 琅琊 on 2018/10/6.
//  Copyright © 2018年 琅琊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXPayTypeView : UIView

- (void)show;
- (void)hide;
@property (nonatomic, strong)void(^selectTypeBlock)(NSInteger selectType);
@end
