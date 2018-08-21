//
//  SearchViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchHeaderView.h"
#import "HeaderTabView.h"
#import "pingpaiCell.h"



@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)SearchHeaderView*headerview;
@property(nonatomic,strong)UITableView*tableview;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"搜索";
    
    [self setUpUI];
}

-(void)setUpUI{
    
    SearchHeaderView*headerview = [[NSBundle mainBundle]loadNibNamed:@"SearchHeaderView" owner:self options:nil].lastObject;
    self.headerview = headerview;
    headerview.frame = CGRectMake(0, SafeAreaTopHeight, kScreenWidth, 60);
    [self.view addSubview:headerview];
    
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerview.frame)+20, kScreenWidth, kScreenHeight-SafeAreaTopHeight-80) style:UITableViewStylePlain];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    
    tableview.tableFooterView = [UIView new];
    tableview.delegate = self;
    tableview.dataSource = self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuesId = @"pingpaiCell";
    pingpaiCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"pingpaiCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HeaderTabView*header = [[NSBundle mainBundle]loadNibNamed:@"HeaderTabView" owner:self options:nil].lastObject;
    header.frame = CGRectMake(0, 0, kScreenWidth, 40);
    
    return header;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
@end
