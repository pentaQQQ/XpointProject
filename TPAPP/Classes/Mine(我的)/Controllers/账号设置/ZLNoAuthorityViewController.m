//
//  ZLNoAuthorityViewController.m
//  多选相册照片
//
//  Created by long on 15/11/30.
//  Copyright © 2015年 long. All rights reserved.
//

#import "ZLNoAuthorityViewController.h"
@interface ZLNoAuthorityViewController ()
{
    UIImageView *_imageView;
    UILabel *_labPrompt;
}

@end

@implementation ZLNoAuthorityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titleString;
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lock"]];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.frame = CGRectMake((kScreenWidth-kScreenWidth/3)/2, 100, kScreenWidth/3, kScreenWidth/3);
    [self.view addSubview:_imageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = GetMatchValue(@"取消", 16, YES, 44);
    btn.frame = CGRectMake(0, 0, width, 44);
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navRightBtn_Click) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    NSString *message = self.remindlString;
    
    _labPrompt = [[UILabel alloc] init];
    _labPrompt.numberOfLines = 2;
    _labPrompt.font = [UIFont systemFontOfSize:14];
    _labPrompt.textColor = [UIColor blackColor];
    _labPrompt.text = message;
    _labPrompt.frame = CGRectMake(50, CGRectGetMaxY(_imageView.frame), kScreenWidth-100, 50);
    _labPrompt.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_labPrompt];
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *setBtn = [[UIButton alloc] init];
    CGFloat width1 = GetMatchValue(@"设置", 16, YES, 44);
    setBtn.frame = CGRectMake((kScreenWidth-width1-20)/2, CGRectGetMaxY(_labPrompt.frame)+20, width1+20, 44);
    setBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [setBtn setTitle:@"设置" forState:UIControlStateNormal];
    [setBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(setBtn_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setBtn];
}


- (void)setBtn_Click{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)navRightBtn_Click
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
