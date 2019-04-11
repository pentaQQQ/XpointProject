//
//  huodongzhuanfayaView.h
//  TPAPP
//
//  Created by 崔文龙 on 2019/4/9.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "zhuanfaModel.h"
#import "releaseActivitiesModel.h"



NS_ASSUME_NONNULL_BEGIN

@interface huodongzhuanfayaView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *firstimageview;
@property (weak, nonatomic) IBOutlet UILabel *huodongTitle;
@property (weak, nonatomic) IBOutlet UITextView *biaotiTextView;
@property (weak, nonatomic) IBOutlet UILabel *dianjiBiaotiLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;



@property (weak, nonatomic) IBOutlet UIView *zhuanfaView;
@property (weak, nonatomic) IBOutlet UILabel *zhuanfaLab;




@property (weak, nonatomic) IBOutlet UIView *jiajiaView;
@property (weak, nonatomic) IBOutlet UILabel *jiajiaLab;
@property (weak, nonatomic) IBOutlet UIView *jiajiaLineView;


@property (weak, nonatomic) IBOutlet UIView *zidingyiView;
@property (weak, nonatomic) IBOutlet UILabel *zidingyiLab;
@property (weak, nonatomic) IBOutlet UIView *zidingyiLineView;



@property (weak, nonatomic) IBOutlet UIButton *bujiajiaBtn;
@property (weak, nonatomic) IBOutlet UIButton *fiveBtn;
@property (weak, nonatomic) IBOutlet UIButton *tenBtn;
@property (weak, nonatomic) IBOutlet UIButton *fitenBtn;

@property (weak, nonatomic) IBOutlet UIView *zidingyihahhaView;

@property (weak, nonatomic) IBOutlet UITextField *textfield;


@property (weak, nonatomic) IBOutlet UIImageView *secondImageview;
@property (weak, nonatomic) IBOutlet UILabel *guigeLab;

@property (weak, nonatomic) IBOutlet UILabel *tejiaLab;
@property (weak, nonatomic) IBOutlet UILabel *yuanjiaLab;


@property (weak, nonatomic) IBOutlet UIButton *yulanBtn;


@property (weak, nonatomic) IBOutlet UIButton *zhuanfaBtn;


@property(nonatomic,copy)void(^removeBlock)(void);




@property(nonatomic,strong)releaseActivitiesModel*model;

@property(nonatomic,strong)zhuanfaModel*zhuanfamodel;


@property(nonatomic,copy)NSString *merchantId;

@property(nonatomic,copy)NSString *activityId;

@property(nonatomic,copy)NSString *imageurl;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)void(^toH5Block)(NSString *url);

@property(nonatomic,copy)void(^zhuanfaBlock)(NSString *url);

-(void)removeView;
@end

NS_ASSUME_NONNULL_END
