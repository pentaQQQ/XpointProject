//
//  MineIndentChildController.m
//  TPAPP
//
//  Created by Frank on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "MineIndentChildController.h"
#import "OrderDetailViewController.h"
#import "GoodsListCell.h"
#import "MineIndentListCell.h"
#import "LKBubble.h"
#import "SVProgressHUD+DoAnythingAfter.h"
#import "MBProgressHUD+NJ.h"

@interface MineIndentChildController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;

@end

@implementation MineIndentChildController

#pragma mark - 懒加载
-(NSMutableArray *)listDataArr
{
    if (_listDataArr == nil) {
        _listDataArr = [NSMutableArray array];
    }
    return _listDataArr;
}
- (void)setUpUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-SafeAreaTopHeight-44) style:UITableViewStyleGrouped];
    
    [self.view addSubview:tableView];
    self.listTableView = tableView;
    self.listTableView.backgroundColor = colorWithRGB(0xEEEEEE);
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.showsVerticalScrollIndicator = NO;
    self.listTableView.showsHorizontalScrollIndicator = NO;
    if ([self.listTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.listTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.listTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.listTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
//#pragma mark - 创建tableview
//-(UITableView *)listTableView
//{
//    if (_listTableView == nil) {
//        _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//        _listTableView.backgroundColor = colorWithRGB(0xEEEEEE);
//        _listTableView.delegate = self;
//        _listTableView.dataSource = self;
//        _listTableView.showsVerticalScrollIndicator = NO;
//        _listTableView.showsHorizontalScrollIndicator = NO;
//        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [self.view addSubview:_listTableView];
//        _listTableView.sd_layout
//        .topSpaceToView(self.view, 0)
//        .leftEqualToView(self.view)
//        .rightEqualToView(self.view)
//        .bottomEqualToView(self.view);
//
//    }
//    return _listTableView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"我的订单";
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self dsads:self.selectCtrl];
    [self setUpUI];
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.listTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.listTableView.mj_header beginRefreshing];

}

#pragma mark - 下拉刷新数据
- (void)loadNewTopic
{
//    [self.listTableView.mj_header beginRefreshing];
    [[NetworkManager sharedManager] getWithUrl:getMainResources param:nil success:^(id json) {
        NSLog(@"%@",json);
        if ([self.listTableView.mj_header isRefreshing]) {
            [self.listTableView.mj_header endRefreshing];
        }
        UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
        [MBProgressHUD hideHUDForView:keyWindow];
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            
                    // 这里是你点击了cell里的某个按钮后要做的操作
                    if (self.selectCtrl == 0) {
            
                        self.listDataArr  = [NSMutableArray arrayWithObjects:@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"1"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"1"]]},@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"2"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"2"]]},@{@"goodName":@"耐克旗舰店",@"listArr":@[@[@"icon",@"NIKE男士运动板鞋",@"40码",@"1",@"355678",@"1",@"420",@"商家已接单",@"3"]]},@{@"goodName":@"阿迪达斯舰店",@"listArr":@[@[@"icon",@"阿迪达斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"商家已发货",@"4"],@[@"icon",@"阿迪达斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"商家已发货",@"4"]]},@{@"goodName":@"安踏旗舰店",@"listArr":@[@[@"icon",@"安踏旗男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已取消",@"5"]]}, nil];
                    }else if (self.selectCtrl == 1){
                        self.listDataArr  = [NSMutableArray arrayWithObjects:@{@"goodName":@"花花公子旗舰店",@"listArr":@[@[@"icon",@"花花公子旗男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"等待付款",@"1"]]},@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"1"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"1"]]}, nil];
                    }else if (self.selectCtrl == 2){
                        self.listDataArr  = [NSMutableArray arrayWithObjects:@{@"goodName":@"花花公子旗舰店",@"listArr":@[@[@"icon",@"花花公子旗男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"2"]]},@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"2"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"2"]]}, nil];
                    }else if (self.selectCtrl == 3){
                        self.listDataArr  = [NSMutableArray arrayWithObjects:@{@"goodName":@"花花公子旗舰店",@"listArr":@[@[@"icon",@"花花公子旗男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"商家已接单",@"3"]]},@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"商家已接单",@"3"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"商家已接单",@"3"]]}, nil];
                    }else if (self.selectCtrl == 4){
                        self.listDataArr  = [NSMutableArray arrayWithObjects:@{@"goodName":@"花花公子旗舰店",@"listArr":@[@[@"icon",@"花花公子旗男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"商家已发货",@"4"]]},@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"商家已发货",@"4"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"商家已发货",@"4"]]}, nil];
                    }else{
                        self.listDataArr = [NSMutableArray array];
//                        self.listDataArr  = [NSMutableArray arrayWithObjects:@{@"goodName":@"花花公子旗舰店",@"listArr":@[@[@"icon",@"花花公子旗男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已取消",@"5"]]},@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已取消",@"5"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"买家已取消",@"5"]]}, nil];
                    }
                    [self.listTableView reloadData];
        }else if([json[@"code"]longValue] == 500){
            
            [self.listTableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listDataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = self.listDataArr[section];
    NSArray *arr = dict[@"listArr"];
    return [arr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineIndentListCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"MineIndentListCellID"];
    if (!headerCell) {
        headerCell = [[MineIndentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineIndentListCellID"];
    }
    
    headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.listDataArr[indexPath.section];
    NSArray *arr = dict[@"listArr"];
    [headerCell configWithModel:arr[indexPath.row]];
    [headerCell setSelectBlock:^(NSInteger num, MineIndentListCell *cell) {
        
    }];
    return headerCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = colorWithRGB(0xEEEEEE);
    
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
//    NSArray *listArr = @[@"2018-07-23",@"2018-07-22",@"2018-07-21",@"2018-07-20",@"2018-07-19",@"2018-07-18",@"2018-07-17",@"2018-07-16",@"2018-07-15",@"2018-07-14"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
//    UIImageView *lineImgeView = [[UIImageView alloc] init];
//    [view addSubview:lineImgeView];
//    lineImgeView.image = [UIImage imageNamed:@"icon_mine_line"];
//    lineImgeView.sd_layout
//    .topSpaceToView(view, 7)
//    .leftSpaceToView(view, 15)
//    .bottomSpaceToView(view, 7)
//    .widthIs(2);
    
    UILabel *listLabel = [[UILabel alloc] init];
    [view addSubview:listLabel];
    listLabel.sd_layout
    .topSpaceToView(view, 5)
    .leftSpaceToView(view, 15)
    .widthIs(150)
    .heightIs(20);
    listLabel.font = [UIFont systemFontOfSize:15];
    NSDictionary *dict = self.listDataArr[section];
    listLabel.text = dict[@"goodName"];

    
    UIImageView *lineImgeView = [[UIImageView alloc] init];
    lineImgeView.image = [UIImage imageNamed:@"我的订单_line"];
    [view addSubview:lineImgeView];
    lineImgeView.sd_layout
    .topSpaceToView(view, 29)
    .leftSpaceToView(view, 0)
    .rightSpaceToView(view, 0)
    .heightIs(1);
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderDetailViewController *minePerCtrl = [[OrderDetailViewController alloc] init];
    [self.navigationController pushViewController:minePerCtrl animated:YES];
}
#pragma mark --------------- LeftBodyCellDelegate
- (void)selecteNumber:(NSInteger)index
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.selectCtrl = index;
        //进入刷新状态
        if (self.listTableView == nil) {
            [self setUpUI];
            self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
             [self.listTableView.mj_header beginRefreshing];
        }else{
           [self.listTableView.mj_header beginRefreshing];
        }
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
//            [MBProgressHUD showMessage:nil toView:keyWindow];
//            [self loadNewTopic];
//        });
        
    });
    
}

#pragma mark - TableView 占位图
- (UIImage *)xy_noDataViewImage {
    return [UIImage imageNamed:@"noOrder"];
}

- (NSString *)xy_noDataViewMessage {
    return @"暂无相关订单";
}

- (UIColor *)xy_noDataViewMessageColor {
    return [UIColor blackColor];
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
