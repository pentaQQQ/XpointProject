//
//  MineBaseController.m
//  TPAPP
//
//  Created by Frank on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "MineBaseController.h"
#import "MineIndentChildController.h"
@interface MineBaseController ()

@end

@implementation MineBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGFloat naviHeight = 64;
    if (@available(iOS 11.0, *)) {
        if (kScreenHeight == 812) {
            naviHeight = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top + 44;
        }
    }
    
    NSUInteger count = [self preferredListViewCount];
    CGFloat categoryViewHeight = [self preferredCategoryViewHeight];
    CGFloat width = kScreenWidth;
    CGFloat height = kScreenHeight - naviHeight - categoryViewHeight;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, categoryViewHeight, width, height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(width*count, height);
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < count; i ++) {
        if (self.selectType == 0) {
            MinePerformanceChildController *listVC = [[MinePerformanceChildController alloc] init];
            listVC.firstCtrl = i;
            listVC.secondCtrl = i;
            [self addChildViewController:listVC];
            //设置代理
            self.selecteDelegate = listVC;
            listVC.view.frame = CGRectMake(i*width, 0, width, height);
            [self.scrollView addSubview:listVC.view];
        }else if(self.selectType == 1){
            MineIndentChildController *listVC = [[MineIndentChildController alloc] init];
            listVC.selectCtrl = i;
            [self addChildViewController:listVC];
            //设置代理
            self.selecteDelegate = listVC;
            listVC.view.frame = CGRectMake(i*width, 0, width, height);
            [self.scrollView addSubview:listVC.view];
        }else{
            GoodsChildViewController *listVC = [[GoodsChildViewController alloc] init];
            listVC.selectCtrl = i;
            [self addChildViewController:listVC];
            
            //设置代理
            self.selecteDelegate = listVC;
            listVC.view.frame = CGRectMake(i*width, 0, width, height);
            [self.scrollView addSubview:listVC.view];
        }
    }
    self.categoryView.frame = CGRectMake(0, 0, kScreenWidth, categoryViewHeight);
    self.categoryView.delegate = self;
    self.categoryView.contentScrollView = self.scrollView;
    [self.view addSubview:self.categoryView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryBaseView class];
}

- (NSUInteger)preferredListViewCount {
    return 0;
}

- (CGFloat)preferredCategoryViewHeight {
    return 50;
}

- (JXCategoryBaseView *)categoryView {
    if (_categoryView == nil) {
        _categoryView = [[[self preferredCategoryViewClass] alloc] init];
    }
    return _categoryView;
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    if (self.selecteDelegate && [self.selecteDelegate respondsToSelector:@selector(selecteTypeNumber:)])
    {
        // 调用代理方法
        [self.selecteDelegate selecteTypeNumber:index];
    }
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width*index, 0) animated:YES];
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
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
