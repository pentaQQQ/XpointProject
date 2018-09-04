//
//  MinePerformanceChildController.m
//  TPAPP
//
//  Created by Frank on 2018/8/23.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "MinePerformanceChildController.h"
#import "BRPickerView.h"
#import "NSDate+BRAdd.h"
#import "PerformaceHeaderCell.h"
#import "MinePerformanceCell.h"
@interface MinePerformanceChildController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)UILabel *dateLabel;
@property (nonatomic, strong)UILabel *fromLabel;
@property (nonatomic, strong)UIButton *startDateBtn;
@property (nonatomic, strong)UIButton *endDateBtn;
@property (nonatomic, strong)UIView *startLineView;
@property (nonatomic, strong)UIView *endLineView;
@end

@implementation MinePerformanceChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.listDataArr = [NSMutableArray arrayWithObjects:@[@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"], nil];
    if (self.firstCtrl == 0 ) {
        [self createTopView];
        [self setUpUI:50];
    }else{
        [self setUpUI:0];
    }
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.listTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.listTableView.mj_header beginRefreshing];
}
- (void)setUpUI:(CGFloat)height_top
{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, height_top, kScreenWidth, kScreenHeight-SafeAreaTopHeight-44-height_top) style:UITableViewStyleGrouped];
    self.listTableView = tableview;
    [self.view addSubview:tableview];
    self.listTableView.backgroundColor = colorWithRGB(0xEEEEEE);
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.showsVerticalScrollIndicator = NO;
    self.listTableView.showsHorizontalScrollIndicator = NO;
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - 懒加载
-(NSMutableArray *)listDataArr
{
    if (_listDataArr == nil) {
        _listDataArr = [NSMutableArray array];
    }
    return _listDataArr;
}
//#pragma mark - 创建tableview
//-(UITableView *)listTableView
//{
//    if (_listTableView == nil) {
//        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height) style:UITableViewStylePlain];
//        _listTableView.backgroundColor = colorWithRGB(0xEEEEEE);
//        _listTableView.delegate = self;
//        _listTableView.showsVerticalScrollIndicator = NO;
//        _listTableView.showsHorizontalScrollIndicator = NO;
//        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _listTableView.dataSource = self;
//        [self.view addSubview:self.listTableView];
//        self.listTableView.sd_layout
//        .topSpaceToView(self.topView, 0)
//        .leftEqualToView(self.view)
//        .rightEqualToView(self.view)
//        .bottomSpaceToView(self.view, 0);
//    }
//    return _listTableView;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listDataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellId = @"MinePerformanceCellID";
        PerformaceHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[PerformaceHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell configWithModel:self.listDataArr[indexPath.section]];
        return cell;
    }else{
        static NSString *cellId = @"MinePerformanceCellID";
        MinePerformanceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[MinePerformanceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell configWithModel:self.listDataArr[indexPath.section]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 85;
    }else{
       return 50;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
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


#pragma mark - 下拉刷新数据
- (void)loadNewTopic
{
    [[NetworkManager sharedManager] getWithUrl:getMainResources param:nil success:^(id json) {
        NSLog(@"%@",json);
        [self.listTableView.mj_header endRefreshing];
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            
              self.listDataArr = [NSMutableArray arrayWithObjects:@[@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"], nil];
            [self.listTableView reloadData];
        }else if([json[@"code"]longValue] == 500){
            
            [self.listTableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark --------------- LeftBodyCellDelegate
- (void)selecteNumber:(NSInteger)index
{
    // 这里是你点击了cell里的某个按钮后要做的操作
    if (index == 0) {
        self.secondCtrl = 0;
    }else{
        self.secondCtrl = 1;
    }
//    if ([self.listTableView.mj_header isRefreshing]) {
//        [self.listTableView.mj_header endRefreshing];
//    }else{
        [self.listTableView.mj_header beginRefreshing];
//    }
    
}
- (void)createTopView
{
    
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.topView];
    self.topView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .widthIs(kScreenWidth)
    .heightIs(50);
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.text = @"日期区间:";
    self.dateLabel.textColor = [UIColor blackColor];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.font = [UIFont systemFontOfSize:15];
    [self.topView addSubview:self.dateLabel];
    self.dateLabel.sd_layout
    .topSpaceToView(self.topView, 15)
    .leftSpaceToView(self.topView, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(20);
    
   
    
    
    self.startDateBtn = [[UIButton alloc] init];
    [self.startDateBtn setTitle:[self getFormerlyDate:-24*60*60*7] forState:UIControlStateNormal];
    [self.startDateBtn setTitleColor:colorWithRGB(0xFF5760) forState:UIControlStateNormal];
    self.startDateBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.startDateBtn addTarget:self action:@selector(startDateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.startDateBtn];
    self.startDateBtn.sd_layout
    .topSpaceToView(self.topView,15)
    .leftSpaceToView(self.dateLabel, 0)
    .widthIs(kScreenWidth/3-10)
    .heightIs(20);
    
    self.startLineView = [[UIView alloc] init];
    self.startLineView.backgroundColor = colorWithRGB(0xFF5760);
    [self.topView addSubview:self.startLineView];
    self.startLineView.sd_layout
    .topSpaceToView(self.startDateBtn, 5)
    .leftSpaceToView(self.topView, kScreenWidth/3+10)
    .widthIs(kScreenWidth/3-10-20)
    .heightIs(1);
    
    
    self.fromLabel = [[UILabel alloc] init];
    self.fromLabel.text = @"至";
    self.fromLabel.textColor = colorWithRGB(0xFF5760);;
    self.fromLabel.textAlignment = NSTextAlignmentCenter;
    self.fromLabel.font = [UIFont systemFontOfSize:15];
    [self.topView addSubview:self.fromLabel];
    self.fromLabel.sd_layout
    .topSpaceToView(self.topView, 15)
    .leftSpaceToView(self.startDateBtn, 0)
    .widthIs(20)
    .heightIs(20);
    
    
    self.endDateBtn = [[UIButton alloc] init];
    [self.endDateBtn setTitle:[self getFormerlyDate:-24*60*60] forState:UIControlStateNormal];
    [self.endDateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.endDateBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.endDateBtn addTarget:self action:@selector(endDateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.endDateBtn];
    self.endDateBtn.sd_layout
    .topSpaceToView(self.topView,15)
    .rightSpaceToView(self.topView, 0)
    .widthIs(kScreenWidth/3-10)
    .heightIs(20);
    self.endLineView = [[UIView alloc] init];
    self.endLineView.backgroundColor = [UIColor lightGrayColor];
    [self.topView addSubview:self.endLineView];
    self.endLineView.sd_layout
    .topSpaceToView(self.endDateBtn, 5)
    .rightSpaceToView(self.topView, 10)
    .widthIs(kScreenWidth/3-10-20)
    .heightIs(1);
    self.listTableView.frame = CGRectMake(0, 50, kScreenWidth, self.view.bounds.size.height-50);
}
- (NSString *)getFormerlyDate:(NSTimeInterval)timeInter
{
    NSDate * date = [NSDate date];//当前时间
    NSDate *lastDay = [NSDate dateWithTimeInterval:timeInter sinceDate:date];//前1天
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = @"yyyy-MM-dd";
    // 将 NSDate 按 formatter格式 转成 NSString
    return [formatter stringFromDate:lastDay];
}
- (void)startDateBtnAction
{
    [self.startDateBtn setTitleColor:colorWithRGB(0xFF5760) forState:UIControlStateNormal];
    self.startLineView.backgroundColor = colorWithRGB(0xFF5760);
    [self.endDateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.endLineView.backgroundColor = [UIColor lightGrayColor];
 
    [BRDatePickerView showDatePickerWithTitle:@"开始时间" dateType:UIDatePickerModeDate defaultSelValue:self.startDateBtn.titleLabel.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:YES resultBlock:^(NSString *selectValue,NSInteger num) {
        [self.startDateBtn setTitle:selectValue forState:UIControlStateNormal];
        if (num == 1) {
            [self startDateWithStartDate:self.startDateBtn.titleLabel.text andWithEndDate:self.endDateBtn.titleLabel.text];
        }
        
    }];
}
- (void)endDateBtnAction
{
    [self.endDateBtn setTitleColor:colorWithRGB(0xFF5760) forState:UIControlStateNormal];
    self.endLineView.backgroundColor = colorWithRGB(0xFF5760);
    [self.startDateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.startLineView.backgroundColor = [UIColor lightGrayColor];
    [BRDatePickerView showDatePickerWithTitle:@"结束时间" dateType:UIDatePickerModeDate defaultSelValue:self.endDateBtn.titleLabel.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:YES resultBlock:^(NSString *selectValue,NSInteger num) {
        [self.endDateBtn setTitle:selectValue forState:UIControlStateNormal];
        if (num == 1) {
            [self startDateWithStartDate:self.startDateBtn.titleLabel.text andWithEndDate:self.endDateBtn.titleLabel.text];
        }
    }];
}


- (void)startDateWithStartDate:(NSString *)startDateString andWithEndDate:(NSString *)endDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [dateFormatter dateFromString:startDateString];
    NSDate *endDate = [dateFormatter dateFromString:endDateString];
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit1 = NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear;//同时比较天数、月份差异
    //比较的结果是NSDateComponents类对象
    NSDateComponents *delta1 = [calendar components:unit1 fromDate:startDate toDate:endDate options:0];
    if (delta1.year<0 || delta1.month< 0 || delta1.day < 0) {
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"开始时间不能大于结束时间" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:^{
            [self.startDateBtn setTitle:[self getFormerlyDate:-24*60*60*7] forState:UIControlStateNormal];
            [self.endDateBtn setTitle:[self getFormerlyDate:-24*60*60] forState:UIControlStateNormal];
        }];
        
    }else if ((delta1.year == 0 && delta1.month == 1 && delta1.day>0)||(delta1.year == 0 &&  delta1.month > 1)|| delta1.year > 0){
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"只能查询30天数据" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:^{
            [self.startDateBtn setTitle:[self getFormerlyDate:-24*60*60*7] forState:UIControlStateNormal];
            [self.endDateBtn setTitle:[self getFormerlyDate:-24*60*60] forState:UIControlStateNormal];
        }];
    }else{
        
    }
    
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
