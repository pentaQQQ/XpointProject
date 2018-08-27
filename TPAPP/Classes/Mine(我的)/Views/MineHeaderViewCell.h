//
//  MineHeaderViewCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/20.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
//颜色绘制类型
typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到小
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};
@interface MineHeaderViewCell : UITableViewCell
@property (nonatomic, strong)UIView *headerBgView;

@property (nonatomic, strong)UIView *myAwardBgView;
@property (nonatomic, strong)UILabel *myAwardLabel;
@property (nonatomic, strong)UILabel *detailLabel;
@property (nonatomic, strong)UIButton *ruleBtn;
@property (nonatomic, strong)UIButton *vipBtn;
@property (nonatomic, strong)UIButton *headerBtn;
@property (nonatomic, strong)UIButton *authenticationBtn;
@property (nonatomic, strong)UIButton *accountBtn;
@property (nonatomic, strong)UILabel *numberLabel;
@property (nonatomic, strong)UILabel *distanceLabel;


@property (nonatomic, strong)UIView *moneyBgView;
@property (nonatomic, strong)UILabel *moneyLabel;
@property (nonatomic, strong)UIView *moneyView;
@property (nonatomic, strong)void(^selectBlcok)(NSInteger);
@end
