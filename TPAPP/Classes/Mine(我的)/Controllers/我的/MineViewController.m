//
//  MineViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "MineViewController.h"
#import "JXCategoryTitleView.h"
#import "ReturnGoodsViewController.h"
#import "CustomerReconciliationsController.h"
#import <Photos/Photos.h>
#import "SystemInformationController.h"
#import "VIPViewController.h"
#import "ApplyGoodsServiceController.h"
#import "InviteAwardController.h"
#import "MinePerformanceController.h"
#import "AccountSetController.h"
#import "MineIndentViewController.h"
#import "ApplyTXViewController.h"
#import "IdentificationController.h"
#import "MineHeaderViewCell.h"
#import "MarketCell.h"
#import "IndentCell.h"
#import "RefundCell.h"
#import "ElseTableCell.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIView *myQRBgview;
@property (nonatomic, strong)UIView *myQRView;
@property (nonatomic, strong)UIImageView *qrImageView;
@property (nonatomic, strong)UILabel *dateLabel;
@property (nonatomic, strong)UIView *bgview;
@property (nonatomic, strong)UILabel *firstLabel;
@property (nonatomic, strong)UILabel *secondLabel;
@property (nonatomic, strong)UIButton *attentionBtn;
@property (nonatomic, strong)MJRefreshNormalHeader *mjHeader;
@end

@implementation MineViewController
{
    UIView *_view1;
}
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
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self createItems];
    [self listTableView];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
   
    // 隐藏时间
    self.mjHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mjHeader.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    // 隐藏状态
    self.mjHeader.stateLabel.hidden = YES;
    self.listTableView.mj_header = self.mjHeader;
    self.mjHeader.hidden = YES;
    
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    CGRect navRect = self.navigationController.navigationBar.frame;
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, statusRect.size.height+navRect.size.height)];
    _view1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [self.view addSubview:_view1];
}
#pragma mark - 刷新数据
- (void)loadNewData
{
    [self.listTableView.mj_header endRefreshing];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f",offsetY);
    if (offsetY<0 && offsetY>-64) {
        [self.navigationController.navigationBar setShadowImage:nil];
        [self.leftBtn setImage:[UIImage imageNamed:@"消息_black"] forState:UIControlStateNormal];
        [self.rightBtn setImage:[UIImage imageNamed:@"设置_black"] forState:UIControlStateNormal];
    }else if (offsetY<=-64){
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        [self.leftBtn setImage:[UIImage imageNamed:@"消息_white"] forState:UIControlStateNormal];
        [self.rightBtn setImage:[UIImage imageNamed:@"设置_white"] forState:UIControlStateNormal];
        
    }
    if (offsetY < -64) {
        self.mjHeader.hidden = NO;
    }else if (offsetY >= -64){
        self.mjHeader.hidden = YES;
    }
    if (SafeAreaTopHeight == 88) {
        if (offsetY < 64)
        {
            _view1.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent: offsetY/40];
        }
    }else{
        if (offsetY < 137)
        {
            _view1.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent: offsetY/64];
        }
    }
}
#pragma mark - iOS 设置导航栏全透明
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    UILabel*titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"我的";
    self.navigationItem.titleView= titleLabel;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    //如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
#pragma mark - 创建tableview
-(UITableView *)listTableView
{
    if (_listTableView == nil) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _listTableView.backgroundColor = colorWithRGB(0xEEEEEE);
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.showsHorizontalScrollIndicator = NO;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_listTableView];
        _listTableView.sd_layout
        .topSpaceToView(self.view, 0)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomEqualToView(self.view);
        //        if ([self.listTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        //            [self.listTableView setSeparatorInset:UIEdgeInsetsZero];
        //        }
        //        if ([self.listTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        //            [self.listTableView setLayoutMargins:UIEdgeInsetsZero];
        //        }
    }
    return _listTableView;
}



#pragma mark -自定义导航栏返回按钮
- (void)createItems
{
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 25, 25);
    //    self.leftBtn.backgroundColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:@"消息_white"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    self.navigationItem.leftBarButtonItem = itemleft;
    
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(0, 0, 25, 25);
    //    self.rightBtn.backgroundColor = [UIColor whiteColor];
    [self.rightBtn setImage:[UIImage imageNamed:@"设置_white"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = itemRight;
}
#pragma mark - tableview代理
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
//    }
//    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
//        [cell setPreservesSuperviewLayoutMargins:NO];
//    }
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        MineHeaderViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"MineHeaderViewCell"];
        if (!headerCell) {
            headerCell = [[MineHeaderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineHeaderViewCell"];
        }
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [headerCell setSelectBlcok:^(NSInteger selectNum) {
            if (selectNum == 0) {
                
            }else if (selectNum == 1){
                IdentificationController *idCtrl = [[IdentificationController alloc] init];
                [self.navigationController pushViewController:idCtrl animated:YES];
            }else if (selectNum == 2){
                
            }else if (selectNum == 3){
                VIPViewController *vipCtrl = [[VIPViewController alloc] init];
                [self.navigationController pushViewController:vipCtrl animated:YES];
            }else{
                AccountSetController *minePerCtrl = [[AccountSetController alloc] init];
                [self.navigationController pushViewController:minePerCtrl animated:YES];
            }
        }];
        return headerCell;
    }else if (indexPath.section==1){
        MarketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarketCell"];
        if (!cell) {
            cell = [[MarketCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MarketCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWithMarketLimit:[NSMutableArray arrayWithObjects:@"¥0.0",@"¥0.0",@"¥0.0",@"¥0.0",@"¥0.0",@"¥0.0", nil] andLimitTitle:[NSMutableArray arrayWithObjects:@"今日销售额",@"今日代购费",@"本月代购费",@"本月销售额",@"上月销售额",@"上月代购额", nil]];
        return cell;
    }else if (indexPath.section==2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = colorWithRGB(0xEEEEEE);
        UIButton *btn = [[UIButton alloc] init];
        [cell addSubview:btn];
        btn.backgroundColor = [UIColor whiteColor];
        btn.sd_layout
        .topSpaceToView(cell, 0)
        .leftSpaceToView(cell, 20)
        .rightSpaceToView(cell, 20)
        .heightIs(50);
        btn.layer.cornerRadius = 10;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor = colorWithRGB(0xFF6B24).CGColor;
        
        [btn setImage:[UIImage imageNamed:@"vip_icon"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(15, (kScreenWidth-40-[self widthLabelWithModel:@"申请提现"]-20)/2+10, 15, (kScreenWidth-40-[self widthLabelWithModel:@"申请提现"]-20)/2+[self widthLabelWithModel:@"申请提现"]-10);
        [btn addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"申请提现" forState:UIControlStateNormal];
        [btn setTitleColor:colorWithRGB(0xFF6B24) forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(5, -(kScreenWidth-40-[self widthLabelWithModel:@"申请提现"]-20)/2-20-10, 5, 0);
        return cell;
        
    }
    else if (indexPath.section==3){
        IndentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndentCell"];
        if (!cell) {
            cell = [[IndentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"IndentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSelectBlcok:^(NSInteger num) {
            MineIndentViewController *minePerCtrl = [[MineIndentViewController alloc] init];
            minePerCtrl.title = @"我的订单";
            minePerCtrl.selectIndex = num+1;
//            minePerCtrl.selectType = 1;
//            JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)minePerCtrl.categoryView;
//
//            titleCategoryView.titleColorGradientEnabled = YES;
//            titleCategoryView.indicatorLineViewShowEnabled = YES;
            [self.navigationController pushViewController:minePerCtrl animated:YES];
        }];
        //        [cell configWithMarketLimit:[NSMutableArray arrayWithObjects:@"¥0.0",@"¥0.0",@"¥0.0",@"¥0.0",@"¥0.0",@"¥0.0", nil] andLimitTitle:[NSMutableArray arrayWithObjects:@"今日销售额",@"今日代购费",@"本月代购费",@"本月销售额",@"上月销售额",@"上月代购额", nil]];
        return cell;
    }
    //    else if (indexPath.section==3){
    //        RefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RefundCell"];
    //        if (!cell) {
    //            cell = [[RefundCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"RefundCell"];
    //        }
    //        [cell configWithMarketLimit:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0", nil] andLimitTitle:[NSMutableArray arrayWithObjects:@"平台缺货",@"用户取消",@"退货中",@"已退货",@"售后记录", nil]];
    //        return cell;
    //
    //    }
    else{
        ElseTableCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"ElseTableCell"];
        if (!headerCell) {
            headerCell = [[ElseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ElseTableCell"];
        }
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [headerCell setSelectBlcok:^(NSInteger num) {
            if (num == 0) {
                ReturnGoodsViewController*goodsCtrl = [[ReturnGoodsViewController alloc] init];
//                goodsCtrl.selectType = 2;
                goodsCtrl.title = @"退款/售后";
//                JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)goodsCtrl.categoryView;
//                titleCategoryView.titleColorGradientEnabled = YES;
//                titleCategoryView.indicatorLineViewShowEnabled = YES;
//                titleCategoryView.zoomEnabled = NO;
                [self.navigationController pushViewController:goodsCtrl animated:YES];
            }else if (num == 1){
                CustomerReconciliationsController *inviteCtrl = [[CustomerReconciliationsController alloc] init];
                [self.navigationController pushViewController:inviteCtrl animated:YES];
            }else if (num == 2){
                ApplyGoodsServiceController *inviteCtrl = [[ApplyGoodsServiceController alloc] init];
                [self.navigationController pushViewController:inviteCtrl animated:YES];
            }else if (num == 3){
                self.myQRBgview = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2.0, kScreenHeight/2.0, 0, 0)];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qrTapAction)];
                [self.myQRBgview addGestureRecognizer:tap];
                self.myQRBgview.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                [window addSubview:self.myQRBgview];
                
                
                [UIView animateWithDuration:.5 animations:^{
                    self.myQRBgview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                } completion:^(BOOL finished) {
                    self.myQRView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-300)/2.0, (kScreenHeight-400)/2.0, 300, 400)];
                    self.myQRView.backgroundColor = [UIColor whiteColor];
                    [self.myQRBgview addSubview:self.myQRView];
                    self.myQRView.layer.cornerRadius = 8;
                    self.myQRView.layer.masksToBounds = YES;
                    
                    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 300, 20)];
                    self.dateLabel.text = @"微信公众号";
                    self.dateLabel.textAlignment = NSTextAlignmentCenter;
                    self.dateLabel.font = [UIFont systemFontOfSize:16];
                    self.dateLabel.textColor = colorWithRGB(0xFF5760);
                    [self.myQRView addSubview:self.dateLabel];
                    //                    self.dateLabel.sd_layout
                    //                    .topSpaceToView(self.myQRView, 20)
                    //                    .centerXEqualToView(self.myQRView)
                    //                    .widthIs(180)
                    //                    .heightIs(20);
                    
                    self.bgview = [[UIView alloc] initWithFrame:CGRectMake((300-160)/2, CGRectGetMaxY(self.dateLabel.frame)+10, 160, 160)];
                    self.bgview.backgroundColor = colorWithRGB(0xFF5760);
                    [self.myQRView addSubview:self.bgview];
                    //                    self.bgview.sd_layout
                    //                    .topSpaceToView(self.dateLabel, 15)
                    //                    .centerXEqualToView(self.myQRView)
                    //                    .widthIs(120)
                    //                    .heightIs(120);
                    
                    self.qrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 140, 140)];
                    //                    imageView.backgroundColor = [UIColor grayColor];
                    self.qrImageView.image = [self createQRImageWithString:@"1234" size:CGSizeMake(140, 140)];
                    [self.bgview addSubview:self.qrImageView];
                    //                    self.qrImageView.sd_layout
                    //                    .topSpaceToView(self.bgview, 10)
                    //                    .leftSpaceToView(self.bgview, 10)
                    //                    .bottomSpaceToView(self.bgview, 10)
                    //                    .rightSpaceToView(self.bgview, 10);
                    
                    
                    self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.bgview.frame)+20, 290, 40)];
                    self.firstLabel.numberOfLines = 2;
                    self.firstLabel.text = @"1、点击立即关注，二维码会自动保存至你的相册";
                    self.firstLabel.textAlignment = NSTextAlignmentLeft;
                    self.firstLabel.font = [UIFont systemFontOfSize:15];
                    self.firstLabel.textColor = [UIColor lightGrayColor];
                    [self.myQRView addSubview:self.firstLabel];
                    //                    self.firstLabel.sd_layout
                    //                    .topSpaceToView(self.bgview, 20)
                    //                    .leftSpaceToView(self.myQRView, 10)
                    //                    .rightEqualToView(self.myQRView)
                    //                    .heightIs(40);
                    
                    self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.firstLabel.frame), 290, 40)];
                    self.secondLabel.numberOfLines = 2;
                    self.secondLabel.text = @"2、打开微信扫一扫，选择相册中的二维码，直接关注成功";
                    self.secondLabel.textAlignment = NSTextAlignmentLeft;
                    self.secondLabel.font = [UIFont systemFontOfSize:15];
                    self.secondLabel.textColor = [UIColor lightGrayColor];
                    [self.myQRView addSubview:self.secondLabel];
                    //                    self.secondLabel.sd_layout
                    //                    .topSpaceToView(self.firstLabel, 0)
                    //                    .leftSpaceToView(self.myQRView, 10)
                    //                    .rightEqualToView(self.myQRView)
                    //                    .heightIs(40);
                    
                    
                    self.attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.secondLabel.frame)+30, 260, 40)];
                    self.attentionBtn.backgroundColor = colorWithRGB(0xFF5760);
                    [self.attentionBtn setTitle:@"立即关注" forState:UIControlStateNormal];
                    [self.attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.attentionBtn addTarget:self action:@selector(attentionBtnAction) forControlEvents:UIControlEventTouchUpInside];
                    [self.myQRView addSubview:self.attentionBtn];
                    //                    self.attentionBtn.sd_layout
                    //                    .topSpaceToView(self.secondLabel,40)
                    //                    .rightSpaceToView(self.myQRView, 20)
                    //                    .leftSpaceToView(self.myQRView, 20)
                    //                    .heightIs(40);
                    self.attentionBtn.layer.cornerRadius = 6;
                    self.attentionBtn.layer.masksToBounds = YES;
                    
                }];
            }else{
                InviteAwardController *inviteCtrl = [[InviteAwardController alloc] init];
                [self.navigationController pushViewController:inviteCtrl animated:YES];
            }
        }];
        return headerCell;
    }
    
    
}
-(void)attentionBtnAction
{
    NSMutableArray *imageIds = [NSMutableArray array];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:[self createQRImageWithString:@"1234" size:CGSizeMake(120, 120)]];
        //记录本地标识，等待完成后取到相册中的图片对象
        [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            [SVProgressHUD doAnythingSuccessWithHUDMessage:@"保存成功" withDuration:1.0];
        }else{
            [SVProgressHUD doAnythingFailedWithHUDMessage:@"保存失败" withDuration:1.0];
        }
        //        NSLog(@"success = %d, error = %@", success, error);
    }];
}
#pragma mark - 生成制定大小的黑白二维码
- (UIImage *)createQRImageWithString:(NSString *)string size:(CGSize)size
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 1.创建过滤器
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [qrFilter setDefaults];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CIImage *qrImage = qrFilter.outputImage;
    //放大并绘制二维码（上面生成的二维码很小，需要放大）
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    //翻转一下图片 不然生成的QRCode就是上下颠倒的
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    CGImageRelease(cgImage);
    return codeImage;
}
-(void)qrTapAction
{
    [UIView animateWithDuration:0.25 animations:^{
        self.myQRBgview.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        self.myQRBgview.frame = CGRectMake(kScreenWidth/2, kScreenHeight/2, 0, 0);
        self.myQRView.frame = CGRectZero;
        self.dateLabel.frame = CGRectZero;
        self.bgview.frame = CGRectZero;
        self.qrImageView.frame = CGRectZero;
        self.firstLabel.frame = CGRectZero;
        self.secondLabel.frame = CGRectZero;
        self.attentionBtn.frame = CGRectZero;
        [self.dateLabel removeFromSuperview];
        [self.bgview removeFromSuperview];
        [self.firstLabel removeFromSuperview];
        [self.secondLabel removeFromSuperview];
        [self.attentionBtn removeFromSuperview];
        [self.qrImageView removeFromSuperview];
        
    } completion:^(BOOL finished) {
        [ self.myQRBgview removeFromSuperview];
        [self.myQRView removeFromSuperview];
    }];
}
- (void)applyAction
{
    ApplyTXViewController *minePerCtrl = [[ApplyTXViewController alloc] init];
    [self.navigationController pushViewController:minePerCtrl animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 2 || section == 4) {
        return 0;
    }else{
        return 50;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 2 || section == 4) {
        return nil;
    }else {
        NSArray *listArr = @[@"我的销售业绩",@"我的订单",@"我的订单"];
        NSArray *detailArr = @[@"更多 ",@"查看全部 ",@"查看全部 "];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        view.tag = section;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewTap:)];
        [view addGestureRecognizer:tapGes];
        UIView *lineView = [[UIView alloc] init];
        [view addSubview:lineView];
        lineView.backgroundColor = colorWithRGB(0xbfbfbf);
        lineView.sd_layout
        .topSpaceToView(view, 49.5)
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
        .topSpaceToView(view, 15)
        .leftSpaceToView(lineImgeView, 5)
        .widthIs(150)
        .heightIs(20);
        listLabel.font = [UIFont systemFontOfSize:15];
        listLabel.text = listArr[section -1];
        
        UIImageView *imgeView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-20, 10, 10, 10)];
        [view addSubview:imgeView];
        imgeView.image = [UIImage imageNamed:@"icon_mine_arrow"];
        imgeView.sd_layout
        .topSpaceToView(view, 20)
        .rightSpaceToView(view, 15)
        .widthIs(10)
        .heightIs(10);
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.textAlignment = NSTextAlignmentRight;
        [view addSubview:detailLabel];
        detailLabel.sd_layout
        .topSpaceToView(view, 15)
        .rightSpaceToView(imgeView, 5)
        .widthIs([self widthLabelWithModel:detailArr[section -1]]+10)
        .heightIs(20);
        detailLabel.font = [UIFont systemFontOfSize:12];
        detailLabel.textColor = colorWithRGB(0xbfbfbf);
        detailLabel.text = detailArr[section -1];
        return view;
    }
}
- (void)headerViewTap:(UITapGestureRecognizer *)ges
{
    UIView *view = [ges view];
    if (view.tag == 1) {
        MinePerformanceController *minePerCtrl = [[MinePerformanceController alloc] init];
        minePerCtrl.title = @"我的销售业绩";
//        minePerCtrl.selectType = 0;
//        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)minePerCtrl.categoryView;
//        titleCategoryView.titleColorGradientEnabled = YES;
//        titleCategoryView.indicatorLineViewShowEnabled = YES;
//        titleCategoryView.zoomEnabled = YES;
        [self.navigationController pushViewController:minePerCtrl animated:YES];
    }else{
        MineIndentViewController *minePerCtrl = [[MineIndentViewController alloc] init];
        minePerCtrl.title = @"我的订单";
//        minePerCtrl.selectType = 1;
        
//        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)minePerCtrl.categoryView;

        
        
//        titleCategoryView.zoomEnabled = YES;
//        titleCategoryView.titleColorGradientEnabled = YES;
//        titleCategoryView.indicatorLineViewShowEnabled = YES;
        [self.navigationController pushViewController:minePerCtrl animated:YES];
    }
}
#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString
{
    CGSize size = CGSizeMake(self.view.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    return rect.size.width+10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        return 40;
    }else{
      return 0;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        view.backgroundColor = colorWithRGB(0xEEEEEE);
        return view;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 240+20;
    }else if (indexPath.section == 4){
//        return 185;
        return 100;
    }else if (indexPath.section == 2){
        return 50+20;
    }else{
        return 100+20;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 导航栏返回按钮的事件
- (void)leftBackAction
{
    
    SystemInformationController *minePerCtrl = [[SystemInformationController alloc] init];
    [self.navigationController pushViewController:minePerCtrl animated:YES];
}
- (void)rightAction
{
    AccountSetController *minePerCtrl = [[AccountSetController alloc] init];
    [self.navigationController pushViewController:minePerCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
