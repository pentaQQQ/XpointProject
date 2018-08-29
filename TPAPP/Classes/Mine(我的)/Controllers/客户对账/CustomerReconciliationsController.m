//
//  CustomerReconciliationsController.m
//  TPAPP
//
//  Created by frank on 2018/8/25.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "CustomerReconciliationsController.h"
#import "CustomerReCell.h"
@interface CustomerReconciliationsController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;

@end

@implementation CustomerReconciliationsController
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
//        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_listTableView];
        _listTableView.sd_layout
        .topSpaceToView(self.view, 0)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomEqualToView(self.view);
        if ([self.listTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.listTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.listTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.listTableView setLayoutMargins:UIEdgeInsetsZero];
        }

    }
    return _listTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"客户对账";
    self.listDataArr = [NSMutableArray arrayWithObjects:@[@"",@"法曼斯FOMOCE",@"2018年08月28日"],@[@"",@"施华洛世奇",@"2018年08月27日"],@[@"",@"法国兰蔻",@"2018年08月26日"],@[@"",@"杰克琼斯",@"2018年08月25日"],@[@"",@"耐克NIKE",@"2018年08月24日"], nil];
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self listTableView];
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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        CustomerReCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"CustomerReCellID"];
        if (!headerCell) {
            headerCell = [[CustomerReCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomerReCellID"];
        }
        
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [headerCell configWithModel:self.listDataArr[indexPath.row]];
        return headerCell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
   return 30;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        view.backgroundColor = [UIColor whiteColor];
    
        
        UILabel *listLabel = [[UILabel alloc] init];
        listLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
        listLabel.textColor = [UIColor redColor];
        [view addSubview:listLabel];
        listLabel.sd_layout
        .topSpaceToView(view, 5)
        .leftSpaceToView(view, 10)
        .widthIs(150)
        .heightIs(20);
        listLabel.text = @"选择活动";
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5,kScreenWidth , 1)];
        lineView.backgroundColor = colorWithRGB(0xEEEEEE);
        [view addSubview:lineView];
        return view;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 50;
    
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
