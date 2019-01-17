//
//  ExpiredCouponsController.m
//  TPAPP
//
//  Created by Frank on 2019/1/17.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import "ExpiredCouponsController.h"
//#import "CouponsCell.h"
//#import "CouponsPersonModel.h"
static NSString *cellID = @"UsedCouponsCellID";
@interface ExpiredCouponsController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArray;

@end

@implementation ExpiredCouponsController
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
        //        _listTableView.sectionFooterHeight = 20;
        //        [_listTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CouponsCell class]) bundle:nil] forCellReuseIdentifier:cellID];
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
    [dict setValue:@(1) forKey:@"type"];
    //    [[NetworkManager sharedManager] getWithUrl:selectCoupon param:dict success:^(id json) {
    //        [SVProgressHUD dismiss];
    //        [self.listDataArray removeAllObjects];
    //        if ([json[@"code"] intValue] == 200) {
    //            if (![json[@"body"] isKindOfClass:[NSNull class]]) {
    //                for (NSDictionary *dict in json[@"body"]) {
    //                    CouponsPersonModel *model = [CouponsPersonModel mj_objectWithKeyValues:dict];
    //                    if (model.type == 1) {
    //                        [self.listDataArray addObject:model];
    //                    }
    //                }
    //            }
    //
    //            [self.listTableView reloadData];
    //
    //        }else{
    //
    //        }
    //    } failure:^(NSError *error) {
    //
    //    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listDataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *cellId = @"deviceSceneCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor clearColor];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.bgImageview.image = [UIImage imageNamed:@"卡券BG-已使用已过期"];
    //    cell.jbImageView.alpha = 0;
    //    CouponsPersonModel *model = self.listDataArray[indexPath.row];
    //    cell.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.money];
    //    cell.couponsTypeLabel.textColor = HEXCOLOR(0x333333, 1.0);
    //    cell.couponsTypeLabel.text = model.couponName;
    //    cell.dateTimeLabel.text = [NSString stringWithFormat:@"有效期至:%@",model.endDateStr];
    //    cell.detailLabel.text = model.describe;
    //    if (model.couponType == 1) {
    //        cell.couponsLabel.text = @"限制券";
    //    }else{
    //        cell.couponsLabel.text = @"非限制券";
    //    }
    //    [cell setSelectBlock:^(NSInteger num) {
    //
    //    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 127;
}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
//    return footerView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 15;
//
//}

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
