//
//  MineIndentViewController.h
//  TPAPP
//
//  Created by Frank on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineBaseController.h"
#import "BaseViewController.h"
@protocol SelecteNumberDelegate <NSObject>
- (void)selecteNumber:(NSInteger)index;
@end

@interface MineIndentViewController : BaseViewController
@property (nonatomic, assign)NSInteger selectIndex;
// 在这里定义一个属性，注意这里的修饰词要用weak
@property(nonatomic,weak)id<SelecteNumberDelegate>selecteDelegate;
@end
