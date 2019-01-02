//
//  SideViewController.m
//  XYSideMenuDemo
//
//  Created by FireHsia on 2017/8/8.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

#import "SideViewController.h"
//#import "OtherViewController.h"
#import "XYSideViewController.h"
#import "UIViewController+XYSideCategory.h"

#import "shanghuModel.h"
#import "MerchanDetailViewController.h"
@interface SideViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *rootTableView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation SideViewController
-(NSMutableArray*)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setUpCustomViews];
    [self getdata];
}

- (void)setUpCustomViews
{
    [self.view addSubview:self.rootTableView];
}

#pragma mark --- tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuesId = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuesId];
    }
    shanghuModel *model = self.titleArray[indexPath.row];
    
    UIImageView *imageview = [[UIImageView alloc] init];
    [imageview sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    [cell addSubview:imageview];
    imageview.sd_layout
    .topSpaceToView(cell, 10)
    .leftSpaceToView(cell, 10)
    .widthIs(30)
    .heightIs(30);
    imageview.layer.cornerRadius = 15;
    imageview.layer.masksToBounds = YES;
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = model.merchantName;
    titleLabel.font = [UIFont systemFontOfSize:19];
    [cell addSubview:titleLabel];
    titleLabel.sd_layout
    .topSpaceToView(cell, 10)
    .leftSpaceToView(imageview, 10)
    .rightSpaceToView(cell, 10)
    .heightIs(30);
    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
//    cell.detailTextLabel.text = model.merchantName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    shanghuModel *model = self.titleArray[indexPath.row];
    MerchanDetailViewController *otherVC = [[MerchanDetailViewController alloc] init];
    otherVC.ID = model.merchantId;
    otherVC.title = model.merchantName;
    [self XYSidePushViewController:otherVC animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"活动进行中";
    titleLabel.frame = CGRectMake(10, 10, tableView.frame.size.width-20, 30);
    titleLabel.font = [UIFont systemFontOfSize:21];
    titleLabel.textColor = [UIColor colorWithRed:103/255.0 green:5/255.0 blue:47/255.0 alpha:1.0];
    [bgView addSubview:titleLabel];
    return bgView;
}

#pragma mark ---- lazyLoad View
- (UITableView *)rootTableView
{
    
    if (!_rootTableView) {
        _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth/4*3, kScreenHeight-SafeAreaTopHeight) style:UITableViewStylePlain];
        _rootTableView.delegate = self;
        _rootTableView.dataSource = self;
        _rootTableView.tableFooterView = [UIView new];
        
    }
    return _rootTableView;
}



-(void)getdata{
    
    [[NetworkManager sharedManager]getWithUrl:getMerchantList param:nil success:^(id json) {
        NSLog(@"%@",json);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]){
            
            for (NSDictionary *dic in json[@"data"]) {
                shanghuModel *model = [shanghuModel mj_objectWithKeyValues:dic];
                [self.titleArray addObject:model];
                
            }
            [self.rootTableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}



@end
