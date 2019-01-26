//
//  CouponsSegment.h
//  Fxapp
//
//  Created by Frank on 2018/11/1.
//  Copyright © 2018年 琅琊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SegmentDelegate <NSObject>
@optional
- (void)scrollToPage:(int)page;
@end
@interface CouponsSegment : UIView
//{
//    id <SegmentDelegate> delegate;
//}

@property (nonatomic, weak) id <SegmentDelegate> delegate;
//@property (nonatomic, weak)void(^selectBlock)(NSInteger num);
@property(nonatomic, assign) CGFloat maxWidth;
@property(nonatomic,strong)NSMutableArray *titleList;
@property(nonatomic,strong)NSMutableArray *buttonList;
@property(nonatomic,weak)CALayer *LGLayer;
@property(nonatomic,assign)CGFloat bannerNowX;
-(void)moveToOffsetX:(CGFloat)X;
@end

NS_ASSUME_NONNULL_END
