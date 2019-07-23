//
//  AboutUSViewController.m
//  TPAPP
//
//  Created by Frank on 2019/7/15.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import "AboutUSViewController.h"
#import "Moment.h"
#import "Comment.h"
@interface AboutUSViewController ()

@end

@implementation AboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于我们";
    UIBarButtonItem *set = [[UIBarButtonItem alloc] initWithImage:@"bake_icon" complete:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItems = @[set];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
//    self.navigationController.navigationBar.translucent = NO;
    
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)createUI
{
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(30);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(80);
        
    }];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"田洋仓--让生活更简单";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:19];
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(headerImageView.mas_bottom).offset(20);
        make.width.mas_equalTo(kScreenWidth-50);
        
    }];
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.text = @"田洋仓由上海田洋实业有限公司于2018年创办，致力于成为全球领先的网络众包分销平台。";
    detailLabel.font = [UIFont systemFontOfSize:19];
    detailLabel.numberOfLines = 0;
    detailLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(kScreenWidth-50);
        
    }];
    
    UILabel *bqLabel = [[UILabel alloc] init];
    bqLabel.text = @"Copyright © 2018–2019 田洋仓";
    bqLabel.font = [UIFont systemFontOfSize:16];
    bqLabel.textColor = [UIColor grayColor];
    bqLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bqLabel];
    [bqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(detailLabel.mas_bottom).offset(80);
        make.width.mas_equalTo(kScreenWidth-50);
    }];
    
    UILabel *comLabel = [[UILabel alloc] init];
    comLabel.text = @"上海田洋实业有限公司 版权所有";
    comLabel.font = [UIFont systemFontOfSize:19];
    comLabel.textColor = [UIColor grayColor];
    comLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:comLabel];
    [comLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(bqLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(kScreenWidth-50);
    }];
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
