//
//  messageHeaderView.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "messageHeaderView.h"

@implementation messageHeaderView
- (IBAction)messageBtnClick:(id)sender {
    if (self.messageBlock) {
        self.messageBlock();
    }
}

- (IBAction)wuliuBtnClick:(id)sender {
    if (self.wuliuBlock) {
        self.wuliuBlock();
    }
}

@end
