//
//  ClassDetailViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/20.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "ClassDetailViewController.h"
#import "SDCycleScrollView.h"
#import "goodsDetailCell.h"
#import "releaseActivitiesModel.h"
#import "GoodsDetailViewController.h"
#import "homePageHeaderModel.h"
#import "AdvertisingModel.h"

#import "fenxiangTanchuangView.h"


@interface ClassDetailViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSMutableArray*dataArr;
@property(nonatomic,strong)SDCycleScrollView*scrollview;
@property(nonatomic,strong)NSMutableArray*imagesArr;
//@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property(nonatomic,weak)UIView *mengbanView;
@property(nonatomic,strong)fenxiangTanchuangView *zhuanfaotherview;
@end

@implementation ClassDetailViewController

- (NSMutableArray *)imagesArr
{
    if (_imagesArr == nil) {
        _imagesArr = [NSMutableArray array];
    }
    return _imagesArr;
}


-(NSMutableArray*)dataArr{
    
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpUI];
    [self getAdvertisingData];
}
- (void)getAdvertisingData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.pageModel.id forKey:@"labelId"];
    [[NetworkManager sharedManager] getWithUrl:getAdvertising param:dict success:^(id json) {
        
        NSLog(@"%@",json);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in json[@"data"]) {
                AdvertisingModel *advModel = [AdvertisingModel mj_objectWithKeyValues:dic];
                [arr addObject:advModel.imgUrl];
                [self.imagesArr addObject:advModel];
            }
            if (arr.count != 0) {
                self.scrollview.imageURLStringsGroup = arr;
            }else{
                self.tableview.tableHeaderView = [UIView new];
            }
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)setUpUI{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-SafeAreaTopHeight-44-49-SafeAreaBottomHeight) style:UITableViewStylePlain];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    
    SDCycleScrollView*scrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 150) delegate:self placeholderImage:nil];
    scrollview.currentPageDotColor = [UIColor colorWithRed:255.0/255.0 green:107.0/255.0 blue:36.0/255.0 alpha:1.0];
    scrollview.pageDotColor = [UIColor lightGrayColor];
    self.scrollview = scrollview;
    self.tableview.tableHeaderView = scrollview;
    
    
    
    self.tableview.tableFooterView = [UIView new];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    
    
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *reuesId = @"goodsDetailCell";
    goodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"goodsDetailCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    releaseActivitiesModel *model = self.arr[indexPath.row];
    cell.model = model;
    
    cell.qianggouBlock = ^(releaseActivitiesModel *model) {
        GoodsDetailViewController *vc = [[GoodsDetailViewController alloc]init];
        vc.title = model.merchantName;
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    cell.zhuanfaBlock = ^(releaseActivitiesModel *model) {
//        PiliangzhuanfaViewController *vc = [[PiliangzhuanfaViewController alloc]init];
//        vc.ID = model.id;
//        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        [self tanchuang];
    };
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    releaseActivitiesModel*model = self.arr[indexPath.row];
    
    CGFloat width = (kScreenWidth-70-10)/3.0;
    
    //content的高度
    CGFloat high = [LYTools getHeighWithTitle:model.context font:[UIFont systemFontOfSize:14] width:kScreenWidth-70];
    
    int tmp = model.imagesList.count % 3;
    int row = (int)model.imagesList.count / 3;
    row += tmp == 0 ? 0:1;
    return (width+5)*row+163+high;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    releaseActivitiesModel*model = self.arr[indexPath.row];
    GoodsDetailViewController *vc = [[GoodsDetailViewController alloc]init];
    vc.title = model.merchantName;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}








-(void)tanchuang

{
    
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    fenxiangTanchuangView *zhuanfaotherview = [[NSBundle mainBundle]loadNibNamed:@"fenxiangTanchuangView" owner:self options:nil].lastObject;
    ViewBorderRadius(zhuanfaotherview, 5, 1, [UIColor clearColor]);
    self.zhuanfaotherview = zhuanfaotherview;
    zhuanfaotherview.frame = CGRectMake(20, (kScreenHeight-322)/2, kScreenWidth-40, 322);
    
    [keyWindow addSubview:zhuanfaotherview];
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [mengbanView addGestureRecognizer:tap];
    
    
    
    __weak __typeof(self) weakSelf = self;
    
 
    
    [zhuanfaotherview.shareBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
    }];
    
}



-(void)tap{
    
    [self.zhuanfaotherview removeFromSuperview];
    [self.mengbanView removeFromSuperview];
    
}


@end
