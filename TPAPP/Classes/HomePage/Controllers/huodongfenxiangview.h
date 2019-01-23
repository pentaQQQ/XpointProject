//
//  huodongfenxiangview.h
//  TPAPP
//
//  Created by 崔文龙 on 2019/1/23.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "releaseActivitiesModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface huodongfenxiangview : UIView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;


@property (weak, nonatomic) IBOutlet UIImageView *firstimageview;
@property (weak, nonatomic) IBOutlet UIImageView *secondimageview;

@property (weak, nonatomic) IBOutlet UIImageView *thirdImageview;
@property (weak, nonatomic) IBOutlet UIImageView *fourthImageview;


@property(nonatomic,strong)releaseActivitiesModel*model;


@end

NS_ASSUME_NONNULL_END
