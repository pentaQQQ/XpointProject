//
//  pickzhuangaView.h
//  TPAPP
//
//  Created by 崔文龙 on 2019/4/11.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface pickzhuangaView : UIView
@property(nonatomic,copy)void(^removeBlock)(void);

@property(nonatomic,copy)void(^zhuanfaBlock)(void);
@property(nonatomic,copy)void(^buzhuanfaBlock)(void);
@property(nonatomic,copy)void(^quxiaoBlock)(void);

-(void)removeView;
@end

NS_ASSUME_NONNULL_END
