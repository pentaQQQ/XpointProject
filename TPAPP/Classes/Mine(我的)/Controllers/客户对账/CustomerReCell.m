//
//  CustomerReCell.m
//  TPAPP
//
//  Created by frank on 2018/8/28.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "CustomerReCell.h"

@implementation CustomerReCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.contentView addSubview:self.goodImageView];
    self.goodImageView.backgroundColor = [UIColor grayColor];
    self.goodImageView.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(30)
    .heightIs(30);
    
    
    [self.contentView addSubview:self.goodName];
    
    self.goodName.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.goodImageView, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(20);
    
    
    [self.contentView addSubview:self.buyGoodDate];
    self.buyGoodDate.sd_layout
    .topSpaceToView(self.goodName, 0)
    .leftSpaceToView(self.goodImageView, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(10);
}
-(void)configWithModel:(NSMutableArray *)model
{
//    self.goodImageView.image = [UIImage imageNamed:@"123"];
    self.goodName.text = model[1];
    self.buyGoodDate.text = model[2];
}



#pragma mark - 懒加载
- (UIImageView *)goodImageView {
    if (!_goodImageView) {
        _goodImageView = [[UIImageView alloc] init];
    }
    return _goodImageView;
}
    
- (UILabel *)goodName {
    if (!_goodName) {
        _goodName= [[UILabel alloc] init];
        _goodName.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
        _goodName.textColor = [UIColor blackColor];
        _goodName.textAlignment = NSTextAlignmentLeft;
    }
    return _goodName;
}
    - (UILabel *)buyGoodDate {
        if (!_buyGoodDate ) {
            _buyGoodDate= [[UILabel alloc] init];
            _buyGoodDate.font = [UIFont systemFontOfSize:10];
            _buyGoodDate.textColor = [UIColor lightGrayColor];
            _buyGoodDate.textAlignment = NSTextAlignmentLeft;
        }
        return _buyGoodDate;
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
