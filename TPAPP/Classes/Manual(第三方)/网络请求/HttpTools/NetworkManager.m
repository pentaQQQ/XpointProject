//
//  NetworkManager.m
//  DoveSGD
//
//  Created by Dylan on 23/06/2017.
//  Copyright © 2017 IdeaSource. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager()
@property(nonatomic, strong)MSHttpTool * httpTool;

@end

@implementation NetworkManager

-(MSHttpTool *)httpTool{
    if (!_httpTool) {
        _httpTool = [MSHttpTool sharedMSHttpTool];
    }
    return _httpTool;
}

+ (NetworkManager *)sharedManager{
    static NetworkManager *controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] init];
    });
    return controller;
}


-(void)getCityData:(NSString *)api Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure
{

 
    [self.httpTool ms_postWithURL:api params:nil success:^(id json) {
        
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


-(void)postCityData:(NSString *)api Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure
{
    [self.httpTool ms_getWithURL:api params:nil success:^(id json) {
        
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}



-(void)getWithUrl:(NSString *)url
            param:(NSDictionary*)dic
          success:(void (^)(id json))success
          failure:(void (^)(NSError *error))failure{
    
    [self.httpTool ms_getWithURL:url params:dic success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}



-(void)postWithUrl:(NSString *)url
             param:(NSDictionary*)dic
           success:(void (^)(id json))success
           failure:(void (^)(NSError *error))failure{
    
    [self.httpTool ms_postWithURL:url params:dic success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}




@end
