//
//  zhuanfaHeaderView.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/23.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimilarProductModel.h"
#import "specsModel.h"
#import "imagesListModel.h"
#import "zhuanfaModel.h"

@interface zhuanfaHeaderView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *firstImageview;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageview;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageview;
@property (weak, nonatomic) IBOutlet UIImageView *fourthImageview;


@property (weak, nonatomic) IBOutlet UILabel *xinghaoLab;
@property (weak, nonatomic) IBOutlet UILabel *kuanshiLab;
@property (weak, nonatomic) IBOutlet UILabel *kuanhaoLab;



@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *firstSaveBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondSaveBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdSaveBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthSaveBtn;




@property (weak, nonatomic) IBOutlet UIButton *previousPageBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextPageBtn;
@property (weak, nonatomic) IBOutlet UIButton *numberBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhuanfaBtn;



@property(nonatomic,copy)NSString * merchanid;


@property(nonatomic,copy)void(^ToNextMerchanBlock)(void);


@property(nonatomic,copy)void(^zhuanfaBlock)(SimilarProductModel*model,int currentDEX);


@end
