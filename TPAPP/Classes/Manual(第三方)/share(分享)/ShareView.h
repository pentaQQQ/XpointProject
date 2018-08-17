//
//  ShareView.h
//  Choose
//
//  Created by George on 16/11/24.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView


+(instancetype)shareWithDataArray:(NSArray *)dataArray didSelectIndex:(void(^)(NSInteger index))selectBlock;

@end
