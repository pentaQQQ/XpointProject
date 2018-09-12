//
//  CustomerReDeatailCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "CustomerReDeatailCell.h"
#import "GoodsCartModel.h"
@implementation CustomerReDeatailCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _Goods_Icon = [[UIImageView alloc] init];
        _Goods_Icon.backgroundColor = [UIColor grayColor];
        
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
        
        _codeLabel = [[UILabel alloc]init];
        _codeLabel.numberOfLines = 2;
        _codeLabel.font = [UIFont systemFontOfSize:12];
        _codeLabel.textColor = colorWithRGB(0xFF6B24);
        
        _Goods_Size = [[UILabel alloc]init];
        _Goods_Size.numberOfLines = 2;
        _Goods_Size.font = [UIFont systemFontOfSize:12];
        _Goods_Size.textColor = [UIColor blackColor];
        
        
        _Goods_Price = [[UILabel alloc]init];
        _Goods_Price.font = [UIFont systemFontOfSize:12];
        _Goods_Price.textAlignment = NSTextAlignmentRight;
        
        
//        _Goods_Number = [[UILabel alloc]init];
//        _Goods_Number.font = [UIFont systemFontOfSize:12];
//        _Goods_Number.textAlignment = NSTextAlignmentRight;
        
        _transactionLabel = [[UILabel alloc]init];
        _transactionLabel.text = @"交易号:";
        _transactionLabel.textColor = colorWithRGB(0xFF6B24);
        _transactionLabel.font = [UIFont systemFontOfSize:13];
        _transactionLabel.numberOfLines = 1;
       
        
        _transactionNumLabel = [[UILabel alloc]init];
        _transactionNumLabel.textColor = colorWithRGB(0xFF6B24);
        _transactionNumLabel.font = [UIFont systemFontOfSize:13];
        _transactionNumLabel.numberOfLines = 1;
        
        _paymentStatusLabel = [[UILabel alloc]init];
        _paymentStatusLabel.textColor = colorWithRGB(0xFF6B24);
        _paymentStatusLabel.font = [UIFont systemFontOfSize:13];
        _paymentStatusLabel.numberOfLines = 1;
        
//        _paymentMoneyNumLabel = [[UILabel alloc]init];
//        _paymentMoneyNumLabel.font = [UIFont systemFontOfSize:13];
//        _paymentMoneyNumLabel.numberOfLines = 1;
        
        
        
        
        [self.contentView addSubview:_Goods_Icon];
        [self.contentView addSubview:_Goods_Name];
        [self.contentView addSubview:_Goods_Desc];
        [self.contentView addSubview:_Goods_DescNum];
        [self.contentView addSubview:_codeLabel];
        [self.contentView addSubview:_Goods_Size];
        
        [self.contentView addSubview:_Goods_Price];
        
        [self.contentView addSubview:_transactionLabel];
        [self.contentView addSubview:_transactionNumLabel];
        
        [self.contentView addSubview:_paymentStatusLabel];
//        [self.contentView addSubview:_paymentLabel];
//        [self.contentView addSubview:_Goods_Number];
        
        [_Goods_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(15);
            make.height.equalTo(@(70));
            make.width.equalTo(@(70));
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
        
        [_codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_Goods_Icon.mas_right).offset(5);
            make.top.equalTo(_Goods_DescNum.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-80);
        }];
        
        [_Goods_Size mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_Goods_Icon.mas_right).offset(5);
            make.top.equalTo(_codeLabel.mas_bottom).offset(5);
//            make.right.equalTo(self).offset(-80);
        }];
        
        [_Goods_Price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_Goods_Size.mas_right).offset(1);
            make.top.equalTo(_codeLabel.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-10);
        }];
        
        [_paymentStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-10);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(@(20));
        }];
        
        [_transactionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_Goods_Icon.mas_left).offset(0);
            make.bottom.equalTo(self).offset(-10);
            make.height.equalTo(@(20));
        }];
        [_transactionNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_transactionLabel.mas_right).offset(5);
            make.right.equalTo(_paymentStatusLabel.mas_left).offset(-5);
            make.bottom.equalTo(self).offset(-10);
            make.height.equalTo(@(20));
        }];
    }
    return self;
}

-(void)withData:(CartDetailsModel *)info
{
    self.detailModel = info;
    [_Goods_Icon sd_setImageWithURL:[NSURL URLWithString:info.productImg]];
    _Goods_Name.text = [NSString stringWithFormat:@"法曼斯FOMOCE女士休闲西装法曼斯FOMOCE女士休闲西装"];
    _Goods_Desc.text = [NSString stringWithFormat:@"款式: 测试打分的权威超大日期法曼斯FOMOCE女士休闲西装"];
    _Goods_DescNum.text = [NSString stringWithFormat:@"款号: NS12324451"];
    _codeLabel.text = [NSString stringWithFormat:@"条码 4322311223"];
    _Goods_Size.text = [NSString stringWithFormat:@"(165/96A/S) x1"];
    _Goods_Price.text = [NSString stringWithFormat:@"结算价: ¥125.00"];
    _transactionLabel.text = @"交易号:";
    _transactionNumLabel.text = @"654921123";
    _paymentStatusLabel.text = @"未发货";
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
