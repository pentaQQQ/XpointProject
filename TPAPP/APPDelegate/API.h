//
//  API.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#ifndef API_h
#define API_h

#define kBaseUrl           @"http://47.92.193.30/"



//获取首页标签及内容
#define getMainResources [NSString stringWithFormat:@"%@%@",kBaseUrl,@"api/main/getMainResources"]

//根据活动查询商品信息，返回所有已上架商品
#define getProductByActivityId [NSString stringWithFormat:@"%@%@",kBaseUrl,@"api/main/getProductByActivityId"]











#endif /* API_h */
