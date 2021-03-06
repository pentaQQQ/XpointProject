//
//  CompileCell.h
//  JGTaoBaoShopping
//
//  Created by 郭军 on 2017/3/16.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "MGSwipeTableCell.h"
#import "GoodsCartModel.h"
@class CompileCell;
@protocol ShoppingSelectedDelegate <NSObject>

-(void)SelectedConfirmCell:(UITableViewCell *)cell;
-(void)SelectedCancelCell:(UITableViewCell *)cell;
-(void)SelectedRemarkCell:(CompileCell *)cell;
-(void)SelectedLookImageListCell:(CompileCell *)cell;
@end

@interface CompileCell : MGSwipeTableCell

/**
 *  商品
 */
@property (nonatomic, retain)UILabel *Goods_Name;
/**
 *  商品介绍
 */
@property (nonatomic, retain)UILabel *Goods_Desc;

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
 *  商品尺码
 */
@property (nonatomic, retain)UILabel *Goods_Size;
/**
 *  原始价格
 */
@property (nonatomic, retain)UILabel *Goods_OldPrice;
/**
 *  下单数量
 */
@property (nonatomic, retain)UILabel *Goods_Number;
/**
 *  选中按钮
 */
@property (nonatomic, retain)UIButton *Goods_Circle;
/**
 *  备注
 */
@property (nonatomic, retain)UILabel *RemarksLabel;
/**
 * 备注按钮
 */
@property (nonatomic, retain)UIButton *Remarks_button;

/**
 *  删除按钮
 */
@property (nonatomic, retain)UIButton *Goods_delete;

@property (nonatomic, strong)void(^deleteBlock)(CartDetailsModel *detailModel);

@property (nonatomic,strong)CartDetailsModel *detailModel;
-(void)withData:(CartDetailsModel *)info;

@property (nonatomic, weak)id<ShoppingSelectedDelegate> SelectedDelegate;


@end

