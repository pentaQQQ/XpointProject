//
//  goodsDetailCell.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/20.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "releaseActivitiesModel.h"
#import "customLabel.h"

#import "OYModel.h"

@interface goodsDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UILabel *title;



@property (weak, nonatomic) IBOutlet UIView *pictureView;

@property (weak, nonatomic) IBOutlet UILabel *content;


@property (weak, nonatomic) IBOutlet UILabel *beginTime;


@property (weak, nonatomic) IBOutlet UILabel *beginDetailTime;

@property (weak, nonatomic) IBOutlet UILabel *endtime;

@property (weak, nonatomic) IBOutlet UIButton *zhuanfaBtn;

@property (weak, nonatomic) IBOutlet UIButton *qianggouBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureViewHigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHigh;

@property (weak, nonatomic) IBOutlet UILabel *tianLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *begintimeWidth;

@property(nonatomic,strong)releaseActivitiesModel*model;

@property(nonatomic,copy)void(^qianggouBlock)(releaseActivitiesModel*model);

@property(nonatomic,copy)void(^zhuanfaBlock)(releaseActivitiesModel*model);

@property (weak, nonatomic) IBOutlet UILabel *daojishiLab;

/// 倒计时到0时回调
@property (nonatomic, copy) void(^countDownZero)(OYModel *);





@end
