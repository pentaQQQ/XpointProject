//
//  RefundCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/20.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//
#define BUTTON_TAG 10000
#import "RefundCell.h"
#import "MarketControl.h"
#import "IndentControl.h"
@implementation RefundCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
}
- (void)configWithMarketLimit:(NSMutableArray *)limitArr andLimitTitle:(NSMutableArray *)titleArr
{
    for (int i = 0; i < limitArr.count; i++) {
        //添加按钮
        MarketControl *markCtrl = [[MarketControl alloc] initWithFrame:CGRectMake(0+(kScreenWidth/5)*i, 10, kScreenWidth/5, 80)];
        [self.contentView addSubview:markCtrl];
        markCtrl.tag =BUTTON_TAG+i;
        [markCtrl addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        markCtrl.marketLimitLabel.textColor = colorWithRGB(0xFF6B24);
        markCtrl.marketLimitLabel.text = limitArr[i];
        markCtrl.marketLimitLabel.font = [UIFont systemFontOfSize:24];
        markCtrl.marketTypeLabel.text = titleArr[i];
        markCtrl.marketTypeLabel.font = [UIFont systemFontOfSize:14];
    }
}
- (void)btnAction:(MarketControl *)btn
{
    if (btn.tag == BUTTON_TAG) {
        
    }else if (btn.tag == BUTTON_TAG +1 ) {
        
    }else if (btn.tag == BUTTON_TAG +2 ) {
        
    }else if (btn.tag == BUTTON_TAG +3 ) {
        
    }else{
        
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
