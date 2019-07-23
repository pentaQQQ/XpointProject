//
//  QMChatRoomEvaluationView.h
//  IMSDK-OC
//
//  Created by lishuijiao on 2019/1/9.
//  Copyright © 2019年 HCF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMLineSDK/QMLineSDK.h>
#import "radioContentView.h"

//@class radioContentView;

@interface QMChatRoomEvaluationView : UIView

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UIView *alpView;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *selectedButton;

@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) QMEvaluation *evaluation;//满意度

@property (nonatomic, strong) QMEvaluats *evaluats;//满意度评价详情

@property (nonatomic, strong) radioContentView *radioView;//标签View

@property (nonatomic, strong) radioContentView *optionView;//选项View

@property (nonatomic, copy) void(^cancelSelect)(void);

@property (nonatomic, copy) void(^sendSelect)(NSString *optionName, NSString *optionValue, NSArray *radioValue, NSString *textViewValue);

- (void)createUI;

@end

