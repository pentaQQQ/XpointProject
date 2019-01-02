//
//  TransMessViewController.m
//  TPAPP
//
//  Created by Frank on 2018/12/5.
//  Copyright © 2018 cbl－　点硕. All rights reserved.
//

#import "TransMessViewController.h"
#import "TransportationCell.h"
#import "TransportationSeationView.h"
@interface TransMessViewController ()<UITableViewDataSource, UITableViewDelegate>
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

@implementation TransMessViewController
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
    [self setUpTableview];
    [self loaData];
}
- (void)loaData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.model.orderLogistics.logisticsCode forKeyPath:@"expressCompany"];
    [dic setValue:self.model.orderLogistics.expressNo forKeyPath:@"expressNo"];
    [[NetworkManager sharedManager] getWithUrl:getLogisticsInfo param:dic success:^(id json) {
        NSLog(@"%@",json);
        [self.dataArray removeAllObjects];
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            TransforMessModel *model = [TransforMessModel mj_objectWithKeyValues:json[@"data"]];
            
            [model.data removeAllObjects];
            for (NSDictionary *newDic in json[@"data"][@"data"]) {
                TransforMessDetailModel *orderDetailModel = [TransforMessDetailModel mj_objectWithKeyValues:newDic];
                [model.data addObject:orderDetailModel];
                
            }
            [self.dataArray addObject:model];
            [self.tableview reloadData];
        }else if([json[@"code"]longValue] == 500){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD doAnythingFailedWithHUDMessage:json[@"respMessage"] withDuration:1.5];
                [self.tableview reloadData];
            });
        }
    } failure:^(NSError *error) {
        
    }];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.boolArray[section] boolValue] == YES) {
        if (self.dataArray.count != 0) {
            TransforMessModel *model = self.dataArray[0];
            return model.data.count-1;
        }else{
            return 0;
        }
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
    return 260;
}
// 分区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.model.orderDetailList.count == 1) {
        OrderDetailModel *model = self.model.orderDetailList[0];
        TransportationSeationView *transview = [[NSBundle mainBundle]loadNibNamed:@"TransportationSeationView" owner:self options:nil].lastObject;
        transview.frame = CGRectMake(0, 0, kScreenWidth, 260);
        [transview.orderIcon sd_setImageWithURL:[NSURL URLWithString:model.productImg]];
        transview.orderName.text = model.productName;
        transview.sizeNum.text = [NSString stringWithFormat:@"%@",model.size];
        transview.payNumber.text = [NSString stringWithFormat:@"x%ld",model.number];
        if (model.remark.length == 0) {
            transview.remarkLabel.text = @"备注: 无";
        }else{
            transview.remarkLabel.text = [NSString stringWithFormat:@"备注: %@",model.remark];
        }
        if (self.dataArray.count != 0) {
            TransforMessModel *transModel = self.dataArray[0];
            transview.logiName.text = transModel.com;
            transview.logilistNum.text = transModel.nu;
            transview.logilistNum.numberOfLines=0;
            transview.logilistNum.textAlignment=NSTextAlignmentLeft;
            transview.logilistNum.lineBreakMode=NSLineBreakByTruncatingTail;
            
            TransforMessDetailModel *deModel = transModel.data[0];
            NSArray *arr = [deModel.time componentsSeparatedByString:@" "];
            transview.yearMouth.text = arr[0];
            transview.dayTime.text = arr[1];
            transview.sendAddress.text = deModel.context;
        }
        transview.priceLabel.text = model.productAmount;
        
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
    return nil;
    
    
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
    if (self.dataArray.count != 0) {
        TransforMessModel *transModel = self.dataArray[0];
        TransforMessDetailModel *deModel = transModel.data[indexPath.row+1];
        NSArray *arr = [deModel.time componentsSeparatedByString:@" "];
        cell.yearMouthLabel.text = arr[0];
        cell.dayTimeLabel.text = arr[1];
        cell.sendAddress.numberOfLines=0;
        cell.sendAddress.textAlignment=NSTextAlignmentLeft;
        cell.sendAddress.lineBreakMode=NSLineBreakByTruncatingTail;
        cell.sendAddress.text = deModel.context;
    }
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
