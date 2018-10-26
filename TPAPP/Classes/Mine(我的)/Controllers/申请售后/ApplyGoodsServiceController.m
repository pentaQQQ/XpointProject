//
//  ApplyGoodsServiceController.m
//  TPAPP
//
//  Created by Frank on 2018/8/24.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "ApplyGoodsServiceController.h"
#import "ApplyDeatailController.h"
#import "GoodsListCell.h"
@interface ApplyGoodsServiceController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;

@end

@implementation ApplyGoodsServiceController
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
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"申请售后";
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self listTableView];
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.listTableView.mj_header.automaticallyChangeAlpha = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.listTableView.mj_header isRefreshing]) {
        [self.listTableView.mj_header endRefreshing];
        [self.listTableView.mj_header beginRefreshing];
    }else{
        [self.listTableView.mj_header beginRefreshing];
    }
}
#pragma mark - 获取数据列表
- (void)loadNewTopic
{
    LYAccount *lyAccount = [LYAccount shareAccount];
    [[NetworkManager sharedManager] getWithUrl:[NSString stringWithFormat:@"%@/%@",getOrderReturnsList,lyAccount.id] param:nil success:^(id json) {
        NSLog(@"%@",json);
        [self.listTableView.mj_header endRefreshing];
        if ([json[@"respCode"] isEqualToString:@"00000"]) {
            
            
        }else if ([json[@"code"] longValue] == 500){
            [SVProgressHUD doAnythingFailedWithHUDMessage:json[@"respMessage"] withDuration:1.5];
        }
    } failure:^(NSError *error) {
        
    }];
  
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsListCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"GoodsListCellID"];
    if (!headerCell) {
        headerCell = [[GoodsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodsListCellID"];
    }
   
    headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [headerCell setSelectBlock:^(GoodsListCell * cell) {
        ApplyDeatailController *applyCtrl = [[ApplyDeatailController alloc] init];
        [self.navigationController pushViewController:applyCtrl animated:YES];
    }];
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
    
    NSArray *listArr = @[@"2018-07-23",@"2018-07-22",@"2018-07-21",@"2018-07-20",@"2018-07-19",@"2018-07-18"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = colorWithRGB(0xEEEEEE);
    
    UIImageView *lineImgeView = [[UIImageView alloc] init];
    [view addSubview:lineImgeView];
    lineImgeView.image = [UIImage imageNamed:@"icon_mine_line"];
    lineImgeView.sd_layout
    .topSpaceToView(view, 7)
    .leftSpaceToView(view, 15)
    .bottomSpaceToView(view, 7)
    .widthIs(2);
    
    UILabel *listLabel = [[UILabel alloc] init];
    [view addSubview:listLabel];
    listLabel.sd_layout
    .topSpaceToView(view, 5)
    .leftSpaceToView(lineImgeView, 5)
    .widthIs(150)
    .heightIs(20);
    listLabel.font = [UIFont systemFontOfSize:15];
    listLabel.text = listArr[section];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155;
    
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
