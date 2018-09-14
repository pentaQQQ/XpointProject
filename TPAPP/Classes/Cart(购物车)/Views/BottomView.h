//
//  BottomView.h
//  仿淘宝
//
//  Created by 郭军 on 2017/3/16.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BottomViewDelegate <NSObject>

//选中所有商品
-(void)DidSelectedAllGoods;
//取消选中所有商品
-(void)NoDidSelectedAllGoods;
//商品结算
-(void)BalanceSelectedGoods:(NSMutableArray *)arr goodsNum:(int)goodsNum goodsPrice:(NSString *)goodsPrice;
@end


@interface BottomView : UIView

-(void)init:(NSDictionary *)dict GoodsData:(NSMutableArray *)goods;

// 全选按钮状态
@property (nonatomic, assign)BOOL AllSelected;
//数据源
@property (nonatomic, strong)NSMutableArray *GoodsArr;
//结算商品件数
@property (nonatomic, assign)int GoodsNum;
//结算商品价格
@property (nonatomic, strong)NSString *GoodsPrice;

@property (nonatomic, weak)id<BottomViewDelegate> delegate;


@end
