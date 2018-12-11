//
//  HasBeenCancelledController.m
//  TPAPP
//
//  Created by Frank on 2018/12/5.
//  Copyright © 2018 cbl－　点硕. All rights reserved.
//

#import "HasBeenCancelledController.h"
#import "OrderDetailViewController.h"
#import "GoodsListCell.h"
#import "MineIndentListCell.h"
#import "LKBubble.h"
#import "SVProgressHUD+DoAnythingAfter.h"
#import "MBProgressHUD+NJ.h"
#import "MineIndentModel.h"
@interface HasBeenCancelledController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)NSMutableArray *urlArr;
@property (nonatomic, strong)NSString *urlString;

@end

@implementation HasBeenCancelledController

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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.listDataArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.title =@"我的订单";
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    [self dsads:self.selectCtrl];
    //    if (self.selectCtrl == 0) {
    self.urlString = getOrderListInfo;
    //    }
    [self setUpUI];
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.listTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    //    [self.listTableView.mj_header beginRefreshing];
//    [SVProgressHUD doAnythingWithHUDMessage:nil];
//    [self loadNewTopic];
}

#pragma mark - 下拉刷新数据
- (void)loadNewTopic
{
    LYAccount *account = [LYAccount shareAccount];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:account.id forKey:@"userId"];
    [dic setValue:@(1) forKey:@"pageNum"];
    [dic setValue:@(10) forKey:@"pageSize"];
    [dic setValue:@(self.selectCtrl) forKey:@"status"];
    [LYTools postBossDemoWithUrl:self.urlString param:dic success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        [SVProgressHUD dismiss];
        [SVProgressHUD dismiss];
        if ([self.listTableView.mj_header isRefreshing]) {
            [self.listTableView.mj_header endRefreshing];
        }
        NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            [self.listDataArr removeAllObjects];
            dispatch_async(dispatch_get_main_queue(), ^{
                for (NSDictionary *dics in dict[@"data"]) {
                    MineIndentModel *model = [MineIndentModel mj_objectWithKeyValues:dics];
                    AddressModel *addressModel = [AddressModel mj_objectWithKeyValues:dics[@"addressInfo"]];
                    model.addressInfo = addressModel;
                    OrderLogisticsModel *logisticsModel = [OrderLogisticsModel mj_objectWithKeyValues:dics[@"orderLogistics"]];
                    model.orderLogistics = logisticsModel;
                    [model.orderDetailList removeAllObjects];
                    for (NSDictionary *newDic in dics[@"orderDetailList"]) {
                        OrderDetailModel *orderDetailModel = [OrderDetailModel mj_objectWithKeyValues:newDic];
                        [model.orderDetailList addObject:orderDetailModel];
                        
                    }
                    [self.listDataArr addObject:model];
                }

                // 这里是你点击了cell里的某个按钮后要做的操作
                //                if (self.selectCtrl == 0) {
                //                    self.listDataArr  = [NSMutableArray arrayWithObjects:@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"1"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"1"]]},@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"2"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"2"]]},@{@"goodName":@"耐克旗舰店",@"listArr":@[@[@"icon",@"NIKE男士运动板鞋",@"40码",@"1",@"355678",@"1",@"420",@"商家已接单",@"3"]]},@{@"goodName":@"阿迪达斯舰店",@"listArr":@[@[@"icon",@"阿迪达斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"商家已发货",@"4"],@[@"icon",@"阿迪达斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"商家已发货",@"4"]]},@{@"goodName":@"安踏旗舰店",@"listArr":@[@[@"icon",@"安踏旗男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已取消",@"5"]]}, nil];
                //                }else if (self.selectCtrl == 1){
                //                    self.listDataArr  = [NSMutableArray arrayWithObjects:@{@"goodName":@"花花公子旗舰店",@"listArr":@[@[@"icon",@"花花公子旗男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"等待付款",@"1"]]},@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"1"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"1"]]}, nil];
                //                }else if (self.selectCtrl == 2){
                //                    self.listDataArr  = [NSMutableArray arrayWithObjects:@{@"goodName":@"花花公子旗舰店",@"listArr":@[@[@"icon",@"花花公子旗男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"2"]]},@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"2"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"买家已付款",@"2"]]}, nil];
                //                }else if (self.selectCtrl == 3){
                //                    self.listDataArr  = [NSMutableArray arrayWithObjects:@{@"goodName":@"花花公子旗舰店",@"listArr":@[@[@"icon",@"花花公子旗男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"商家已接单",@"3"]]},@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"商家已接单",@"3"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"商家已接单",@"3"]]}, nil];
                //                }else if (self.selectCtrl == 4){
                //                    self.listDataArr  = [NSMutableArray arrayWithObjects:@{@"goodName":@"花花公子旗舰店",@"listArr":@[@[@"icon",@"花花公子旗男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"商家已发货",@"4"]]},@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"商家已发货",@"4"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"商家已发货",@"4"]]}, nil];
                //                }else{
                //                    self.listDataArr = [NSMutableArray array];
                //                    //self.listDataArr  = [NSMutableArray arrayWithObjects:@{@"goodName":@"花花公子旗舰店",@"listArr":@[@[@"icon",@"花花公子旗男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已取消",@"5"]]},@{@"goodName":@"杰克琼斯旗舰店",@"listArr":@[@[@"icon",@"杰克琼斯男士上衣新款休闲",@"L码",@"1",@"355678",@"1",@"120",@"买家已取消",@"5"],@[@"icon",@"杰克琼斯男士秋季夹克",@"L码",@"1",@"355678",@"1",@"120",@"买家已取消",@"5"]]}, nil];
                //                }
               
                [self.listTableView reloadData];
            });
        }else if([dict[@"code"]longValue] == 500){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                [self.listTableView reloadData];
            });
        }
    } fail:^(NSError *error) {
        
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
    MineIndentModel *model = self.listDataArr[section];
    
    NSArray *arr = model.orderDetailList;
    return [arr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineIndentListCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"MineIndentListCellID"];
    if (!headerCell) {
        headerCell = [[MineIndentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineIndentListCellID"];
    }
    headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
    MineIndentModel *model = self.listDataArr[indexPath.section];
    
    OrderDetailModel *detailModel = model.orderDetailList[indexPath.row];
    [headerCell configWithModel:detailModel andMineIndentModel:model];
    [headerCell setSelectBlock:^(NSInteger num, MineIndentListCell *cell) {
        
    }];
    return headerCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MineIndentModel *model = self.listDataArr[section];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    bgView.backgroundColor = colorWithRGB(0xEEEEEE);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:view];
    
    UILabel*goodStatus = [[UILabel alloc] init];
    goodStatus.textAlignment = NSTextAlignmentLeft;
    goodStatus.textColor = colorWithRGB(0xFF6B24);
    goodStatus.font = [UIFont systemFontOfSize:15];
    [view addSubview:goodStatus];
    goodStatus.sd_layout
    .topSpaceToView(view, 15)
    .leftSpaceToView(view, 15)
    .widthIs(80)
    .heightIs(20);
    if ([model.status isEqualToString:@"5"]){
        goodStatus.text = @"已取消";
    }
    
    return bgView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
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
    .topSpaceToView(view, 10)
    .leftSpaceToView(view, 15)
    .widthIs(150)
    .heightIs(20);
    listLabel.font = [UIFont systemFontOfSize:15];
    MineIndentModel *model = self.listDataArr[section];
    listLabel.text = model.merchantName;
    listLabel.textColor = [UIColor colorWithRed:103.0/255.0 green:5.0/255.0 blue:67.0/255.0 alpha:1.0];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MineIndentModel *minModel = self.listDataArr[indexPath.section];
    OrderDetailViewController *minePerCtrl = [[OrderDetailViewController alloc] init];
    minePerCtrl.model = minModel;
    [self.navigationController pushViewController:minePerCtrl animated:YES];
}
#pragma mark --------------- LeftBodyCellDelegate
- (void)selecteHasBeenCancelled:(NSInteger)index
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.selectCtrl = index;
        //进入刷新状态
        if (self.listTableView == nil) {
            [self setUpUI];
            self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
        }else{
        }
        [SVProgressHUD doAnythingWithHUDMessage:nil];
        [self loadNewTopic];
    });
}

#pragma mark - TableView 占位图
- (UIImage *)xy_noDataViewImage {
    return [UIImage imageNamed:@"缺省-暂无"];
}

- (NSString *)xy_noDataViewMessage {
    return @"暂无相关订单";
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
