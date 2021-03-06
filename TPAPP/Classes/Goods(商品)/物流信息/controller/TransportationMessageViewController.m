//
//  TransportationMessageViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "TransportationMessageViewController.h"
#import "TransportationCell.h"
#import "TransportationSeationView.h"
@interface TransportationMessageViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSIndexPath *_indexPath; // 保存当前选中的单元格
    NSMutableArray *switchArr; // 保存旋转状态(展开/折叠)
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)BOOL seconOne;
@property(nonatomic,assign)BOOL seconTwo;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *boolArray;


@property(nonatomic,assign)int page;

@end

@implementation TransportationMessageViewController
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)boolArray{
    if (_boolArray==nil) {
        _boolArray = [NSMutableArray array];
    }
    return _boolArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流信息";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.boolArray addObject:@YES];
    [self.boolArray addObject:@NO];
    [self.boolArray addObject:@NO];
    [self.boolArray addObject:@NO];
    [self setUpTableview];
}



-(void)setUpTableview{
    
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableview = tableview;
    
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    
}





#pragma mark- UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if ([self.boolArray[section] boolValue] == YES) {
        
        
        return 4;
        
    }else{
        return 0;
    }
    
    
}




// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
// 分区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 201;
}
// 分区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    TransportationSeationView *transview = [[NSBundle mainBundle]loadNibNamed:@"TransportationSeationView" owner:self options:nil].lastObject;
    
    transview.frame = CGRectMake(0, 0, kScreenWidth, 201);
    CGFloat rota;
    
    if ([self.boolArray[section] boolValue] == NO) {
        rota = 0;
        
    }else{
        rota = M_PI; //π
    }
    
    transview.rotaBtn.transform = CGAffineTransformMakeRotation(rota);//箭头偏移π
    transview.rotaBtn.tag = 1000 + section;
    [transview.rotaBtn addTarget:self action:@selector(openClick:) forControlEvents:UIControlEventTouchUpInside];
    return transview;
    
}


- (void)openClick:(UIButton *)sender {
    
    
    NSInteger section = sender.tag - 1000;
    
    
    if ([self.boolArray[section] boolValue] == NO) {
        [self.boolArray replaceObjectAtIndex:section withObject:@YES];
        
    }else{
        [self.boolArray replaceObjectAtIndex:section withObject:@NO];
    }
    
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuesId = @"TransportationCell";
    
    TransportationCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TransportationCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    // 取消选中后的高亮状态(默认是：选中单元格后一直处于高亮状态，直到下次重新选择)
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //
    //    SecondPageListModel *listModel = self.dataArray[indexPath.section];
    //
    //    childNvrBaseInfoVo *model = listModel.childNvrBaseInfoVo[indexPath.row];
    //
    //    TCYuShiViewController * vc = [[TCYuShiViewController alloc]init];
    //    vc.ID = model.id;
    //    vc.devices = self.device;
    //    [self.navigationController pushViewController:vc animated:YES];
    //
    
}

@end
