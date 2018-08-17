//
//  SGNormalPickerView.m
//  Choose
//
//  Created by George on 2016/12/7.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "SGNormalPickerView.h"

@interface SGNormalPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSString *sureButtonTitle;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIButton *coverView;

/** 信息提示Label */
@property (nonatomic, strong) UILabel *messageLabel;
/** 取消按钮 */
@property (nonatomic, strong) UIButton *cancelButton;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *sureButton;
/** 底部弹出视图 */
@property (nonatomic, strong) UIView *sheetView;

//@property (nonatomic, copy  ) NSString *selectedString;
@property (nonatomic, copy  ) void(^selectBlock)(NSString *text);
@end

@implementation SGNormalPickerView

/** 底部View弹出的时间 */
static CGFloat const sheetViewAnimationDuration = 0.5;
static CGFloat const sheetViewHeight = 220;


- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle sureButtonTitle:(NSString *)sureButtonTitle dataArray:(NSArray *)dataArray selectBlock:(void(^)(NSString *text))selectBlock {
    
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        
        self.title = title;
        self.cancelButtonTitle = cancelButtonTitle;
        self.sureButtonTitle = sureButtonTitle;
        self.dataArray = dataArray;
        self.selectBlock = selectBlock;
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    // 遮盖视图
    self.coverView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.coverView.frame = self.bounds;
    [self.coverView addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.coverView];
    
    
    self.sheetView = [UIView new];
    self.sheetView.backgroundColor = colorWithRGB(0xDDDDDD);
    self.sheetView.frame = CGRectMake(0, self.height, self.width, sheetViewHeight);
    [self.coverView addSubview:self.sheetView];
    
    // 取消按钮的创建
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setTitle:self.cancelButtonTitle forState:(UIControlStateNormal)];
    _cancelButton.titleLabel.font = font(15);
    [_cancelButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"SGActionSheet.bundle/cell_bg_image"] forState:(UIControlStateNormal)];
    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"SGActionSheet.bundle/cell_bg_image_high@2x"] forState:(UIControlStateHighlighted)];
    [_cancelButton addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 确定按钮的创建
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureButton setTitle:self.sureButtonTitle forState:(UIControlStateNormal)];
    [_sureButton.titleLabel setFont:font(15)];
    [_sureButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_sureButton setBackgroundImage:[UIImage imageNamed:@"SGActionSheet.bundle/cell_bg_image"] forState:(UIControlStateNormal)];
    [_sureButton setBackgroundImage:[UIImage imageNamed:@"SGActionSheet.bundle/cell_bg_image_high@2x"] forState:(UIControlStateHighlighted)];
    [_sureButton jk_addActionHandler:^(NSInteger tag) {
        if (self.selectBlock && self.selectedString) {
            self.selectBlock(self.selectedString);
            [self dismiss];
        }
    }];
    
    // 提示标题
    self.messageLabel = [UILabel new];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.numberOfLines = 0;
    _messageLabel.backgroundColor = [UIColor whiteColor];
    _messageLabel.text = self.title;
    _messageLabel.font = font(17);
    
    
    [self.sheetView addSubview:self.messageLabel];
    [self.sheetView addSubview:self.cancelButton];
    [self.sheetView addSubview:self.sureButton];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.sheetView);
        make.height.mas_equalTo(44);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sheetView);
        make.left.equalTo(self.sheetView).offset(-0.25);
        make.width.equalTo(self.sheetView).multipliedBy(0.5).insets(UIEdgeInsetsMake(0, 0, 0, 1));
        make.height.mas_equalTo(44);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sheetView);
        make.right.equalTo(self.sheetView).offset(0.25);
        make.width.equalTo(self.sheetView).multipliedBy(0.5);
        make.height.equalTo(self.cancelButton);
    }];
    
    self.pickerView = [UIPickerView new];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    [self.sheetView addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.sheetView);
        make.top.equalTo(self.messageLabel.mas_bottom).offset(0.5);
        make.bottom.equalTo(self.cancelButton.mas_top).offset(-0.5);
    }];
    [self.coverView addSubview:_sheetView];
}

-(NSInteger)indexOfSelectedElement:(NSArray *)dataArray {
    if (self.selectedString == nil || self.selectedString.length == 0) {
        return 0;
    }
    for (int i = 0; i<dataArray.count; i++) {
        if ([dataArray[i] isEqualToString:self.selectedString]) {
            return i;
        }
    }
    return 0;
}

- (void)show {
    if (self.superview != nil) return;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:sheetViewAnimationDuration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.sheetView.frame = CGRectMake(0, self.height-sheetViewHeight, self.width, sheetViewHeight);
        
    } completion:^(BOOL finished) {
        [self.pickerView selectRow:[self indexOfSelectedElement:self.dataArray] inComponent:0 animated:YES];
    }];
}

/** 点击按钮以及遮盖部分执行的方法 */
- (void)dismiss {

    [UIView animateWithDuration:sheetViewAnimationDuration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        self.sheetView.frame = CGRectMake(0, self.height, self.width, sheetViewHeight);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}




#pragma mark - - - UIPickerViewDataSource - UIPickerViewDelegate
// 返回列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
// 每列多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

// 返回当前行的内容, 此处是将数组中数值添加到滚动的那个显示栏上
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArray[row];
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return pickerView.width;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 36;
}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"did select row is %@", self.dataArray[row]);
    self.selectedString = self.dataArray[row];
}

/** 自定义component内容 */
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = [UILabel new];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = [self.dataArray objectAtIndex:row];
    
    label.font = [UIFont systemFontOfSize:16];         //用label来设置字体大小
    
    return label;
}



@end
