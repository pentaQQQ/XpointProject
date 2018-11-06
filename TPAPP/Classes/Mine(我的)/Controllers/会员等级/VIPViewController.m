//
//  VIPViewController.m
//  TPAPP
//
//  Created by frank on 2018/8/25.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "VIPViewController.h"
#import "VipHeaderCell.h"
#import "VipDeatailCell.h"

@interface VIPViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;

@end

@implementation VIPViewController
#pragma mark - 懒加载
-(NSMutableArray *)listDataArr
{
    if (_listDataArr == nil) {
        _listDataArr = [NSMutableArray array];
    }
    return _listDataArr;
}
#pragma mark - 创建tableview
-(UITableView *)listTableView
{
    if (_listTableView == nil) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _listTableView.backgroundColor = colorWithRGB(0xEEEEEE);
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.showsHorizontalScrollIndicator = NO;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_listTableView];
        //获取状态栏的rect
        CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
        //获取导航栏的rect
        CGRect navRect = self.navigationController.navigationBar.frame;
        _listTableView.sd_layout
        .topSpaceToView(self.view, statusRect.size.height+navRect.size.height)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomSpaceToView(self.view, SafeAreaBottomHeight);
        
    }
    return _listTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"会员等级";
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self listTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        VipHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"VipHeaderCellID"];
        if (!headerCell) {
            headerCell = [[VipHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VipHeaderCellID"];
        }
        
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return headerCell;
    }else{
        VipDeatailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VipDeatailCellID"];
        if (!cell) {
            cell = [[VipDeatailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VipDeatailCellID"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section== 0) {
       return 0;
    }else{
       return 30;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 0;
    }else{
       return 10;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return nil;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        view.backgroundColor = colorWithRGB(0xEEEEEE);
        return view;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else{
        NSArray *listArr = @[@"会员权益",@"升级规则"];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIImageView *lineImgeView = [[UIImageView alloc] init];
        [view addSubview:lineImgeView];
        lineImgeView.image = [UIImage imageNamed:@"icon_mine_line"];
        lineImgeView.sd_layout
        .topSpaceToView(view, 7)
        .leftSpaceToView(view, 15)
        .bottomSpaceToView(view, 7)
        .widthIs(2);
        
        UILabel *listLabel = [[UILabel alloc] init];
        [view addSubview:listLabel];
        listLabel.sd_layout
        .topSpaceToView(view, 5)
        .leftSpaceToView(lineImgeView, 5)
        .widthIs(150)
        .heightIs(20);
        listLabel.font = [UIFont systemFontOfSize:15];
        listLabel.text = listArr[section-1];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5,kScreenWidth , 1)];
        lineView.backgroundColor = colorWithRGB(0xEEEEEE);
        [view addSubview:lineView];
        return view;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 110;
    }
    return 200;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
