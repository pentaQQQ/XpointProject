//
//  MSHttpTool.h
//  TestDemo
//
//  Created by Dylan on 11/11/2016.
//  Copyright © 2016 IdeaSource. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface MSHttpTool : NSObject

@property(nonatomic,strong)AFHTTPSessionManager * manager;
@property(nonatomic,strong)NSMutableArray * mgrTasksArray;

+(instancetype)sharedMSHttpTool;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
-(void)ms_postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

-(void)ms_getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

-(void)cancelAllTasks;

@end
