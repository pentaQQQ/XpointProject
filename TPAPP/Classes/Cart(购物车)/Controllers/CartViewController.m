//
//  CartViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "CartViewController.h"
#import "MGSwipeTableCell.h"
#import "CompileCell.h"
#import "SectionView.h"
#import "BottomView.h"
#import "Helper.h"
#import "CartHeaderCell.h"
#import "BuyGoodsListController.h"
#import "AddressManageController.h"
#import "XYNoDataView.h"
#import <objc/runtime.h>
#import "AppDelegate.h"
@interface CartViewController ()<UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate,ShoppingSelectedDelegate,SelectedSectionDelegate,BottomViewDelegate>
{
    BOOL allowMultipleSwipe;
}

@property (nonatomic, strong)UITableView *CartTableView;
@property (nonatomic, strong)BottomView *accountView;
@property (nonatomic, strong)UIView *remindView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation CartViewController

-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    _CartTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -SafeAreaBottomHeight) style:UITableViewStyleGrouped];
    _CartTableView.estimatedRowHeight = 0;
    _CartTableView.delegate = self;
    _CartTableView.dataSource = self;
    _CartTableView.backgroundColor = colorWithRGB(0xEEEEEE);
    _CartTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_CartTableView];
    _CartTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    _CartTableView.mj_header.automaticallyChangeAlpha = YES;
    
    
   
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([_CartTableView.mj_header isRefreshing]) {
        [_CartTableView.mj_header endRefreshing];
    }
    //进入刷新状态
    [_CartTableView.mj_header beginRefreshing];
}
#pragma mark - 下拉刷新数据
- (void)loadNewTopic
{
    [[NetworkManager sharedManager] getWithUrl:getMainResources param:nil success:^(id json) {
        NSLog(@"%@",json);
        _CartTableView.backgroundView = nil;
        [_CartTableView.mj_header endRefreshing];
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            
           [self CartData];
           
            

            [_CartTableView reloadData];
        }else if([json[@"code"]longValue] == 500){
            
//            [_CartTableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


-( NSMutableArray *)CartData
{
    
    [self.dataSource removeAllObjects];
    
        NSArray *data = @[@[],@[@{@"GoodsIcon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571326962&di=8f502445613592dc9dd19dde4032c6ec&imgtype=0&src=http%3A%2F%2Fimg009.hc360.cn%2Fm6%2FM0A%2F98%2F05%2FwKhQoVVat96Ee_nyAAAAANCKIXo389.jpg",@"GoodsName":@"秋冬季毛呢显瘦直筒西装裤韩版高腰哈伦裤女小脚裤休闲裤宽松裤子",@"GoodsDesc":@"颜色:米白色;尺寸:170/85A[M 120斤内]",@"GoodsPrice":@"15",@"GoodsOldPrice":@"￥235",@"GoodsNumber":@"3",@"SelectedType":@"未选中支付",@"Type":@"0",@"CheckAll":@"0",@"Edit":@"0",@"EditBtn":@"0"},@{@"GoodsIcon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571328758&di=0f9dafd5ef73a3eff0a125ae310174ac&imgtype=0&src=http%3A%2F%2Fpic36.nipic.com%2F20131205%2F12477111_155227608129_2.jpg",@"GoodsName":@"秋冬加绒卫裤2016韩版松紧腰系带金丝绒哈伦裤男女情侣休闲裤保暖",@"GoodsDesc":@"颜色:米白色;尺寸:170/85A[M 120斤内]",@"GoodsPrice":@"7",@"GoodsOldPrice":@"￥353",@"GoodsNumber":@"2",@"SelectedType":@"未选中支付",@"Type":@"0",@"Edit":@"0"}],
                          @[@{@"GoodsIcon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571383364&di=3aea37c3e86ada28783624a5475d27cf&imgtype=0&src=http%3A%2F%2Fimg.shushi100.com%2F2017%2F02%2F15%2F1487169103-2682884336966288.jpg",@"GoodsName":@"简易牛津布大号双人无纺布艺衣柜收纳加固加厚钢架衣橱衣柜挂衣柜",@"GoodsDesc":@"颜色:米白色;尺寸:170/85A[M 120斤内]",@"GoodsPrice":@"5",@"GoodsOldPrice":@"￥3533",@"GoodsNumber":@"4",@"SelectedType":@"未选中支付",@"Type":@"0",@"CheckAll":@"0",@"Edit":@"0",@"EditBtn":@"0"}],
                          @[@{@"GoodsIcon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571404170&di=93c67271812592cb3483b4e88d633e2c&imgtype=0&src=http%3A%2F%2Fpic16.nipic.com%2F20110911%2F3059559_103205656510_2.png",@"GoodsName":@"运动裤女长裤春秋卫裤纯棉宽松学生三道杠哈伦裤小脚运动裤男收口",@"GoodsDesc":@"颜色:米白色;尺寸:170/85A[M 120斤内]",@"GoodsPrice":@"15",@"GoodsOldPrice":@"￥125",@"GoodsNumber":@"2",@"SelectedType":@"未选中支付",@"Type":@"0",@"CheckAll":@"0",@"Edit":@"0",@"EditBtn":@"0"},@{@"GoodsIcon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571451068&di=33fa6647e96d7213edb8773522775191&imgtype=0&src=http%3A%2F%2Fd10.yihaodianimg.com%2FN10%2FM04%2FD7%2FD6%2FChEi3FYbPAqALUz-AAIG6KjEa9c87800_320x320.jpg",@"GoodsName":@"春季李易峰鹿晗纯棉同款条纹长袖T恤打底衫男女卫衣学生情侣衣服",@"GoodsDesc":@"颜色:米白色;尺寸:170/85A[M 120斤内]",@"GoodsPrice":@"13",@"GoodsOldPrice":@"￥3225",@"GoodsNumber":@"1",@"SelectedType":@"未选中支付",@"Type":@"0",@"Edit":@"0"},@{@"GoodsIcon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571466593&di=2814d8170a2e17baf9b4de1bd9b9a930&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D25193392%2C2952556956%26fm%3D214%26gp%3D0.jpg",@"GoodsName":@"gd权志龙同款卫衣长袖男女bigbang演唱会欧美潮牌衣服嘻哈街舞潮",@"GoodsDesc":@"颜色:米白色;尺寸:170/85A[M 120斤内]",@"GoodsPrice":@"25",@"GoodsOldPrice":@"￥3523",@"GoodsNumber":@"2",@"SelectedType":@"未选中支付",@"Type":@"0",@"Edit":@"0"}]];
        [self.dataSource addObjectsFromArray:data];
        
    return self.dataSource;
}

/**
 *  底部结账栏
 */
-(void)accountsView
{
    self.accountView = [[BottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight -44 - 44-SafeAreaBottomHeight, kScreenWidth, 44)];
    self.accountView.backgroundColor = [UIColor whiteColor];
    self.accountView.AllSelected = YES;
    self.accountView.delegate = self;
    [self.view addSubview:self.accountView];
    
    
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    if (section !=0) {
#warning notice ---  我只把信息放在了第一个row中  这里不想改  但是原理一样
        NSArray *arr = self.dataSource[section];
        NSDictionary *dict = arr[0];
        
        //自定义一个View
        SectionView *SectionHeadView = [[SectionView alloc]initWithFrame:tableView.tableHeaderView.bounds];
        SectionHeadView.delegate = self;
        SectionHeadView.backgroundColor = [UIColor whiteColor];
        SectionHeadView.Section = section;
        [SectionHeadView InfuseData:dict[@"CheckAll"]];
        
        return SectionHeadView;
    }else{
        return nil;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 40;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.dataSource.count == 1) {
        if(self.accountView != nil){
            [self.accountView removeFromSuperview];
            self.accountView = nil;
        }
        _CartTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight);
        return 330;
    }else{
        if(self.accountView == nil){
            [self accountsView];
        }
        _CartTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-SafeAreaBottomHeight);
        if (section == self.dataSource.count - 1) {
            return 200;
        }else{
            return 10;
        }
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.dataSource.count == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 330)];
        view.backgroundColor = colorWithRGB(0xEEEEEE);
        //  计算位置, 垂直居中, 图片默认中心偏上.
        CGFloat sW = _CartTableView.bounds.size.width;
        CGFloat iW = 74;
        CGFloat iH = 74;
        
        //  图片
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame        = CGRectMake((kScreenWidth - iW) / 2, 30, iW, iH);
        imgView.image        = [UIImage imageNamed:@"购物车"];
        
        //  文字
        UILabel *label       = [[UILabel alloc] init];
        label.font           = [UIFont systemFontOfSize:15];
        label.textColor      = colorWithRGB(0xC7C7C7);
        
        label.text           = @"购物车为空";
        label.textAlignment  = NSTextAlignmentCenter;
        label.frame          = CGRectMake(0, CGRectGetMaxY(imgView.frame) + 14, sW, label.font.lineHeight);
        //  图片
        UIImageView *leftImgView = [[UIImageView alloc] init];
        leftImgView.frame        = CGRectMake(30, CGRectGetMaxY(label.frame) + 35, (kScreenWidth-60)/3-10, 1.5);
        leftImgView.image        = [UIImage imageNamed:@"我的订单_line"];
        
        //  图片
        UIImageView *rightImgView = [[UIImageView alloc] init];
        rightImgView.frame        = CGRectMake(30+(kScreenWidth-60)/3*2+10, CGRectGetMaxY(label.frame) + 35, (kScreenWidth-60)/3-10, 1.5);
        rightImgView.image        = [UIImage imageNamed:@"我的订单_line"];
        
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame        = CGRectMake(30+(kScreenWidth-60)/3-10, CGRectGetMaxY(label.frame) + 20, (kScreenWidth-60)/3+20, 30);
        [btn setImage:[UIImage imageNamed:@"icon_mine_sqsh"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(5, ((kScreenWidth-60)/3+20-((kScreenWidth-60)/3+20-20)-10)/2+10, 5, ((kScreenWidth-60)/3+20-((kScreenWidth-60)/3+20-20)-10)/2+((kScreenWidth-60)/3+20-20)-10-10);
        [btn addTarget:self action:@selector(guanzhuAction) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"关注商品" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(5, -((kScreenWidth-60)/3+20-((kScreenWidth-60)/3+20-20)-10)/2, 5, 0);
        //  文字
        UILabel *remindLabel       = [[UILabel alloc] init];
        remindLabel.font           = [UIFont systemFontOfSize:15];
        remindLabel.textColor      = colorWithRGB(0xC7C7C7);
        remindLabel.text           = @"你还没有关注的商品";
        remindLabel.textAlignment  = NSTextAlignmentCenter;
        remindLabel.frame          = CGRectMake(0, CGRectGetMaxY(btn.frame) + 30, sW, remindLabel.font.lineHeight);
        
        UIButton *guanzhuBtn = [[UIButton alloc] init];
        guanzhuBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:87.0/255.0 blue:96.0/255.0 alpha:1.0];
        guanzhuBtn.frame        = CGRectMake((kScreenWidth-((kScreenWidth-60)/3+30))/2, CGRectGetMaxY(remindLabel.frame)+20, (kScreenWidth-60)/3+30, 30);
        guanzhuBtn.layer.cornerRadius = 5;
        guanzhuBtn.layer.masksToBounds = YES;
        [guanzhuBtn addTarget:self action:@selector(goGuanzhuAction) forControlEvents:UIControlEventTouchUpInside];
        [guanzhuBtn setTitle:@"去关注" forState:UIControlStateNormal];
        [guanzhuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        guanzhuBtn.userInteractionEnabled = YES;
        guanzhuBtn.exclusiveTouch = YES;
        guanzhuBtn.enabled = YES;
        [view addSubview:imgView];
        [view addSubview:label];
        [view addSubview:leftImgView];
        [view addSubview:rightImgView];
        [view addSubview:btn];
        [view addSubview:remindLabel];
        [view addSubview:guanzhuBtn];
        return view;
    }else{
        if (section == self.dataSource.count - 1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
            view.backgroundColor = colorWithRGB(0xEEEEEE);
            //  计算位置, 垂直居中, 图片默认中心偏上.
            CGFloat sW = _CartTableView.size.width;
            //  图片
            UIImageView *leftImgView = [[UIImageView alloc] init];
            leftImgView.frame        = CGRectMake(30, 35, (kScreenWidth-60)/3-10, 1.5);
            leftImgView.image        = [UIImage imageNamed:@"我的订单_line"];
            
            //  图片
            UIImageView *rightImgView = [[UIImageView alloc] init];
            rightImgView.frame        = CGRectMake(30+(kScreenWidth-60)/3*2+10, 35, (kScreenWidth-60)/3-10, 1.5);
            rightImgView.image        = [UIImage imageNamed:@"我的订单_line"];
            
            
            UIButton *btn = [[UIButton alloc] init];
            btn.frame        = CGRectMake(30+(kScreenWidth-60)/3-10, 20, (kScreenWidth-60)/3+20, 30);
            [btn setImage:[UIImage imageNamed:@"icon_mine_sqsh"] forState:UIControlStateNormal];
            btn.imageEdgeInsets = UIEdgeInsetsMake(5, ((kScreenWidth-60)/3+20-((kScreenWidth-60)/3+20-20)-10)/2+10, 5, ((kScreenWidth-60)/3+20-((kScreenWidth-60)/3+20-20)-10)/2+((kScreenWidth-60)/3+20-20)-10-10);
            [btn addTarget:self action:@selector(guanzhuAction) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"关注商品" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleEdgeInsets = UIEdgeInsetsMake(5, -((kScreenWidth-60)/3+20-((kScreenWidth-60)/3+20-20)-10)/2, 5, 0);
            //  文字
            UILabel *remindLabel       = [[UILabel alloc] init];
            remindLabel.font           = [UIFont systemFontOfSize:15];
            remindLabel.textColor      = colorWithRGB(0xC7C7C7);
            remindLabel.text           = @"你还没有关注的商品";
            remindLabel.textAlignment  = NSTextAlignmentCenter;
            remindLabel.frame          = CGRectMake(0, CGRectGetMaxY(btn.frame) + 30, sW, remindLabel.font.lineHeight);
            
            UIButton *guanzhuBtn = [[UIButton alloc] init];
            guanzhuBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:87.0/255.0 blue:96.0/255.0 alpha:1.0];
            guanzhuBtn.frame        = CGRectMake((kScreenWidth-((kScreenWidth-60)/3+30))/2, CGRectGetMaxY(remindLabel.frame)+20, (kScreenWidth-60)/3+30, 30);
            guanzhuBtn.layer.cornerRadius = 5;
            guanzhuBtn.layer.masksToBounds = YES;
            [guanzhuBtn addTarget:self action:@selector(goGuanzhuAction) forControlEvents:UIControlEventTouchUpInside];
            [guanzhuBtn setTitle:@"去关注" forState:UIControlStateNormal];
            [guanzhuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            guanzhuBtn.userInteractionEnabled = YES;
            guanzhuBtn.exclusiveTouch = YES;
            guanzhuBtn.enabled = YES;
            [view addSubview:leftImgView];
            [view addSubview:rightImgView];
            [view addSubview:btn];
            [view addSubview:remindLabel];
            [view addSubview:guanzhuBtn];
            return view;
        }else{
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
            view.backgroundColor = colorWithRGB(0xEEEEEE);
            return view;
        }
    }
}
//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 155;
//        return 120;
    }else{
      return 120;
    }
}
//有多少section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
//每个section有多少row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        NSArray *ListArr = self.dataSource[section];
        return ListArr.count;
    }
    
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
//        CartHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CartHeaderCellID"];
//        if (cell==nil) {
//            cell = [[CartHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CartHeaderCellID"];
//        }
//        cell.backgroundColor = [UIColor whiteColor];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setSelectBlock:^(NSInteger num) {
//            if (num == 1) {
//                AddressManageController *addressMaCtrl = [[AddressManageController alloc] init];
//                [self.navigationController pushViewController:addressMaCtrl animated:YES];
//            }else{
//
//            }
//        }];
//        return cell;
//
        CartHeaderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CartHeaderAddressCellID"];
        if (cell==nil) {
          cell = [[CartHeaderAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CartHeaderAddressCellID"];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSelectBlock:^(NSInteger num) {
            if (num == 1) {
                AddressManageController *addressMaCtrl = [[AddressManageController alloc] init];
                addressMaCtrl.title = @"选择地址";
                [self.navigationController pushViewController:addressMaCtrl animated:YES];
            }else{

            }
        }];
        return cell;
    }else{

            NSArray *ListArr = self.dataSource[indexPath.section];
            NSDictionary *dict = ListArr[indexPath.row];
            
            if ([dict[@"Edit"] isEqualToString:@"0"]) {
                CompileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompileCellID"];
                
                if (cell==nil) {
                    cell = [[CompileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CompileCellID"];
                }
                
                //            cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor]],[MGSwipeButton buttonWithTitle:@"更多" backgroundColor:[UIColor grayColor]]];
                cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor]]];
                [cell withData:dict];
                
                cell.delegate = self;
                cell.SelectedDelegate = self;
                
                cell.allowsMultipleSwipe = allowMultipleSwipe;
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                return nil;
            }
        }
       
    
}
/**
 *  侧滑后的动作  删除   +   更多
 */
-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    NSIndexPath *indexPath = [_CartTableView indexPathForCell:cell];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
    
    NSLog(@"Delegate: button tapped, %@ position, index %d, from Expansion: %@",
          direction == MGSwipeDirectionLeftToRight ? @"left" : @"right", (int)index, fromExpansion ? @"YES" : @"NO");
    //删除
    if (index == 0) {
        
        [Helper ShowAlertWithTitle:@"是否删除该商品" prompt:@"" cancel:@"取消" defaultLb:@"确定" ViewController:self alertOkClick:^{
            
            [arr removeObjectAtIndex:indexPath.row];
            if (arr.count > 0) {
                [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
                
                [self postCenter];
                
                
                
                //                [_CartTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
                
                NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
                NSInteger index = 0; //判读section下的row是否全部勾选
                for (NSInteger i = 0; i < arr.count; i++) {
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[i]];
                    if ([dict[@"Type"] isEqualToString:@"1"]) {
                        index ++;
                    }
                }
                
                //如果全部row的状态都为选中状态   则改变section的按钮状态
                if (index == arr.count) {
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
                    [dict setValue:@"1" forKey:@"CheckAll"];
                    [arr replaceObjectAtIndex:0 withObject:dict];
                }
                
                [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
                //                //一个section刷新
//                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
//                [_CartTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                _CartTableView.backgroundView = nil;
                [_CartTableView reloadData];
            }else{
                [self.dataSource removeObjectAtIndex:indexPath.section];
                
                [self postCenter];
                
//                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
//                [_CartTableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                _CartTableView.backgroundView = nil;
                [_CartTableView reloadData];
            }
            
            
            
        } alertNoClick:^{
            
        }];
        
    }
    
    return YES;
}
/**
 *  选中商品
 */
-(void)SelectedConfirmCell:(UITableViewCell *)cell
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [_CartTableView indexPathForCell:cell];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[indexPath.row]];
        [dict setValue:@"已选中" forKey:@"SelectedType"];
        [dict setValue:@"1" forKey:@"Type"];
        [arr replaceObjectAtIndex:indexPath.row withObject:dict];
        
        [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
        
        [self didChangeValueForSectionAllRow:indexPath.section];
        [_CartTableView reloadData];
    });
    
}
/**
 *  取消选中商品
 */
-(void)SelectedCancelCell:(UITableViewCell *)cell
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [_CartTableView indexPathForCell:cell];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[indexPath.row]];
        [dict setValue:@"未选中支付" forKey:@"SelectedType"];
        [dict setValue:@"0" forKey:@"Type"];
        [arr replaceObjectAtIndex:indexPath.row withObject:dict];
        
        [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
        
        //判断是否把section的全选按钮取消
        [self didChangeValueForSectionRow:indexPath.section];
        [_CartTableView reloadData];
    });
    
}

/**
 *  取消选中商品
 */
-(void)SelectedRemarkCell:(CompileCell *)cell
{
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"修改昵称" message: nil preferredStyle:UIAlertControllerStyleAlert];
    [alertCtrl  addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    
         textField.text = cell.RemarksLabel.text;
         textField.borderStyle = UITextBorderStyleNone;
         textField.textColor = [UIColor blackColor];
         textField.clearButtonMode = UITextFieldViewModeAlways;
    }];
    [alertCtrl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alertCtrl  addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         NSArray * textfields = alertCtrl.textFields;
         UITextField * namefield = textfields[0];
        cell.RemarksLabel.text = namefield.text;
    }]];
    [self presentViewController:alertCtrl animated:YES completion:nil];
//    NSIndexPath *indexPath = [_CartTableView indexPathForCell:cell];
//    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[indexPath.row]];
//    [dict setValue:@"未选中支付" forKey:@"SelectedType"];
//    [dict setValue:@"0" forKey:@"Type"];
//    [arr replaceObjectAtIndex:indexPath.row withObject:dict];
//
//    [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
//
//    //判断是否把section的全选按钮取消
//    [self didChangeValueForSectionRow:indexPath.section];
}


/**
 *  选中了哪一section
 */
-(void)SelectedSection:(NSInteger)section
{
    //修改section的选中状态
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[section]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
    [dict setValue:@"1" forKey:@"CheckAll"];
    [arr replaceObjectAtIndex:0 withObject:dict];
    
    [self.dataSource replaceObjectAtIndex:section withObject:arr];
    
    
    [self didChangeValueForSection:section SectionSelectedTyep:YES];
    [_CartTableView reloadData];
}
/**
 *  取消选中哪个section
 */
-(void)SelectedSectionCancel:(NSInteger)section
{
    //修改section的选中状态
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[section]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
    [dict setValue:@"0" forKey:@"CheckAll"];
    [arr replaceObjectAtIndex:0 withObject:dict];
    
    [self.dataSource replaceObjectAtIndex:section withObject:arr];
    
    [self didChangeValueForSection:section SectionSelectedTyep:NO];
    [_CartTableView reloadData];
    
}
/******************************************
 
 1.根据状态修改section中所有row的选中状态
 
 2.
 
 *********************************************************/
-(void)didChangeValueForSection:(NSInteger)section SectionSelectedTyep:(BOOL)Check
{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[section]];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[i]];
        if (Check) {
            [dict setValue:@"已选中" forKey:@"SelectedType"];
            [dict setValue:@"1" forKey:@"Type"];
        }else{
            [dict setValue:@"未选中支付" forKey:@"SelectedType"];
            [dict setValue:@"0" forKey:@"Type"];
        }
        
        [arr replaceObjectAtIndex:i withObject:dict];
    }
    [self.dataSource replaceObjectAtIndex:section withObject:arr];
    
    
    //判断section按钮是选中还是取消  再判断结账栏的状态
    if (Check) {
        //根据头部section的选中状态  判断结账栏的状态
        BOOL sectionChose = YES;
        for (NSInteger i = 0; i < self.dataSource.count; i++) {
            
            NSArray *arr = self.dataSource[i];
            if (arr.count != 0) {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
                if ([dict[@"CheckAll"] isEqualToString:@"1"]) {
                    sectionChose = YES;
                }else{
                    sectionChose = NO;
                    
                    break;
                }
            }
            
        }
        
        if (sectionChose == YES) {
            [self.accountView init:@{@"SelectIcon":@"已选中",@"SelectedType":@"YES"} GoodsData:self.dataSource];
        }
        
    }else{
        [self.accountView init:@{@"SelectIcon":@"未选中支付",@"SelectedType":@"NO"} GoodsData:self.dataSource];
    }
    
    [self postCenter];
    
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [_CartTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

/********************************************
 
 判断是否需要取消section的全选状态
 
 *******************************************************/

-(void)didChangeValueForSectionRow:(NSInteger)section
{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[section]];
    for (NSInteger i = 0; i < arr.count; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
        if ([dict[@"CheckAll"] isEqualToString:@"1"]) {
            [dict setValue:@"0" forKey:@"CheckAll"];
            [arr replaceObjectAtIndex:0 withObject:dict];
            
            [self.accountView init:@{@"SelectIcon":@"未选中支付",@"SelectedType":@"NO"} GoodsData:self.dataSource];
        }
    }
    
    [self.dataSource replaceObjectAtIndex:section withObject:arr];
    
    [self postCenter];
    
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [_CartTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

/****************************************
 
 每次选中单个row时  判断是否section内的row全部选中 全部选中后改变section的状态按钮
 
 ***********************************************************/

-(void)didChangeValueForSectionAllRow:(NSInteger)section
{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[section]];
    NSInteger index = 0; //判读section下的row是否全部勾选
    for (NSInteger i = 0; i < arr.count; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[i]];
        if ([dict[@"Type"] isEqualToString:@"1"]) {
            index ++;
        }
    }
    
    //如果全部row的状态都为选中状态   则改变section的按钮状态
    if (index == arr.count) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
        [dict setValue:@"1" forKey:@"CheckAll"];
        [arr replaceObjectAtIndex:0 withObject:dict];
    }
    
    [self.dataSource replaceObjectAtIndex:section withObject:arr];
    
    //根据头部section的选中状态  判断结账栏的状态
    BOOL sectionChose = YES;
    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        NSArray *arr = self.dataSource[i];
        if (arr.count != 0) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
            if ([dict[@"CheckAll"] isEqualToString:@"1"]) {
                sectionChose = YES;
            }else{
                sectionChose = NO;
                
                break;
            }
        }
       
    }
    
    if (sectionChose == YES) {
        [self.accountView init:@{@"SelectIcon":@"已选中",@"SelectedType":@"YES"} GoodsData:self.dataSource];
    }
    
    
    [self postCenter];
    
    
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [_CartTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

/****************************************
 
 底部结账按钮
 
 ***********************************************************/

- (void)BalanceSelectedGoods
{
    BuyGoodsListController *buyCtrl = [[BuyGoodsListController alloc] init];
    [self.navigationController pushViewController:buyCtrl animated:YES];
}

-(void)DidSelectedAllGoods
{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < self.dataSource.count; i ++) {
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[i]];
            for (NSInteger j = 0; j < arr.count; j ++) {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[j]];
                if (j == 0) {
                    [dict setValue:@"1" forKey:@"CheckAll"];
                    [arr replaceObjectAtIndex:0 withObject:dict];
                }
                [dict setValue:@"已选中" forKey:@"SelectedType"];
                [dict setValue:@"1" forKey:@"Type"];
                [arr replaceObjectAtIndex:j withObject:dict];
            }
            [self.dataSource replaceObjectAtIndex:i withObject:arr];
        }
        [self postCenter];
        
        [_CartTableView reloadData];
    });
   
}

-(void)NoDidSelectedAllGoods
{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < self.dataSource.count; i ++) {
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[i]];
            for (NSInteger j = 0; j < arr.count; j ++) {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[j]];
                if (j == 0) {
                    [dict setValue:@"0" forKey:@"CheckAll"];
                    [arr replaceObjectAtIndex:0 withObject:dict];
                }
                [dict setValue:@"未选中支付" forKey:@"SelectedType"];
                [dict setValue:@"0" forKey:@"Type"];
                [arr replaceObjectAtIndex:j withObject:dict];
            }
            [self.dataSource replaceObjectAtIndex:i withObject:arr];
        }
        [self postCenter];
        
        [_CartTableView reloadData];
    });
    
}

/**
 *  刷新结账栏金额
 */
-(void)postCenter
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BottomRefresh" object:nil userInfo:@{@"Data":self.dataSource}];
}

/**
 *  编辑商品
 */
-(void)SelectedEdit:(NSInteger)section
{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[section]];
    if ([arr[0][@"EditBtn"] isEqualToString:@"0"]) {
        for (NSInteger i = 0; i < arr.count; i ++) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[i]];
            
            [dict setValue:@"1" forKey:@"Edit"];
            [dict setValue:@"1" forKey:@"EditBtn"];
            
            [arr replaceObjectAtIndex:i withObject:dict];
        }
        
    }else{
        for (NSInteger i = 0; i < arr.count; i ++) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[i]];
            
            [dict setValue:@"0" forKey:@"Edit"];
            [dict setValue:@"0" forKey:@"EditBtn"];
            
            [arr replaceObjectAtIndex:i withObject:dict];
        }
    }
    
    [self.dataSource replaceObjectAtIndex:section withObject:arr];
    
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [_CartTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSLog(@"%ld",section);
}

/**
 *  修改商品数量
 */
-(void)ChangeGoodsNumberCell:(UITableViewCell *)cell Number:(NSInteger)num
{
    NSIndexPath *indexPath = [_CartTableView indexPathForCell:cell];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[indexPath.row]];
    [dict setValue:[NSString stringWithFormat:@"%ld",num] forKey:@"GoodsNumber"];
    [arr replaceObjectAtIndex:indexPath.row withObject:dict];
    
    [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
    
    [self postCenter];
    
    //一个cell刷新
    NSIndexPath *indexPaths=[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    [_CartTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPaths,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}
/**
 *  删除该商品
 */
-(void)DeleteTheGoodsCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [_CartTableView indexPathForCell:cell];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
    
    [Helper ShowAlertWithTitle:@"是否删除该商品" prompt:@"" cancel:@"取消" defaultLb:@"确定" ViewController:self alertOkClick:^{
        
        [arr removeObjectAtIndex:indexPath.row];
        
        if (arr.count > 0) {
            
            [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
            
            [self postCenter];
            
            //                //一个section刷新
            //                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
            //                [_CartTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [_CartTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }else{
            [self.dataSource removeObjectAtIndex:indexPath.section];
            
            [self postCenter];
            
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
            [_CartTableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        
        
    } alertNoClick:^{
        
    }];
    
}

- (void)goGuanzhuAction
{
   self.tabBarController.selectedIndex = 0;
}
- (void)guanzhuAction
{
    
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
