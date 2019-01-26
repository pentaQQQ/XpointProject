//
//  MineIndentViewController.m
//  TPAPP
//
//  Created by Frank on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//
#import "SGPagingView.h"
#import "XYSideViewController.h"
#import "UIViewController+XYSideCategory.h"
#import "LXFloaintButton.h"
#import "MineIndentViewController.h"
#import "JXCategoryNumberView.h"
#import "MineIndentChildController.h"
#import "AfterSalesViewController.h"
#import "HasBeenCancelledController.h"
#import "HasBeenCompletedController.h"
#import "HasBeenShippedViewController.h"
#import "WaitDeliveryViewController.h"
#import "HavePayViewController.h"
#import "GenerationPaymentViewController.h"
@interface MineIndentViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
//@property (nonatomic, strong) NSMutableArray *titles;
//@property (nonatomic, strong) JXCategoryNumberView *myCategoryView;
@end

@implementation MineIndentViewController
//-(NSMutableArray *)titles
//{
//    if (_titles == nil) {
//        _titles = [NSMutableArray arrayWithObjects:@"全部", @"待支付", @"待发货", @"拣货中", @"已发货", @"已取消", nil];
//    }
//    return _titles;
//}
- (void)dealloc {
    NSLog(@"DefaultScrollVC - - dealloc");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSArray *numbers = @[@0, @1, @0, @0, @0, @0];
//    self.myCategoryView.counts = numbers;
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectedIndex:) name:@"changeSelectedIndex" object:nil];
    self.navigationItem.title = @"我的订单";
    //    self.myCategoryView.titles = self.titles;
//    self.myCategoryView.defaultSelectedIndex = self.selectIndex;
//    self.myCategoryView.zoomEnabled = YES;
//    self.myCategoryView.titleColorGradientEnabled = YES;
//    self.myCategoryView.indicatorLineViewShowEnabled = YES;
    [self setupPageView];
}
- (void)changeSelectedIndex:(NSNotification *)noti {
    _pageTitleView.resetSelectedIndex = [noti.object integerValue];
}

- (void)setupPageView {
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat pageTitleViewY = 0;
    if (statusHeight == 20.0) {
        pageTitleViewY = 64;
    } else {
        pageTitleViewY = 88;
    }
    
    NSArray *titleArr = @[@"待支付", @"已支付", @"待发货", @"已发货", @"已完成", @"已取消", @"售后"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleAdditionalWidth = 15;
//    configure.indicatorAdditionalWidth = 10; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.showBottomSeparator = NO;
    configure.titleSelectedFont = [UIFont systemFontOfSize:17];
    //    configure.titleColor = [UIColor lightGrayColor];
    //    configure.titleSelectedColor = kRGBColor(228, 135, 60);
    //    configure.indicatorColor = kRGBColor(228, 135, 60);
    configure.titleGradientEffect = YES;
    //    configure.titleTextZoom = YES;
    //    configure.titleTextZoomAdditionalPointSize = 4;
    /// pageTitleView
    if (self.isPushCtrl) {
        self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    }else{
        self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, pageTitleViewY, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    }
//    if (self.selectIndex == 4) {
//        self.selectIndex = 5;
//    }
    self.pageTitleView.selectedIndex = self.selectIndex;
    [self.view addSubview:_pageTitleView];
//        [_pageTitleView addBadgeForIndex:1];
//        [_pageTitleView addBadgeForIndex:5];
    
    NSMutableArray *childArr = [NSMutableArray array];
    for (int i=0; i<titleArr.count; i++) {
        if (i == 0) {
            GenerationPaymentViewController *vc = [[GenerationPaymentViewController alloc]init];
            vc.selectCtrl = i;
            vc.pushCtrl = self.pushCtrl;
            //设置代理
            self.generationPaymentDelegate  =  vc;
            [childArr addObject:vc];
        }else if (i == 1){
            HavePayViewController *vc = [[HavePayViewController alloc]init];
            vc.selectCtrl = i;
            vc.pushCtrl = self.pushCtrl;
            //设置代理
            self.havePayDelegate  =  vc;
            [childArr addObject:vc];
        }else if (i == 2){
            WaitDeliveryViewController *vc = [[WaitDeliveryViewController alloc]init];
            vc.selectCtrl = i;
            vc.pushCtrl = self.pushCtrl;
            //设置代理
            self.waitDeliveryDelegate  =  vc;
            [childArr addObject:vc];
        }else if (i == 3){
            HasBeenShippedViewController *vc = [[HasBeenShippedViewController alloc]init];
            vc.selectCtrl = i;
            vc.pushCtrl = self.pushCtrl;
            //设置代理
            self.hasBeenShippedDelegate  =  vc;
            [childArr addObject:vc];
        }else if (i == 4){
            HasBeenCompletedController *vc = [[HasBeenCompletedController alloc]init];
            vc.selectCtrl = i;
            vc.pushCtrl = self.pushCtrl;
            //设置代理
            self.hasBeenCompletedDelegate  =  vc;
            [childArr addObject:vc];
        }else if (i == 5){
            HasBeenCancelledController *vc = [[HasBeenCancelledController alloc]init];
            vc.selectCtrl = i;
            vc.pushCtrl = self.pushCtrl;
            //设置代理
            self.hasBeenCancelledDelegate  =  vc;
            [childArr addObject:vc];
        }else{
            AfterSalesViewController *vc = [[AfterSalesViewController alloc]init];
            vc.selectCtrl = i;
            vc.pushCtrl = self.pushCtrl;
            //设置代理
            self.afterSalesDelegate  =  vc;
            [childArr addObject:vc];
        }
    }
    CGFloat ContentCollectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {
//    if (index == 1 || index == 5) {
//        [_pageTitleView removeBadgeForIndex:index];
//    }
    if (index == 0) {
        if (self.generationPaymentDelegate && [self.generationPaymentDelegate respondsToSelector:@selector(selecteGenerationPayment:)])
        {
            // 调用代理方法
            [self.generationPaymentDelegate selecteGenerationPayment:index];
        }
    }else if (index == 1){
        if (self.havePayDelegate && [self.havePayDelegate respondsToSelector:@selector(selecteHavePay:)])
        {
            // 调用代理方法
            [self.havePayDelegate selecteHavePay:index];
        }
    }else if (index == 2){
        if (self.waitDeliveryDelegate && [self.waitDeliveryDelegate respondsToSelector:@selector(selecteWaitDelivery:)])
        {
            // 调用代理方法
            [self.waitDeliveryDelegate selecteWaitDelivery:index];
        }
    }else if (index == 3){
        if (self.hasBeenShippedDelegate && [self.hasBeenShippedDelegate respondsToSelector:@selector(selecteHasBeenShipped:)])
        {
            // 调用代理方法
            [self.hasBeenShippedDelegate selecteHasBeenShipped:index];
        }
    }else if (index == 4){
        if (self.hasBeenCompletedDelegate && [self.hasBeenCompletedDelegate respondsToSelector:@selector(selecteHasBeenCompleted:)])
        {
            // 调用代理方法
            [self.hasBeenCompletedDelegate selecteHasBeenCompleted:index];
        }
    }else if (index == 5){
        if (self.hasBeenCancelledDelegate && [self.hasBeenCancelledDelegate respondsToSelector:@selector(selecteHasBeenCancelled:)])
        {
            // 调用代理方法
            [self.hasBeenCancelledDelegate selecteHasBeenCancelled:index];
        }
    }else if (index == 6){
        if (self.afterSalesDelegate && [self.afterSalesDelegate respondsToSelector:@selector(selecteAfterSales:)])
        {
            // 调用代理方法
            [self.afterSalesDelegate selecteAfterSales:index];
        }
    }
    
//    if (self.selecteDelegate && [self.selecteDelegate respondsToSelector:@selector(selecteNumber:)])
//    {
//        // 调用代理方法
//        [self.selecteDelegate selecteNumber:index];
//    }
}

//- (JXCategoryNumberView *)myCategoryView {
//    return (JXCategoryNumberView *)self.categoryView;
//}
//
//- (NSUInteger)preferredListViewCount {
//    return self.titles.count;
//}
//
//- (Class)preferredCategoryViewClass {
//    return [JXCategoryNumberView class];
//}

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
