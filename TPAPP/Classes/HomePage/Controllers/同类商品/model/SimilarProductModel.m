//
//  SimilarProductModel.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "SimilarProductModel.h"
#import "imagesListModel.h"
#import "specsModel.h"
@implementation SimilarProductModel
+(NSDictionary*)mj_objectClassInArray{
    
    return @{@"imagesList":[imagesListModel class],@"specs":[specsModel class]};
}
@end
