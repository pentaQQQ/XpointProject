//
//  UIBarButtonItem+Create.m
//  GoodDemo
//
//  Created by George on 16/8/25.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "UIBarButtonItem+Create.h"
#import <objc/runtime.h>



@implementation UIBarButtonItem (Create)

static char item_a;

#pragma mark --
-(instancetype)initWithTitle:(NSString *)title complete:(void(^)(void))block {

    objc_setAssociatedObject(self, &item_a, block, OBJC_ASSOCIATION_COPY);

    return [self initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(handleItemAction)];
}


-(instancetype)initWithImage:(NSString *)image complete:(void(^)(void))block {

    objc_setAssociatedObject(self, &item_a, block, OBJC_ASSOCIATION_COPY);
    
    return [self initWithImage:[UIImage imageNamed:image] style:UIBarButtonItemStylePlain target:self action:@selector(handleItemAction)];
}

-(void)handleItemAction {
    
    if (objc_getAssociatedObject(self, &item_a)) {
        ((void (^)())objc_getAssociatedObject(self, &item_a))();
    }
}

@end


