//
//  HomePageController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//hshfljdhkjashkad

#import "HomePageController.h"
#import "SGPagingView.h"
#import "ClassDetailViewController.h"
#import "XYSideViewController.h"
#import "UIViewController+XYSideCategory.h"
#import "SearchViewController.h"
#import "LXFloaintButton.h"
#import "zhuanfaViewController.h"



@interface HomePageController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property(nonatomic,strong)LXFloaintButton *button;

@end

@implementation HomePageController

- (void)dealloc {
    NSLog(@"DefaultScrollVC - - dealloc");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectedIndex:) name:@"changeSelectedIndex" object:nil];
    
    [self setupPageView];
    
    [self setUpDrageBtn];
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
    
    NSArray *titleArr = @[@"精选", @"电影", @"电视剧", @"综艺", @"NBA", @"娱乐", @"动漫", @"演唱会", @"VIP会员"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorAdditionalWidth = 10; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.showBottomSeparator = NO;
    configure.titleSelectedFont = [UIFont systemFontOfSize:14];
    configure.titleColor = [UIColor lightGrayColor];
    configure.titleSelectedColor = kRGBColor(228, 135, 60);
    configure.indicatorColor = kRGBColor(228, 135, 60);
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, pageTitleViewY, 44, 44)];
    leftBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-44, pageTitleViewY, 44, 44)];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
    [self.view addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(44, pageTitleViewY, self.view.frame.size.width-88, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    [_pageTitleView addBadgeForIndex:1];
    [_pageTitleView addBadgeForIndex:5];
    
    NSMutableArray *childArr = [NSMutableArray array];
    for (int i=0; i<titleArr.count; i++) {
        ClassDetailViewController *vc = [[ClassDetailViewController alloc]init];
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
}





-(void)leftBtnClick{
    
     [self XYSideOpenVC];
    
}
-(void)rightBtnClick{
    SearchViewController *vc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



//网络请求实列
- (void)lodaData
{
    [[NetworkManager sharedManager] postCityData:@"" Success:^(id json) {
        
        //保存一次全局都能用
        USERINFO.password = @"";
        //颜色
        //colorWithRGB(0x000000)
        //字体
        //font(12);
        //宽 高  适配比列
        //SCREEN_WIDTH
        //SCREEN_HEIGHT
        //SCREEN_PRESENT
   
    } Failure:^(NSError *error) {
        
    }];
    
}
-(void)setUpDrageBtn{
    LXFloaintButton *button = [LXFloaintButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, kScreenHeight-160, 80,80);
    [button setTitle:@"拖动" forState:UIControlStateNormal];
    button.backgroundColor =[UIColor blueColor];
    ViewBorderRadius(button, 40, 0, [UIColor clearColor]);
    
    button.safeInsets = UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0);
   [self.view addSubview:button];
    
    button.parentView = [UIApplication sharedApplication].keyWindow;
    
    self.button  = button;
    
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonClick{
    zhuanfaViewController *vc = [[zhuanfaViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
    
}

@end
