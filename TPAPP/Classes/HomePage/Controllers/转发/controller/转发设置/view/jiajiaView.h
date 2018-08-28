//
//  jiajiaView.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/28.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jiajiaView : UIView
@property (weak, nonatomic) IBOutlet UIView *firstView;


@property (weak, nonatomic) IBOutlet UILabel *firstContentLab;


@property (weak, nonatomic) IBOutlet UIView *secongView;
@property (weak, nonatomic) IBOutlet UILabel *secondContentLab;





@property (weak, nonatomic) IBOutlet UIView *thirdView;

@property (weak, nonatomic) IBOutlet UILabel *thirdContentLab;



@property (weak, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UILabel *fourthContentLab;


@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;



@property(nonatomic,copy)void(^removeBlock)(void);


@property(nonatomic,copy)void(^jiajiaBlock)(NSString*title,NSString*detailTitle);


-(void)removeView;

@end
