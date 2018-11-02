//
//  allGoodsView.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/11/2.
//  Copyright © 2018 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shanghuModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface allGoodsView : UIView
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(nonatomic,assign)int currentIndex;

@property(nonatomic,copy)void(^goodviewBlock)(int index,shanghuModel *model);



-(void)removeView;
@end

NS_ASSUME_NONNULL_END
