//
//  MinePerformanceController.m
//  TPAPP
//
//  Created by Frank on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//
#import "SGPagingView.h"
#import "XYSideViewController.h"
#import "UIViewController+XYSideCategory.h"
#import "LXFloaintButton.h"
#import "MinePerformanceController.h"
#import "MinePerformanceChildController.h"
//#import "JXCategoryNumberView.h"
@interface MinePerformanceController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;

//@property (nonatomic, strong) NSMutableArray *titles;
//@property (nonatomic, strong) JXCategoryNumberView *myCategoryView;

@end

@implementation MinePerformanceController

//-(NSMutableArray *)titles
//{
//    if (_titles == nil) {
//        _titles = [NSMutableArray arrayWithObjects:@"日销售业绩", @"月销售业绩", nil];
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
//    NSArray *numbers = @[@0, @0];
//    self.myCategoryView.counts = numbers;
//    self.myCategoryView.zoomEnabled = YES;
//    self.myCategoryView.titleColorGradientEnabled = YES;
//    self.myCategoryView.indicatorLineViewShowEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectedIndex:) name:@"changeSelectedIndex" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupPageView];
    
//    self.myCategoryView.titles = self.titles;
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
    
    NSArray *titleArr = @[@"日销售业绩", @"月销售业绩"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorAdditionalWidth = 10; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.showBottomSeparator = NO;
    configure.titleSelectedFont = [UIFont systemFontOfSize:17];
//    configure.titleColor = [UIColor lightGrayColor];
//    configure.titleSelectedColor = kRGBColor(228, 135, 60);
//    configure.indicatorColor = kRGBColor(228, 135, 60);
    configure.titleGradientEffect = YES;
//    configure.titleTextZoom = YES;
//    configure.titleTextZoomAdditionalPointSize = 4;
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, pageTitleViewY, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
//    [_pageTitleView addBadgeForIndex:0];
//    [_pageTitleView addBadgeForIndex:5];
    
    NSMutableArray *childArr = [NSMutableArray array];
    for (int i=0; i<titleArr.count; i++) {
        MinePerformanceChildController *vc = [[MinePerformanceChildController alloc]init];
        vc.firstCtrl = i;
        vc.secondCtrl = i;
        
        self.selecteDelegate = vc;
        
        [childArr addObject:vc];
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
    if (index == 1 || index == 5) {
        [_pageTitleView removeBadgeForIndex:index];
    }
    if (self.selecteDelegate && [self.selecteDelegate respondsToSelector:@selector(selecteNumber:)])
    {
        // 调用代理方法
        [self.selecteDelegate selecteNumber:index];
    }
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
