 //
//  MSHttpTool.m
//  TestDemo
//
//  Created by Dylan on 11/11/2016.
//  Copyright © 2016 IdeaSource. All rights reserved.
//

#import "MSHttpTool.h"
#import "Debug.h"
@implementation MSHttpTool

SYNTHESIZE_SINGLETON_FOR_CLASS(MSHttpTool)

-(NSMutableArray *)mgrTasksArray{
    if (!_mgrTasksArray) {
        _mgrTasksArray = [NSMutableArray new];
    }
    return _mgrTasksArray;
}

-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager =  [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html",@"text/plain", nil];
        
        NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
        
        [_manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    return _manager;
}


//自定义
-(void)ms_postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    NSURLSessionDataTask * task = [self postWithURL:url params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    [self.mgrTasksArray addObject:task];
}

-(void)ms_getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    
    NSURLSessionDataTask * task = [self getWithURL:url params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    [self.mgrTasksArray addObject:task];

    
}




-(void)ms_putWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    
    NSURLSessionDataTask * task = [self putWithURL:url params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    [self.mgrTasksArray addObject:task];
    
    
}





-(void)ms_deleteWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    
    NSURLSessionDataTask * task = [self deleteWithURL:url params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    [self.mgrTasksArray addObject:task];
    
    
}




-(void)cancelAllTasks{
    for (NSURLSessionDataTask * task in self.mgrTasksArray) {
        [task cancel];
        [self.mgrTasksArray removeObject:task];
    }
    [self.mgrTasksArray removeAllObjects];
}




#pragma mark - PrivateMethod

//封装AF

- (NSURLSessionDataTask *)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    [_manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    NSURLSessionDataTask * task = [self.manager GET:url parameters:params  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    return task;
}


- (NSURLSessionDataTask *)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    [_manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    NSURLSessionDataTask * task = [self.manager POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
   
    return task;
}

- (NSURLSessionDataTask *)postBodyWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    [_manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    NSURLSessionDataTask * task = [self.manager POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    return task;
}

- (NSURLSessionDataTask *)putWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    [_manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    NSURLSessionDataTask * task = [self.manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    return task;
}



- (NSURLSessionDataTask *)deleteWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    [_manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    NSURLSessionDataTask * task = [self.manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    return task;
}






@end
