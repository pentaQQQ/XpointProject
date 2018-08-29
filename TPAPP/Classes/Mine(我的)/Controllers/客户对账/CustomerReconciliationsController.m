//
//  CustomerReconciliationsController.m
//  TPAPP
//
//  Created by frank on 2018/8/25.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "CustomerReconciliationsController.h"
#import "CustomerReCell.h"
#import "TuYeTextField.h"
@interface CustomerReconciliationsController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (strong,nonatomic)NSMutableArray *searchList;  //搜索结果
@property (nonatomic, strong)TuYeTextField *searchField;
@property (nonatomic, strong)UIButton *searchBtn;
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
#pragma mark - 懒加载
-(NSMutableArray *)searchList
{
    if (_searchList == nil) {
        _searchList = [NSMutableArray array];
    }
    return _searchList;
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
    if (self.searchList.count != 0) {
        return [self.searchList count];
    }else{
        return [self.listDataArr count];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        CustomerReCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"CustomerReCellID"];
        if (!headerCell) {
            headerCell = [[CustomerReCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomerReCellID"];
        }
        
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.searchList.count != 0) {
        [headerCell configWithModel:self.searchList[indexPath.row]];
    }
    else{
        [headerCell configWithModel:self.listDataArr[indexPath.row]];
    }

        return headerCell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

   return 30+44;

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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30+44)];
    view.backgroundColor = [UIColor whiteColor];

    self.searchField = [[TuYeTextField alloc]initWithFrame:CGRectMake(0,0,kScreenWidth-60,34)];
    [view addSubview:self.searchField];
    self.searchField.placeholder = @"品牌名称";
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    leftImageView.image = [UIImage imageNamed:@"icon_home_search"];
    self.searchField.leftView = leftImageView;
    self.searchField.leftViewMode = UITextFieldViewModeAlways;
    self.searchField.borderStyle = UITextBorderStyleRoundedRect;
    self.searchField.textColor = [UIColor blackColor];
    self.searchField.font= [UIFont systemFontOfSize:16] ;
    self.searchField.backgroundColor= [UIColor whiteColor] ;
 self.searchField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    self.searchField.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [self.searchField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged]; // textField的文本发生变化时相应事件
    [self.searchField setReturnKeyType:UIReturnKeySearch];
    self.searchField.delegate=self;
    
    self.searchBtn = [[UIButton alloc] init];
    self.searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.searchBtn];
    self.searchBtn.sd_layout
    .topSpaceToView(view, 0)
    .rightSpaceToView(view, 0)
    .widthIs(60)
    .heightIs(34);
    
    
    UILabel *listLabel = [[UILabel alloc] init];
    listLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    listLabel.textColor = [UIColor redColor];
    [view addSubview:listLabel];
    listLabel.sd_layout
    .topSpaceToView(view, 5+44)
    .leftSpaceToView(view, 10)
    .widthIs(150)
    .heightIs(20);
    listLabel.text = @"选择活动";
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5+44,kScreenWidth , 1)];
    lineView.backgroundColor = colorWithRGB(0xEEEEEE);
    [view addSubview:lineView];
    return view;
}
#pragma mark - 搜索按钮事件
- (void)searchBtnAction
{
    if (self.listDataArr.count != 0) {
        [self.searchList removeAllObjects];
        for (NSArray *arr in self.listDataArr) {
            
            if ([arr[1] rangeOfString:self.searchField.text].location != NSNotFound) {
                [self.searchList addObject:arr];
            }
        }
        [self.listTableView reloadData];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField*)theTextField {
    [self.view endEditing:YES];
    if (self.listDataArr.count != 0) {
        [self.searchList removeAllObjects];
        for (NSArray *arr in self.listDataArr) {

            if ([arr[1] rangeOfString:theTextField.text].location != NSNotFound) {
                [self.searchList addObject:arr];
            }
        }
        [self.listTableView reloadData];
    }
    NSLog(@"do something what you want");
    return YES;
}
//textField的文本内容发生变化时,处理事件函数
- (void) textFieldDidChange:(UITextField*) TextField{
    NSLog(@"textFieldDidChange textFieldDidChange");
    if(![TextField.text isEqualToString:@""]) {
        
    } else{
        [self.searchList removeAllObjects];
        [self.listTableView reloadData];
    }
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
