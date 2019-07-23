//
//  QMDateManager.h
//  IMSDK-OC
//
//  Created by haochongfeng on 2017/5/17.
//  Copyright © 2017年 HCF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMDateManager : NSObject

+ (NSString *)showChatTime:(NSString *)timeT;

+ (NSString*)getTimeStringAutoShort2:(NSDate*)dt mustIncludeTime:(BOOL)includeTime;

+ (NSString*)getTimeString:(NSDate*)dt format:(NSString*)fmt;

+ (NSTimeInterval) getIOSTimeStamp:(NSDate*)dat;

+ (long) getIOSTimeStamp_l:(NSDate*)dat;

@end
