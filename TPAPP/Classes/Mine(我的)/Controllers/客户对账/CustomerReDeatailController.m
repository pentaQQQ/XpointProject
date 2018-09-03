//
//  CustomerReDeatailController.m
//  TPAPP
//
//  Created by Frank on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "CustomerReDeatailController.h"
#import "CustomerReDeatailCell.h"
@interface CustomerReDeatailController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;

@end

@implementation CustomerReDeatailController

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
        .bottomSpaceToView(self.view, SafeAreaBottomHeight);
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
//    self.listDataArr = [NSMutableArray arrayWithObjects:@[@"",@"法曼斯FOMOCE",@"2018年08月28日"],@[@"",@"施华洛世奇",@"2018年08月27日"],@[@"",@"法国兰蔻",@"2018年08月26日"],@[@"",@"杰克琼斯",@"2018年08月25日"],@[@"",@"耐克NIKE",@"2018年08月24日"], nil];
    self.view.backgroundColor = [UIColor whiteColor];
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
    return [self.listDataArr count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerReDeatailCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"CustomerReDeatailCellID"];
    if (!headerCell) {
        headerCell = [[CustomerReDeatailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomerReDeatailCellID"];
    }
    headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [headerCell configWithModel:self.listDataArr[indexPath.row]];
    return headerCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 91;
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 91)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *upLineView = [[UIView alloc] init];
    [view addSubview:upLineView];
    upLineView.backgroundColor = colorWithRGB(0xbfbfbf);
    upLineView.sd_layout
    .topSpaceToView(view, 50)
    .leftEqualToView(view)
    .rightEqualToView(view)
    .heightIs(.5);
    
    UIView *centerLineView = [[UIView alloc] init];
    [view addSubview:centerLineView];
    centerLineView.backgroundColor = colorWithRGB(0xbfbfbf);
    centerLineView.sd_layout
    .topSpaceToView(view, 50)
    .centerXEqualToView(view)
    .heightIs(40)
    .widthIs(.5);
    
    UIView *downLineView = [[UIView alloc] init];
    [view addSubview:downLineView];
    downLineView.backgroundColor = colorWithRGB(0xbfbfbf);
    downLineView.sd_layout
    .topSpaceToView(view, 90.5)
    .leftEqualToView(view)
    .rightEqualToView(view)
    .heightIs(.5);
    
    UIImageView *lineImgeView = [[UIImageView alloc] init];
    lineImgeView.backgroundColor = [UIColor grayColor];
    [view addSubview:lineImgeView];
//    lineImgeView.image = [UIImage imageNamed:@"icon_mine_line"];
    lineImgeView.sd_layout
    .topSpaceToView(view, 10)
    .leftSpaceToView(view, 10)
    .heightIs(30)
    .widthIs(30);
    
    UILabel *listLabel = [[UILabel alloc] init];
    listLabel.textColor = [UIColor redColor];
    [view addSubview:listLabel];
    listLabel.sd_layout
    .topSpaceToView(view, 15)
    .leftSpaceToView(lineImgeView, 10)
    .rightSpaceToView(view, 10)
    .heightIs(20);
    listLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    listLabel.text = @"法曼斯FOMOCE";
    
    
    
    UIButton *applyReButton = [[UIButton alloc] init];
    applyReButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [applyReButton setTitle:@"申请对账单" forState:UIControlStateNormal];
    [applyReButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [applyReButton addTarget:self action:@selector(applyReButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:applyReButton];
    applyReButton.sd_layout
    .topSpaceToView(view, 50)
    .leftSpaceToView(view, 0)
    .widthIs((kScreenWidth-0.5)/2)
    .heightIs(40);
    
    UIButton *downloadReButton = [[UIButton alloc] init];
    downloadReButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [downloadReButton setTitle:@"下载对账单" forState:UIControlStateNormal];
    [downloadReButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [downloadReButton addTarget:self action:@selector(downloadReButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:downloadReButton];
    downloadReButton.sd_layout
    .topSpaceToView(view, 50)
    .rightSpaceToView(view, 0)
    .widthIs((kScreenWidth-0.5)/2)
    .heightIs(40);
    return view;
}
- (void)applyReButtonAction
{
    
}
- (void)downloadReButtonAction
{
    
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
