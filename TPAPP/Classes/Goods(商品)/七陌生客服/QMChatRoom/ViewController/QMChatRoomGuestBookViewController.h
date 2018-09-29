//
//  QMChatRoomGuestBookViewController.h
//  IMSDK-OC
//
//  Created by HCF on 16/3/10.
//  Copyright © 2016年 HCF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QMChatRoomGuestBookViewController : UIViewController

@property (nonatomic ,strong)UILabel *messageLabel;
@property (nonatomic ,strong)UITextView *messageTextView;
@property (nonatomic ,strong)UILabel *textLabel;

@property (nonatomic ,strong)UILabel *messageLabel2;

@property (nonatomic ,strong)UIButton *submitBtn;

@property (nonatomic, copy) NSString *peerId; // 技能组ID

@property (nonatomic, copy) NSString *leaveMsg; // 留言内容

@property (nonatomic, copy) NSArray *contactFields; // 自定义联系字段

@property (nonatomic, copy) NSMutableDictionary *condition; // 联系信息

@property (nonatomic, assign) BOOL isScheduleLeave; //是否是日程管理留言

@end
