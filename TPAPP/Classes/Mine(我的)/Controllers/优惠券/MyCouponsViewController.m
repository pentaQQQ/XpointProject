//
//  MyCouponsViewController.m
//  TPAPP
//
//  Created by Frank on 2019/1/17.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import "MyCouponsViewController.h"
#import "CouponsSegment.h"
#import "ExpiredCouponsController.h"
#import "AvailableCouponsController.h"
#define LG_ScreenW [UIScreen mainScreen].bounds.size.width
#define LG_ScreenH [UIScreen mainScreen].bounds.size.height
//ScrollView高度
#define LG_scrollViewH 220
//Segment高度
#define LG_segmentH 40
@interface MyCouponsViewController ()<UIScrollViewDelegate,SegmentDelegate>
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property(nonatomic,strong)NSMutableArray *buttonList;
@property (nonatomic, weak) CouponsSegment *segment;
@property(nonatomic,weak)CALayer *LGLayer;

@end

@implementation MyCouponsViewController
- (NSMutableArray *)buttonList
{
    if (!_buttonList)
    {
        _buttonList = [NSMutableArray array];
    }
    return _buttonList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"优惠券";
//    [self createNavBarBtn];
    //加载Segment
    [self setSegment];
    //加载ViewController
    [self addChildViewController];
    //加载ScrollView
    [self setContentScrollView];
    //添加导航栏左边按钮
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(0, 0, 25, 25);
//    [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(leftBackAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItem = itemleft;
}
-(void)setSegment {
    
    [self buttonList];
    //初始化
    CouponsSegment *segment = [[CouponsSegment alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, LG_ScreenW, 40)];
    segment.delegate = self;
    self.segment = segment;
    [self.view addSubview:segment];
    [self.buttonList addObject:segment.buttonList];
    self.LGLayer = segment.LGLayer;
    
}

//加载ScrollView的颜色
-(void)setContentScrollView {
    //
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+40, LG_ScreenW, LG_ScreenH-SafeAreaTopHeight-40-SafeAreaBottomHeight)];
    
    //    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - LG_scrollViewH - 50, self.view.frame.size.width, 300)];
    [self.view addSubview:sv];
    sv.bounces = NO;
    sv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    sv.contentOffset = CGPointMake(0, 0);
    sv.pagingEnabled = YES;
    sv.showsHorizontalScrollIndicator = NO;
    sv.scrollEnabled = YES;
    sv.userInteractionEnabled = YES;
    sv.delegate = self;
    
    for (int i=0; i<self.childViewControllers.count; i++) {
        UIViewController * vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * LG_ScreenW, 0, LG_ScreenW, LG_ScreenH-SafeAreaTopHeight-40-SafeAreaBottomHeight);
        [sv addSubview:vc.view];
    }
    
    sv.contentSize = CGSizeMake(2 * LG_ScreenW, 0);
    self.contentScrollView = sv;
}
//加载2个ViewController
-(void)addChildViewController{
    
    AvailableCouponsController * vc1 = [[AvailableCouponsController alloc]init];
    [self addChildViewController:vc1];
    
    ExpiredCouponsController * vc2 = [[ExpiredCouponsController alloc]init];
    [self addChildViewController:vc2];
    
//    ExpiredCouponsController* vc3 = [[ExpiredCouponsController alloc]init];
//    [self addChildViewController:vc3];
    
}
#pragma mark - UIScrollViewDelegate
//实现LGSegment代理方法
-(void)scrollToPage:(int)Page {
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = self.view.frame.size.width * Page;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentScrollView.contentOffset = offset;
    }];
}
// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    [self.segment moveToOffsetX:offsetX];
    
}
//iOS 设置导航栏全透明
//- (void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    //如果不想让其他页面的导航栏变为透明 需要重置
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//}
- (void)createNavBarBtn
{
    //    self.navigationController.navigationBar.translucent = NO;
    //    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    if (@available(iOS 8.2, *)) {
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium];
    } else {
        // Fallback on earlier versions
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:16.0];
    }
    [self.navigationController.navigationBar setTitleTextAttributes:attrs];
    self.navigationItem.title = @"优惠券";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = itemleft;
    
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 60.5, 12);
//    [rightBtn setTitle:@"添加优惠券" forState:UIControlStateNormal];
//    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    if (@available(iOS 8.2, *)) {
//        [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]];
//    } else {
//        // Fallback on earlier versions
//        [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
//    }
//    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = itemRight;
}
//- (void)rightAction
//{
//    AddCouponsViewController *fzCtrl = [[AddCouponsViewController alloc] init];
//    [self.navigationController pushViewController:fzCtrl animated:YES];
//}
- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
