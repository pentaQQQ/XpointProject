//
//  TransforMessModel.h
//  TPAPP
//
//  Created by Frank on 2018/12/11.
//  Copyright © 2018 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TransforMessDetailModel;
@interface TransforMessModel : NSObject
@property (nonatomic, copy)NSString *com;
@property (nonatomic, copy)NSString *message;
@property (nonatomic, copy)NSString *nu;
@property (nonatomic, copy)NSString *state;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, strong)NSMutableArray<TransforMessDetailModel*> *data;
@end
@interface TransforMessDetailModel : NSObject
@property (nonatomic, copy)NSString *context;
@property (nonatomic, copy)NSString *time;
@end
