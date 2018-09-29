//
//  QMTextModel.h
//  IMSDK-OC
//
//  Created by haochongfeng on 2018/1/23.
//  Copyright © 2018年 HCF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMTextModel : NSObject

@property (nonatomic, copy)NSString *content;

@property (nonatomic, copy)NSString *type;

+ (CGFloat)calcRobotHeight: (NSString *)htmlString;

+ (CGFloat)calcTextHeight: (NSString *)text;
@end
