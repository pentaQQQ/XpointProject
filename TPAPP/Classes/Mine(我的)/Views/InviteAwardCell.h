//
//  InviteAwardCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/24.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteCodeModel.h"
@interface InviteAwardCell : UITableViewCell
@property (nonatomic,strong)UILabel *inviteCodeLabel;
@property (nonatomic,strong)UILabel *codeLabel;
@property (nonatomic,strong)UILabel *registeLabel;
- (void)configWithModel:(InviteCodeModel *)model;
@end
