//
//  AccountSetController.h
//  TPAPP
//
//  Created by Frank on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSStaticSectionModel.h"
#import "YSStaticCellModel.h"
#import "YSStaticTableViewCell.h"


@interface AccountSetController : UIViewController
@property (nonatomic, readwrite, strong) NSArray *sectionModelArray;
@property (nonatomic, readonly , strong) UITableView *tableView;

#pragma mark - public method
- (YSStaticSectionModel *)sectionModelInSection:(NSInteger )section;
- (__kindof YSStaticCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath;
@end
