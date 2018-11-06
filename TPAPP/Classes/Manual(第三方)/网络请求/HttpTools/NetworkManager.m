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





-(void)getWithUrl:(NSString *)url
            param:(NSDictionary*)dic
          success:(void (^)(id json))success
          failure:(void (^)(NSError *error))failure{
    
    [self.httpTool ms_getWithURL:url params:dic success:^(id json) {
        [self WeatherToLoginWithJson:json success:^(id json) {
            if (success) {
                success(json);
            }
        }];
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
        
        [self WeatherToLoginWithJson:json success:^(id json) {
            if (success) {
                success(json);
            }
        }];
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}




-(void)putWithUrl:(NSString *)url
             param:(NSDictionary*)dic
           success:(void (^)(id json))success
           failure:(void (^)(NSError *error))failure{
    
    [self.httpTool ms_putWithURL:url params:dic success:^(id json) {
        
        [self WeatherToLoginWithJson:json success:^(id json) {
            if (success) {
                success(json);
            }
        }];
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


-(void)deleteWithUrl:(NSString *)url
            param:(NSDictionary*)dic
          success:(void (^)(id json))success
          failure:(void (^)(NSError *error))failure{
    
    [self.httpTool ms_deleteWithURL:url params:dic success:^(id json) {
        
        [self WeatherToLoginWithJson:json success:^(id json) {
            if (success) {
                success(json);
            }
        }];
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}




-(void)WeatherToLoginWithJson:(id)json success:(void(^)(id json))success{
    
//    NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
//     NSString *code = [NSString stringWithFormat:@"%@",json[@"code"]];
//    NSLog(@"=================%@",respCode);
//    if ([respCode isEqualToString:@"90000"]) {
//        [SVProgressHUD doAnyRemindWithHUDMessage:@"登陆过期，请重新登录" withDuration:1.5];
//        [LYTools ToLogin];
//        return;
//    }else{
    
        success(json);
//    }
}









@end
