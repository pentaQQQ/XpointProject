//
//  PiLiangzhuanfaCell.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/9/7.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimilarProductModel.h"
#import "specsModel.h"
#import "imagesListModel.h"
@interface PiLiangzhuanfaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *firstImageview;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageview;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageview;
@property (weak, nonatomic) IBOutlet UIImageView *fourthImageview;


@property (weak, nonatomic) IBOutlet UIImageView *selctImageview;


@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *chimaLab;
@property (weak, nonatomic) IBOutlet UILabel *kuanshiLab;
@property (weak, nonatomic) IBOutlet UILabel *kuanhaoLab;




@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHigh;//产品介绍高度

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chimaHigh;//产品尺码高度

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kuanshiHigh;//款式高度

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kuanhaoHigh;//款号高度



@property(nonatomic,strong)SimilarProductModel*model;

@end
