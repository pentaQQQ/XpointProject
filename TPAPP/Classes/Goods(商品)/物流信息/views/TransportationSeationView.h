//
//  TransportationSeationView.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransportationSeationView : UIView
@property (weak, nonatomic) IBOutlet UIButton *rotaBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomview;
@property (weak, nonatomic) IBOutlet UIImageView *orderIcon;
@property (weak, nonatomic) IBOutlet UILabel *orderName;
@property (weak, nonatomic) IBOutlet UILabel *sizeTitle;
@property (weak, nonatomic) IBOutlet UILabel *sizeNum;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *payNumber;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@end
