//
//  AddressManageController.m
//  TPAPP
//
//  Created by Frank on 2018/8/22.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "AddressManageController.h"
#import "AddAddressController.h"
#import "AddressTableViewCell.h"
#import "EditAddressController.h"
#import "AddressModel.h"
@interface AddressManageController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)NSMutableDictionary *dataDict;
@property (nonatomic, strong)UIButton *addBtn;
@end

@implementation AddressManageController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
//    self.listDataArr = [NSMutableArray arrayWithObjects:@[@"Alan",@"18721488888",@"上海宝山区",@"沪太路3100号A座",@1],@[@"黄石",@"172156348548",@"上海黄浦区",@"四川中路181号234",@0],@[@"张三",@"15612739826",@"上海徐汇区",@"锦绣中路1200号",@0], nil];
    [self listTableView];
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.listTableView.mj_header.automaticallyChangeAlpha = YES;
    
    
    
    self.addBtn = [[UIButton alloc] init];
    self.addBtn.backgroundColor = colorWithRGB(0xFF6B24);
    [self.addBtn setTitle:@"新建地址" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addBtn];
    self.addBtn.sd_layout
    .bottomSpaceToView(self.view,30)
    .rightSpaceToView(self.view, 20)
    .widthIs(kScreenWidth-40)
    .heightIs(50);
    self.addBtn.layer.cornerRadius = 10;
    self.addBtn.layer.masksToBounds = YES;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self.listTableView.mj_header isRefreshing]) {
        //进入刷新状态
        [self.listTableView.mj_header beginRefreshing];
    }
    
}

#pragma mark -自定义导航栏返回按钮
- (void)createItems
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    //    self.leftBtn.backgroundColor = [UIColor whiteColor];
    [leftBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = itemleft;
}

- (void)leftBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBtnAction
{
    AddAddressController *addCtrl = [[AddAddressController alloc] init];
    addCtrl.dataNull = self.listDataArr.count;
    [self.navigationController pushViewController:addCtrl animated:YES];
}

#pragma mark - 下拉刷新数据
- (void)loadNewTopic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    LYAccount *lyAccount = [LYAccount shareAccount];
    [dic setValue:lyAccount.id forKey:@"userId"];
    [[NetworkManager sharedManager] getWithUrl:getAddressList param:dic success:^(id json) {
        [self.listTableView.mj_header endRefreshing];
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            [self.listDataArr removeAllObjects];
            for (NSDictionary *dict in json[@"data"]) {
                AddressModel *model = [AddressModel statusWithDict:dict];
                if ([model.isDefault isEqualToString:@"1"]) {
                    [self.listDataArr insertObject:model atIndex:0];
                }else{
                   [self.listDataArr addObject:model];
                }
            }
            [self.listTableView reloadData];
        }else{
            [SVProgressHUD doAnythingFailedWithHUDMessage:json[@"respMessage"] withDuration:1.5];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



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
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.showsHorizontalScrollIndicator = NO;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.dataSource = self;
        [self.view addSubview:self.listTableView];
        self.listTableView.sd_layout
        .topSpaceToView(self.view, 0)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomSpaceToView(self.view, 100);
    }
    return _listTableView;
}

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
    static NSString *cellId = @"AddressTableViewCellID";
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithModel:self.listDataArr[indexPath.section]];
    [cell setSelectBlcok:^(NSInteger num,AddressModel *model) {
        if (num == 0) {
            EditAddressController *addCtrl = [[EditAddressController alloc] init];
            addCtrl.addressModel = model;
            [self.navigationController pushViewController:addCtrl animated:YES];
        }else{
            if ([model.isDefault isEqualToString:@"0"]) {
                self.dataDict = [NSMutableDictionary dictionary];
                [self.dataDict addEntriesFromDictionary:@{@"recProv":model.recProv}];
                [self.dataDict addEntriesFromDictionary:@{@"recCity":model.recCity}];
                [self.dataDict addEntriesFromDictionary:@{@"recArea":model.recArea}];
                [self.dataDict addEntriesFromDictionary:@{@"userId":model.userId}];
                [self.dataDict addEntriesFromDictionary:@{@"recNickName":model.recNickName}];
                [self.dataDict addEntriesFromDictionary:@{@"recPhone":model.recPhone}];
                [self.dataDict addEntriesFromDictionary:@{@"isGeneration":model.isGeneration}];
                [self.dataDict addEntriesFromDictionary:@{@"recIdentityCardNo":model.recIdentityCardNo}];
                [self.dataDict addEntriesFromDictionary:@{@"recAddress":model.recAddress}];
                [self.dataDict addEntriesFromDictionary:@{@"isDefault":@"1"}];
                [self.dataDict addEntriesFromDictionary:@{@"recProv":model.recProv}];
                [self.dataDict addEntriesFromDictionary:@{@"recCity":model.recCity}];
                [self.dataDict addEntriesFromDictionary:@{@"recArea":model.recArea}];
                [self.dataDict addEntriesFromDictionary:@{@"id":model.id}];
                [LYTools postBossDemoWithUrl:updateAddress param:self.dataDict success:^(NSDictionary *dict) {
//                    NSLog(@"%@",dict);
                    NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
                    if ([respCode isEqualToString:@"00000"]) {
                        [self loadNewTopic];
                    }else{
                        [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                    }
                } fail:^(NSError *error) {
                    
                }];
            }
            
        }
        
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)xy_noDataViewMessage
{
    return @"暂无地址";
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
