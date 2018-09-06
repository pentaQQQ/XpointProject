//
//  GoodsCartModel.m
//  TPAPP
//
//  Created by frank on 2018/9/5.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "GoodsCartModel.h"
#import "SimilarProductModel.h"
@implementation GoodsCartModel

+(NSDictionary*)mj_objectClassInArray{
    
    return @{@"cartDetails":[CartDetailsModel class],@"likes":[GoodsLikeModel class]};
}

@end
@implementation GoodsLikeModel


@end

@implementation CartDetailsModel


@end
