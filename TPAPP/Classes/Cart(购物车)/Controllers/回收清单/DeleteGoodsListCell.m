//
//  DeleteGoodsListCell.m
//  TPAPP
//
//  Created by Frank on 2018/9/7.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "DeleteGoodsListCell.h"
#import "GoodsCartModel.h"
#import "MLLabel.h"
#import "SimilarProductModel.h"
#import "specsModel.h"
#define Image(name) [UIImage imageNamed:name]
@interface DeleteGoodsListCell ()
{
    NSString *Selected;
}
@end
@implementation DeleteGoodsListCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _Goods_Icon = [[UIButton alloc] init];
       [_Goods_Icon addTarget:self action:@selector(goodsIconAction) forControlEvents:UIControlEventTouchUpInside];
//        _Goods_Icon = [[UIImageView alloc]init];
        
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
        
        
        _Goods_Number = [[UILabel alloc]init];
        _Goods_Number.font = [UIFont systemFontOfSize:12];
        _Goods_Number.textAlignment = NSTextAlignmentRight;
        
        _RemarksLabel = [[UILabel alloc]init];
        _RemarksLabel.text = @"备注:";
        _RemarksLabel.textColor = colorWithRGB(0xFF6B24);
        _RemarksLabel.font = [UIFont systemFontOfSize:13];
        _RemarksLabel.numberOfLines = 2;
        
        _ReBuy_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _ReBuy_button.titleLabel.font = [UIFont systemFontOfSize:13];
        _ReBuy_button.backgroundColor = colorWithRGB(0xFF6B24);
        [_ReBuy_button setTitle:@"重新购买" forState:UIControlStateNormal];
        [_ReBuy_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_ReBuy_button addTarget:self action:@selector(reBuyAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_Goods_Icon];
        [self.contentView addSubview:_Goods_Desc];
        [self.contentView addSubview:_Goods_DescNum];
        [self.contentView addSubview:_Goods_Size];
        [self.contentView addSubview:_Goods_Name];
        [self.contentView addSubview:_Goods_Price];
        [self.contentView addSubview:_Goods_Number];
        [self.contentView addSubview:_RemarksLabel];
        [self.contentView addSubview:_ReBuy_button];
        

        
        [_Goods_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
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
        
        
        
        [_Goods_Number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_Goods_Desc.mas_right).offset(8);
            make.top.equalTo(_Goods_Name.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(@(20));
        }];
        [_ReBuy_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-10);
            make.right.equalTo(self).offset(-10);
            make.width.equalTo(@(70));
            make.height.equalTo(@(25));

        }];
        _ReBuy_button.layer.cornerRadius = 2;
        _ReBuy_button.layer.masksToBounds = YES;
        [_RemarksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_Goods_Icon.mas_left).offset(0);
            make.top.equalTo(_ReBuy_button.mas_top).offset(0);
            make.right.equalTo(self).offset(-90);
        }];
    }
    
    
    return self;
}
- (void)goodsIconAction
{
    [self.SelectedDelegate SelectedLookImageListCell:self];
}
- (void)reBuyAction
{
    [self.SelectedDelegate SelectedReBuyCell:self];
}

-(void)withData:(CartDetailsModel *)info
{
    self.detailModel = info;
    [_Goods_Icon sd_setImageWithURL:[NSURL URLWithString:info.productImg]
                           forState:UIControlStateNormal
                   placeholderImage:Image(@"share_sina")];
    _Goods_Name.text = info.productName;
    _Goods_Desc.text = [NSString stringWithFormat:@"款式 %@",info.productForm.design];
    _Goods_DescNum.text = [NSString stringWithFormat:@"款号 %@",info.productForm.designCode];
    _Goods_Size.text = [NSString stringWithFormat:@"规格: %@",info.size];
    _Goods_Price.text = [NSString stringWithFormat:@"￥%@",info.amount];
    _Goods_Number.text = [NSString stringWithFormat:@"x%ld",(long)info.number];
    
    
    if (info.remark.length == 0) {
        _RemarksLabel.text = @"备注:";
    }else{
        _RemarksLabel.text = [NSString stringWithFormat:@"备注:%@",info.remark];
    }
    
    for (specsModel *model in self.detailModel.productForm.specs) {
        if ([model.size isEqualToString:self.detailModel.size]) {
            if ([model.stock intValue] == 0) {
                UIImageView *imageView = [[UIImageView alloc] init];
                [_Goods_Icon addSubview:imageView];
                imageView.image = Image(@"已售磐");
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(_Goods_Icon.mas_left).offset(15);
                    make.top.equalTo(_Goods_Icon.mas_top).offset(15);
                    make.height.equalTo(@(60));
                    make.width.equalTo(@(60));
                }];
                _ReBuy_button.backgroundColor = [UIColor grayColor];
                _Goods_Icon.userInteractionEnabled = NO;
                _Goods_Icon.alpha=0.4;
                _ReBuy_button.userInteractionEnabled = NO;
            }else{
                break;
            }
        }
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
