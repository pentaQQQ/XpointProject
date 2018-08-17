//
//  UIBarButtonItem+Create.h
//  GoodDemo
//
//  Created by George on 16/8/25.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIBarButtonItem (Create)

//+(instancetype)createWithTitle:(NSString *)title complete:(void(^)(void))block;
//+(instancetype)createWithImage:(NSString *)image complete:(void(^)(void))block;

-(instancetype)initWithTitle:(NSString *)title complete:(void(^)(void))block;
-(instancetype)initWithImage:(NSString *)image complete:(void(^)(void))block;

@end
