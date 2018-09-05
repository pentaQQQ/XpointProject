//
//  MerchanDetailViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/9/4.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "MerchanDetailViewController.h"
#import "SimilarProductModel.h"
#import "GoDetailTableViewCell.h"
#import "specsModel.h"
@interface MerchanDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UITableView*tableview;

@end

@implementation MerchanDetailViewController

-(NSMutableArray*)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTableview];
    
    
    [self lodaData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setUpTableview{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableview = tableview;
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    
    tableview.tableFooterView = [UIView new];
    
    
    [self.view addSubview:tableview];
    
}


- (void)lodaData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.ID forKey:@"id"];
    [[NetworkManager sharedManager] getWithUrl:getProductByMerchantId param:dic success:^(id json) {
        
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
    
    
    static NSString*reuesId = @"GoDetailTableViewCell";
    GoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"GoDetailTableViewCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SimilarProductModel*model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SimilarProductModel*model = self.dataArr[indexPath.row];
    
    NSString *str = @"";
    for (int i=0; i<model.specs.count; i++) {
        specsModel*spmodel =model.specs[i];
        if (i== 0) {
            str = [NSString stringWithFormat:@"%@(%@)",spmodel.stock,spmodel.size];
        }else{
            
            NSString *tempstr = [NSString stringWithFormat:@"%@(%@)",spmodel.stock,spmodel.size];
            str = [NSString stringWithFormat:@"%@/%@",str,tempstr];
        }
    }
    
    
    NSString *chima = [NSString stringWithFormat:@"尺码 %@",str];
    NSString *kuanshi = [NSString stringWithFormat:@"款式 %@",model.design];
    NSString *kuanhao= [NSString stringWithFormat:@"款号 %@",model.designCode];
    
    
    
    
    CGFloat high1 = [LYTools getHeighWithTitle: model.productName font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
    
    CGFloat high2 = [LYTools getHeighWithTitle:  chima font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
    
    CGFloat high3= [LYTools getHeighWithTitle: kuanshi font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
    
    CGFloat high4 =[LYTools getHeighWithTitle: kuanhao font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
    
    
    
    int tmp = model.imagesList.count % 3;
    int row = (int)model.imagesList.count / 3;
    CGFloat width = (kScreenWidth-70-10)/3.0;
    row += tmp == 0 ? 0:1;
    CGFloat high5 = (width+5)*row;
    
    
    
    
    int tm = model.specs.count % 2;
    int rows = (int)model.specs.count / 2;
    CGFloat high = 20;
    rows += tm == 0 ? 0:1;
    CGFloat high6 = (high+10)*rows+50;
    
    
    
    return high1+high2+high3+high4+high5+high6+160;
}


@end
