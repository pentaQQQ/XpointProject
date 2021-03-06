//
//  AllOrderListController.m
//  TPAPP
//
//  Created by Frank on 2019/3/11.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//
#define KeyWindow [UIApplication sharedApplication].keyWindow
#import "AllOrderListController.h"
#import "OrderDetailViewController.h"
#import "GoodsListCell.h"
#import "MineIndentListCell.h"
#import "LKBubble.h"
#import "SVProgressHUD+DoAnythingAfter.h"
#import "MBProgressHUD+NJ.h"
#import "MineIndentModel.h"
#import "UITableView+XY.h"
#import "XYNoDataView.h"
#import "BuyGoodsListController.h"
#import "FXPayTypeView.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "WXApi.h"
#import "TransportationMessageViewController.h"
#import "TransMessViewController.h"
#import "ApplyDeatailController.h"
@interface AllOrderListController ()<UITableViewDelegate, UITableViewDataSource,DeclareAbnormalAlertViewOrderListRemindDelegate,WXApiManagerPayDelegate,WXApiDelegate>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)NSMutableArray *urlArr;
@property (nonatomic, strong)NSString *urlString;
@property (nonatomic, strong) FXPayTypeView *payTypeView;
@end

@implementation AllOrderListController
{
    NSMutableDictionary *_selectDict;
    int _dataRefreshNumber;
    int _isFiveData;
}
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
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-SafeAreaTopHeight-44) style:UITableViewStyleGrouped];
    
    [self.view addSubview:self.listTableView];
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
- (void)headerRereshing
{
    _dataRefreshNumber = 1;
    [self loadNewTopic];
    
}
- (void)footerRereshing
{
    _dataRefreshNumber++;
    [self loadNewTopic];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listDataArr = [NSMutableArray array];
    [WXApiManager sharedManager].paydelegate = self;
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPaytype:) name:@"aliPaytype"object:nil];
    // Do any additional setup after loading the view.
    self.title =@"我的订单";
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    [self dsads:self.selectCtrl];
    //    if (self.selectCtrl == 0) {
    self.urlString = getOrderListInfo;
    //    }
    [self setUpUI];
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    //    [self.listTableView.mj_header beginRefreshing];
    self.listTableView.mj_header.automaticallyChangeAlpha = YES;
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    self.listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
//    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    
    //进入刷新状态
    //    [self.listTableView.mj_header beginRefreshing];
    //    [SVProgressHUD doAnythingWithHUDMessage:nil];
    //    [self loadNewTopic];
}
//接收通知并相应的方法
- (void) aliPaytype:(NSNotification *)notification{
    NSDictionary *dic = notification.object;
    //    NSLog(@"通知过来的 - dic = %@",notification.object);
    int statusCode = [dic[@"resultStatus"]  intValue];
    if (statusCode == 9000)
    {
        [self loadNewTopic];
    }
    else
    {
        DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"支付失败"] selectType:@"支付失败" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:nil];
        [alertView show];
    }
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"aliPaytype" object:nil];
}
#pragma mark 微信回调的代理方法
- (void)WXApiManagerPay:(PayResp *)payResp{
    //支付返回结果，实际支付结果需要去微信服务器端查询
    NSString *strMsg;
    
    if (payResp.errCode == WXSuccess) {
        strMsg = @"支付结果：成功！";
        NSLog(@"支付成功－PaySuccess，retcode = %d", payResp.errCode);
        [self loadNewTopic];
    }else{
        DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"支付失败"] selectType:@"支付失败" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:nil];
        [alertView show];
        strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", payResp.errCode,payResp.errStr];
        NSLog(@"错误，retcode = %d, retstr = %@", payResp.errCode,payResp.errStr);
    }
    
    
}
#pragma mark - 下拉刷新数据
- (void)loadNewTopic
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        LYAccount *account = [LYAccount shareAccount];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:account.id forKey:@"userId"];
        [dic setValue:@(10) forKey:@"pageSize"];
        [dic setValue:@(self->_dataRefreshNumber) forKey:@"pageNum"];
        [LYTools postBossDemoWithUrl:self.urlString param:dic success:^(NSDictionary *dict) {
            NSLog(@"%@",dict);
            [SVProgressHUD dismiss];
            [SVProgressHUD dismiss];
            if ([self.listTableView.mj_header isRefreshing]) {
                [self.listTableView.mj_header endRefreshing];
            }
            if ([self.listTableView.mj_footer isRefreshing]) {
                [self.listTableView.mj_footer endRefreshing];
            }
            NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
            if ([respCode isEqualToString:@"00000"]) {
                if (self->_dataRefreshNumber == 1) {
                  [self.listDataArr removeAllObjects];
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
                    [self performSelectorOnMainThread:@selector(reloadDeals) withObject:self waitUntilDone:NO];
                    if (self.listDataArr.count != 0) {
                        [self.listTableView xy_havingData:YES];
                    }else{
                        [self.listTableView xy_havingData:NO];
                    }
                }else{
                    if ([dict[@"data"] count] < 10) {
                        self->_isFiveData++;
                        if (self->_isFiveData > 1) {
                            [self.listTableView.mj_footer endRefreshingWithNoMoreData];
                        }else{
                            if (self.listDataArr.count < 10) {
                                [self.listTableView.mj_footer endRefreshingWithNoMoreData];
                            }else{
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
                                [self performSelectorOnMainThread:@selector(reloadDeals) withObject:self waitUntilDone:NO];
                            }
                            
                        }
                    }else{
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
                        [self performSelectorOnMainThread:@selector(reloadDeals) withObject:self waitUntilDone:NO];
                    }
                }
            }else if([dict[@"code"]longValue] == 500){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                    [self performSelectorOnMainThread:@selector(reloadDeals) withObject:self waitUntilDone:NO];
                    if (self.listDataArr.count != 0) {
                        [self.listTableView xy_havingData:YES];
                    }else{
                        [self.listTableView xy_havingData:NO];
                    }
                });
            }
        } fail:^(NSError *error) {
            
        }];
    });
}
- (void)reloadDeals
{
    [self.listTableView reloadData];
    [self.listTableView.mj_header endRefreshing];
    [self.listTableView.mj_footer endRefreshing];
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
    if ([model.status isEqualToString:@"0"]) {
        goodStatus.text = @"待支付";
        if ([model.afterStatus isEqualToString:@"0"]) {
            UIButton *paymentBtn = [[UIButton alloc] init];
            paymentBtn.tag = section;
            paymentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            paymentBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [paymentBtn setTitle:@"去支付" forState:UIControlStateNormal];
            [paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [paymentBtn addTarget:self action:@selector(applyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:paymentBtn];
            paymentBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(view, 15)
            .widthIs(70)
            .heightIs(30);
            paymentBtn.layer.cornerRadius = 3;
            paymentBtn.layer.masksToBounds = YES;
            
            
            UIButton*cancelGoodsBtn = [[UIButton alloc] init];
            cancelGoodsBtn.tag = section;
            cancelGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            cancelGoodsBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [cancelGoodsBtn setTitle:@"取消交易" forState:UIControlStateNormal];
            [cancelGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cancelGoodsBtn addTarget:self action:@selector(cancelGoodsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:cancelGoodsBtn];
            cancelGoodsBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(paymentBtn, 10)
            .widthIs(70)
            .heightIs(30);
            cancelGoodsBtn.layer.cornerRadius = 3;
            cancelGoodsBtn.layer.masksToBounds = YES;
        }
        
    }else if ([model.status isEqualToString:@"1"]){
        if ([model.afterStatus isEqualToString:@"1"]) {
            goodStatus.text = @"申请退款";
        }else if ([model.afterStatus isEqualToString:@"2"]) {
            goodStatus.text = @"拒绝退款";
        }else if ([model.afterStatus isEqualToString:@"3"]) {
            goodStatus.text = @"申请退货退款";
        }else if ([model.afterStatus isEqualToString:@"4"]) {
            goodStatus.text = @"拒绝退货";
        }else if ([model.afterStatus isEqualToString:@"5"]) {
            goodStatus.text = @"退货中";
        }else if ([model.afterStatus isEqualToString:@"7"]) {
            goodStatus.text = @"退款成功";
        }else if ([model.afterStatus isEqualToString:@"8"]) {
            goodStatus.text = @"退款中";
        }else{
            goodStatus.text = @"已支付";
        }
        
        if ([model.afterStatus isEqualToString:@"0"]||[model.afterStatus isEqualToString:@"6"]) {
            UIButton *lookLogisticsBtn = [[UIButton alloc] init];
            lookLogisticsBtn.tag = section;
            lookLogisticsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            lookLogisticsBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [lookLogisticsBtn setTitle:@"退款" forState:UIControlStateNormal];
            [lookLogisticsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lookLogisticsBtn addTarget:self action:@selector(lookLogisticsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:lookLogisticsBtn];
            lookLogisticsBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(view, 10)
            .widthIs(70)
            .heightIs(30);
            lookLogisticsBtn.layer.cornerRadius = 3;
            lookLogisticsBtn.layer.masksToBounds = YES;
            
            
            UIButton *deliverGoodsBtn = [[UIButton alloc] init];
            deliverGoodsBtn.tag = section;
            deliverGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            deliverGoodsBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [deliverGoodsBtn setTitle:@"确认发货" forState:UIControlStateNormal];
            [deliverGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [deliverGoodsBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:deliverGoodsBtn];
            deliverGoodsBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(lookLogisticsBtn, 10)
            .widthIs(70)
            .heightIs(30);
            deliverGoodsBtn.layer.cornerRadius = 3;
            deliverGoodsBtn.layer.masksToBounds = YES;
            
        }else{
            UIButton *deliverGoodsBtn = [[UIButton alloc] init];
            deliverGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            deliverGoodsBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [deliverGoodsBtn setTitle:@"确认发货" forState:UIControlStateNormal];
            [deliverGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [deliverGoodsBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:deliverGoodsBtn];
            deliverGoodsBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(view, 15)
            .widthIs(70)
            .heightIs(30);
            deliverGoodsBtn.layer.cornerRadius = 3;
            deliverGoodsBtn.layer.masksToBounds = YES;
        }
        
    }else if ([model.status isEqualToString:@"2"]){
        if ([model.afterStatus isEqualToString:@"2"]) {
            goodStatus.text = @"退款拒绝";
        }else if ([model.afterStatus isEqualToString:@"4"]) {
            goodStatus.text = @"退款退货";
        }else{
            goodStatus.text = @"已支付";
        }
        if ([model.afterStatus isEqualToString:@"0"] || [model.afterStatus isEqualToString:@"6"]) {
            UIButton *paymentBtn = [[UIButton alloc] init];
            paymentBtn.tag = section;
            paymentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            paymentBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [paymentBtn setTitle:@"退款" forState:UIControlStateNormal];
            [paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [paymentBtn addTarget:self action:@selector(paymentBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:paymentBtn];
            paymentBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(view, 15)
            .widthIs(70)
            .heightIs(30);
            paymentBtn.layer.cornerRadius = 3;
            paymentBtn.layer.masksToBounds = YES;
        }
        if ([model.afterStatus isEqualToString:@"8"]) {
            UIButton *returningBtn = [[UIButton alloc] init];
            returningBtn.tag = section;
            returningBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            returningBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [returningBtn setTitle:@"退款中" forState:UIControlStateNormal];
            [returningBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [returningBtn addTarget:self action:@selector(returningAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:returningBtn];
            returningBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(view, 15)
            .widthIs(70)
            .heightIs(30);
            returningBtn.layer.cornerRadius = 3;
            returningBtn.layer.masksToBounds = YES;
        }
    }else if ([model.status isEqualToString:@"3"]){
        if ([model.afterStatus isEqualToString:@"2"]) {
            goodStatus.text = @"退款拒绝";
        }else if ([model.afterStatus isEqualToString:@"4"]) {
            goodStatus.text = @"退款退货";
        }else{
            goodStatus.text = @"已支付";
        }
        if ([model.afterStatus isEqualToString:@"0"]) {
            UIButton *paymentBtn = [[UIButton alloc] init];
            paymentBtn.tag = section;
            paymentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            paymentBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [paymentBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            [paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [paymentBtn addTarget:self action:@selector(comfirmReceiveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:paymentBtn];
            paymentBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(view, 15)
            .widthIs(70)
            .heightIs(30);
            paymentBtn.layer.cornerRadius = 3;
            paymentBtn.layer.masksToBounds = YES;
            
            UIButton*cancelGoodsBtn = [[UIButton alloc] init];
            cancelGoodsBtn.tag = section;
            cancelGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            cancelGoodsBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [cancelGoodsBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [cancelGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cancelGoodsBtn addTarget:self action:@selector(lookGoodsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:cancelGoodsBtn];
            cancelGoodsBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(paymentBtn, 10)
            .widthIs(70)
            .heightIs(30);
            cancelGoodsBtn.layer.cornerRadius = 3;
            cancelGoodsBtn.layer.masksToBounds = YES;
        }
    }else if ([model.status isEqualToString:@"4"]){
        UIButton *paymentBtn = [[UIButton alloc] init];
        paymentBtn.tag = section;
        paymentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        paymentBtn.backgroundColor =colorWithRGB(0xFF6B24);
        [paymentBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        [paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [paymentBtn addTarget:self action:@selector(lookGoodsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:paymentBtn];
        paymentBtn.sd_layout
        .topSpaceToView(view, 10)
        .rightSpaceToView(view, 15)
        .widthIs(70)
        .heightIs(30);
        paymentBtn.layer.cornerRadius = 3;
        paymentBtn.layer.masksToBounds = YES;
        if ([model.afterStatus isEqualToString:@"3"]) {
            goodStatus.text = @"申请退款";
        }else if ([model.afterStatus isEqualToString:@"4"]) {
            goodStatus.text = @"拒绝退货";
        }else if ([model.afterStatus isEqualToString:@"5"]) {
            goodStatus.text = @"退货中";
        }else if ([model.afterStatus isEqualToString:@"7"]) {
            goodStatus.text = @"退款完成";
        }else{
            goodStatus.text = @"已支付";
            UIButton*cancelGoodsBtn = [[UIButton alloc] init];
            cancelGoodsBtn.tag = section;
            cancelGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            cancelGoodsBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [cancelGoodsBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            [cancelGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cancelGoodsBtn addTarget:self action:@selector(applyGoodsAfterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:cancelGoodsBtn];
            cancelGoodsBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(paymentBtn, 10)
            .widthIs(70)
            .heightIs(30);
            cancelGoodsBtn.layer.cornerRadius = 3;
            cancelGoodsBtn.layer.masksToBounds = YES;
        }
        
        
    }else if ([model.status isEqualToString:@"5"]){
        goodStatus.text = @"已取消";
    }else{
        if ([model.afterStatus isEqualToString:@"1"]) {
            goodStatus.text = @"申请退款";
            UIButton *paymentBtn = [[UIButton alloc] init];
            paymentBtn.tag = section;
            paymentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            paymentBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [paymentBtn setTitle:@"取消售后" forState:UIControlStateNormal];
            [paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [paymentBtn addTarget:self action:@selector(applyBtn1Action:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:paymentBtn];
            paymentBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(view, 15)
            .widthIs(70)
            .heightIs(30);
            paymentBtn.layer.cornerRadius = 3;
            paymentBtn.layer.masksToBounds = YES;
            
        }else if ([model.afterStatus isEqualToString:@"2"]){
            goodStatus.text = @"拒绝退款";
            
        }else if ([model.afterStatus isEqualToString:@"3"]){
            goodStatus.text = @"申请退货退款";
            UIButton *paymentBtn = [[UIButton alloc] init];
            paymentBtn.tag = section;
            paymentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            paymentBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [paymentBtn setTitle:@"取消售后" forState:UIControlStateNormal];
            [paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [paymentBtn addTarget:self action:@selector(applyBtn1Action:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:paymentBtn];
            paymentBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(view, 15)
            .widthIs(70)
            .heightIs(30);
            paymentBtn.layer.cornerRadius = 3;
            paymentBtn.layer.masksToBounds = YES;
            
            UIButton *seeDetailBtn = [[UIButton alloc] init];
            seeDetailBtn.tag = section;
            seeDetailBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            seeDetailBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [seeDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            [seeDetailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [seeDetailBtn addTarget:self action:@selector(seeDetailBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:seeDetailBtn];
            seeDetailBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(paymentBtn, 10)
            .widthIs(70)
            .heightIs(30);
            seeDetailBtn.layer.cornerRadius = 3;
            seeDetailBtn.layer.masksToBounds = YES;
        }else if ([model.afterStatus isEqualToString:@"4"]){
            goodStatus.text = @"拒绝退货";
            UIButton *seeDetailBtn = [[UIButton alloc] init];
            seeDetailBtn.tag = section;
            seeDetailBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            seeDetailBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [seeDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            [seeDetailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [seeDetailBtn addTarget:self action:@selector(seeDetailBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:seeDetailBtn];
            seeDetailBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(view, 15)
            .widthIs(70)
            .heightIs(30);
            seeDetailBtn.layer.cornerRadius = 3;
            seeDetailBtn.layer.masksToBounds = YES;
        }else if ([model.afterStatus isEqualToString:@"5"]){
            goodStatus.text = @"退货中";
            UIButton *paymentBtn = [[UIButton alloc] init];
            paymentBtn.tag = section;
            paymentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            paymentBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [paymentBtn setTitle:@"取消售后" forState:UIControlStateNormal];
            [paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [paymentBtn addTarget:self action:@selector(applyBtn1Action:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:paymentBtn];
            paymentBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(view, 15)
            .widthIs(70)
            .heightIs(30);
            paymentBtn.layer.cornerRadius = 3;
            paymentBtn.layer.masksToBounds = YES;
            UIButton *returnOrderBtn = [[UIButton alloc] init];
            returnOrderBtn.tag = section;
            returnOrderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            returnOrderBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [returnOrderBtn setTitle:@"退货物流" forState:UIControlStateNormal];
            [returnOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [returnOrderBtn addTarget:self action:@selector(returnOrderBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:returnOrderBtn];
            returnOrderBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(paymentBtn, 10)
            .widthIs(70)
            .heightIs(30);
            returnOrderBtn.layer.cornerRadius = 3;
            returnOrderBtn.layer.masksToBounds = YES;
            
            UIButton *seeDetailBtn = [[UIButton alloc] init];
            seeDetailBtn.tag = section;
            seeDetailBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            seeDetailBtn.backgroundColor =colorWithRGB(0xFF6B24);
            [seeDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            [seeDetailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [seeDetailBtn addTarget:self action:@selector(seeDetailBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:seeDetailBtn];
            seeDetailBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(returnOrderBtn, 10)
            .widthIs(70)
            .heightIs(30);
            seeDetailBtn.layer.cornerRadius = 3;
            seeDetailBtn.layer.masksToBounds = YES;
        }else if ([model.afterStatus isEqualToString:@"6"]){
            goodStatus.text = @"取消售后";
        }else if ([model.afterStatus isEqualToString:@"7"]){
            goodStatus.text = @"售后已完成";
            
        }else if ([model.afterStatus isEqualToString:@"8"]){
            goodStatus.text = @"退款中";
            
        }else{
            goodStatus.text = @"售后";
        }
    }
    
    return bgView;
}
- (void)returnOrderBtnAction:(UIButton *)btn
{
    MineIndentModel *minModel = self.listDataArr[btn.tag];
    TransMessViewController*vc = [[TransMessViewController alloc]init];
    vc.model = minModel;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)seeDetailBtnAction:(UIButton *)btn
{
    MineIndentModel *minModel = self.listDataArr[btn.tag];
    ApplyDeatailController *applyCtrl = [[ApplyDeatailController alloc] init];
    applyCtrl.minModel = minModel;
    [self.navigationController pushViewController:applyCtrl animated:YES];
    //    MineIndentModel *minModel = self.listDataArr[btn.tag];
    //    OrderDetailViewController *minePerCtrl = [[OrderDetailViewController alloc] init];
    //    minePerCtrl.model = minModel;
    //    [self.navigationController pushViewController:minePerCtrl animated:YES];
}

- (void)applyBtn1Action:(UIButton *)btn
{
    MineIndentModel *minModel = self.listDataArr[btn.tag];
    DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:@"确定取消售后吗?" selectType:@"取消售后" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:minModel];
    [alertView show];
    
}
- (void)applyGoodsAfterBtnAction:(UIButton *)btn
{
    MineIndentModel *minModel = self.listDataArr[btn.tag];
    ApplyDeatailController *applyCtrl = [[ApplyDeatailController alloc] init];
    applyCtrl.minModel = minModel;
    [self.navigationController pushViewController:applyCtrl animated:YES];
}

- (void)lookGoodsBtnAction:(UIButton *)btn
{
    MineIndentModel *minModel = self.listDataArr[btn.tag];
    TransMessViewController*vc = [[TransMessViewController alloc]init];
    vc.model = minModel;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)comfirmReceiveBtnAction:(UIButton *)btn
{
    MineIndentModel *minModel = self.listDataArr[btn.tag];
    LYAccount *account = [LYAccount shareAccount];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:account.id forKey:@"userId"];
    [dic setValue:minModel.id forKey:@"id"];
    [LYTools postBossDemoWithUrl:confirmReceipt param:dic success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            [self loadNewTopic];
        }else if([dict[@"code"]longValue] == 500){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                [self.listTableView reloadData];
                if (self.listDataArr.count != 0) {
                    [self.listTableView xy_havingData:YES];
                }else{
                    [self.listTableView xy_havingData:NO];
                }
            });
        }
    } fail:^(NSError *error) {
        
    }];
}
- (void)paymentBtnAction:(UIButton *)btn
{
    MineIndentModel *minModel = self.listDataArr[btn.tag];
    //    DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"确认退款" message:[NSString stringWithFormat:@"您的退款金额为%.2lf,运费:%.2lf，共:%.2lf确认退款?",minModel.orderAmountTotal,minModel.logisticsFee,minModel.orderAmountTotal+minModel.logisticsFee] selectType:@"退款" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:minModel];
    DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"确认退款" message:[NSString stringWithFormat:@"您的退款金额为%.2lf,确认退款?",minModel.orderAmountTotal] selectType:@"退款" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:minModel];
    [alertView show];
    
    
}
- (void)returningAction:(UIButton *)btn
{
    
}
- (void)lookLogisticsBtnAction:(UIButton *)btn
{
    MineIndentModel *minModel = self.listDataArr[btn.tag];
    DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"确认退款" message:[NSString stringWithFormat:@"您的退款金额为%.2lf,确认退款?",minModel.orderAmountTotal] selectType:@"退款" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:minModel];
    [alertView show];
    
}
- (void)confirmBtnAction:(UIButton *)btn
{
    MineIndentModel *minModel = self.listDataArr[btn.tag];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%@",minModel.id] forKey:@"orderIds"];
    [[NetworkManager sharedManager] postWithUrl:confirmDelivery param:dic success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"respCode"] isEqualToString:@"00000"]) {
            
            self->_selectDict = [[NSMutableDictionary alloc] initWithDictionary:json[@"data"]];
            if (self->_selectDict[@"amount"] != 0) {
                DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"您选择的订单中有%d个收货地址且不满三件,您需额外支付%.2lf元运费,确认支付运费?",[self->_selectDict[@"addressNum"] intValue],[self->_selectDict[@"amount"] doubleValue]] selectType:@"确认支付运费" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:nil];
                [alertView show];
            }else{
                DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"确认批量发货吗"] selectType:@"确认批量发货" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:nil];
                [alertView show];
            }
        }else{
            [SVProgressHUD doAnyRemindWithHUDMessage:json[@"respMessage"] withDuration:1.0];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)cancelGoodsBtnAction:(UIButton *)btn
{
    MineIndentModel *minModel = self.listDataArr[btn.tag];
    DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:@"您确定要取消订单吗" selectType:@"取消交易" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:minModel];
    [alertView show];
}

- (void)applyBtnAction:(UIButton *)btn
{
    MineIndentModel *minModel = self.listDataArr[btn.tag];
    BuyGoodsListController *buyCtrl = [[BuyGoodsListController alloc] init];
    buyCtrl.orderListArray = [NSMutableArray arrayWithObject:minModel];
    buyCtrl.minModel = minModel;
    buyCtrl.pushCtrl = 2;
    [self.navigationController pushViewController:buyCtrl animated:YES];
    
}

-(void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex selectType:(NSString *)type comGoodList:(MineIndentModel *)minModel
{
    if (buttonIndex == AlertButtonLeft) {
        if ([type isEqualToString:@"退款中"]){
            [self loadNewTopic];
        }else if ([type isEqualToString:@"退款审核中"]){
            [self loadNewTopic];
        }else if ([type isEqualToString:@"取消售后"]){
            [self loadNewTopic];
        }
    }else{
        if ([type isEqualToString:@"取消交易"]) {
            LYAccount *account = [LYAccount shareAccount];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:account.id forKey:@"userId"];
            [dic setValue:minModel.id forKey:@"id"];
            [LYTools postBossDemoWithUrl:cancelOrderInfo param:dic success:^(NSDictionary *dict) {
                NSLog(@"%@",dict);
                
                NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
                if ([respCode isEqualToString:@"00000"]) {
                    [self loadNewTopic];
                }else if([dict[@"code"]longValue] == 500){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                        [self.listTableView reloadData];
                        if (self.listDataArr.count != 0) {
                            [self.listTableView xy_havingData:YES];
                        }else{
                            [self.listTableView xy_havingData:NO];
                        }
                    });
                }
            } fail:^(NSError *error) {
                
            }];
        }else if ([type isEqualToString:@"退款"]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:minModel.id forKey:@"orderNo"];
            [dic setValue:@"1" forKey:@"state"];
            [dic setValue:@"无" forKey:@"why"];
            [dic setValue:@"无" forKey:@"remark"];
            [dic setValue:@(minModel.orderAmountTotal) forKey:@"applyAmount"];
            NSString *urlStr = orderReturnsApply;
            [[NetworkManager sharedManager]postWithUrl:urlStr param:dic success:^(id json) {
                NSLog(@"%@",json);
                NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
                if ([respCode isEqualToString:@"00000"]) {
                    DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"审核成功，待审核之后将原路退回到微信、支付宝或者银行卡"] selectType:@"退款中" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:minModel];
                    [alertView show];
                    
                }else{
                    [SVProgressHUD doAnyRemindWithHUDMessage:json[@"respMessage"] withDuration:1.5];
                }
            } failure:^(NSError *error) {
                
            }];
        }else if ([type isEqualToString:@"退款中"]){
            [self loadNewTopic];
        }else if ([type isEqualToString:@"确认发货"]){
            
        }else if ([type isEqualToString:@"确认支付运费"]){
            typeof(self) weakSelf = self;
            _payTypeView = [[FXPayTypeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [KeyWindow addSubview:_payTypeView];
            [_payTypeView show];
            
            [_payTypeView setSelectTypeBlock:^(NSInteger selectType) {
                if (selectType == 2) {
                    
                    [weakSelf->_selectDict setValue:@"IOS" forKey:@"tradeType"];
                    [LYTools postBossDemoWithUrl:confirmDeliverySubmitPay param:weakSelf->_selectDict success:^(NSDictionary *dict) {
                        NSLog(@"%@",dict);
                        NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
                        if ([respCode isEqualToString:@"00000"]) {
                            NSDictionary *body = dict[@"data"];
                            NSMutableString *stamp  = [body objectForKey:@"timestamp"];
                            PayReq* req             = [[PayReq alloc] init];
                            req.partnerId           = [body objectForKey:@"partnerid"];
                            req.prepayId            = [body objectForKey:@"prepayid"];
                            req.nonceStr            = [body objectForKey:@"noncestr"];
                            req.timeStamp           = stamp.intValue;
                            req.package             = [body objectForKey:@"package"];
                            req.sign                = [body objectForKey:@"sign"];
                            [WXApi sendReq:req];
                        }else{
                            [SVProgressHUD doAnyRemindWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                        }
                    } fail:^(NSError *error) {
                        
                    }];
                    
                }else{
                    [weakSelf->_selectDict setValue:@"IOS" forKey:@"tradeType"];
                    [LYTools postBossDemoWithUrl:confirmDeliverySubmitPayAli param:weakSelf->_selectDict success:^(NSDictionary *dict) {
                        NSLog(@"%@",dict);
                        NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
                        if ([respCode isEqualToString:@"00000"]) {
                            NSLog(@"%@",dict);
                            // NOTE: 调用支付结果开始支付
                            [[AlipaySDK defaultService] payOrder:dict[@"data"] fromScheme:AliSchemeKey callback:^(NSDictionary *resultDic) {
                                int statusCode = [resultDic[@"resultStatus"]  intValue];
                                
                                if (statusCode == 9000)
                                {
                                    
                                }
                                else
                                {
                                    
                                }
                                
                                
                            }];
                        }else{
                            [SVProgressHUD doAnyRemindWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                        }
                    } fail:^(NSError *error) {
                        
                    }];
                }
            }];
        }else if ([type isEqualToString:@"确认批量发货"]){
            [[NetworkManager sharedManager]postWithUrl:confirmDeliverySubmit param:_selectDict success:^(id json) {
                NSLog(@"%@",json);
                NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
                if ([respCode isEqualToString:@"00000"]) {
                    [self loadNewTopic];
                }else{
                    [SVProgressHUD doAnyRemindWithHUDMessage:json[@"respMessage"] withDuration:1.5];
                }
            } failure:^(NSError *error) {
                
            }];
        }else if ([type isEqualToString:@"退款审核中"]){
            [self loadNewTopic];
        }else if ([type isEqualToString:@"取消售后"]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:minModel.id forKey:@"orderId"];
            [[NetworkManager sharedManager]postWithUrl:cancelOrderReturnsApply param:dic success:^(id json) {
                NSLog(@"%@",json);
                NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
                if ([respCode isEqualToString:@"00000"]) {
                    [self loadNewTopic];
                }else{
                    [self.listTableView reloadData];
                    if (self.listDataArr.count != 0) {
                        [self.listTableView xy_havingData:YES];
                    }else{
                        [self.listTableView xy_havingData:NO];
                    }
                    [SVProgressHUD doAnyRemindWithHUDMessage:json[@"respMessage"] withDuration:1.5];
                }
            } failure:^(NSError *error) {
                
            }];
            
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    
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
    minePerCtrl.pushCtrl = self.pushCtrl;
    [self.navigationController pushViewController:minePerCtrl animated:YES];
}
#pragma mark --------------- LeftBodyCellDelegate
- (void)allOrderList:(NSInteger)index
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.selectCtrl = index;
        //进入刷新状态
        if (self.listTableView == nil) {
            [self setUpUI];
            self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
            //    [self.listTableView.mj_header beginRefreshing];
            self.listTableView.mj_header.automaticallyChangeAlpha = YES;
            // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
            self.listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
//            self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        }else{
        }
        [SVProgressHUD doAnythingWithHUDMessage:nil];
        [self headerRereshing];
    });
}

#pragma mark - TableView 占位图
- (UIImage *)xy_noDataViewImage {
    return [UIImage imageNamed:@"缺省-暂无"];
}

- (NSString *)xy_noDataViewMessage {
    return @"暂无相关订单";
}
- (UIColor *)xy_noDataViewMessageColor {
    return [UIColor blackColor];
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
