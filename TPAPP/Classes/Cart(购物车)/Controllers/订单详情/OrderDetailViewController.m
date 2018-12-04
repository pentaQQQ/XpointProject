//
//  OrderDetailViewController.m
//  TPAPP
//
//  Created by Frank on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailCell.h"
#import "PayIndentCell.h"

@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UILabel *allGoodsPriceLabel;
@property (nonatomic, strong)UILabel *allGoodsNumberLabel;
@property (nonatomic, strong)UIImageView *buyGoodsIcon;
@property (nonatomic, strong)UILabel *buyGoodsPriceLabel;
@property (nonatomic, strong)UIButton *buyButton;


@end

@implementation OrderDetailViewController
#pragma mark - 懒加载
-(NSMutableArray *)listDataArr
{
    if (_listDataArr == nil) {
        _listDataArr = [NSMutableArray array];
    }
    return _listDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpUI];
    [self createBottomView];
}

- (void)createBottomView
{
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    self.bottomView.sd_layout
    .bottomSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .widthIs(kScreenWidth)
    .heightIs(50+SafeAreaBottomHeight);
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.text = @"合计:";
    self.priceLabel.textAlignment = NSTextAlignmentLeft;
//    self.priceLabel.textColor = colorWithRGB(0xFF6B24);
    self.priceLabel.font = [UIFont systemFontOfSize:15];
    [self.bottomView addSubview:self.priceLabel];
    self.priceLabel.sd_layout
    .topSpaceToView(self.bottomView,15)
    .leftSpaceToView(self.bottomView, 15)
    .widthIs([self widthLabelWithModel:@"合计:" withFont:15])
    .heightIs(20);
    
    
    
    self.allGoodsNumberLabel = [[UILabel alloc] init];
    self.allGoodsNumberLabel.text = @"1件";
    self.allGoodsNumberLabel.textAlignment = NSTextAlignmentLeft;
//    self.allGoodsNumberLabel.textColor = colorWithRGB(0xFF6B24);
    self.allGoodsNumberLabel.font = [UIFont systemFontOfSize:15];
    [self.bottomView addSubview:self.allGoodsNumberLabel];
    self.allGoodsNumberLabel.sd_layout
    .topSpaceToView(self.bottomView,15)
    .leftSpaceToView(self.priceLabel, 5)
    .widthIs([self widthLabelWithModel:@"1件" withFont:15])
    .heightIs(20);
    
//    self.buyButton = [[UIButton alloc] init];
//    self.buyButton.backgroundColor = colorWithRGB(0xFF6B24);
//    [self.buyButton setTitle:@"结算" forState:UIControlStateNormal];
//    [self.buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.buyButton addTarget:self action:@selector(buyButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.bottomView addSubview:self.buyButton];
//    self.buyButton.sd_layout
//    .topSpaceToView(self.bottomView, 0)
//    .rightSpaceToView(self.bottomView, 0)
//    .widthIs(80)
//    .heightIs(50);
    
    self.allGoodsPriceLabel = [[UILabel alloc] init];
    self.allGoodsPriceLabel.text = @"¥1000";
    self.allGoodsPriceLabel.textAlignment = NSTextAlignmentRight;
    self.allGoodsPriceLabel.textColor = colorWithRGB(0xFF6B24);
    self.allGoodsPriceLabel.font = [UIFont systemFontOfSize:17];
    [self.bottomView addSubview:self.allGoodsPriceLabel];
    self.allGoodsPriceLabel.sd_layout
    .topSpaceToView(self.bottomView,10)
    .rightSpaceToView(self.bottomView, 15)
    .widthIs([self widthLabelWithModel:@"¥1000" withFont:17])
    .heightIs(30);
    
    self.buyGoodsPriceLabel = [[UILabel alloc] init];
    self.buyGoodsPriceLabel.text = @"¥结算金额:";
    self.buyGoodsPriceLabel.textAlignment = NSTextAlignmentRight;
    self.buyGoodsPriceLabel.textColor = colorWithRGB(0xFF6B24);
    self.buyGoodsPriceLabel.font = [UIFont systemFontOfSize:15];
    [self.bottomView addSubview:self.buyGoodsPriceLabel];
    self.buyGoodsPriceLabel.sd_layout
    .topSpaceToView(self.bottomView,10)
    .rightSpaceToView(self.allGoodsPriceLabel, 5)
    .widthIs([self widthLabelWithModel:@"¥结算金额:" withFont:15])
    .heightIs(30);
    
    self.buyGoodsIcon = [[UIImageView alloc] init];
    self.buyGoodsIcon.image = [UIImage imageNamed:@"icon_money_press"];
    [self.bottomView addSubview:self.buyGoodsIcon];
    self.buyGoodsIcon.sd_layout
    .topSpaceToView(self.bottomView,15)
    .rightSpaceToView(self.buyGoodsPriceLabel, 5)
    .widthIs(20)
    .heightIs(20);
    
}
- (void)buyButtonAction
{
    
}
- (void)setUpUI
{
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.listTableView];
    self.listTableView.sd_layout
    .topSpaceToView(self.view, k_top_height)
    .leftEqualToView(self.view)
    .bottomSpaceToView(self.view, 50+SafeAreaBottomHeight)
    .widthIs(kScreenWidth);
    self.listTableView.backgroundColor = colorWithRGB(0xEEEEEE);
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.showsVerticalScrollIndicator = NO;
    self.listTableView.showsHorizontalScrollIndicator = NO;
    if ([self.listTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.listTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.listTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.listTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    //    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return 3;
    }else{
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellId = @"OrderDetailMessageCellID";
        OrderDetailMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[OrderDetailMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell configWithModel:[NSMutableArray arrayWithObjects:@"3363655",@"交易成功",@"2018-07-22 15:40:22", nil]];
        return cell;
    }else if (indexPath.section == 1 || indexPath.section == 2){
        static NSString *cellId = @"OrderDetailAddressCellID";
        OrderDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[OrderDetailAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@[@"收货人:",@"Alan",@"18501605966",@"收货地址:",@"上海宝山区沪太路3100号A座"],@[@"代购人:",@"Alan",@"18501605966",@"代购地址:",@"上海宝山区沪太路3100号A座"], nil];
        [cell configWithModel:arr[indexPath.section-1]];
        return cell;
    }else if (indexPath.section == 3){
        static NSString *cellId = @"PayIndentDefaultCellID";
         PayIndentDefaultCell*cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[PayIndentDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
         NSMutableArray *arr = [NSMutableArray arrayWithObjects:@[@"商品金额 (1件)",@"¥1000"],@[@"优惠金额",@"¥50"],@[@"运费",@"¥50"], nil];
        [cell configWithModel:arr[indexPath.row]];
        return cell;
    }else{
        static NSString *cellId = @"OrderDetailCellID";
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell configWithModel:[NSMutableArray arrayWithObjects:@"粉色简约休闲OL轻便上装",@"S码",@"¥1000",@"x1",@"交易成功",@"图片", nil]];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        return 50;
    }else if (indexPath.section == 4) {
        return 90;
    }else{
        return 70;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 40;
    }else{
      return 0;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] init];
        [view addSubview:lineView];
        lineView.backgroundColor = colorWithRGB(0xbfbfbf);
        lineView.sd_layout
        .topSpaceToView(view, 39.5)
        .leftEqualToView(view)
        .rightEqualToView(view)
        .heightIs(.5);
        
        UIImageView *lineImgeView = [[UIImageView alloc] init];
        [view addSubview:lineImgeView];
        lineImgeView.image = [UIImage imageNamed:@"icon_mine_line"];
        lineImgeView.sd_layout
        .topSpaceToView(view, 15)
        .leftSpaceToView(view, 15)
        .bottomSpaceToView(view, 15)
        .widthIs(3);
        
        UILabel *listLabel = [[UILabel alloc] init];
        [view addSubview:listLabel];
        listLabel.sd_layout
        .topSpaceToView(view, 10)
        .leftSpaceToView(lineImgeView, 5)
        .widthIs(150)
        .heightIs(20);
        listLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
        listLabel.text = @"代购人信息";
        return view;
    }else{
       return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = colorWithRGB(0xEEEEEE);
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString withFont:(NSInteger)font
{
    CGSize size = CGSizeMake(self.view.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width+5;
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
