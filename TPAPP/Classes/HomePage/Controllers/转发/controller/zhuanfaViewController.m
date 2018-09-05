//
//  zhuanfaViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/23.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "zhuanfaViewController.h"
#import "zhuanfaHeaderView.h"
#import "zhuanfaCell.h"
#import "zhuanfasetViewController.h"
#import "shanghuModel.h"
#import "SimilarProductModel.h"

@interface zhuanfaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)zhuanfaHeaderView*headerview;
@property(nonatomic,strong)UITableView*tableview;
@property (nonatomic, strong) NSMutableArray *titleArray;

@property(nonatomic,assign)int currentIndex;

@end

@implementation zhuanfaViewController
-(NSMutableArray*)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"选择品牌转发";
    self.currentIndex = 0;
    
    [self setItems];
    [self setUpHeaderview];
    //    [self getThePeopleZhuanfaPeizhi];
    [self getdata];
}



-(void)setItems{
    
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithTitle:@"转发设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightitemClick)];
    
    self.navigationItem.rightBarButtonItem = rightitem;
    
    
    
}

-(void)leftitemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)rightitemClick{
    zhuanfasetViewController *vc = [[zhuanfasetViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setUpHeaderview{
    
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-380) style:UITableViewStylePlain];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    tableview.tableFooterView = [UIView new];
    
    
    zhuanfaHeaderView*headerview = [[NSBundle mainBundle]loadNibNamed:@"zhuanfaHeaderView" owner:self options:nil].lastObject;
    self.headerview = headerview;
    headerview.frame = CGRectMake(0, CGRectGetMaxY(tableview.frame), kScreenWidth,380);
    [self.view addSubview:headerview];
    
    
    headerview.ToNextMerchanBlock = ^{
        
        self.currentIndex++;
        if (self.currentIndex<self.titleArray.count) {
            
            [self.tableview reloadData];
        }else{
            [SVProgressHUD doAnyRemindWithHUDMessage:@"该活动已转发完" withDuration:1.5];
        }
    };
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString*reuesId = @"zhuanfaCell";
    
    zhuanfaCell*cell =[tableView dequeueReusableCellWithIdentifier:reuesId];
    
    if (cell == nil) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"zhuanfaCell" owner:self options:nil].lastObject;
    }
    shanghuModel *model = self.titleArray[indexPath.row];
    
    cell.model = model;
    
    
    if (indexPath.row == self.currentIndex) {
        self.headerview.merchanid = model.merchantId;
        
    }
    
    return cell;
    
}




//获取商户列表
-(void)getdata{
    
    [[NetworkManager sharedManager]getWithUrl:getMerchantList param:nil success:^(id json) {
        NSLog(@"%@",json);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]){
            
            for (NSDictionary *dic in json[@"data"]) {
                shanghuModel *model = [shanghuModel mj_objectWithKeyValues:dic];
                [self.titleArray addObject:model];
            }
            [self.tableview reloadData];
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}






@end
