//
//  PiliangzhuanfaViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/9/7.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "PiliangzhuanfaViewController.h"
#import "PiLiangzhuanfaCell.h"
#import "SimilarProductModel.h"
@interface PiliangzhuanfaViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UILabel *topLab;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *jiajiaBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhuanfaBtn;

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation PiliangzhuanfaViewController

-(NSMutableArray*)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    ViewBorderRadius(self.jiajiaBtn, 5, 1, [UIColor redColor]);
    ViewBorderRadius(self.zhuanfaBtn, 5, 1, [UIColor clearColor]);
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [UIView new];
    [self lodaData];
    
}




- (void)lodaData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.ID forKey:@"id"];
    [[NetworkManager sharedManager] getWithUrl:getProductByActivityId param:dic success:^(id json) {
        
        NSLog(@"%@",json);
        
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            
            for (NSDictionary *dic in json[@"data"]) {
                SimilarProductModel *model = [SimilarProductModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
            [self.tableview reloadData];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuesrId = @"PiLiangzhuanfaCell";
    
    PiLiangzhuanfaCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesrId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"PiLiangzhuanfaCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SimilarProductModel *model = self.dataArr[indexPath.row];
    
    cell.model = model;
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


@end
