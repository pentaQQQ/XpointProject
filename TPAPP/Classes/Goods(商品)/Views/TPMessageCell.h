//
//  TPMessageCell.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@end
