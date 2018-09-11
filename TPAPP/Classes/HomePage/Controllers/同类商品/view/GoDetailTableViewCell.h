//
//  GoDetailTableViewCell.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimilarProductModel.h"
#import "specsModel.h"
@interface GoDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageview;//商户头像

@property (weak, nonatomic) IBOutlet UILabel *title;//商户名字

@property (weak, nonatomic) IBOutlet UILabel *contentLab;//产品介绍

@property (weak, nonatomic) IBOutlet UILabel *chimLab;//产品尺码

@property (weak, nonatomic) IBOutlet UILabel *kuanshiLab;//款式

@property (weak, nonatomic) IBOutlet UILabel *kuanhaoLab;//款号

@property (weak, nonatomic) IBOutlet UILabel *PriceLab;//最新价格

@property (weak, nonatomic) IBOutlet UILabel *originPriceLab;//原来价格

@property (weak, nonatomic) IBOutlet UILabel *feeLab;//代购费

@property (weak, nonatomic) IBOutlet UIView *pictureView;//图片view

@property (weak, nonatomic) IBOutlet UIButton *shouqianBtn;//售前按钮

@property (weak, nonatomic) IBOutlet UIButton *zhuanfaBtn;//转发按钮

@property (weak, nonatomic) IBOutlet UIView *xinghaoView;//型号view

@property (weak, nonatomic) IBOutlet UIButton *shoppingcartBtn;//购物车按钮

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHigh;//产品介绍高度

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chimaHigh;//产品尺码高度

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kuanshiHigh;//款式高度

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kuanhaoHigh;//款号高度

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureHigh;//图片view高度

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianghaoViewHigh;//型号view高度


@property(nonatomic,strong)SimilarProductModel*model;

@property(nonatomic,copy)void(^addGoodsGoCartBlock)(specsModel*model);

@property(nonatomic,copy)void(^ToZhuanfaBlock)(SimilarProductModel*model,int currentDEX);



@end
