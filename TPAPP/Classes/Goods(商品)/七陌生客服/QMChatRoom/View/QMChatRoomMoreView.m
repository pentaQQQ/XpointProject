//
//  QMChatRoomMoreView.m
//  IMSDK-OC
//
//  Created by HCF on 16/3/10.
//  Copyright © 2016年 HCF. All rights reserved.
//

#import "QMChatRoomMoreView.h"

@implementation QMChatRoomMoreView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createView];
    }
    return self;
}

- (void)createView {    
    // 获取相册图片
    self.takePicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.takePicBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-60*4)/5, 15, 60, 60);
    [self addSubview:self.takePicBtn];
    UILabel * takePicLabel = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-60*4)/5, 80, 60, 15)];
    takePicLabel.text = NSLocalizedString(@"button.chat_img", nil);
    [self.takePicBtn setBackgroundImage:[UIImage imageNamed:@"sharemore_ album"] forState:UIControlStateNormal];
    takePicLabel.font = [UIFont systemFontOfSize:13];
    takePicLabel.textColor = [UIColor lightGrayColor];
    takePicLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:takePicLabel];
    
    // 获取本地文件
    self.takeFileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.takeFileBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-60*4)/5*2+60, 15, 60, 60);
    [self addSubview:self.takeFileBtn];
    UILabel * takeFileLabel = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-60*4)/5*2+60, 80, 60, 15)];
    takeFileLabel.text = NSLocalizedString(@"button.chat_file", nil);
    [self.takeFileBtn setBackgroundImage:[UIImage imageNamed:@"sharemore_folder"] forState:UIControlStateNormal];
    takeFileLabel.font = [UIFont systemFontOfSize:13];
    takeFileLabel.textAlignment = NSTextAlignmentCenter;
    takeFileLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:takeFileLabel];
    
    // 进行服务评价
    self.evaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.evaluateBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-60*4)/5*3+120, 15, 60, 60);
    [self addSubview:self.evaluateBtn];
    self.evaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-60*4)/5*3+120, 80, 60, 15)];
    self.evaluateLabel.text = NSLocalizedString(@"button.chat_evaluate", nil);
    [self.evaluateBtn setBackgroundImage:[UIImage imageNamed:@"sharemore_evalue"] forState:UIControlStateNormal];
    self.evaluateLabel.font = [UIFont systemFontOfSize:13];
    self.evaluateLabel.textAlignment = NSTextAlignmentCenter;
    self.evaluateLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.evaluateLabel];
}

@end
