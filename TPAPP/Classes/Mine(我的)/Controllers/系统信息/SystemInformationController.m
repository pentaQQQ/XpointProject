//
//  SystemInformationController.m
//  TPAPP
//
//  Created by frank on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "SystemInformationController.h"
#import "SystemInformationCell.h"
#import "SVProgressHUD+DoAnythingAfter.h"
@interface SystemInformationController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;

@end

@implementation SystemInformationController

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
        //获取状态栏的rect
        CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
        //获取导航栏的rect
        CGRect navRect = self.navigationController.navigationBar.frame;
        _listTableView.sd_layout
        .topSpaceToView(self.view, statusRect.size.height+navRect.size.height)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomSpaceToView(self.view, SafeAreaBottomHeight);

    }
    return _listTableView;
}
//- (void)setUpUI
//{
//    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight) style:UITableViewStyleGrouped];
//
//    [self.view addSubview:tableView];
//    self.listTableView = tableView;
//    self.listTableView.backgroundColor = colorWithRGB(0xEEEEEE);
//    self.listTableView.delegate = self;
//    self.listTableView.dataSource = self;
//    self.listTableView.showsVerticalScrollIndicator = NO;
//    self.listTableView.showsHorizontalScrollIndicator = NO;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"系统消息";
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.listDataArr = [NSMutableArray arrayWithObjects:@[@"更高效的完成订单",@"安分守己卡多少分肯定撒飞机哦未确认Joe全文IQ威尔金额可领取文件附件文档附件噢请问积分人气王热情而忘记而温热",@"2018-07-23"],@[@"服装行业面临的问题",@"啊速度加快立法上的可乐放哈迪斯发多少钱围殴IE我我佛的出发点是浪费空间啊大神福利和外人去陪我我偶然且危害撒地方就卡掉了首付即可拉伸考虑对方空间撒看到了付款就安静思考的房间啊圣诞节快乐",@"2018-07-20"],@[@"高效的流程，为客户",@"热为其人气问饿哦日的设计开发框架爱多少卡就开始对方加强为轻微积分去我姐发的是解放军爱豆世纪飞机撒地方就困了就快来撒打飞机卡的积分即可拉动世界咖啡圣诞节快乐健康拉多少方法的就是骄傲的双方纠纷的撒娇阿道夫撒打发时间放假爱的开始发的世界发达啊啊打发时间爱上对方发的技术",@"2018-07-20"],@[@"高效的流程，为客户",@"爱的色放哗啦的方式的萨芬辣豆腐砂电风扇辣豆腐乐山大佛后视镜阿道夫撒多舒服哈代发货撒地方哈撒打发时间啊阿打发时间的飞洒地方撒娇拉卡拉东方斯卡拉东方斯卡拉；卡的方式；拉德芳斯困了就爱的方式可立即热为其人气问饿哦日的设计开发框架爱多少卡就开始对方加强为轻微积分去我姐发的是解放军爱豆世纪飞机撒地方就困了就快来撒打飞机卡的积分即可拉动世界咖啡圣诞节快乐健康拉多少方法的就是骄傲的双方纠纷的撒娇阿道夫撒打发时间放假爱的开始发的世界发达啊啊打发时间爱上对方发的技术",@"2018-07-20"],@[@"更高效的完成订单",@"安分守己卡多少分肯定撒飞机哦未确认Joe全文IQ威尔金额可领取文件附件文档附件噢请问积分人气王热情而忘记而温热",@"2018-07-23"],@[@"服装行业面临的问题",@"啊速度加快立法上的可乐放哈迪斯发多少钱围殴IE我我佛的出发点是浪费空间啊大神福利和外人去陪我我偶然且危害撒地方就卡掉了首付即可拉伸考虑对方空间撒看到了付款就安静思考的房间啊圣诞节快乐",@"2018-07-20"],@[@"高效的流程，为客户",@"热为其人气问饿哦日的设计开发框架爱多少卡就开始对方加强为轻微积分去我姐发的是解放军爱豆世纪飞机撒地方就困了就快来撒打飞机卡的积分即可拉动世界咖啡圣诞节快乐健康拉多少方法的就是骄傲的双方纠纷的撒娇阿道夫撒打发时间放假爱的开始发的世界发达啊啊打发时间爱上对方发的技术",@"2018-07-20"],@[@"高效的流程，为客户",@"爱的色放哗啦的方式的萨芬辣豆腐砂电风扇辣豆腐乐山大佛后视镜阿道夫撒多舒服哈代发货撒地方哈撒打发时间啊阿打发时间的飞洒地方撒娇拉卡拉东方斯卡拉东方斯卡拉；卡的方式；拉德芳斯困了就爱的方式可立即热为其人气问饿哦日的设计开发框架爱多少卡就开始对方加强为轻微积分去我姐发的是解放军爱豆世纪飞机撒地方就困了就快来撒打飞机卡的积分即可拉动世界咖啡圣诞节快乐健康拉多少方法的就是骄傲的双方纠纷的撒娇阿道夫撒打发时间放假爱的开始发的世界发达啊啊打发时间爱上对方发的技术",@"2018-07-20"], nil];
    [self listTableView];
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.listTableView.mj_header.automaticallyChangeAlpha = YES;
    
    //进入刷新状态
    [self.listTableView.mj_header beginRefreshing];
    self.listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}
#pragma mark - 上拉加载更多数据
- (void)loadMoreTopic
{
    [[NetworkManager sharedManager] getWithUrl:getMainResources param:nil success:^(id json) {
        NSLog(@"%@",json);
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
             self.listTableView.mj_footer.state = MJRefreshStateNoMoreData;
        }else if ([json[@"code"] longValue] == 500){
            [self.listTableView.mj_footer endRefreshing];
            [SVProgressHUD doAnythingFailedWithHUDMessage:json[@"respMessage"] withDuration:1.5];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 下拉刷新数据
- (void)loadNewTopic
{
    [[NetworkManager sharedManager] getWithUrl:getMainResources param:nil success:^(id json) {
        [self.listTableView.mj_header endRefreshing];
        NSLog(@"%@",json);
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            
//            for (NSDictionary *dic in json[@"data"]) {
//            
//            }
        }else if ([json[@"code"] longValue] == 500){
            [SVProgressHUD showInfoWithStatus:json[@"respMessage"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.listTableView.mj_header endRefreshing];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemInformationCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"SystemInformationCellID"];
    if (!headerCell) {
        headerCell = [[SystemInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SystemInformationCellID"];
    }
    
    headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr = self.listDataArr[indexPath.row];
    [headerCell configWithModel:arr];

    return headerCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
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
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = self.listDataArr[indexPath.row];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:arr[1]];
    
    NSRange allRange = [arr[1] rangeOfString:arr[1]];
    
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:allRange];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor]range:allRange];
    
    CGFloat titleHeight;
    
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    // 获取label的最大宽度
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(kScreenWidth-45-15, CGFLOAT_MAX)options:options context:nil];
    
    titleHeight = ceilf(rect.size.height);
    
    
    return  titleHeight+55;
    
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
