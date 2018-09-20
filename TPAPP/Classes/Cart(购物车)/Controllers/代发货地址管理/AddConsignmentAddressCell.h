//
//  AddConsignmentAddressCell.h
//  TPAPP
//
//  Created by frank on 2018/9/15.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddConsignmentAddressCell : UITableViewCell
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UITextField *myTextField;
@property (nonatomic,strong)UITextView *myTextView;
@property (nonatomic,strong)UISwitch *defaultSwitch;
@property (nonatomic,strong)void(^myBlock)(NSString*);

@property (nonatomic,assign)NSInteger defaultNumber;

- (void)configWithModel:(NSMutableArray *)arr withModelData:(NSMutableArray *)modelArr withNumber:(NSInteger)num;
@end
