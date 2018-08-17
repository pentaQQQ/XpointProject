//
//  NetworkManager.h
//  DoveSGD
//
//  Created by Dylan on 23/06/2017.
//  Copyright © 2017 IdeaSource. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSHttpTool.h"
@interface NetworkManager : NSObject


+ (NetworkManager *)sharedManager;

-(void)postWithUrl:(NSString *)url
             param:(NSDictionary*)dic
           success:(void (^)(id json))success
           failure:(void (^)(NSError *error))failure;

-(void)getWithUrl:(NSString *)url
            param:(NSDictionary*)dic
          success:(void (^)(id json))success
          failure:(void (^)(NSError *error))failure;

-(void)getCityData:(NSString *)api Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure;

-(void)postCityData:(NSString *)api Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure;


@end
