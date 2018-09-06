//
//  MMImageListView.h
//  MomentKit
//
//  Created by LEA on 2017/12/14.
//  Copyright © 2017年 LEA. All rights reserved.
//
//  朋友圈动态 >> 小图区视图
//

#import <UIKit/UIKit.h>
#import "Moment.h"

@interface MMImageListView : UIView
// 长按图片的操作，可以外面传入
@property (strong,nonatomic) UIActionSheet *sheet;
// 动态
@property (nonatomic,strong) Moment *moment;
@property (nonatomic, strong)NSMutableArray *imagesListArray;
@end

//### 单个小图显示视图
@interface MMImageView : UIImageView

// 点击小图
@property (nonatomic, copy) void (^tapSmallView)(MMImageView *imageView);

@end

