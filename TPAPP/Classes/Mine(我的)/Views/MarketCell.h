//
//  MarketCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/20.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
//颜色绘制类型
//typedef NS_ENUM(NSUInteger, GradientType) {
//    GradientTypeTopToBottom = 0,//从上到小
//    GradientTypeLeftToRight = 1,//从左到右
//    GradientTypeUpleftToLowright = 2,//左上到右下
//    GradientTypeUprightToLowleft = 3,//右上到左下
//};
@interface MarketCell : UITableViewCell
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pageController;
//@property (nonatomic, strong)UILabel *marketLimitLabel;
//@property (nonatomic, strong)UILabel *marketTypeLabel;
@property (nonatomic, strong)UIButton *changeBtn;
- (void)configWithMarketLimit:(NSMutableArray *)limitArr andLimitTitle:(NSMutableArray *)titleArr;

@end
