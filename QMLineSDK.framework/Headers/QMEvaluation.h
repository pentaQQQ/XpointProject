//
//  QMEvaluation.h
//  QMLineSDK
//
//  Created by lishuijiao on 2018/11/22.
//  Copyright © 2018年 haochongfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QMEvaluats;

@interface QMEvaluation : NSObject

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * thank;

@property (nonatomic, copy) NSArray<QMEvaluats *> * evaluats;

@end

@interface QMEvaluats : NSObject

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * value;

@property (nonatomic, copy) NSArray * reason;

@end
