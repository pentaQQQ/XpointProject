//
//  HavePayViewController.m
//  TPAPP
//
//  Created by Frank on 2018/12/5.
//  Copyright © 2018 cbl－　点硕. All rights reserved.
//
//keyWindow
#define KeyWindow [UIApplication sharedApplication].keyWindow
#import "HavePayViewController.h"
#import "OrderDetailViewController.h"
#import "GoodsListCell.h"
#import "MineIndentListCell.h"
#import "LKBubble.h"
#import "SVProgressHUD+DoAnythingAfter.h"
#import "MBProgressHUD+NJ.h"
#import "MineIndentModel.h"
#import "FXPayTypeView.h"
#import "WXApiRequestHandler.h"
#import "UITableView+XY.h"
#import "XYNoDataView.h"
#import "WXApiManager.h"
#import "WXApi.h"
@interface HavePayViewController ()<UITableViewDelegate, UITableViewDataSource,WXApiManagerPayDelegate,WXApiDelegate,DeclareAbnormalAlertViewOrderListRemindDelegate>
@property (nonatomic, strong) FXPayTypeView *payTypeView;
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)NSMutableArray *urlArr;
@property (nonatomic, strong)NSString *urlString;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)NSMutableArray *selectDataArr;
@end

@implementation HavePayViewController
{
    NSMutableDictionary *_selectDict;
}
#pragma mark - 懒加载
-(NSMutableArray *)listDataArr
{
    if (_listDataArr == nil) {
        _listDataArr = [NSMutableArray array];
    }
    return _listDataArr;
}
-(NSMutableArray *)selectDataArr
{
    if (_selectDataArr == nil) {
        _selectDataArr = [NSMutableArray array];
    }
    return _selectDataArr;
}
- (void)setUpUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-SafeAreaTopHeight-44-50-SafeAreaBottomHeight) style:UITableViewStyleGrouped];
    
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

#pragma mark -批量发货的事件
- (void)rightBtnAction
{
    NSMutableArray *selectArr = [NSMutableArray array];
    NSMutableArray *arr = [NSMutableArray array];
    for (MineIndentModel *model in self.listDataArr) {
        if (model.selectStatus) {
            [selectArr addObject:model];
            [arr addObject:model.id];
        }
    }
    if (selectArr.count==0) {
        DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:@"请选择订单" selectType:@"请选择批量发货订单" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:nil];
        [alertView show];
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[NSString stringWithFormat:@"%@",[arr componentsJoinedByString:@","]] forKey:@"orderIds"];
        [[NetworkManager sharedManager] postWithUrl:confirmDelivery param:dic success:^(id json) {
            NSLog(@"%@",json);
            if ([json[@"respCode"] isEqualToString:@"00000"]) {
                self->_selectDict = [[NSMutableDictionary alloc] initWithDictionary:json[@"data"]];
                if (self->_selectDict[@"amount"] != 0) {
                    DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"确认支付运费%.2lf吗?",[self->_selectDict[@"amount"] doubleValue]] selectType:@"确认支付运费" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:nil];
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
    self.urlString = getOrderListInfo;
    [self setUpUI];
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.listTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    self.bottomView.sd_layout
    .topSpaceToView(self.listTableView, 0)
    .leftEqualToView(self.view)
    .widthIs(kScreenWidth)
    .heightIs(50+SafeAreaBottomHeight);
    
    self.rightBtn = [[UIButton alloc] init];
    self.rightBtn.backgroundColor = colorWithRGB(0xFF6B24);
    [self.rightBtn setTitle:@"批量发货" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:colorWithRGB(0xFFFFFF) forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.rightBtn];
    self.rightBtn.sd_layout
    .topSpaceToView(self.bottomView, 0)
    .rightEqualToView(self.bottomView)
    .widthIs(120)
    .heightIs(50+SafeAreaBottomHeight);
    
}
//接收通知并相应的方法
- (void) aliPaytype:(NSNotification *)notification{
    NSDictionary *dic = notification.object;
    //    NSLog(@"通知过来的 - dic = %@",notification.object);
    int statusCode = [dic[@"resultStatus"]  intValue];
    if (statusCode == 9000)
    {
        [self loadNewTopic];
//        MineIndentViewController *minePerCtrl = [[MineIndentViewController alloc] init];
//        minePerCtrl.title = @"我的订单";
//        minePerCtrl.selectIndex = 1;
//        [self.navigationController pushViewController:minePerCtrl animated:YES];
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
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
                
                [self.listTableView reloadData];
                if (self.listDataArr.count != 0) {
                    [self.listTableView xy_havingData:YES];
                }else{
                    [self.listTableView xy_havingData:NO];
                }
            });
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
    
    if (self.listDataArr.count != 0) {
        MineIndentModel *model = self.listDataArr[indexPath.section];
        OrderDetailModel *detailModel = model.orderDetailList[indexPath.row];
        [headerCell configWithModel:detailModel andMineIndentModel:model];
    }
    
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
   if ([model.status isEqualToString:@"1"]){
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
            [deliverGoodsBtn addTarget:self action:@selector(applyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
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
            [deliverGoodsBtn addTarget:self action:@selector(applyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:deliverGoodsBtn];
            deliverGoodsBtn.sd_layout
            .topSpaceToView(view, 10)
            .rightSpaceToView(view, 15)
            .widthIs(70)
            .heightIs(30);
            deliverGoodsBtn.layer.cornerRadius = 3;
            deliverGoodsBtn.layer.masksToBounds = YES;
        }
        
    }
    
    return bgView;
}

- (void)lookLogisticsBtnAction:(UIButton *)btn
{
    MineIndentModel *minModel = self.listDataArr[btn.tag];
    DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"确认退款" message:[NSString stringWithFormat:@"您的退款金额为%.2lf,确认退款?",minModel.orderAmountTotal] selectType:@"退款" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:minModel];
    [alertView show];

}
- (void)applyBtnAction:(UIButton *)btn
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
-(void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex selectType:(NSString *)type comGoodList:(MineIndentModel *)minModel
{
    if (buttonIndex == AlertButtonLeft) {
        if ([type isEqualToString:@"退款中"]){
            [self loadNewTopic];
        }
    }else{
        if ([type isEqualToString:@"退款"]) {
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
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    [view addGestureRecognizer:tapGes];
    view.tag = section;
    
    
    UIImageView *lineImgeView = [[UIImageView alloc] init];
    [view addSubview:lineImgeView];
    lineImgeView.tag = section;
    lineImgeView.image = [UIImage imageNamed:@"icon_未选择"];
    lineImgeView.sd_layout
    .topSpaceToView(view, 12.5)
    .leftSpaceToView(view, 15)
    .heightIs(15)
    .widthIs(15);
    
    UILabel *listLabel = [[UILabel alloc] init];
    [view addSubview:listLabel];
    listLabel.sd_layout
    .topSpaceToView(view, 10)
    .leftSpaceToView(lineImgeView, 10)
    .widthIs(150)
    .heightIs(20);
    listLabel.font = [UIFont systemFontOfSize:15];
    MineIndentModel *model = self.listDataArr[section];
    listLabel.text = model.merchantName;
    listLabel.textColor = [UIColor colorWithRed:103.0/255.0 green:5.0/255.0 blue:67.0/255.0 alpha:1.0];
    return view;
}
- (void)tapGes:(UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    NSArray *arr = [view subviews];
    MineIndentModel *model = self.listDataArr[view.tag];
    if (model.selectStatus) {
        model.selectStatus = NO;
        [self.listDataArr replaceObjectAtIndex:view.tag withObject:model];
        for (id imaView in arr) {
            if ([imaView isKindOfClass:[UIImageView class]]) {
                UIImageView *lineImageView = (UIImageView *)imaView;
                lineImageView.image = [UIImage imageNamed:@"icon_未选择"];
            }
        }
    }else{
        NSMutableArray *selectArr = [NSMutableArray array];
        for (MineIndentModel *model in self.listDataArr) {
            if (model.selectStatus) {
                [selectArr addObject:model];
            }
        }
        BOOL isEqualModel = YES;
        for (MineIndentModel *selctModel in selectArr) {
            if (![selctModel.merchantId isEqualToString:model.merchantId]) {
                isEqualModel = NO;
            }
        }
        if (isEqualModel) {
            model.selectStatus = YES;
            [self.listDataArr replaceObjectAtIndex:view.tag withObject:model];
            for (id imaView in arr) {
                if ([imaView isKindOfClass:[UIImageView class]]) {
                    UIImageView *lineImageView = (UIImageView *)imaView;
                    lineImageView.image = [UIImage imageNamed:@"icon_已选择"];
                }
            }
        }else{
            DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:@"批量发货只能选同一商户商品" selectType:@"批量发货提示" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:model];
            [alertView show];
        }
        
    }
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
- (void)selecteHavePay:(NSInteger)index
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
