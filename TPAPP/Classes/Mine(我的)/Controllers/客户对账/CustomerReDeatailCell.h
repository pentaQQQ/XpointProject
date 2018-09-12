//
//  CustomerReDeatailCell.h
//  TPAPP
//
//  Created by Frank on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsCartModel.h"
@interface CustomerReDeatailCell : UITableViewCell
/**
 *  商品的图片
 */
@property (nonatomic, retain)UIImageView *Goods_Icon;
/**
 *  商品
 */
@property (nonatomic, retain)UILabel *Goods_Name;
/**
 *  款式
 */
@property (nonatomic, retain)UILabel *Goods_Desc;

/**
 *  商品款号
 */
@property (nonatomic, retain)UILabel *Goods_DescNum;
/**
 *  商品尺码
 */
@property (nonatomic, retain)UILabel *Goods_Size;

/**
 *  出售时价格
 */
@property (nonatomic, retain)UILabel *Goods_Price;


/**
 *  下单数量
 */
@property (nonatomic, retain)UILabel *Goods_Number;

/**
 *  交易
 */
@property (nonatomic, retain)UILabel *transactionLabel;
/**
 *  交易号
 */
@property (nonatomic, retain)UILabel *transactionNumLabel;

/**
 *  支付状态
 */
@property (nonatomic, retain)UILabel *paymentStatusLabel;
/**
 *  条码
 */
@property (nonatomic, retain)UILabel *codeLabel;



@property (nonatomic,strong)CartDetailsModel *detailModel;
-(void)withData:(CartDetailsModel *)info;
@end
