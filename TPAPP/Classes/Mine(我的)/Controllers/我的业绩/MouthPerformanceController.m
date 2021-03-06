//
//  MouthPerformanceController.m
//  TPAPP
//
//  Created by Frank on 2018/12/4.
//  Copyright © 2018 cbl－　点硕. All rights reserved.
//

#import "MouthPerformanceController.h"
#import "BRPickerView.h"
#import "NSDate+BRAdd.h"
#import "PerformaceHeaderCell.h"
#import "MinePerformanceCell.h"
#import "PerformanceModel.h"
@interface MouthPerformanceController ()<UITableViewDelegate,UITableViewDataSource>
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

@implementation MouthPerformanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    self.listDataArr = [NSMutableArray arrayWithObjects:@[@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"],@[@"2018-08-22",@"¥0.0",@"¥0.0"], nil];
//    if (self.firstCtrl == 0 ) {
        [self createTopView];
        [self setUpUI:50];
        self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
        //自动更改透明度
        self.listTableView.mj_header.automaticallyChangeAlpha = YES;
        //进入刷新状态
        //    [self.listTableView.mj_header beginRefreshing];
//        [self loadNewTopic];
//    }else{
//        [self setUpUI:0];
//        self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
//        //自动更改透明度
//        self.listTableView.mj_header.automaticallyChangeAlpha = YES;
//
//    }
    
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
    if (self.listDataArr.count != 0) {
        return self.listDataArr.count+1;
    }else{
        return 0;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellId = @"PerformaceHeaderCellID";
        PerformaceHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[PerformaceHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell configWithModel:self.listDataArr];
        return cell;
    }else{
        static NSString *cellId = @"MinePerformanceCellID";
        MinePerformanceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[MinePerformanceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell configWithModel:self.listDataArr[indexPath.row]];
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
    LYAccount *account = [LYAccount shareAccount];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.secondCtrl == 0) {
    }else{
        [dict setValue:[[self.startDateBtn.titleLabel.text componentsSeparatedByString:@"-"] componentsJoinedByString:@""] forKey:@"startDate"];
        [dict setValue:[[self.endDateBtn.titleLabel.text componentsSeparatedByString:@"-"] componentsJoinedByString:@""] forKey:@"endDate"];
        [dict setValue:@"2" forKey:@"type"];
        [dict setValue:account.id forKey:@"userId"];
    }
    
    [[NetworkManager sharedManager] getWithUrl:transSumAmount param:dict success:^(id json) {
        NSLog(@"%@",json);
        [self.listTableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
        [SVProgressHUD dismiss];
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.listDataArr removeAllObjects];
                for (NSDictionary *dic in json[@"data"]) {
                    PerformanceModel *model = [PerformanceModel mj_objectWithKeyValues:dic];
                    [self.listDataArr addObject:model];
                }
                [self.listTableView reloadData];
            });
        }else if([json[@"code"]longValue] == 500){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD doAnythingFailedWithHUDMessage:json[@"respMessage"] withDuration:1.5];
                [self.listTableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark --------------- LeftBodyCellDelegate
- (void)selecteMouthNumber:(NSInteger)index
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // 这里是你点击了cell里的某个按钮后要做的操作
        if (index == 0) {
            self.secondCtrl = 0;
        }else{
            self.secondCtrl = 1;
            //进入刷新状态
            if (self.listTableView == nil) {
//                if (self.secondCtrl == 0 ) {
                    [self createTopView];
                    [self setUpUI:50];
//                }else{
//                    [self setUpUI:0];
//                }
                self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
                self.listTableView.mj_header.automaticallyChangeAlpha = YES;
                //进入刷新状态
                //            [self.listTableView.mj_header beginRefreshing];
            }else{
                //             [self.listTableView.mj_header beginRefreshing];
            }
            [SVProgressHUD doAnythingWithHUDMessage:nil];
            [self loadNewTopic];
            
        }
        
    });
    
    
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
    [self.endDateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.endDateBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.endDateBtn addTarget:self action:@selector(endDateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.endDateBtn];
    self.endDateBtn.sd_layout
    .topSpaceToView(self.topView,15)
    .rightSpaceToView(self.topView, 0)
    .widthIs(kScreenWidth/3-10)
    .heightIs(20);
    
    if (self.secondCtrl == 0) {
        
    }else{
        [self.startDateBtn setTitle:[self getLastFormerlyDate] forState:UIControlStateNormal];
        [self.endDateBtn setTitle:[self getFormerlyDate:0] forState:UIControlStateNormal];
    }
    
    
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
- (NSString *)getLastFormerlyDate
{
    //获取NSCalender单例
    NSCalendar *calender = [NSCalendar currentCalendar];
    // 设置属性，因为我只需要年和月，这个属性还可以支持时，分，秒
    NSDateComponents *cmp = [calender components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[[NSDate alloc] init]];
    //设置上个月，即在现有的基础上减去一个月(2017年1月 减去一个月 会得到2016年12月)
    [cmp setMonth:[cmp month] - 1];
    //拿到上个月的NSDate，再用NSDateFormatter就可以拿到单独的年和月了。
    NSDate *date = [calender dateFromComponents:cmp];

    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = @"yyyy-MM";
    // 将 NSDate 按 formatter格式 转成 NSString
    return [formatter stringFromDate:date];
}
- (NSString *)getFormerlyDate:(NSTimeInterval)timeInter
{
    NSDate * date = [NSDate date];//当前时间
    NSDate *lastDay = [NSDate dateWithTimeInterval:timeInter sinceDate:date];//前1天
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = @"yyyy-MM";
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
        
        [self.startDateBtn setTitle:[selectValue substringWithRange:NSMakeRange(0, 7)] forState:UIControlStateNormal];
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
        [self.endDateBtn setTitle:[selectValue substringWithRange:NSMakeRange(0, 7)] forState:UIControlStateNormal];
        if (num == 1) {
            [self startDateWithStartDate:self.startDateBtn.titleLabel.text andWithEndDate:self.endDateBtn.titleLabel.text];
        }
    }];
}


- (void)startDateWithStartDate:(NSString *)startDateString andWithEndDate:(NSString *)endDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *startDate = [dateFormatter dateFromString:startDateString];
    NSDate *endDate = [dateFormatter dateFromString:endDateString];
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit1 = NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear;//同时比较天数、月份差异
    //比较的结果是NSDateComponents类对象
    NSDateComponents *delta1 = [calendar components:unit1 fromDate:startDate toDate:endDate options:0];
    if (delta1.year<0 || delta1.month< 0) {
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"开始时间不能大于结束时间" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:^{
            [self.startDateBtn setTitle:[self getFormerlyDate:-24*60*60*7] forState:UIControlStateNormal];
            [self.endDateBtn setTitle:[self getFormerlyDate:-24*60*60] forState:UIControlStateNormal];
        }];
        
    }
//    else if ((delta1.year == 0 && delta1.month == 1 && delta1.day>0)||(delta1.year == 0 &&  delta1.month > 1)|| delta1.year > 0){
//        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"只能查询30天数据" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
//        [self presentViewController:alert animated:YES completion:^{
//            [self.startDateBtn setTitle:[self getFormerlyDate:-24*60*60*7] forState:UIControlStateNormal];
//            [self.endDateBtn setTitle:[self getFormerlyDate:-24*60*60] forState:UIControlStateNormal];
//        }];
//    }
    else{
        [SVProgressHUD doAnythingWithHUDMessage:nil];
        [self loadNewTopic];
    }
    
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
