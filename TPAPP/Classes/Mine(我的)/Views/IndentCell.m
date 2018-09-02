//
//  IndentCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/20.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//
#define BUTTON_TAG 1000
#import "IndentCell.h"
#import "IndentControl.h"
@implementation IndentCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = colorWithRGB(0xEEEEEE);
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    bgView.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomSpaceToView(self.contentView, 20);
    NSArray *icons = @[@"icon_mine_dzf",@"icon_mine_dfh",@"icon_mine_jhz",@"icon_mine_yfh",@"icon_mine_yqx"];
    NSArray *arr = @[@"代付款",@"代发货",@"拣货中",@"已发货",@"已取消"];
    for (int i = 0; i < arr.count; i++) {
        //添加按钮
        IndentControl *indentCtrl = [[IndentControl alloc] initWithFrame:CGRectMake(0+(kScreenWidth/5)*i, 15, kScreenWidth/5, 70)];
        [self.contentView addSubview:indentCtrl];
        indentCtrl.tag =BUTTON_TAG+i;
        indentCtrl.headIamgeView.image = [UIImage imageNamed:icons[i]];
        [indentCtrl addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        indentCtrl.indentTypeLabel.textColor = [UIColor blackColor];
        indentCtrl.indentTypeLabel.text = arr[i];
        indentCtrl.indentTypeLabel.font = [UIFont systemFontOfSize:15];
    }
}
- (void)btnAction:(IndentControl *)btn
{
    if (btn.tag == BUTTON_TAG) {
        self.selectBlcok(0);
    }else if (btn.tag == BUTTON_TAG +1 ) {
        self.selectBlcok(1);
    }else if (btn.tag == BUTTON_TAG +2 ) {
       self.selectBlcok(2);
    }else if (btn.tag == BUTTON_TAG +3 ) {
        self.selectBlcok(3);
    }else{
       self.selectBlcok(4);
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
