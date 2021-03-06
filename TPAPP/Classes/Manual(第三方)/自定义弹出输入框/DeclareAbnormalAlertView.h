//
//  DeclareAbnormalAlertView.h
//  iDeliver
//
//  Created by 蔡强 on 2017/4/3.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

//========== 申报异常弹窗 ==========//

#import <UIKit/UIKit.h>
#import "CompileCell.h"
#import "specsModel.h"
/**
 弹窗上的按钮

 - AlertButtonLeft: 左边的按钮
 - AlertButtonRight: 右边的按钮
 */
typedef NS_ENUM(NSUInteger, AbnormalButton) {
    AlertButtonLeft = 0,
    AlertButtonRight
};


#pragma mark - 协议

@class DeclareAbnormalAlertView;

@protocol DeclareAbnormalAlertViewDelegate <NSObject>

- (void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex selectCell:(CompileCell *)cell selectSpesModel:(specsModel *)model;

@end
@protocol DeclareAbnormalAlertViewOrderListRemindDelegate <NSObject>

- (void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex selectType:(NSString *)type comGoodList:(MineIndentModel *)minModel;

@end
@protocol DeclareAbnormalAlertViewRemindDelegate <NSObject>

- (void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex comGoodList:(NSMutableArray *)goodListArr;

@end
#pragma mark - interface

/** 申报异常弹窗 */
@interface DeclareAbnormalAlertView : UIView

/** 这个弹窗对应的orderID */
@property (nonatomic,copy) NSString *orderID;
/** 用户填写异常情况的textView */
@property (nonatomic,strong) UITextView *textView;
/** 左边按钮title */
@property (nonatomic,copy)   NSString *leftButtonTitle;
/** 右边按钮title */
@property (nonatomic,copy)   NSString *rightButtonTitle;
@property (nonatomic,weak) id<DeclareAbnormalAlertViewDelegate> delegate;
@property (nonatomic,weak) id<DeclareAbnormalAlertViewRemindDelegate> remindDelegate;
@property (nonatomic,weak) id<DeclareAbnormalAlertViewOrderListRemindDelegate> orderListRemindDelegate;
/**
 申报异常弹窗的构造方法

 @param title 弹窗标题
 @param message 弹窗message
 @param delegate 确定代理方
 @param leftButtonTitle 左边按钮的title
 @param rightButtonTitle 右边按钮的title
 @return 一个申报异常的弹窗
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle comCell:(CompileCell *)cell isAddGood:(BOOL)isAddGood spesmodel:(specsModel *)model;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message remind:(NSString *)remind delegate:(id)remindDelegate leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle comGoodList:(NSMutableArray *)goodListArr;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message selectType:(NSString *)type delegate:(id)orderRemindDelegate leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle comGoodList:(MineIndentModel *)minModel;
/** show出这个弹窗 */
- (void)show;

@end
