//
//  DeleteGoodsListCell.h
//  TPAPP
//
//  Created by Frank on 2018/9/7.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "MGSwipeTableCell.h"
#import "GoodsCartModel.h"
@class DeleteGoodsListCell;
@protocol SelectedReBuyDelegate <NSObject>

-(void)SelectedReBuyCell:(DeleteGoodsListCell *)cell;
-(void)SelectedLookImageListCell:(DeleteGoodsListCell *)cell;

@end
@interface DeleteGoodsListCell : MGSwipeTableCell
/**
 *  商品
 */
@property (nonatomic, retain)UILabel *Goods_Name;
/**
 *  商品介绍
 */
@property (nonatomic, retain)UILabel *Goods_Desc;

/**
 *  商品尺码
 */
@property (nonatomic, retain)UILabel *Goods_Size;
/**
 *  商品款号
 */
@property (nonatomic, retain)UILabel *Goods_DescNum;

/**
 *  商品的图片
 */
@property (nonatomic, retain)UIButton *Goods_Icon;
/**
 *  出售时价格
 */
@property (nonatomic, retain)UILabel *Goods_Price;
/**
 *  下单数量
 */
@property (nonatomic, retain)UILabel *Goods_Number;

/**
 *  备注
 */
@property (nonatomic, retain)UILabel *RemarksLabel;
/**
 * 重新下单按钮
 */
@property (nonatomic, retain)UIButton *ReBuy_button;
@property (nonatomic,strong)CartDetailsModel *detailModel;
-(void)withData:(CartDetailsModel *)info;

@property (nonatomic, weak)id<SelectedReBuyDelegate> SelectedDelegate;
@end
