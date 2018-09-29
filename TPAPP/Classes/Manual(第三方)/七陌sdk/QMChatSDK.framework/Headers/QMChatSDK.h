//
//  QMChatSDK.h
//  QMChatSDK
//
//  Created by haochongfeng on 2017/11/8.
//  Copyright © 2017年 haochongfeng. All rights reserved.
//  SDK Version = 2.8.2

#import <UIKit/UIKit.h>

//! Project version number for QMChatSDK.
FOUNDATION_EXPORT double QMChatSDKVersionNumber;

//! Project version string for QMChatSDK.
FOUNDATION_EXPORT const unsigned char QMChatSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <QMChatSDK/PublicHeader.h>


#import <Qiniu/Qiniu.h>
#import <FMDB/FMDB.h>


/**
 *  注册accessId成功通知
 */
#define CUSTOM_LOGIN_SUCCEED @"customLoginSucceed"

/**
 *  注册accessId失败通知
 */
#define CUSTOM_LOGIN_ERROR_USER @"customLoginErrorUser"

/**
 *  新消息通知
 */
#define CHATMSG_RELOAD @"chatMsgReload"

/**
 *  机器人客服通知
 */
#define ROBOT_SERVICE @"robotService"

/**
 *  客服在线
 */
#define CUSTOMSRV_ONLINE @"CustomOnline"

/**
 *  客服不在线
 */
#define CUSTOMSRV_OFFLINE @"CustomOffline"

/**
 *  在线领取消息
 */
#define CUSTOMSRV_CLAIM @"customClaim"

/**
 *  后台主动推送满意度调查
 */
#define CUSTOMSRV_INVESTIGATE @"customsrvInvestigate"

/**
 *  排队人数通知
 */
#define CUSTOMSRV_QUEUENUM @"customsrvqueuenum"

/**
 *  结束会话通知
 */
#define CUSTOMSRV_FINISH @"customsrvfinish"

/**
 *  坐席信息通知
 */
#define CUSTOMSRV_AGENT @"customagent"

/**
 *  专属坐席通知
 */
#define CUSTOMSRV_VIP @"customvip"

/**
 * 日程管理中的留言通知 (只适用于开启日程管理的坐席)
 */
#define CUSTOMSRV_LEAVEMSG @"leavemsg"

/**
 * 正在输入
 */
#define CUSTOMSRV_IMPORTING @"importing"

/**
 * 撤回消息
 */
#define CUSTOMSRV_DRAWMESSAGE @"drawmessage"
