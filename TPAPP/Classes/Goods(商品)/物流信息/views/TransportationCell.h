//
//  TransportationCell.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransportationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bottomview;
@property (weak, nonatomic) IBOutlet UIImageView *wuliuStatusIcon;
//@property (weak, nonatomic) IBOutlet UILabel *sendStatus;
@property (weak, nonatomic) IBOutlet UILabel *sendAddress;
@property (weak, nonatomic) IBOutlet UILabel *yearMouthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayTimeLabel;

@end
