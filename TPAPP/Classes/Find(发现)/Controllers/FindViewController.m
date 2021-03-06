//
//  FindViewController.m
//  TPAPP
//
//  Created by 上海点硕 on 2017/7/18.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "FindViewController.h"
#import "SGPagingView.h"
#import "UIViewController+XYSideCategory.h"
#import "LXFloaintButton.h"
#import "UIViewController+XYSideCategory.h"
#import "SearchViewController.h"
#import "homePageHeaderModel.h"
#import "NewsViewController.h"
@interface FindViewController ()<SGPageTitleViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property(nonatomic,strong)LXFloaintButton *button;


@property(nonatomic,strong)NSMutableArray*titleArr;
@property(nonatomic,strong)NSMutableArray*dataArr;
@end

@implementation FindViewController
-(NSMutableArray*)titleArr{
    
    if (_titleArr == nil) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
    
}
-(NSMutableArray*)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)dealloc {
    NSLog(@"DefaultScrollVC - - dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeSelectedIndex" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectedIndex:) name:@"changeSelectedIndex" object:nil];
    
    [self lodaDataSuccess:^(id respons) {
        [self setupPageView];
    }];
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
    
    //    NSArray *titleArr = @[@"精选", @"电影", @"电视剧", @"综艺", @"NBA", @"娱乐", @"动漫", @"演唱会", @"VIP会员"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleAdditionalWidth = 15;
    configure.showBottomSeparator = NO;
    configure.titleSelectedFont = [UIFont systemFontOfSize:16];
    configure.titleGradientEffect = YES;
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, pageTitleViewY, 44, 44)];
    [self.view addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"icon_home_fenlei"] forState:UIControlStateNormal];
    
    
    
//    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-44, pageTitleViewY, 44, 44)];
//    rightBtn.backgroundColor = [UIColor clearColor];
//    [rightBtn setImage:[UIImage imageNamed:@"icon_home_search"] forState:UIControlStateNormal];
//    [self.view addSubview:rightBtn];
//    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    /// pageTitleView
//    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(44, pageTitleViewY, self.view.frame.size.width-88, 44) delegate:self titleNames:self.titleArr configure:configure];
//    [self.view addSubview:_pageTitleView];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(44, pageTitleViewY, self.view.frame.size.width-44, 44) delegate:self titleNames:self.titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    //    [_pageTitleView addBadgeForIndex:1];
    //    [_pageTitleView addBadgeForIndex:5];
    
    NSMutableArray *childArr = [NSMutableArray array];
    for (int i=0; i<self.titleArr.count; i++) {
//        homePageHeaderModel *model = self.dataArr[i];
        NewsViewController *vc = [[NewsViewController alloc]init];
//        vc.arr = model.releaseActivities;
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
- (void)lodaDataSuccess:(void(^)(id respons))success
{[[NetworkManager sharedManager] getWithUrl:getMainResources param:nil success:^(id json) {
    
    NSLog(@"%@",json);
    
    
    NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
    if ([respCode isEqualToString:@"00000"]) {
        
        for (NSDictionary *dic in json[@"data"]) {
            homePageHeaderModel *model = [homePageHeaderModel mj_objectWithKeyValues:dic];
            [self.titleArr addObject:model.labelName];
            
            [self.dataArr addObject:model];
        }
        success(self.titleArr);
        
    }
    
} failure:^(NSError *error) {
    NSLog(@"%@",error);
}];
    
}

@end
