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


@interface ClassDetailViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSMutableArray*dataArr;
@property(nonatomic,strong)SDCycleScrollView*scrollview;
@end

@implementation ClassDetailViewController
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
}

-(void)setUpUI{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-SafeAreaTopHeight-44-49-SafeAreaBottomHeight) style:UITableViewStylePlain];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    
    
//    SDCycleScrollView*scrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) delegate:self placeholderImage:[UIImage imageNamed:@"WechatIMG3"]];
//
//    self.scrollview = scrollview;
//
//    self.tableview.tableHeaderView = scrollview;
//    self.scrollview.imageURLStringsGroup = [NSArray array];
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
        vc.ID = model.id;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    
    cell.zhuanfaBlock = ^(releaseActivitiesModel *model) {
//        PiliangzhuanfaViewController *vc = [[PiliangzhuanfaViewController alloc]init];
//        vc.ID = model.id;
//        [self.navigationController pushViewController:vc animated:YES];
        
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
    vc.ID = model.id;
    [self.navigationController pushViewController:vc animated:YES];
    
}





@end
