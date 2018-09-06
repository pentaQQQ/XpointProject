//
//  ShareItem.h
//  iPhoneMY
//
//  Created by chenjie on 17/4/11.
//  Copyright © 2017年 LinChao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShareItem : NSObject

-(instancetype)initWithData:(UIImage *)img andFile:(NSURL *)file;

@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong) NSURL *path;

@end
