//
//  HFiveDetailViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2019/4/10.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import "HFiveDetailViewController.h"

@interface HFiveDetailViewController ()
@property(nonatomic,strong)UIWebView *webview;
@end

@implementation HFiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight)];
    self.webview = webview;
    
    [self.view addSubview:webview];
    
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webview loadRequest:request];
    
    
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
