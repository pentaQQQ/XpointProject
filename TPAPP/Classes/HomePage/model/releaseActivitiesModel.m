//
//  releaseActivitiesModel.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "releaseActivitiesModel.h"
#import "imagesListModel.h"
@implementation releaseActivitiesModel


+(NSDictionary*)mj_objectClassInArray{
    
    return @{@"imagesList":[imagesListModel class]};
}



@end
