//
//  AddAddressController.m
//  TPAPP
//
//  Created by Frank on 2018/8/22.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "AddAddressController.h"
#import "AddAddressCell.h"
#import "BRPickerView.h"
#import "NSDate+BRAdd.h"

@interface AddAddressController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)UIButton *addBtn;
@property (nonatomic, strong)NSMutableDictionary *dataDict;
//@property (nonatomic, strong) SHPlacePickerView *shplacePicker;
@end

@implementation AddAddressController
-(NSMutableDictionary *)dataDict
{
    if (_dataDict == nil) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新建地址";
//    [self createItems];
    [self listTableView];
//    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
//    //自动更改透明度
//    self.listTableView.mj_header.automaticallyChangeAlpha = YES;
//    //进入刷新状态
//    [self.listTableView.mj_header beginRefreshing];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.listDataArr = [NSMutableArray arrayWithObjects:@[@[@"收货人:",@"请输入收货人名字",@0],@[@"电    话:",@"请输入收货人电话",@0]],@[@[@"省 市 区",@"",@1],@[@"请输入详细地址",@"",@2],@[@"身份证号码:",@"请输入身份证号码",@0],@[@"是否设置为默认地址",@"",@3]], nil];
    
    
}


//#pragma mark - 下拉刷新数据
//- (void)loadNewTopic
//{
//    [[NetworkManager sharedManager] getWithUrl:saveAddress param:@{@"id":@"123",@"userId":@"34"} success:^(id json) {
//        NSLog(@"%@",json);
//        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
//        if ([respCode isEqualToString:@"00000"]) {
//
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}


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
    if ([self.dataDict[@"recNickName"] length] == 0) {
        
    }else{
        if ([self.dataDict[@"recPhone"] length] == 0) {
            
        }else{
            if ([self.dataDict[@"recProv"] length] == 0) {
                
            }else{
                if ([self.dataDict[@"recAddress"] length] == 0) {
                    
                }else{
                    if ([self.dataDict[@"recIdentityCardNo"] length] == 0) {
                        
                    }else{
                        LYAccount *lyAccount = [LYAccount shareAccount];
                        [self.dataDict addEntriesFromDictionary:@{@"userId":lyAccount.id}];
                        [self.dataDict addEntriesFromDictionary:@{@"isGeneration":@"0"}];
                        [LYTools postBossDemoWithUrl:saveAddress param:self.dataDict success:^(NSDictionary *dict) {
                            NSLog(@"%@",dict);
                            NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
                            if ([respCode isEqualToString:@"00000"]) {
                                [SVProgressHUD doAnythingSuccessWithHUDMessage:@"新建成功" withDuration:1.5];
                                [self.navigationController popViewControllerAnimated:YES];
                            }else{
                                [SVProgressHUD doAnythingSuccessWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                            }
                        } fail:^(NSError *error) {

                        }];
                    }
                }
            }
        }
    }
    
    
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
//        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.dataSource = self;
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
//        if ([self.listTableView respondsToSelector:@selector(setSeparatorInset:)]) {
//            [self.listTableView setSeparatorInset:UIEdgeInsetsZero];
//        }
//        if ([self.listTableView respondsToSelector:@selector(setLayoutMargins:)]) {
//            [self.listTableView setLayoutMargins:UIEdgeInsetsZero];
//        }
        

    }
    return _listTableView;
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
//    }
//    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
//        [cell setPreservesSuperviewLayoutMargins:NO];
//    }
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listDataArr.count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==2) {
        return 1;
    }else{
        NSArray *arr = self.listDataArr[section];
        return arr.count;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        static NSString *cellId = @"UITableViewCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        cell.backgroundColor = [UIColor clearColor];
        self.addBtn = [[UIButton alloc] init];
        self.addBtn.backgroundColor = colorWithRGB(0xFF6B24);
        [self.addBtn setTitle:@"保存" forState:UIControlStateNormal];
        [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:self.addBtn];
        self.addBtn.sd_layout
        .topSpaceToView(cell.contentView,30)
        .rightSpaceToView(cell.contentView, 20)
        .leftSpaceToView(cell.contentView, 20)
        .heightIs(50);
        self.addBtn.layer.cornerRadius = 6;
        self.addBtn.layer.masksToBounds = YES;
        return cell;
    }else{
        static NSString *cellId = @"AddAddressCellID";
        AddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AddAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        if (indexPath.section == 1 && indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setMyBlock:^(NSDictionary *dict) {
            [self.dataDict addEntriesFromDictionary:dict];
        }];
        [cell configWithModel:self.listDataArr[indexPath.section][indexPath.row] withModelData:nil withNumber:self.dataNull];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1) {
        return 70;
    }else if (indexPath.section == 2){
        return 80;
    }
    else{
        return 50;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }else{
        return 0;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
        view.backgroundColor = [UIColor clearColor];
        
        return view;
    }else{
        return nil;
    }
   
    
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
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddAddressCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 1 && indexPath.row == 0) {
        [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
            cell.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
            [self.dataDict addEntriesFromDictionary:@{@"recProv":selectAddressArr[0]}];
            [self.dataDict addEntriesFromDictionary:@{@"recCity":selectAddressArr[1]}];
            [self.dataDict addEntriesFromDictionary:@{@"recArea":selectAddressArr[2]}];
        }];

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
