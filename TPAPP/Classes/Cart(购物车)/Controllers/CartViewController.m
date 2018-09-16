
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
#import "DeclareAbnormalAlertView.h"
#import "GoodsCartModel.h"
#import "SimilarProductModel.h"
#import "MMImageListView.h"
#import "MMImagePreviewView.h"
#import "imagesListModel.h"
#import "DeleteGoodsListController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#define Image(name) [UIImage imageNamed:name]
@interface CartViewController ()<UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate,ShoppingSelectedDelegate,SelectedSectionDelegate,BottomViewDelegate,DeclareAbnormalAlertViewDelegate,DeclareAbnormalAlertViewRemindDelegate>
{
    BOOL allowMultipleSwipe;
    BOOL isPreview;
}

@property (nonatomic, strong)UITableView *CartTableView;
@property (nonatomic, strong)BottomView *accountView;
@property (nonatomic, strong)UIView *remindView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)GoodsCartModel *goodsCartModel;
@end

@implementation CartViewController
{
    NSMutableArray * timeArr;
    NSArray  * dateSectionArr;
    MMImagePreviewView *_previewView;
    MMImageView *selectImage;
    int _goodsNum;
    NSString *_goodsPrice;
}
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
    
    
    self.CartTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -SafeAreaBottomHeight) style:UITableViewStyleGrouped];
    self.CartTableView.estimatedRowHeight = 0;
    self.CartTableView.delegate = self;
    self.CartTableView.dataSource = self;
    self.CartTableView.backgroundColor = colorWithRGB(0xEEEEEE);
    self.CartTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.CartTableView];
    self.CartTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.CartTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
//    [self.CartTableView.mj_header beginRefreshing];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (isPreview) {
        isPreview = NO;
    }else{
        if ([self.CartTableView.mj_header isRefreshing]) {
            [self.CartTableView.mj_header endRefreshing];
        }
        //进入刷新状态
        [self.CartTableView.mj_header beginRefreshing];
    }
    
    
}
#pragma mark - 下拉刷新数据
- (void)loadNewTopic
{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    LYAccount *lyAccount = [LYAccount shareAccount];
    [dataDict setValue:lyAccount.id forKey:@"userId"];
    [dataDict setValue:@"0" forKey:@"status"];
    [LYTools postBossDemoWithUrl:cartList param:dataDict success:^(NSDictionary *dict) {
        [self.CartTableView.mj_header endRefreshing];
        [self.dataSource removeAllObjects];
        [self.dataSource addObject:@[]];
        NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            self.goodsCartModel = [GoodsCartModel mj_objectWithKeyValues:dict[@"data"]];
            NSMutableArray *allTimeArr = [NSMutableArray array];
            for (NSDictionary *dic in dict[@"data"][@"cartDetails"]) {
                //1.取出所有的商户id
                [allTimeArr addObject:dic[@"productForm"][@"merchantId"]];
            }
            dateSectionArr = [self arrayWithMemberIsOnly:allTimeArr];
            for (NSString *nowTim in dateSectionArr) {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (NSDictionary *ordersDicTwo in dict[@"data"][@"cartDetails"]) {
                    NSString *twoTim = ordersDicTwo[@"productForm"][@"merchantId"];
                    if([twoTim isEqualToString:nowTim]){
                        //2.将每个字典保存在模型数组中
                        CartDetailsModel *model = [CartDetailsModel mj_objectWithKeyValues:ordersDicTwo];
                        model.SelectedType = @"已选中";
                        model.Type = @"1";
                        model.CheckAll = @"1";
                        model.Edit= @"0";
                        model.EditBtn = @"0";
                        SimilarProductModel *sModel = [SimilarProductModel mj_objectWithKeyValues:ordersDicTwo[@"productForm"]];
                        model.productForm = sModel;
                        [arr addObject:model];
                    }
                }

                [self.dataSource addObject:arr];
            }
            [self.CartTableView reloadData];
        }else if([dict[@"code"]longValue] == 500){
            [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
        }
    } fail:^(NSError *error) {
        [self.dataSource removeAllObjects];
        [SVProgressHUD doAnythingFailedWithHUDMessage:@"[Error]\n似乎已断开与互联网的连接" withDuration:1.5];
        [self.CartTableView.mj_header endRefreshing];
        [self.dataSource addObject:@[]];
        [self.CartTableView reloadData];
    }];
}
//去除数组中重复的
-(NSArray *)arrayWithMemberIsOnly:(NSArray *)array
{
    NSMutableArray *categoryArray =[[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [array count]; i++) {
        @autoreleasepool {
            if ([categoryArray containsObject:[array objectAtIndex:i]]==NO) {
                [categoryArray addObject:[array objectAtIndex:i]];
            }
        }
    }
    return categoryArray;
}

//-( NSMutableArray *)CartData
//{
//
//    [self.dataSource removeAllObjects];
//
//        NSArray *data = @[@[],@[@{@"GoodsIcon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571326962&di=8f502445613592dc9dd19dde4032c6ec&imgtype=0&src=http%3A%2F%2Fimg009.hc360.cn%2Fm6%2FM0A%2F98%2F05%2FwKhQoVVat96Ee_nyAAAAANCKIXo389.jpg",@"GoodsName":@"秋冬季毛呢显瘦直筒西装裤韩版高腰哈伦裤女小脚裤休闲裤宽松裤子",@"GoodsDesc":@"颜色:米白色;尺寸:170/85A[M 120斤内]",@"GoodsPrice":@"15",@"GoodsOldPrice":@"￥235",@"GoodsNumber":@"3",@"SelectedType":@"未选中支付",@"Type":@"0",@"CheckAll":@"0",@"Edit":@"0",@"EditBtn":@"0"},@{@"GoodsIcon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571328758&di=0f9dafd5ef73a3eff0a125ae310174ac&imgtype=0&src=http%3A%2F%2Fpic36.nipic.com%2F20131205%2F12477111_155227608129_2.jpg",@"GoodsName":@"秋冬加绒卫裤2016韩版松紧腰系带金丝绒哈伦裤男女情侣休闲裤保暖",@"GoodsDesc":@"颜色:米白色;尺寸:170/85A[M 120斤内]",@"GoodsPrice":@"7",@"GoodsOldPrice":@"￥353",@"GoodsNumber":@"2",@"SelectedType":@"未选中支付",@"Type":@"0",@"Edit":@"0"}],
//                          @[@{@"GoodsIcon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571383364&di=3aea37c3e86ada28783624a5475d27cf&imgtype=0&src=http%3A%2F%2Fimg.shushi100.com%2F2017%2F02%2F15%2F1487169103-2682884336966288.jpg",@"GoodsName":@"简易牛津布大号双人无纺布艺衣柜收纳加固加厚钢架衣橱衣柜挂衣柜",@"GoodsDesc":@"颜色:米白色;尺寸:170/85A[M 120斤内]",@"GoodsPrice":@"5",@"GoodsOldPrice":@"￥3533",@"GoodsNumber":@"4",@"SelectedType":@"未选中支付",@"Type":@"0",@"CheckAll":@"0",@"Edit":@"0",@"EditBtn":@"0"}],
//                          @[@{@"GoodsIcon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571404170&di=93c67271812592cb3483b4e88d633e2c&imgtype=0&src=http%3A%2F%2Fpic16.nipic.com%2F20110911%2F3059559_103205656510_2.png",@"GoodsName":@"运动裤女长裤春秋卫裤纯棉宽松学生三道杠哈伦裤小脚运动裤男收口",@"GoodsDesc":@"颜色:米白色;尺寸:170/85A[M 120斤内]",@"GoodsPrice":@"15",@"GoodsOldPrice":@"￥125",@"GoodsNumber":@"2",@"SelectedType":@"未选中支付",@"Type":@"0",@"CheckAll":@"0",@"Edit":@"0",@"EditBtn":@"0"},@{@"GoodsIcon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571451068&di=33fa6647e96d7213edb8773522775191&imgtype=0&src=http%3A%2F%2Fd10.yihaodianimg.com%2FN10%2FM04%2FD7%2FD6%2FChEi3FYbPAqALUz-AAIG6KjEa9c87800_320x320.jpg",@"GoodsName":@"春季李易峰鹿晗纯棉同款条纹长袖T恤打底衫男女卫衣学生情侣衣服",@"GoodsDesc":@"颜色:米白色;尺寸:170/85A[M 120斤内]",@"GoodsPrice":@"13",@"GoodsOldPrice":@"￥3225",@"GoodsNumber":@"1",@"SelectedType":@"未选中支付",@"Type":@"0",@"Edit":@"0"},@{@"GoodsIcon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571466593&di=2814d8170a2e17baf9b4de1bd9b9a930&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D25193392%2C2952556956%26fm%3D214%26gp%3D0.jpg",@"GoodsName":@"gd权志龙同款卫衣长袖男女bigbang演唱会欧美潮牌衣服嘻哈街舞潮",@"GoodsDesc":@"颜色:米白色;尺寸:170/85A[M 120斤内]",@"GoodsPrice":@"25",@"GoodsOldPrice":@"￥3523",@"GoodsNumber":@"2",@"SelectedType":@"未选中支付",@"Type":@"0",@"Edit":@"0"}]];
//        [self.dataSource addObjectsFromArray:data];
//
//    return self.dataSource;
//}

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
//        NSDictionary *dict = arr[0];
        CartDetailsModel *model = arr[0];
        //自定义一个View
        SectionView *SectionHeadView = [[SectionView alloc]initWithFrame:tableView.tableHeaderView.bounds];
        SectionHeadView.delegate = self;
        SectionHeadView.backgroundColor = [UIColor whiteColor];
        SectionHeadView.Section = section;
        [SectionHeadView InfuseData:model.CheckAll];
        [SectionHeadView InfMerchantNameData:model.productForm.merchantName];
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
        self.CartTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight);
        return 330;
    }else{
        if(self.accountView == nil){
            [self accountsView];
            
        }
        [self postCenter];
        self.CartTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-SafeAreaBottomHeight);
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
        CGFloat sW = self.CartTableView.bounds.size.width;
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
            CGFloat sW = self.CartTableView.size.width;
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
        LYAccount *lyAccount = [LYAccount shareAccount];
        AddressModel *addressModel = [AddressModel mj_objectWithKeyValues:lyAccount.defaultAddress];
//        DefaultAddressMessage *addressMes = [DefaultAddressMessage shareDefaultAddressMessage];
        if (addressModel.id.length == 0) {
            return 100;
        }else{
          return 155;
        }
        
//        return 120;
    }else{
      return 160;
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
//        NSArray *ListArr = self.dataSource[section];
//        return 1;
    }
    
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        CartHeaderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CartHeaderAddressCellID"];
        if (cell==nil) {
          cell = [[CartHeaderAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CartHeaderAddressCellID"];
        }
        cell.backgroundColor = [UIColor whiteColor];
        [cell withData:[LYAccount shareAccount]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSelectButtonBlock:^(NSInteger num) {
            if (num == 1) {
                AddressManageController *addressMaCtrl = [[AddressManageController alloc] init];
                addressMaCtrl.title = @"选择地址";
                addressMaCtrl.isCartCtrlType = YES;
                [self.navigationController pushViewController:addressMaCtrl animated:YES];
            }else{
                DeleteGoodsListController *deleteGoodsCtrl = [[DeleteGoodsListController alloc] init];
                deleteGoodsCtrl.title = @"回收清单";
                [self.navigationController pushViewController:deleteGoodsCtrl animated:YES];
                
            }
        }];
        return cell;
    }else{

            NSArray *ListArr = self.dataSource[indexPath.section];
//            NSDictionary *dict = ListArr[indexPath.row];
            CartDetailsModel *model = ListArr[indexPath.row];
            if ([model.Edit isEqualToString:@"0"]) {
                CompileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompileCellID"];
                if (cell==nil) {
                    cell = [[CompileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CompileCellID"];
                }
                //            cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor]],[MGSwipeButton buttonWithTitle:@"更多" backgroundColor:[UIColor grayColor]]];
                cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor]]];
                [cell withData:model];
                
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) {
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
        CartDetailsModel *model = arr[indexPath.row];
        if ([model.Type isEqualToString:@"1"]) {
            model.SelectedType = @"未选中支付";
            model.Type = @"0";
            [arr replaceObjectAtIndex:indexPath.row withObject:model];
            [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
            //判断是否把section的全选按钮取消
            [self didChangeValueForSectionRow:indexPath.section];
        }else{
            model.SelectedType = @"已选中";
            model.Type = @"1";
            [arr replaceObjectAtIndex:indexPath.row withObject:model];
            
            [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
            
            [self didChangeValueForSectionAllRow:indexPath.section];
        }
    }
   

   
}
/**
 *  侧滑后的动作  删除   +   更多
 */
-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    NSIndexPath *indexPath = [self.CartTableView indexPathForCell:cell];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
    
    NSLog(@"Delegate: button tapped, %@ position, index %d, from Expansion: %@",
          direction == MGSwipeDirectionLeftToRight ? @"left" : @"right", (int)index, fromExpansion ? @"YES" : @"NO");
    //删除
    if (index == 0) {
        [Helper ShowAlertWithTitle:@"是否删除该商品" prompt:@"" cancel:@"取消" defaultLb:@"确定" ViewController:self alertOkClick:^{
            NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
            CartDetailsModel *model = arr[indexPath.row];
            [dict1 setValue:model.id forKey:@"cartDetailId"];
            [LYTools postBossDemoWithUrl:cartDelProduct param:dict1 success:^(NSDictionary *dict) {
//                NSLog(@"%@",dict);
                NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
                if ([respCode isEqualToString:@"00000"]) {
                    [arr removeObjectAtIndex:indexPath.row];
                    if (arr.count > 0) {
                        [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
                        [self postCenter];
                        //[self.CartTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
                        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
                        NSInteger index = 0; //判读section下的row是否全部勾选
                        for (NSInteger i = 0; i < arr.count; i++) {
                            CartDetailsModel *model = arr[i];
                            //NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[i]];
                            if ([model.Type isEqualToString:@"1"]) {
                                index ++;
                            }
                        }
                        //如果全部row的状态都为选中状态 则改变section的按钮状态
                        if (index == arr.count) {
                            CartDetailsModel *model = arr[0];
                            //NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
                            //[dict setValue:@"1" forKey:@"CheckAll"];
                            model.CheckAll = @"1";
                            [arr replaceObjectAtIndex:0 withObject:model];
                        }
                        [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
                        //一个section刷新
                        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
                        [self.CartTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//                        self.CartTableView.backgroundView = nil;
//                        [self.CartTableView reloadData];
                    }else{
                        [self.dataSource removeObjectAtIndex:indexPath.section];
                        [self postCenter];
//                        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
//                        [self.CartTableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//                        self.CartTableView.backgroundView = nil;
                        [self.CartTableView reloadData];
                    }
                }else if([dict[@"code"]longValue] == 500){
                    [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                }
            } fail:^(NSError *error) {

            }];
            
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
//    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [self.CartTableView indexPathForCell:cell];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[indexPath.row]];
        CartDetailsModel *model = arr[indexPath.row];
        model.SelectedType = @"已选中";
        model.Type = @"1";
//        [dict setValue:@"已选中" forKey:@"SelectedType"];
//        [dict setValue:@"1" forKey:@"Type"];
        [arr replaceObjectAtIndex:indexPath.row withObject:model];
        
        [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
        
        [self didChangeValueForSectionAllRow:indexPath.section];
//        [self.CartTableView reloadData];
//    });
    
}
/**
 *  取消选中商品
 */
-(void)SelectedCancelCell:(UITableViewCell *)cell
{
//    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [self.CartTableView indexPathForCell:cell];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[indexPath.row]];
        CartDetailsModel *model = arr[indexPath.row];
        model.SelectedType = @"未选中支付";
        model.Type = @"0";
//        [dict setValue:@"未选中支付" forKey:@"SelectedType"];
//        [dict setValue:@"0" forKey:@"Type"];
        [arr replaceObjectAtIndex:indexPath.row withObject:model];
        
        [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
        //判断是否把section的全选按钮取消
        [self didChangeValueForSectionRow:indexPath.section];
//        [self.CartTableView reloadData];
//    });
    
}

/**
 *  添加备注
 */
-(void)SelectedRemarkCell:(CompileCell *)cell
{
    DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"添加商品备注" message:@"请输入备注信息" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comCell:cell isAddGood:NO spesmodel:nil];
    [alertView show];
}
/**
 *  查看商品图片列表
 */
-(void)SelectedLookImageListCell:(CompileCell *)cell
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        _previewView = [[MMImagePreviewView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//        // 更新视图数据
//        NSInteger count = cell.detailModel.productForm.imagesList.count;
//        _previewView.pageNum = count;
//        _previewView.scrollView.contentSize = CGSizeMake(_previewView.width*count, _previewView.height);
//        [self singleTapSmallViewCallback:cell];
//    });
    
    
    // 图片游览器
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 数据源/delegate
    NSMutableArray * ZLPhotosArry = [NSMutableArray array];
    int imagecount = (int)cell.detailModel.productForm.imagesList.count;
    for (int i = 0; i<imagecount; i++) {
        imagesListModel*model = cell.detailModel.productForm.imagesList[i];
        ZLPhotoPickerBrowserPhoto *photo1 = [[ZLPhotoPickerBrowserPhoto alloc] init];
        photo1.photoURL = [NSURL URLWithString:model.imgUrl];;
        [ZLPhotosArry addObject:photo1];
    }
    // 数据源可以不传，传photos数组 photos<里面是ZLPhotoPickerBrowserPhoto>
    pickerBrowser.photos = ZLPhotosArry;
    //    pickerBrowser.dataSource = self;
    // 是否可以删除照片
    //    pickerBrowser.editing = YES;
    // 当前选中的值
    pickerBrowser.currentIndex = 0;
    pickerBrowser.status = UIViewAnimationAnimationStatusZoom;
    // 展示控制器
    [pickerBrowser showPickerVc:[UIApplication sharedApplication].keyWindow.rootViewController];
    [pickerBrowser setSelectImagesClick:^(NSString *selectString) {
        isPreview = YES;
    }];
}

/**
 *  选中了哪一section
 */
-(void)SelectedSection:(NSInteger)section
{
    //修改section的选中状态
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[section]];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
    CartDetailsModel *model = arr[0];
    model.CheckAll = @"1";
//    [dict setValue:@"1" forKey:@"CheckAll"];
    [arr replaceObjectAtIndex:0 withObject:model];
    
    [self.dataSource replaceObjectAtIndex:section withObject:arr];
    
    
    [self didChangeValueForSection:section SectionSelectedTyep:YES];
//    [self.CartTableView reloadData];
}
- (void)SelectedShop:(NSInteger)section
{
    
}

/**
 *  取消选中哪个section
 */
-(void)SelectedSectionCancel:(NSInteger)section
{
    //修改section的选中状态
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[section]];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
    CartDetailsModel *model = arr[0];
    model.CheckAll = @"0";
//    [dict setValue:@"0" forKey:@"CheckAll"];
    [arr replaceObjectAtIndex:0 withObject:model];
    
    [self.dataSource replaceObjectAtIndex:section withObject:arr];
    
    [self didChangeValueForSection:section SectionSelectedTyep:NO];
//    [self.CartTableView reloadData];
    
}
/******************************************
 
 1.根据状态修改section中所有row的选中状态
 
 2.
 
 *********************************************************/
-(void)didChangeValueForSection:(NSInteger)section SectionSelectedTyep:(BOOL)Check
{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[section]];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        CartDetailsModel *model = arr[i];
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[i]];
        if (Check) {
            model.SelectedType = @"已选中";
            model.Type = @"1";
//            [dict setValue:@"已选中" forKey:@"SelectedType"];
//            [dict setValue:@"1" forKey:@"Type"];
        }else{
            model.SelectedType = @"未选中支付";
            model.Type = @"0";
//            [dict setValue:@"未选中支付" forKey:@"SelectedType"];
//            [dict setValue:@"0" forKey:@"Type"];
        }
        
        [arr replaceObjectAtIndex:i withObject:model];
    }
    [self.dataSource replaceObjectAtIndex:section withObject:arr];
    
    
    //判断section按钮是选中还是取消  再判断结账栏的状态
    if (Check) {
        //根据头部section的选中状态  判断结账栏的状态
        BOOL sectionChose = YES;
        for (NSInteger i = 0; i < self.dataSource.count; i++) {
            
            NSArray *arr = self.dataSource[i];
            if (arr.count != 0) {
                CartDetailsModel *model = arr[0];
//                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
                if ([model.CheckAll isEqualToString:@"1"]) {
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
    [self.CartTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

/********************************************
 
 判断是否需要取消section的全选状态
 
 *******************************************************/

-(void)didChangeValueForSectionRow:(NSInteger)section
{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[section]];
    for (NSInteger i = 0; i < arr.count; i++) {
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
        CartDetailsModel *model = arr[0];
        
        if ([model.CheckAll isEqualToString:@"1"]) {
            model.CheckAll = @"0";
//            [dict setValue:@"0" forKey:@"CheckAll"];
            [arr replaceObjectAtIndex:0 withObject:model];
            
            [self.accountView init:@{@"SelectIcon":@"未选中支付",@"SelectedType":@"NO"} GoodsData:self.dataSource];
        }
    }
    
    [self.dataSource replaceObjectAtIndex:section withObject:arr];
    
    [self postCenter];
    
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [self.CartTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

/****************************************
 
 每次选中单个row时  判断是否section内的row全部选中 全部选中后改变section的状态按钮
 
 ***********************************************************/

-(void)didChangeValueForSectionAllRow:(NSInteger)section
{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[section]];
    NSInteger index = 0; //判读section下的row是否全部勾选
    for (NSInteger i = 0; i < arr.count; i++) {
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[i]];
        CartDetailsModel *model = arr[i];

        if ([model.Type isEqualToString:@"1"]) {
            index ++;
        }
    }
    
    //如果全部row的状态都为选中状态   则改变section的按钮状态
    if (index == arr.count) {
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
        CartDetailsModel *model = arr[0];
        model.CheckAll = @"1";
//        [dict setValue:@"1" forKey:@"CheckAll"];
        [arr replaceObjectAtIndex:0 withObject:model];
    }
    
    [self.dataSource replaceObjectAtIndex:section withObject:arr];
    
    //根据头部section的选中状态  判断结账栏的状态
    BOOL sectionChose = YES;
    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        NSArray *arr = self.dataSource[i];
        if (arr.count != 0) {
//            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[0]];
            CartDetailsModel *model = arr[0];
            if ([model.CheckAll isEqualToString:@"1"]) {
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
    [self.CartTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

/****************************************
 
 底部结账按钮
 
 ***********************************************************/

- (void)BalanceSelectedGoods:(NSMutableArray *)arr goodsNum:(int)goodsNum goodsPrice:(NSString *)goodsPrice
{
    LYAccount *lyAccount = [LYAccount shareAccount];
    if (lyAccount.defaultAddress == nil) {
        [SVProgressHUD showInfoWithStatus:@"请先添加收货地址"];
    }else{
        _goodsNum = goodsNum;
        _goodsPrice = goodsPrice;
        DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"立即去支付?" message:[NSString stringWithFormat:@"一共%d件 结算金额%@元",goodsNum,goodsPrice] remind:@"(单场活动最多可取消5件商品！)" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"去支付" comGoodList:arr];
        [alertView show];
        
        
    }
    
}
-(void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex comGoodList:(NSMutableArray *)goodListArr
{
    if (buttonIndex == AlertButtonLeft) {
        
    }else{
        NSString *addressId = nil;
        DefaultAddressMessage *addressMess = [DefaultAddressMessage shareDefaultAddressMessage];
        if ([addressMess.id length] == 0) {
            addressId = [[AddressModel mj_objectWithKeyValues:[LYAccount shareAccount].defaultAddress] id];
        }else{
            addressId = addressMess.id;
        }
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (int i =  0; i < goodListArr.count; i++) {
            NSArray *arr = goodListArr[i];
            CartDetailsModel *model = arr[0];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:addressId forKey:@"addressId"];
            [dict setValue:model.productForm.merchantId forKey:@"merchantId"];
            [dict setValue:model.productForm.merchantUrL forKey:@"merchantLogo"];
            [dict setValue:model.productForm.merchantName forKey:@"merchantName"];
            [dict setValue:[[LYAccount shareAccount] id]  forKey:@"userId"];
            NSMutableArray *arr1 = [NSMutableArray array];
            for (NSInteger j = 0 ; j < arr.count; j ++) {
                CartDetailsModel *detailModel = arr[j];
                NSMutableDictionary *goodDict = [NSMutableDictionary dictionary];
                [goodDict setValue:@([detailModel.productForm.discountAmount longLongValue]) forKey:@"discountAmount"];
                [goodDict setValue:@(detailModel.number) forKey:@"number"];
                [goodDict setValue:detailModel.productId forKey:@"productId"];
                [goodDict setValue:detailModel.remark forKey:@"remark"];
                [goodDict setValue:detailModel.size forKey:@"size"];
                [goodDict setValue:detailModel.specId forKey:@"specId"];
                [goodDict setValue:detailModel.productForm.marketAmount forKey:@"productAmount"];
                [arr1 addObject:goodDict];
            }
            [dict setValue:arr1 forKey:@"orderDetailList"];
            [dataArray addObject:dict];
        }
        
        
        [LYTools postBossDemoWithUrl:makeOrder param:dataArray success:^(NSDictionary *dict) {
            NSLog(@"%@",dict);
            NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
            if ([respCode isEqualToString:@"00000"]) {
                BuyGoodsListController *buyCtrl = [[BuyGoodsListController alloc] init];
                buyCtrl.goodsListArray = goodListArr;
                buyCtrl.goodsNum = _goodsNum;
                buyCtrl.goodsPrice = _goodsPrice;
                [self.navigationController pushViewController:buyCtrl animated:YES];
            }else if([dict[@"code"]longValue] == 500){
                [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
            }
        } fail:^(NSError *error) {
            
        }];
        
//        [[NetworkManager sharedManager] postWithUrl:makeOrder param:dataArray success:^(id json) {
//
//            NSLog(@"%@",json);
//
//        } failure:^(NSError *error) {
//
//        }];
        

    }
}
-(void)DidSelectedAllGoods
{
//    dispatch_async(dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < self.dataSource.count; i ++) {
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[i]];
            for (NSInteger j = 0; j < arr.count; j ++) {
//                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[j]];
                CartDetailsModel *model = arr[j];
                
                if (j == 0) {
                    model.CheckAll = @"1";
//                    [dict setValue:@"1" forKey:@"CheckAll"];
                    [arr replaceObjectAtIndex:0 withObject:model];
                }
                model.SelectedType = @"已选中";
                model.Type = @"1";
//                [dict setValue:@"已选中" forKey:@"SelectedType"];
//                [dict setValue:@"1" forKey:@"Type"];
                [arr replaceObjectAtIndex:j withObject:model];
            }
            [self.dataSource replaceObjectAtIndex:i withObject:arr];
        }
        [self postCenter];
        
        [self.CartTableView reloadData];
//    });
   
}

-(void)NoDidSelectedAllGoods
{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < self.dataSource.count; i ++) {
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[i]];
            for (NSInteger j = 0; j < arr.count; j ++) {
//                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[j]];
                CartDetailsModel *model = arr[j];

                if (j == 0) {
                    model.CheckAll = @"0";
//                    [dict setValue:@"0" forKey:@"CheckAll"];
                    [arr replaceObjectAtIndex:0 withObject:model];
                }
                model.SelectedType = @"未选中支付";
                model.Type = @"0";
//                [dict setValue:@"未选中支付" forKey:@"SelectedType"];
//                [dict setValue:@"0" forKey:@"Type"];
                [arr replaceObjectAtIndex:j withObject:model];
            }
            [self.dataSource replaceObjectAtIndex:i withObject:arr];
        }
        [self postCenter];
        
        [self.CartTableView reloadData];
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
    [self.CartTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSLog(@"%ld",section);
}

/**
 *  修改商品数量
 */
-(void)ChangeGoodsNumberCell:(UITableViewCell *)cell Number:(NSInteger)num
{
    NSIndexPath *indexPath = [self.CartTableView indexPathForCell:cell];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:arr[indexPath.row]];
    [dict setValue:[NSString stringWithFormat:@"%ld",num] forKey:@"GoodsNumber"];
    [arr replaceObjectAtIndex:indexPath.row withObject:dict];
    
    [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
    
    [self postCenter];
    
    //一个cell刷新
    NSIndexPath *indexPaths=[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    [self.CartTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPaths,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}
/**
 *  删除该商品
 */
-(void)DeleteTheGoodsCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.CartTableView indexPathForCell:cell];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:self.dataSource[indexPath.section]];
    
    [Helper ShowAlertWithTitle:@"是否删除该商品" prompt:@"" cancel:@"取消" defaultLb:@"确定" ViewController:self alertOkClick:^{
        
        [arr removeObjectAtIndex:indexPath.row];
        
        if (arr.count > 0) {
            
            [self.dataSource replaceObjectAtIndex:indexPath.section withObject:arr];
            
            [self postCenter];
            
            //                //一个section刷新
            //                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
            //                [self.CartTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self.CartTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }else{
            [self.dataSource removeObjectAtIndex:indexPath.section];
            
            [self postCenter];
            
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
            [self.CartTableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
#pragma mark - Delegate - 带输入框的弹窗
// 输入框弹窗的button点击时回调
- (void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex selectCell:(CompileCell *)cell selectSpesModel:(specsModel *)model{
    if (buttonIndex == AlertButtonLeft) {
        
    }else{
            NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
            CartDetailsModel *model =cell.detailModel;
            [dict1 setValue:model.id forKey:@"cartDetailId"];
            [dict1 setValue:alertView.textView.text forKey:@"remark"];
            [LYTools postBossDemoWithUrl:cartRemark param:dict1 success:^(NSDictionary *dict) {
                NSLog(@"%@",dict);
                NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
                if ([respCode isEqualToString:@"00000"]) {
                    cell.RemarksLabel.text = [NSString stringWithFormat:@"备注:%@",alertView.textView.text];
                   [SVProgressHUD doAnythingSuccessWithHUDMessage:@"成功添加备注" withDuration:1.5];
                }else if([dict[@"code"]longValue] == 500){
                    [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                }
            } fail:^(NSError *error) {
                
            }];
            
        
        
    }
}



#pragma mark - 小图单击
- (void)singleTapSmallViewCallback:(CompileCell *)cell
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        // 解除隐藏
        [window addSubview:_previewView];
        [window bringSubviewToFront:_previewView];
        // 清空
        [_previewView.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        // 添加子视图
        NSInteger index = 0;
        NSInteger count = cell.detailModel.productForm.imagesList.count;
        CGRect convertRect;
        if (count == 1) {
            [_previewView.pageControl removeFromSuperview];
        }
        for (NSInteger i = 0; i < count; i ++)
        {
            imagesListModel *model = cell.detailModel.productForm.imagesList[i];
            
            CGRect rect1 = [cell.Goods_Icon convertRect:cell.Goods_Icon.frame fromView:cell.contentView];//获取button在contentView的位置
            
            CGRect rect2 = [cell.Goods_Icon convertRect:rect1 toView:window];
            // 转换Frame
            MMImageView *pImageView = [[MMImageView alloc] initWithFrame:rect2];;
            convertRect = rect2;
            // 添加
            MMScrollView *scrollView = [[MMScrollView alloc] initWithFrame:CGRectMake(i*_previewView.width, 0, _previewView.width, _previewView.height)];
            scrollView.tag = 100+i;
            scrollView.maximumZoomScale = 2.0;
            // 根据图片的url下载图片数据
            dispatch_queue_t xrQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
            dispatch_async(xrQueue, ^{
                // 异步下载图片
                UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imgUrl]]];
                // 主线程刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    scrollView.image = img;
//                    [pImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:Image(@"share_sina")];
                    scrollView.contentRect = convertRect;
                    // 单击
                    [scrollView setTapBigView:^(MMScrollView *scrollView){
                        [self singleTapBigViewCallback:scrollView];
                    }];
                    // 长按
                    [scrollView setLongPressBigView:^(MMScrollView *scrollView){
                        [self longPresssBigViewCallback:scrollView.imageView];
                    }];
                    [_previewView.scrollView addSubview:scrollView];
                    if (i == index) {
                        [UIView animateWithDuration:0.3 animations:^{
                            _previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
                            _previewView.pageControl.hidden = NO;
                            [scrollView updateOriginRect];
                        }];
                    } else {
                        [scrollView updateOriginRect];
                    }
                });

            });
            
        }
        // 更新offset
        CGPoint offset = _previewView.scrollView.contentOffset;
        offset.x = index * k_screen_width;
        _previewView.scrollView.contentOffset = offset;
    });
    
}

#pragma mark - 大图单击||长按
- (void)singleTapBigViewCallback:(MMScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        _previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _previewView.pageControl.hidden = YES;
        scrollView.contentRect = scrollView.contentRect;
        scrollView.zoomScale = 1.0;
    } completion:^(BOOL finished) {
        [_previewView removeFromSuperview];
    }];
}

- (void)longPresssBigViewCallback:(UIImageView *)scrollView
{
    dispatch_async(dispatch_get_main_queue(), ^{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            
                NSMutableArray *imageIds = [NSMutableArray array];
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//
                        //写入图片到相册
                        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:scrollView.image];
                        //记录本地标识，等待完成后取到相册中的图片对象
                        [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
//
                    
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    if (success) {
                        [SVProgressHUD doAnythingSuccessWithHUDMessage:@"保存成功" withDuration:1.0];
                    }else{
                        [SVProgressHUD doAnythingSuccessWithHUDMessage:@"保存失败" withDuration:1.0];
                    }
                    //        NSLog(@"success = %d, error = %@", success, error);
                }];
            
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    });
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
