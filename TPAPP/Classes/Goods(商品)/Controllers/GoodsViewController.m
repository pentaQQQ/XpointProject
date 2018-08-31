//
//  GoodsViewController.m
//  TPAPP
//
//  Created by 上海点硕 on 2017/7/18.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "GoodsViewController.h"
#import "messageHeaderView.h"
#import "TPMessageCell.h"
#import "messageHeaderView.h"
#import "SystemInformationController.h"
#import "TransportationMessageViewController.h"
@interface GoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSMutableArray*dataArr;
@end

@implementation GoodsViewController
-(NSMutableArray*)dataArr{
    
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self setUpUI];
    
}



-(void)setUpUI{
   
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-SafeAreaBottomHeight) style:UITableViewStylePlain];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    
    
 
    messageHeaderView *header = [[NSBundle mainBundle]loadNibNamed:@"messageHeaderView" owner:self options:nil].lastObject;
    
    header.frame = CGRectMake(0, 0, kScreenWidth, 80);
    self.tableview.tableHeaderView =header;
    __weak __typeof(self) weakSelf = self;

    header.messageBlock = ^{
        SystemInformationController*vc = [[SystemInformationController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    header.wuliuBlock = ^{
        TransportationMessageViewController*vc = [[TransportationMessageViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    
    
    
    self.tableview.tableFooterView = [UIView new];

    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *reuesId = @"TPMessageCell";
    TPMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TPMessageCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}






@end
