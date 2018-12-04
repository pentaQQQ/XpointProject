//
//  BuyGoodsListController.m
//  TPAPP
//
//  Created by frank on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "BuyGoodsListController.h"
#import "PayIndentCell.h"
#import "AddressManageController.h"
#import "ConsignmentAddressManageController.h"
#import "DeclareAbnormalAlertView.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "WXApi.h"
#define defaultTag 1990

@interface BuyGoodsListController ()<UITableViewDelegate,UITableViewDataSource,WXApiManagerPayDelegate,WXApiDelegate,DeclareAbnormalAlertViewRemindDelegate>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;

@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UILabel *allGoodsPriceLabel;
@property (nonatomic, strong)UILabel *allGoodsNumberLabel;
@property (nonatomic, strong)UIButton *buyButton;
@property (nonatomic, assign)NSInteger btnTag;//默认选中的Tag

@property (nonatomic, assign)BOOL isSender;//判断是否代发货

@end

@implementation BuyGoodsListController
#pragma mark - 懒加载
-(NSMutableArray *)listDataArr
{
    if (_listDataArr == nil) {
        _listDataArr = [NSMutableArray array];
    }
    return _listDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *set = [[UIBarButtonItem alloc] initWithImage:@"back" complete:^{
         DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"订单未支付" message:[NSString stringWithFormat:@"订单未支付，确定离开后可以在我的订单中继续完成支付；"] remind:@"超时未支付系统将取消您的订单!" delegate:self leftButtonTitle:@"继续支付" rightButtonTitle:@"确定离开" comGoodList:nil];
         [alertView show];
        
    }];
    [WXApiManager sharedManager].paydelegate = self;
    self.navigationItem.leftBarButtonItems = @[set];
    DefaultAddressMessage *addressMess = [DefaultAddressMessage shareDefaultAddressMessage];
    if ([addressMess.id length] == 0) {
        self.addressModel = [AddressModel mj_objectWithKeyValues:[LYAccount shareAccount].defaultAddress];
    }else{
        self.addressModel = [AddressModel mj_objectWithKeyValues:[addressMess mj_keyValues]];
    }
    self.listDataArr = [NSMutableArray arrayWithObjects:@[[NSString stringWithFormat:@"商品金额 (%d件)",self.goodsNum],self.goodsPrice],@[@"优惠金额",@"-¥0.00"],@[@"运费",@"+¥50.00"],@[@"应付金额",self.goodsPrice], nil];
    
    self.title = @"支付订单";
    self.btnTag = defaultTag; //self.btnTag = defaultTag+1  表示默认选择第二个，依次类推
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpUI];
    [self createBottomView];
}
#pragma mark 微信回调的代理方法
- (void)WXApiManagerPay:(PayResp *)payResp{
    //支付返回结果，实际支付结果需要去微信服务器端查询
    NSString *strMsg;
    
    if (payResp.errCode == WXSuccess) {
        strMsg = @"支付结果：成功！";
        NSLog(@"支付成功－PaySuccess，retcode = %d", payResp.errCode);
        
    }else{
        
        strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", payResp.errCode,payResp.errStr];
        NSLog(@"错误，retcode = %d, retstr = %@", payResp.errCode,payResp.errStr);
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isSender) {
        self.addressModel = [AddressModel mj_objectWithKeyValues:[[ConsignmentManage shareDefaultAddressMessage] mj_keyValues]];
    }else{
        DefaultAddressMessage *addressMess = [DefaultAddressMessage shareDefaultAddressMessage];
        if ([addressMess.id length] == 0) {
            self.addressModel = [AddressModel mj_objectWithKeyValues:[LYAccount shareAccount].defaultAddress];
        }else{
            self.addressModel = [AddressModel mj_objectWithKeyValues:[addressMess mj_keyValues]];
        }
    }
    
    [self.listTableView reloadData];
}
- (void)createBottomView
{
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    self.bottomView.sd_layout
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.view, 0)
    .widthIs(kScreenWidth)
    .heightIs(50+SafeAreaBottomHeight);
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.text = @"合计:";
    self.priceLabel.textAlignment = NSTextAlignmentLeft;
    self.priceLabel.textColor = colorWithRGB(0xFF6B24);
    self.priceLabel.font = [UIFont systemFontOfSize:15];
    [self.bottomView addSubview:self.priceLabel];
    self.priceLabel.sd_layout
    .topSpaceToView(self.bottomView,15)
    .leftSpaceToView(self.bottomView, 15)
    .widthIs([self widthLabelWithModel:@"合计:" withFont:15])
    .heightIs(20);
    
    self.allGoodsPriceLabel = [[UILabel alloc] init];
    self.allGoodsPriceLabel.text = self.goodsPrice;
    self.allGoodsPriceLabel.textAlignment = NSTextAlignmentLeft;
    self.allGoodsPriceLabel.textColor = colorWithRGB(0xFF6B24);
    self.allGoodsPriceLabel.font = [UIFont systemFontOfSize:19];
    [self.bottomView addSubview:self.allGoodsPriceLabel];
    self.allGoodsPriceLabel.sd_layout
    .topSpaceToView(self.bottomView,10)
    .leftSpaceToView(self.priceLabel, 5)
    .widthIs([self widthLabelWithModel:self.goodsPrice withFont:19])
    .heightIs(30);
    
    self.allGoodsNumberLabel = [[UILabel alloc] init];
    self.allGoodsNumberLabel.text = [NSString stringWithFormat:@"(共%d件)",self.goodsNum];
    self.allGoodsNumberLabel.textAlignment = NSTextAlignmentLeft;
    self.allGoodsNumberLabel.textColor = colorWithRGB(0xFF6B24);
    self.allGoodsNumberLabel.font = [UIFont systemFontOfSize:13];
    [self.bottomView addSubview:self.allGoodsNumberLabel];
    self.allGoodsNumberLabel.sd_layout
    .topSpaceToView(self.bottomView,20)
    .leftSpaceToView(self.allGoodsPriceLabel, 5)
    .widthIs([self widthLabelWithModel:[NSString stringWithFormat:@"(共%d件)",self.goodsNum] withFont:13])
    .heightIs(20);
    
    self.buyButton = [[UIButton alloc] init];
    self.buyButton.backgroundColor = colorWithRGB(0xFF6B24);
    [self.buyButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [self.buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buyButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.buyButton addTarget:self action:@selector(buyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.buyButton];
    self.buyButton.sd_layout
    .topSpaceToView(self.bottomView, 0)
    .rightSpaceToView(self.bottomView, 0)
    .widthIs(80)
    .heightIs(50);
    
}
- (void)buyButtonAction
{
    
}
- (void)setUpUI
{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.listTableView = tableview;
    [self.view addSubview:tableview];
    tableview.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .bottomSpaceToView(self.view, 50)
    .widthIs(kScreenWidth);
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
//    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - UITableview代理方法
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
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 4;
    }else{
        return 2;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellId = @"PayIndentCellID";
        PayIndentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[PayIndentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell withAddressModel:self.addressModel];
        
        [cell setSelectSenderBlock:^(BOOL isSender) {
            self.isSender = isSender;
            if (self.isSender) {
                self.addressModel = [AddressModel mj_objectWithKeyValues:[[ConsignmentManage shareDefaultAddressMessage] mj_keyValues]];
            }else{
                DefaultAddressMessage *addressMess = [DefaultAddressMessage shareDefaultAddressMessage];
                if ([addressMess.id length] == 0) {
                    self.addressModel = [AddressModel mj_objectWithKeyValues:[LYAccount shareAccount].defaultAddress];
                }else{
                    self.addressModel = [AddressModel mj_objectWithKeyValues:[addressMess mj_keyValues]];
                }
            }
            [self.listTableView reloadData];
        }];
        
        [cell setSelectBlock:^(NSInteger num) {
            if (num == 0) {
                AddressManageController *addressMaCtrl = [[AddressManageController alloc] init];
                addressMaCtrl.title = @"选择地址";
                addressMaCtrl.isCartCtrlType = YES;
                [self.navigationController pushViewController:addressMaCtrl animated:YES];
            }else{
                ConsignmentAddressManageController *addressMaCtrl = [[ConsignmentAddressManageController alloc] init];
                addressMaCtrl.title = @"选择地址";
//                addressMaCtrl.isCartCtrlType = YES;
                [self.navigationController pushViewController:addressMaCtrl animated:YES];
            }
        }];
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellId = @"PayIndentDefaultCellID";
        PayIndentDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[PayIndentDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell configWithModel: self.listDataArr[indexPath.row]];
        [cell setYfBlock:^(NSInteger num) {
            DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"运费规则" message:@"同一家店铺且同一收获地址的满三件包邮" remind:@"(否则收6元运费)" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"同意" comGoodList:nil];
            [alertView show];
        }];
        return cell;
    }else{
        static NSString *cellId = @"PayIndentButtonCellID";
        PayIndentButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[PayIndentButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.choosePayTypeButton.tag = defaultTag+indexPath.row;
        if (cell.choosePayTypeButton.tag == self.btnTag) {
            cell.isSelect = YES;
            [cell.choosePayTypeButton setImage:[UIImage imageNamed:@"选中支付"] forState:UIControlStateNormal];
        }else{
            cell.isSelect = NO;
            [cell.choosePayTypeButton setImage:[UIImage imageNamed:@"未选中支付"] forState:UIControlStateNormal];
        }
        __weak PayIndentButtonCell *weakCell = cell;
        [cell setQhxSelectBlock:^(BOOL choice,NSInteger btnTag){
            if (choice) {
                [weakCell.choosePayTypeButton setImage:[UIImage imageNamed:@"选中支付"] forState:UIControlStateNormal];
                self.btnTag = btnTag;
                NSLog(@"$$$$$$%ld",(long)btnTag);
                [self.listTableView reloadData];
            }
            else{
                //选中一个之后，再次点击，是未选中状态，图片仍然设置为选中的图片，记录下tag，刷新tableView，这个else 也可以注释不用，tag只记录选中的就可以
                [weakCell.choosePayTypeButton setImage:[UIImage imageNamed:@"选中支付"] forState:UIControlStateNormal];
                self.btnTag = btnTag;
                [self.listTableView reloadData];
                NSLog(@"#####%ld",(long)btnTag);
            }
        }];
        
        
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@[@"weixn_pay",@"微信支付"],@[@"zhifubao_pay",@"支付宝支付"], nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell configWithModel:arr[indexPath.row]];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.isSender) {
            if ([self.addressModel.isGeneration isEqualToString:@"1"]) {
                return 223;
            }else{
               return 80;
            }
        }else{
          return 130;
        }
        
    }else{
        return 50;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = colorWithRGB(0xEEEEEE);
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        PayIndentButtonCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.isSelect = !cell.isSelect;
        if (cell.isSelect) {
            [cell.choosePayTypeButton setImage:[UIImage imageNamed:@"选中支付"] forState:UIControlStateNormal];
            self.btnTag = cell.choosePayTypeButton.tag;
            NSLog(@"$$$$$$%ld",(long)cell.choosePayTypeButton.tag);
            [self.listTableView reloadData];
        }
        else{
            //选中一个之后，再次点击，是未选中状态，图片仍然设置为选中的图片，记录下tag，刷新tableView，这个else 也可以注释不用，tag只记录选中的就可以
            [cell.choosePayTypeButton setImage:[UIImage imageNamed:@"选中支付"] forState:UIControlStateNormal];
            self.btnTag = cell.choosePayTypeButton.tag;
            [self.listTableView reloadData];
            NSLog(@"#####%ld",(long)cell.choosePayTypeButton.tag);
        }
    }
}
-(void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex comGoodList:(NSMutableArray *)goodListArr
{
    if (buttonIndex == AlertButtonLeft) {
        if ([alertView.leftButtonTitle isEqualToString:@"继续支付"]) {
            
        }else{
            
        }
    }else{
        if ([alertView.rightButtonTitle isEqualToString:@"确定离开"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
//        BuyGoodsListController *buyCtrl = [[BuyGoodsListController alloc] init];
//        buyCtrl.goodsListArray = goodListArr;
//        buyCtrl.goodsNum = _goodsNum;
//        buyCtrl.goodsPrice = _goodsPrice;
//        [self.navigationController pushViewController:buyCtrl animated:YES];
    }
}

#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString withFont:(NSInteger)font
{
    CGSize size = CGSizeMake(self.view.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width+5;
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
