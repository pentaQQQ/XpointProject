//
//  ElseTableCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/20.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//
#define BUTTON_TAG 100000
#import "ElseTableCell.h"
#import "IndentControl.h"
@implementation ElseTableCell
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

    NSArray *iconsArr = @[@"icon_mine_tk",@"icon_mine_khdz",@"icon_mine_sqsh",@"icon_mine_weixin",@"icon_mine_yqyj"];
    NSArray *arr = @[@"退货/售后",@"客户对账",@"申请售后",@"微信公众号",@"邀请有奖"];
    for (int i = 0; i < arr.count; i++) {
        int wid_l = i%3;
        int hei_l = i/3;
        if (hei_l == 0) {
            //添加按钮
            IndentControl *indentCtrl = [[IndentControl alloc] initWithFrame:CGRectMake(0+(kScreenWidth/3)*wid_l, 15, kScreenWidth/3, 70)];
            [self.contentView addSubview:indentCtrl];
            indentCtrl.tag =BUTTON_TAG+i;
            indentCtrl.headIamgeView.image = [UIImage imageNamed:iconsArr[i]];
            [indentCtrl addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            indentCtrl.indentTypeLabel.text = arr[i];
            indentCtrl.indentTypeLabel.font = [UIFont systemFontOfSize:15];
        }else{
            //添加按钮
            IndentControl *indentCtrl = [[IndentControl alloc] initWithFrame:CGRectMake((kScreenWidth/3)/2+((kScreenWidth/3))*wid_l, 15+(70+15)*hei_l, kScreenWidth/3, 70)];
            [self.contentView addSubview:indentCtrl];
            indentCtrl.headIamgeView.image = [UIImage imageNamed:iconsArr[i]];
            indentCtrl.tag =BUTTON_TAG+i;
            [indentCtrl addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            indentCtrl.indentTypeLabel.text = arr[i];
            indentCtrl.indentTypeLabel.font = [UIFont systemFontOfSize:15];
        }


    }
//    NSArray *iconsArr = @[@"icon_mine_khdz",@"icon_mine_sqsh",@"icon_mine_weixin",@"icon_mine_yqyj"];
//    NSArray *arr = @[@"客户对账",@"申请售后",@"微信公众号",@"邀请有奖"];
//    for (int i = 0; i < arr.count; i++) {
//        int wid_l = i%4;
//        int hei_l = i/4;
////        if (hei_l == 0) {
//            //添加按钮
//            IndentControl *indentCtrl = [[IndentControl alloc] initWithFrame:CGRectMake(0+(kScreenWidth/4)*wid_l, 15+(70+15)*hei_l, kScreenWidth/4, 70)];
//            [self.contentView addSubview:indentCtrl];
//            indentCtrl.tag =BUTTON_TAG+i+1;
//            indentCtrl.headIamgeView.image = [UIImage imageNamed:iconsArr[i]];
//            [indentCtrl addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//            indentCtrl.indentTypeLabel.text = arr[i];
//            indentCtrl.indentTypeLabel.font = [UIFont systemFontOfSize:15];
////        }else{
////            //添加按钮
////            IndentControl *indentCtrl = [[IndentControl alloc] initWithFrame:CGRectMake((kScreenWidth/3)/2+((kScreenWidth/3))*wid_l, 15+(70+15)*hei_l, kScreenWidth/3, 70)];
////            [self.contentView addSubview:indentCtrl];
////            indentCtrl.headIamgeView.image = [UIImage imageNamed:iconsArr[i]];
////            indentCtrl.tag =BUTTON_TAG+i;
////            [indentCtrl addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
////            indentCtrl.indentTypeLabel.text = arr[i];
////            indentCtrl.indentTypeLabel.font = [UIFont systemFontOfSize:15];
////        }
//        
//        
//    }
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
