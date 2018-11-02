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

#import "allGoodsView.h"
#import "SimilarProductModel.h"
#import "GoDetailTableViewCell.h"
#import "specsModel.h"
#import "DeclareAbnormalAlertView.h"
#import "danshouView.h"
#import "HuoDongCell.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)SearchHeaderView*headerview;
@property(nonatomic,strong)UITableView*tableview;

@property(nonatomic,weak)UIView *mengbanView;
@property(nonatomic,strong)allGoodsView*goodsView;

@property(nonatomic,assign)int currentIndex;
@property(nonatomic,strong)UIButton *topbtn;





@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)shanghuModel *model;
@end




@implementation SearchViewController


-(NSMutableArray*)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"搜索";
    
    
    self.currentIndex = 0;
    SearchHeaderView*headerview = [[NSBundle mainBundle]loadNibNamed:@"SearchHeaderView" owner:self options:nil].lastObject;
    headerview.frame = CGRectMake(0, 0, 100,20);
    ViewBorderRadius(headerview, 5, 1, [UIColor groupTableViewBackgroundColor]);
    self.headerview = headerview;
    
    
    headerview.textField.tintColor = [UIColor lightGrayColor];
    headerview.textField.textColor =[UIColor lightGrayColor];
    [ headerview.textField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.navigationItem.titleView = headerview;
    
    
    headerview.textField.delegate = self;
    
    
    [self setUpUI];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (!textField.text.length) {
        [SVProgressHUD doAnyRemindWithHUDMessage:@"输入的内容不能为空" withDuration:1.5];
    }else{
        
        [self getTheSearchGoodsWithkeyword:textField.text AndmerchantId:self.model.merchantId];
        
        
    }
    textField.text = @"";
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    return YES;
}



-(void)setUpUI{
    
    
    
    UIButton *topbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, SafeAreaTopHeight, kScreenWidth-20, 40)];
    self.topbtn = topbtn;
    [self.view addSubview:topbtn];
    topbtn.backgroundColor = [UIColor whiteColor];
    topbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    topbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [topbtn setTitle:@"搜索品牌：全部" forState:UIControlStateNormal];
    [topbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [topbtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    WeakSelf(weakSelf)
    [topbtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf loadgoodview];
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }];
    
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topbtn.frame), kScreenWidth, 1)];
    [self.view addSubview:vi];
    vi.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topbtn.frame)+1, kScreenWidth, kScreenHeight-SafeAreaTopHeight-41) style:UITableViewStylePlain];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    
    tableview.tableFooterView = [UIView new];
    tableview.delegate = self;
    tableview.dataSource = self;
}






-(void)loadgoodview{
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mengbanViewClick)];
    [mengbanView addGestureRecognizer:tap];
    
    allGoodsView*goodsView = [[NSBundle mainBundle]loadNibNamed:@"allGoodsView" owner:self options:nil].lastObject;
    self.goodsView = goodsView;
    goodsView.currentIndex = self.currentIndex;
    
    goodsView.frame = CGRectMake(0, kScreenHeight/4, kScreenWidth, kScreenHeight/4*3);
    
    [keyWindow addSubview:goodsView];
    
    
    WeakSelf(weakSelf)
    goodsView.goodviewBlock = ^(int index, shanghuModel * _Nonnull model) {
        
        weakSelf.currentIndex = index;
        
        [weakSelf mengbanViewClick];
        
        weakSelf.model = model;
        
        if (index == 0) {
            
            [weakSelf.topbtn setTitle:@"搜索品牌：全部" forState:UIControlStateNormal];
        }else{
            NSString *tit = [NSString stringWithFormat:@"搜索品牌：%@",model.merchantName];
            [weakSelf.topbtn setTitle:tit forState:UIControlStateNormal];
        }
        
    };
    
}



-(void)mengbanViewClick{
    
    [self.goodsView removeView];
    [self.mengbanView removeFromSuperview];
}






-(void)getTheSearchGoodsWithkeyword:(NSString*)keyword AndmerchantId:(NSString *)merchantId{
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setValue:keyword forKey:@"keyword"];
    [dict1 setValue:merchantId forKey:@"merchantId"];
    
    
    [[NetworkManager sharedManager]getWithUrl:getsearchProductByKeyword param:dict1 success:^(id json) {
        NSLog(@"%@",json);
        
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            
            [self.dataArr removeAllObjects];
            for (NSDictionary *dic in json[@"data"]) {
                SimilarProductModel *model = [SimilarProductModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
            
            if (self.dataArr.count == 0) {
                [SVProgressHUD doAnyRemindWithHUDMessage:@"暂无商品" withDuration:1.5];
            }
            
            
            
            [self.tableview reloadData];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SimilarProductModel*model = self.dataArr[indexPath.row];
    
    if (!([model.typeac isEqualToString:@"0"]||[model.typeac isEqualToString:@"1"])) {
        static NSString*reuesId = @"GoDetailTableViewCell";
        GoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"GoDetailTableViewCell" owner:self options:nil].lastObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = model;
        
        [cell setAddGoodsGoCartBlock:^(specsModel *model) {
            LYAccount *lyAccount = [LYAccount shareAccount];
            if ([lyAccount.isRemark intValue] == 1) {
                DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"添加商品备注" message:@"请输入备注信息" delegate:self leftButtonTitle:@"不下单" rightButtonTitle:@"下单" comCell:nil isAddGood:YES spesmodel:model];
                [alertView show];
            }else{
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:model.productId forKey:@"productId"];
                [dic setValue:model.size forKey:@"size"];
                [dic setValue:lyAccount.id forKey:@"userId"];
                [dic setValue:@"1" forKey:@"number"];
                [LYTools postBossDemoWithUrl:cartAddProduct param:dic success:^(NSDictionary *dict) {
                    NSLog(@"%@",dict);
                    NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
                    if ([respCode isEqualToString:@"00000"]) {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"getShopCarNumber" object:@{@"getShopCarNumber":@1}];
                        [SVProgressHUD doAnythingSuccessWithHUDMessage:@"已经成功添加购物车" withDuration:1.5];
                        //                        [self.navigationController.tabBarController.viewControllers[3].tabBarItem setBadgeValue:@"5"];
                    }else{
                        [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                    }
                } fail:^(NSError *error) {
                    
                }];
            }
        }];
        
        
        return cell;
    }else{
        
        
        static NSString *reuesId = @"HuoDongCell";
        HuoDongCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"HuoDongCell" owner:self options:nil].lastObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        
        cell.model = model;
        
        
        
        return cell;
        
    }
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SimilarProductModel*model = self.dataArr[indexPath.row];
    
    
    if (!([model.typeac isEqualToString:@"0"]||[model.typeac isEqualToString:@"1"])) {
        
        NSString *str = @"";
        for (int i=0; i<model.specs.count; i++) {
            specsModel*spmodel =model.specs[i];
            
            if (i== 0) {
                str = [NSString stringWithFormat:@"%ld(%@)",[spmodel.stock integerValue],spmodel.size];
            }else{
                
                NSString *tempstr = [NSString stringWithFormat:@"%ld(%@)",[spmodel.stock integerValue],spmodel.size];
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
    }else{
        
        CGFloat width = (kScreenWidth-70-10)/3.0;
        
        //content的高度
        CGFloat high = [LYTools getHeighWithTitle:model.context font:[UIFont systemFontOfSize:14] width:kScreenWidth-70];
        
        int tmp = model.imagesList.count % 3;
        int row = (int)model.imagesList.count / 3;
        row += tmp == 0 ? 0:1;
        return (width+5)*row+163+high;
    }
    
    
}
@end
