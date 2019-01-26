//
//  releaseActivitiesModel.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface releaseActivitiesModel : NSObject<MJKeyValue>

@property(nonatomic,copy)NSString *beginTime;
@property(nonatomic,copy)NSString *beginTimes;
@property(nonatomic,copy)NSString *context;
@property(nonatomic,copy)NSString *endTime;
@property(nonatomic,copy)NSString *endTimes;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,strong)NSArray *imagesList;
@property(nonatomic,copy)NSString *merchantId;
@property(nonatomic,copy)NSString *merchantName;
@property(nonatomic,copy)NSString *merchantUrL;
@property(nonatomic,copy)NSString *typeac;



@end
