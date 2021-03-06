//
//  HuoDongCell.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/9/9.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimilarProductModel.h"
@interface HuoDongCell : UITableViewCell
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

@property (weak, nonatomic) IBOutlet UILabel *daojishi;

@property(nonatomic,strong)SimilarProductModel*model;


@property(nonatomic,copy)void(^zhuanfaBlock)(SimilarProductModel*model);

@end
