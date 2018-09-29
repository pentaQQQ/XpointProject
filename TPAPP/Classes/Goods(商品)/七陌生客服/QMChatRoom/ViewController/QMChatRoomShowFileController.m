//
//  QMChatRoomShowFileController.m
//  IMSDK-OC
//
//  Created by HCF on 16/8/15.
//  Copyright © 2016年 HCF. All rights reserved.
//

#import "QMChatRoomShowFileController.h"

@interface QMChatRoomShowFileController ()

@end

@implementation QMChatRoomShowFileController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 20, 60, 30);
    [button setTitle:NSLocalizedString(@"button.back", nil) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIWebView * webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
    [webView scalesPageToFit];
    webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];
    
    NSString * filePath = [NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),@"Documents",self.filePath];
    // 中文路径要encode
    NSString * fileUrl = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fileUrl]];
    [webView loadRequest:request];
}

- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
