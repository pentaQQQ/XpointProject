//
//  CompileCell.m
//  JGTaoBaoShopping
//
//  Created by 郭军 on 2017/3/16.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "CompileCell.h"
#import "GoodsCartModel.h"
#import "MLLabel.h"

#define Image(name) [UIImage imageNamed:name]


@interface CompileCell ()
{
    NSString *Selected;
}
@end

@implementation CompileCell

//static BOOL Selected = NO;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _Goods_Circle = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Goods_Circle addTarget:self action:@selector(Selected) forControlEvents:UIControlEventTouchUpInside];
        
        _Goods_Icon = [[UIButton alloc] init];
        [_Goods_Icon addTarget:self action:@selector(goodsIconAction) forControlEvents:UIControlEventTouchUpInside];
        
        _Goods_Name = [[UILabel alloc]init];
        _Goods_Name.numberOfLines = 2;
        _Goods_Name.font = [UIFont systemFontOfSize:13];
        
        _Goods_Desc = [[UILabel alloc]init];
        _Goods_Desc.numberOfLines = 2;
        _Goods_Desc.font = [UIFont systemFontOfSize:12];
        _Goods_Desc.textColor = [UIColor blackColor];
        
        _Goods_DescNum = [[UILabel alloc]init];
        _Goods_DescNum.numberOfLines = 2;
        _Goods_DescNum.font = [UIFont systemFontOfSize:12];
        _Goods_DescNum.textColor = [UIColor blackColor];
        
        _Goods_Size = [[UILabel alloc]init];
        _Goods_Size.numberOfLines = 2;
        _Goods_Size.font = [UIFont systemFontOfSize:12];
        _Goods_Size.textColor = [UIColor blackColor];
        
        _Goods_Price = [[UILabel alloc]init];
        _Goods_Price.textColor = colorWithRGB(0xFF6B24);
        _Goods_Price.font = [UIFont systemFontOfSize:14];
        _Goods_Price.textAlignment = NSTextAlignmentRight;
        
//        _Goods_OldPrice = [[UILabel alloc]init];
//        _Goods_OldPrice.textColor = [UIColor grayColor];
//        _Goods_OldPrice.font = [UIFont systemFontOfSize:12];
        
        _Goods_Number = [[UILabel alloc]init];
        _Goods_Number.font = [UIFont systemFontOfSize:12];
        _Goods_Number.textAlignment = NSTextAlignmentRight;
        
        _RemarksLabel = [[UILabel alloc]init];
        _RemarksLabel.text = @"备注:";
        _RemarksLabel.textColor = colorWithRGB(0xFF6B24);
        _RemarksLabel.font = [UIFont systemFontOfSize:13];
        _RemarksLabel.numberOfLines = 2;
//        CGSize size = [_RemarksLabel sizeThatFits:CGSizeMake(_RemarksLabel.frame.size.width, MAXFLOAT)];
//        _RemarksLabel.frame = CGRectMake(_RemarksLabel.frame.origin.x, _RemarksLabel.frame.origin.y, _RemarksLabel.frame.size.width,size.height);
        _Goods_delete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Goods_delete setImage:[UIImage imageNamed:@"icon_shanchu"] forState:UIControlStateNormal];
        [_Goods_delete addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        
        _Remarks_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _Remarks_button.titleLabel.font = [UIFont systemFontOfSize:13];
        _Remarks_button.backgroundColor = colorWithRGB(0xFF6B24);
        [_Remarks_button setTitle:@"备注" forState:UIControlStateNormal];
        [_Remarks_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_Remarks_button addTarget:self action:@selector(remarkAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_Goods_Icon];
        [self.contentView addSubview:_Goods_Desc];
        [self.contentView addSubview:_Goods_DescNum];
        [self.contentView addSubview:_Goods_Size];
        
        [self.contentView addSubview:_Goods_Name];
        [self.contentView addSubview:_Goods_Price];
        
        [self.contentView addSubview:_Goods_Number];
        [self.contentView addSubview:_Goods_Circle];
        [self.contentView addSubview:_RemarksLabel];
        [self.contentView addSubview:_Goods_delete];
        [self.contentView addSubview:_Remarks_button];
        
        [_Goods_Circle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(5);
            make.width.equalTo(@(30));
            make.height.equalTo(@(30));
            make.top.equalTo(self).offset(45);
        }];
        
        [_Goods_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(40);
            make.top.equalTo(self).offset(15);
            make.height.equalTo(@(90));
            make.width.equalTo(@(90));
        }];
        
        [_Goods_Name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_Goods_Icon.mas_right).offset(8);
            make.top.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-60);
        }];
        
        [_Goods_Desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_Goods_Icon.mas_right).offset(8);
            make.top.equalTo(_Goods_Name.mas_bottom).offset(0);
            make.right.equalTo(self).offset(-60);
        }];
        
        [_Goods_DescNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_Goods_Icon.mas_right).offset(8);
            make.top.equalTo(_Goods_Desc.mas_bottom).offset(0);
            make.right.equalTo(self).offset(-60);
        }];
        
        [_Goods_Size mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_Goods_Icon.mas_right).offset(8);
            make.top.equalTo(_Goods_DescNum.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-60);
        }];
        
        [_Goods_Price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_Goods_Name.mas_right).offset(1);
            make.top.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(@(20));

        }];
        
//        [_RemarksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_Goods_Icon.mas_left).offset(0);
//            make.top.equalTo(_Goods_Icon.mas_bottom).offset(20);
//            make.right.equalTo(self).offset(-90);
////            make.height.equalTo(@(40));
//        }];
        
        
//        [_Goods_OldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_Goods_Price.mas_right).offset(8);
//            make.top.equalTo(_Goods_Desc.mas_bottom).offset(5);
//            make.height.equalTo(@(20));
//        }];
        
        [_Goods_Number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_Goods_Desc.mas_right).offset(8);
            make.top.equalTo(_Goods_Name.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(@(20));
        }];
        
        [_Goods_delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_Goods_Number.mas_bottom).offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(@(20));
            make.width.equalTo(@(20));
        }];
        
        
        [_Remarks_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-10);
            make.right.equalTo(self).offset(-10);
            make.width.equalTo(@(70));
            make.height.equalTo(@(25));
        }];
        _Remarks_button.layer.cornerRadius = 2;
        _Remarks_button.layer.masksToBounds = YES;
        [_RemarksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_Goods_Icon.mas_left).offset(0);
            make.top.equalTo(_Remarks_button.mas_top).offset(0);
            make.right.equalTo(self).offset(-90);
        }];
    }
    
    
    return self;
}
- (void)deleteAction
{
    self.deleteBlock(self.detailModel);
}
- (void)remarkAction
{
    [self.SelectedDelegate SelectedRemarkCell:self];
}

-(void)withData:(CartDetailsModel *)info
{
    self.detailModel = info;
   [_Goods_Circle setImage:Image(info.SelectedType) forState:UIControlStateNormal];
   [_Goods_Icon sd_setImageWithURL:[NSURL URLWithString:info.productImg]
                           forState:UIControlStateNormal
                   placeholderImage:Image(@"share_sina")];
    
    _Goods_Name.text = info.productName;
    _Goods_Desc.text = [NSString stringWithFormat:@"款式 %@",info.productForm.design];
    _Goods_DescNum.text = [NSString stringWithFormat:@"款号 %@",info.productForm.designCode];

    _Goods_Size.text = [NSString stringWithFormat:@"规格: %@",info.size];
    _Goods_Price.text = [NSString stringWithFormat:@"￥%@",info.productForm.marketAmount];
    
    //中划线
//    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"" attributes:attribtDic];
//    // 赋值
//    _Goods_OldPrice.attributedText = attribtStr;
    _Goods_Number.text = [NSString stringWithFormat:@"x%ld",(long)info.number];
    
    Selected = info.Type;
    
    if (info.remark.length == 0) {
        _RemarksLabel.text = @"备注:";
    }else{
    _RemarksLabel.text = [NSString stringWithFormat:@"备注:%@",info.remark];
    }

}

- (void)goodsIconAction
{
    [self.SelectedDelegate SelectedLookImageListCell:self];
}

-(void)Selected
{
    if ([Selected isEqualToString:@"0"]) {
        [self.SelectedDelegate SelectedConfirmCell:self];
        
    }else{
        [self.SelectedDelegate SelectedCancelCell:self];
    }
    
}

@end

