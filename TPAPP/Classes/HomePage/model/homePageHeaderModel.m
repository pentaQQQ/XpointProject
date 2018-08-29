//
//  homePageHeaderModel.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "homePageHeaderModel.h"
#import "releaseActivitiesModel.h"
@implementation homePageHeaderModel



+(NSDictionary*)mj_objectClassInArray{
    
    return @{@"releaseActivities":[releaseActivitiesModel class]};
}

@end
