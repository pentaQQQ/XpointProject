//
//  SystemInformationCell.h
//  TPAPP
//
//  Created by frank on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemInformationCell : UITableViewCell
@property (nonatomic, strong)UIImageView *imageIcon;
@property (nonatomic, strong)UILabel *messageName;
@property (nonatomic, strong)UILabel *messageDeatail;
@property (nonatomic, strong)UILabel *messageDate;
@property (nonatomic, strong)UIImageView *messageUnread;

@end
