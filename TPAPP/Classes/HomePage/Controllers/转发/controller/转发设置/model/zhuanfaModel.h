//
//  zhuanfaModel.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/9/5.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zhuanfaModel : NSObject
@property(nonatomic,copy)NSString *defaultImg;//默认转发图片
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *lackSize;//是否转发缺货尺码
@property(nonatomic,copy)NSString *num;//转发件数
@property(nonatomic,copy)NSString *price;//转发商品价格
@property(nonatomic,copy)NSString *userId;
@end
