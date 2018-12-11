//
//  DeclareAbnormalAlertView.m
//  iDeliver
//
//  Created by 蔡强 on 2017/4/3.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

//========== 申报异常弹窗 ==========//

#import "DeclareAbnormalAlertView.h"
#import "UIColor+Util.h"
#import "UIView+frameAdjust.h"
#import "CompileCell.h"
#import "specsModel.h"
@interface DeclareAbnormalAlertView ()<UITextViewDelegate>

/** 弹窗主内容view */
@property (nonatomic,strong) UIView   *contentView;
/** 弹窗标题 */
@property (nonatomic,copy)   NSString *title;
/** 弹窗message */
@property (nonatomic,copy)   NSString *message;
/** message label */
@property (nonatomic,strong) UILabel  *messageLabel;

/** 弹窗remind */
@property (nonatomic,copy)   NSString *remind;
/** remind label */
@property (nonatomic,strong) UILabel  *remindLabel;


@property (nonatomic,strong) CompileCell *compileCell;
@property (nonatomic,assign) BOOL isAddGood;
@property (nonatomic, strong)specsModel *model;
@property (nonatomic, strong)NSMutableArray *goodListArr;


@property (nonatomic, strong)MineIndentModel *minModel;

@end

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation DeclareAbnormalAlertView{
    UILabel *label;
}

#pragma mark - 构造方法
/**
 申报异常弹窗的构造方法
 
 @param title 弹窗标题
 @param message 弹窗message
 @param delegate 确定代理方
 @param leftButtonTitle 左边按钮的title
 @param rightButtonTitle 右边按钮的title
 @return 一个申报异常的弹窗
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle comCell:(CompileCell *)cell isAddGood:(BOOL)isAddGood spesmodel:(specsModel *)model{
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.delegate = delegate;
        self.leftButtonTitle = leftButtonTitle;
        self.rightButtonTitle = rightButtonTitle;
        self.compileCell = cell;
        self.isAddGood = isAddGood;
        self.model = model;
        // 接收键盘显示隐藏的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        
        // UI搭建
        [self setUpUI];
    }
    return self;
}
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message remind:(NSString *)remind delegate:(id)remindDelegate leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle comGoodList:(NSMutableArray *)goodListArr
{
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.remind = remind;
        self.goodListArr  = goodListArr;
        self.remindDelegate = remindDelegate;
        self.leftButtonTitle = leftButtonTitle;
        self.rightButtonTitle = rightButtonTitle;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        
        // UI搭建
        [self setRemindUpUI];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message selectType:(NSString *)type delegate:(id)orderRemindDelegate leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle comGoodList:(MineIndentModel *)minModel
{
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.remind = type;
        self.minModel  = minModel;
        self.orderListRemindDelegate = orderRemindDelegate;
        self.leftButtonTitle = leftButtonTitle;
        self.rightButtonTitle = rightButtonTitle;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        
        // UI搭建
        [self setOrderListRemindUI];
    }
    return self;
}
- (void)setOrderListRemindUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
    //------- 弹窗主内容 -------//
    self.contentView = [[UIView alloc]init];
    self.contentView.frame = CGRectMake(40, (SCREEN_HEIGHT - 225-60) / 2, (SCREEN_WIDTH - 80), 225-60);
    self.contentView.center = self.center;
    [self addSubview:self.contentView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 6;
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.contentView.width, 30)];
    [self.contentView addSubview:titleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    
    // textView里面的占位label
    self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, titleLabel.maxY + 10, self.contentView.width - 40, 50)];
    self.messageLabel.text = self.message;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.numberOfLines = 2;
    self.messageLabel.font = [UIFont systemFontOfSize:15];
    self.messageLabel.textColor = [UIColor colorWithHexString:@"484848"];
    //        [self.messageLabel sizeToFit];
    [self.contentView addSubview:self.messageLabel];
    
    
    // 标题
//    self.remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.messageLabel.maxY + 10, self.contentView.width-40, 20)];
//    [self.contentView addSubview:self.remindLabel];
//    self.remindLabel.numberOfLines = 0;
//    self.remindLabel.font = [UIFont systemFontOfSize:15];
//    self.remindLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:87.0/255.0 blue:96.0/255.0 alpha:1.0];
//    //        [remindLabel sizeToFit];
//    self.remindLabel.textAlignment = NSTextAlignmentLeft;
//    self.remindLabel.text = self.remind;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.messageLabel.maxY + 10, self.contentView.width, 1)];
    topView.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
    [self.contentView addSubview:topView];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, topView.maxY, (self.contentView.width-1)/2, self.contentView.height-topView.maxY)];
    [self.contentView addSubview:cancelButton];
    [cancelButton setTitle:self.leftButtonTitle forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    cancelButton.layer.cornerRadius = 6;
    [cancelButton addTarget:self action:@selector(cancelOrderRemindButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake((self.contentView.width-1)/2, topView.maxY, 1, self.contentView.height-topView.maxY)];
    middleView.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
    [self.contentView addSubview:middleView];
    // 确定按钮
    UIButton *abnormalButton = [[UIButton alloc]initWithFrame:CGRectMake((self.contentView.width-1)/2+1, cancelButton.minY, (self.contentView.width-1)/2, self.contentView.height-topView.maxY)];
    [self.contentView addSubview:abnormalButton];
    [abnormalButton setTitleColor:[UIColor colorWithRed:255.0/255.0 green:87.0/255.0 blue:96.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [abnormalButton setTitle:self.rightButtonTitle forState:UIControlStateNormal];
    [abnormalButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    abnormalButton.layer.cornerRadius = 6;
    [abnormalButton addTarget:self action:@selector(abnormalOrderRemindButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    //------- 调整弹窗高度和中心 -------//
    self.contentView.center = self.center;
    
}
- (void)cancelOrderRemindButtonClicked
{
    if ([self.orderListRemindDelegate respondsToSelector:@selector(declareAbnormalAlertView:clickedButtonAtIndex:selectType:comGoodList:)]) {
        [self.orderListRemindDelegate declareAbnormalAlertView:self clickedButtonAtIndex:AlertButtonLeft selectType:self.remind comGoodList:self.minModel];
    }
    [self dismiss];
}

- (void)abnormalOrderRemindButtonClicked
{
    if ([self.orderListRemindDelegate respondsToSelector:@selector(declareAbnormalAlertView:clickedButtonAtIndex:selectType:comGoodList:)]) {
        [self.orderListRemindDelegate declareAbnormalAlertView:self clickedButtonAtIndex:AlertButtonRight selectType:self.remind comGoodList:self.minModel];
    }
    [self dismiss];
    
}
- (void)setRemindUpUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
        //------- 弹窗主内容 -------//
        self.contentView = [[UIView alloc]init];
        self.contentView.frame = CGRectMake(40, (SCREEN_HEIGHT - 245-60) / 2, (SCREEN_WIDTH - 80), 245-60);
        self.contentView.center = self.center;
        [self addSubview:self.contentView];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 6;
        
        // 标题
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.contentView.width, 30)];
        [self.contentView addSubview:titleLabel];
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = self.title;
    
        // textView里面的占位label
        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, titleLabel.maxY + 10, self.contentView.width - 40, 40)];
        self.messageLabel.text = self.message;
        self.messageLabel.numberOfLines = 2;
        self.messageLabel.font = [UIFont systemFontOfSize:15];
        self.messageLabel.textColor = [UIColor colorWithHexString:@"484848"];
//        [self.messageLabel sizeToFit];
        [self.contentView addSubview:self.messageLabel];
    
    
        // 标题
        self.remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.messageLabel.maxY + 10, self.contentView.width-40, 20)];
        [self.contentView addSubview:self.remindLabel];
        self.remindLabel.numberOfLines = 0;
        self.remindLabel.font = [UIFont systemFontOfSize:15];
        self.remindLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:87.0/255.0 blue:96.0/255.0 alpha:1.0];
        //        [remindLabel sizeToFit];
        self.remindLabel.textAlignment = NSTextAlignmentLeft;
        self.remindLabel.text = self.remind;
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.remindLabel.maxY + 10, self.contentView.width, 1)];
        topView.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
        [self.contentView addSubview:topView];
        
        // 取消按钮
        UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, topView.maxY, (self.contentView.width-1)/2, self.contentView.height-topView.maxY)];
        [self.contentView addSubview:cancelButton];
        [cancelButton setTitle:self.leftButtonTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        cancelButton.layer.cornerRadius = 6;
        [cancelButton addTarget:self action:@selector(cancelRemindButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake((self.contentView.width-1)/2, topView.maxY, 1, self.contentView.height-topView.maxY)];
        middleView.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
        [self.contentView addSubview:middleView];
        // 确定按钮
        UIButton *abnormalButton = [[UIButton alloc]initWithFrame:CGRectMake((self.contentView.width-1)/2+1, cancelButton.minY, (self.contentView.width-1)/2, self.contentView.height-topView.maxY)];
        [self.contentView addSubview:abnormalButton];
        [abnormalButton setTitleColor:[UIColor colorWithRed:255.0/255.0 green:87.0/255.0 blue:96.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [abnormalButton setTitle:self.rightButtonTitle forState:UIControlStateNormal];
        [abnormalButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        abnormalButton.layer.cornerRadius = 6;
        [abnormalButton addTarget:self action:@selector(abnormalRemindButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        //------- 调整弹窗高度和中心 -------//
        self.contentView.center = self.center;
    
}
- (void)cancelRemindButtonClicked
{
    if ([self.remindDelegate respondsToSelector:@selector(declareAbnormalAlertView:clickedButtonAtIndex:comGoodList:)]) {
        [self.remindDelegate declareAbnormalAlertView:self clickedButtonAtIndex:AlertButtonLeft comGoodList:self.goodListArr];
    }
    [self dismiss];
}

- (void)abnormalRemindButtonClicked
{
    if ([self.remindDelegate respondsToSelector:@selector(declareAbnormalAlertView:clickedButtonAtIndex:comGoodList:)]) {
        [self.remindDelegate declareAbnormalAlertView:self clickedButtonAtIndex:AlertButtonRight comGoodList:self.goodListArr];
    }
    [self dismiss];
    
}
#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
    if (self.isAddGood) {
        //------- 弹窗主内容 -------//
        self.contentView = [[UIView alloc]init];
        self.contentView.frame = CGRectMake(40, (SCREEN_HEIGHT - 245) / 2, (SCREEN_WIDTH - 80), 245);
        self.contentView.center = self.center;
        [self addSubview:self.contentView];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 6;
        
        // 标题
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.contentView.width, 30)];
        [self.contentView addSubview:titleLabel];
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = self.title;
        
        // 填写异常情况描述的textView
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(22, titleLabel.maxY + 10, self.contentView.width - 44, 80)];
        [self.contentView addSubview:self.textView];
        self.textView.layer.borderWidth = 1.0;
        self.textView.layer.borderColor = [UIColor colorWithHexString:@"e0e0e0"].CGColor;
        self.textView.font = [UIFont systemFontOfSize:12];
        [self.textView becomeFirstResponder];
        self.textView.delegate = self;
        
        // textView里面的占位label
        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, self.textView.width - 16, self.textView.height - 16)];
        self.messageLabel.text = self.message;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.font = [UIFont systemFontOfSize:12];
        self.messageLabel.textColor = [UIColor colorWithHexString:@"484848"];
        [self.messageLabel sizeToFit];
        [self.textView addSubview:self.messageLabel];
        
        // 标题
        UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(22, self.textView.maxY + 10, self.contentView.width-44, 30)];
        [self.contentView addSubview:remindLabel];
        remindLabel.numberOfLines = 0;
        remindLabel.font = [UIFont systemFontOfSize:12];
        remindLabel.textColor = [UIColor colorWithHexString:@"484848"];
//        [remindLabel sizeToFit];
        remindLabel.textAlignment = NSTextAlignmentLeft;
        remindLabel.text = @"您可以在设置中关闭备注开关，该确认框将不再显示";
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, remindLabel.maxY + 20, self.contentView.width, 1)];
        topView.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
        [self.contentView addSubview:topView];
        
        // 取消按钮
        UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, topView.maxY, (self.contentView.width-1)/2, self.contentView.height-topView.maxY)];
        [self.contentView addSubview:cancelButton];
        [cancelButton setTitle:self.leftButtonTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        cancelButton.layer.cornerRadius = 6;
        [cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake((self.contentView.width-1)/2, topView.maxY, 1, self.contentView.height-topView.maxY)];
        middleView.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
        [self.contentView addSubview:middleView];
        // 确定按钮
        UIButton *abnormalButton = [[UIButton alloc]initWithFrame:CGRectMake((self.contentView.width-1)/2+1, cancelButton.minY, (self.contentView.width-1)/2, self.contentView.height-topView.maxY)];
        [self.contentView addSubview:abnormalButton];
        [abnormalButton setTitleColor:[UIColor colorWithRed:255.0/255.0 green:87.0/255.0 blue:96.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [abnormalButton setTitle:self.rightButtonTitle forState:UIControlStateNormal];
        [abnormalButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        abnormalButton.layer.cornerRadius = 6;
        [abnormalButton addTarget:self action:@selector(abnormalButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        //------- 调整弹窗高度和中心 -------//
        self.contentView.center = self.center;
    }else{
        //------- 弹窗主内容 -------//
        self.contentView = [[UIView alloc]init];
        self.contentView.frame = CGRectMake(40, (SCREEN_HEIGHT - 215) / 2, (SCREEN_WIDTH - 80), 215);
        self.contentView.center = self.center;
        [self addSubview:self.contentView];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 6;
        
        // 标题
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.contentView.width, 30)];
        [self.contentView addSubview:titleLabel];
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = self.title;
        
        // 填写异常情况描述的textView
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(22, titleLabel.maxY + 10, self.contentView.width - 44, 80)];
        [self.contentView addSubview:self.textView];
        self.textView.layer.borderWidth = 1.0;
        self.textView.layer.borderColor = [UIColor colorWithHexString:@"e0e0e0"].CGColor;
        self.textView.font = [UIFont systemFontOfSize:12];
        [self.textView becomeFirstResponder];
        self.textView.delegate = self;
        
        // textView里面的占位label
        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, self.textView.width - 16, self.textView.height - 16)];
        self.messageLabel.text = self.message;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.font = [UIFont systemFontOfSize:12];
        self.messageLabel.textColor = [UIColor colorWithHexString:@"484848"];
        [self.messageLabel sizeToFit];
        [self.textView addSubview:self.messageLabel];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.textView.maxY + 20, self.contentView.width, 1)];
        topView.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
        [self.contentView addSubview:topView];
        
        // 取消按钮
        UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, topView.maxY, (self.contentView.width-1)/2, self.contentView.height-topView.maxY)];
        [self.contentView addSubview:cancelButton];
        [cancelButton setTitle:self.leftButtonTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        cancelButton.layer.cornerRadius = 6;
        [cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake((self.contentView.width-1)/2, topView.maxY, 1, self.contentView.height-topView.maxY)];
        middleView.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
        [self.contentView addSubview:middleView];
        // 确定按钮
        UIButton *abnormalButton = [[UIButton alloc]initWithFrame:CGRectMake((self.contentView.width-1)/2+1, cancelButton.minY, (self.contentView.width-1)/2, self.contentView.height-topView.maxY)];
        [self.contentView addSubview:abnormalButton];
        [abnormalButton setTitleColor:[UIColor colorWithRed:255.0/255.0 green:87.0/255.0 blue:96.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [abnormalButton setTitle:self.rightButtonTitle forState:UIControlStateNormal];
        [abnormalButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        abnormalButton.layer.cornerRadius = 6;
        [abnormalButton addTarget:self action:@selector(abnormalButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        //------- 调整弹窗高度和中心 -------//
        self.contentView.center = self.center;
    }
    
}

#pragma mark - 弹出此弹窗
/** 弹出此弹窗 */
- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

#pragma mark - 移除此弹窗
/** 移除此弹窗 */
- (void)dismiss{
    [self removeFromSuperview];
}

#pragma mark - 申报异常按钮点击
/** 申报异常按钮点击 */
- (void)abnormalButtonClicked{
    if ([self.delegate respondsToSelector:@selector(declareAbnormalAlertView:clickedButtonAtIndex:selectCell:selectSpesModel:)]) {
        [self.delegate declareAbnormalAlertView:self clickedButtonAtIndex:AlertButtonRight selectCell:self.compileCell selectSpesModel:self.model];
    }
    [self dismiss];
}

#pragma mark - 取消按钮点击
/** 取消按钮点击 */
- (void)cancelButtonClicked{
    if ([self.delegate respondsToSelector:@selector(declareAbnormalAlertView:clickedButtonAtIndex:selectCell:selectSpesModel:)]) {
        [self.delegate declareAbnormalAlertView:self clickedButtonAtIndex:AlertButtonLeft selectCell:self.compileCell selectSpesModel:self.model];
    }
    [self dismiss];
}

#pragma mark - UITextView代理方法
- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        self.messageLabel.hidden = NO;
    }else{
        self.messageLabel.hidden = YES;
    }
}

/**
 *  键盘将要显示
 *
 *  @param notification 通知
 */
-(void)keyboardWillShow:(NSNotification *)notification
{
    // 获取到了键盘frame
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = frame.size.height;
    
    self.contentView.maxY = SCREEN_HEIGHT - keyboardHeight - 10;
}
/**
 *  键盘将要隐藏
 *
 *  @param notification 通知
 */
-(void)keyboardWillHidden:(NSNotification *)notification
{
    // 弹窗回到屏幕正中
    self.contentView.centerY = SCREEN_HEIGHT / 2;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
}

@end
