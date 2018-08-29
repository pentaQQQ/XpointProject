//
//  homePageHeaderModel.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface homePageHeaderModel : NSObject<MJKeyValue>
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *labelName;
@property(nonatomic,strong)NSArray *releaseActivities;
@end
