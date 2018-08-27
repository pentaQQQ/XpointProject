//
//  MineBaseController.h
//  TPAPP
//
//  Created by Frank on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryBaseView.h"
@protocol SelecteTypeNumberDelegate <NSObject>
- (void)selecteTypeNumber:(NSInteger)index;
@end

@interface MineBaseController : UIViewController<JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryBaseView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign)NSInteger selectType;
// 在这里定义一个属性，注意这里的修饰词要用weak
@property(nonatomic,weak)id<SelecteTypeNumberDelegate>selecteDelegate;
- (Class)preferredCategoryViewClass;

- (NSUInteger)preferredListViewCount;

- (CGFloat)preferredCategoryViewHeight;
@end
