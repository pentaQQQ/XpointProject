//
//  AddAddressCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/22.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAddressCell : UITableViewCell
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UITextField *myTextField;
@property (nonatomic,strong)UITextView *myTextView;
@property (nonatomic,strong)UISwitch *defaultSwitch;
@property (nonatomic, strong)void(^myBlock)(NSDictionary*);
- (void)configWithModel:(NSMutableArray *)arr;
@end
