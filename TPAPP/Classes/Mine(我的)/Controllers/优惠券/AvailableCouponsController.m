//
//  AvailableCouponsController.m
//  TPAPP
//
//  Created by Frank on 2019/1/17.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import "AvailableCouponsController.h"
#import "CouponModel.h"
#import "MyCouponsCell.h"
//#import "CouponsCell.h"
//#import "CouponsPersonModel.h"
static NSString *cellID = @"MyCouponsCellID";
@interface AvailableCouponsController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArray;

@end

@implementation AvailableCouponsController
#pragma mark - 懒加载
- (NSMutableArray *)listDataArray
{
    if (_listDataArray == nil) {
        _listDataArray = [NSMutableArray array];
    }
    return _listDataArray;
}
#pragma mark - 创建tableview
-(UITableView *)listTableView
{
    if (_listTableView == nil) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTableView.backgroundColor = [UIColor clearColor];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.tableFooterView = [UIView new];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.tableHeaderView = [UIView new];
        _listTableView.sectionHeaderHeight = 0;
//        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCouponsCell class]) bundle:nil] forCellReuseIdentifier:cellID];
        [self.view addSubview:_listTableView];
        [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.right.left.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(SafeAreaBottomHeight);
        }];
    }
    return _listTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}
- (void)createUI
{
    //    [self setupTopView];
    //    [self setupCenterView];
    [self listTableView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)loadData
{
    [SVProgressHUD show];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    LYAccount *lyAcc = [LYAccount shareAccount];
    [dict setValue:lyAcc.id forKey:@"userId"];
    [[NetworkManager sharedManager] getWithUrl:getUseCouponListByUserId param:dict success:^(id json) {
        [SVProgressHUD dismiss];
        [self.listDataArray removeAllObjects];
        if ([json[@"respCode"] isEqualToString:@"00000"]) {
                for (NSDictionary *dict in json[@"data"]) {
                    CouponModel *model = [CouponModel mj_objectWithKeyValues:dict];
//                    if (model.type == 1) {
                        [self.listDataArray addObject:model];
//                    }
                }

            [self.listTableView reloadData];

        }else{

        }
    } failure:^(NSError *error) {
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listDataArray.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[MyCouponsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    CouponModel *model = self.listDataArray[indexPath.section];
    cell.bgImageview.image = [UIImage imageNamed:@"优惠券"];
    cell.dateTimeLabel.text = [NSString stringWithFormat:@"%@-%@",[[model.updateTime componentsSeparatedByString:@" "] firstObject],[[model.loseTime componentsSeparatedByString:@" "] firstObject]];
    cell.merchantNameLabel.text = model.couponMerchantName;
    
    NSString *dateStr = [NSString stringWithFormat:@"¥%.0lf",model.discountMoney];
    NSRange range = NSMakeRange(0, 1);
    NSMutableAttributedString *mutAttStr = [[NSMutableAttributedString alloc]initWithString:dateStr];
    [mutAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0] range:range];
    cell.moneyLabel.attributedText = mutAttStr;
    cell.detailLabel.text = [NSString stringWithFormat:@"满%.0lf抵用",model.fullReduction];
//    cell.couponsTypeLabel.text = @"可使用";
    cell.couponsLabel.text = model.couponName;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    if (indexPath.row == 3) {
    //        FZCenterController *fzCtrl = [[FZCenterController alloc] init];
    //        [self.navigationController pushViewController:fzCtrl animated:YES];
    //    }
}
- (UIImage  *)xy_noDataViewImage
{
    return [UIImage imageNamed:@"缺省-暂无"];
}
- (NSString *)xy_noDataViewMessage
{
    return @"暂无数据";
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
