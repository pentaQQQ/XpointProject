//
//  BuyGoodsListController.m
//  TPAPP
//
//  Created by frank on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "BuyGoodsListController.h"
#import "PayIndentCell.h"
@interface BuyGoodsListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;

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
    self.title = @"支付订单";
//    self.listDataArr = [NSMutableArray arrayWithObjects:@[@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"], nil];
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    [self setUpUI];
}

- (void)setUpUI
{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-SafeAreaTopHeight) style:UITableViewStylePlain];
    self.listTableView = tableview;
    [self.view addSubview:tableview];
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
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellId = @"PayIndentDefaultCellID";
        PayIndentDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[PayIndentDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@[@"商品金额 (1件)",@"¥1000"],@[@"优惠金额",@"¥50"],@[@"运费",@"¥50"],@[@"应付金额",@"¥1000"], nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell configWithModel:arr[indexPath.row]];
        return cell;
    }else{
        static NSString *cellId = @"PayIndentButtonCellID";
        PayIndentButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[PayIndentButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
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
        return 140;
    }else{
        return 50;
    }
    
    
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
