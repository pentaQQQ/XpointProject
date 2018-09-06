//
//  danshouView.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/9/6.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimilarProductModel.h"
#import "imagesListModel.h"
#import "specsModel.h"
@interface danshouView : UIView

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *tejiaLab;

@property (weak, nonatomic) IBOutlet UILabel *yuanjiaLab;

@property (weak, nonatomic) IBOutlet UILabel *chimaLab;

@property (weak, nonatomic) IBOutlet UILabel *kuanshiLab;

@property (weak, nonatomic) IBOutlet UILabel *kuanhaoLab;

@property (weak, nonatomic) IBOutlet UIImageView *firstImageview;







@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chimaHigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kuanshiHigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kuanhaoHigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHigh;


@property(nonatomic,strong)SimilarProductModel*model;





@end
