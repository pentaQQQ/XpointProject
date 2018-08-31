//
//  messageHeaderView.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface messageHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIButton *wuliuBtn;
@property(nonatomic,copy)void(^messageBlock)(void);
@property(nonatomic,copy)void(^wuliuBlock)(void);
@end
