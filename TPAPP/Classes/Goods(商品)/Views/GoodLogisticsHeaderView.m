//
//  GoodLogisticsHeaderView.m
//  TPAPP
//
//  Created by Frank on 2018/8/31.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "GoodLogisticsHeaderView.h"
#import "GoodLogisticsModel.h"
@implementation GoodLogisticsHeaderView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
   [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.goodIcon = [[UIImageView alloc] init];
    self.goodIcon.backgroundColor = [UIColor grayColor];
    [self addSubview:self.goodIcon];
    self.goodIcon.sd_layout
    .topSpaceToView(self, 15)
    .leftSpaceToView(self, 15)
    .widthIs(80)
    .heightIs(80);
    
    self.goodPrice = [[UILabel alloc] init];
    self.goodPrice.text = @"¥1000";
    self.goodPrice.textAlignment = NSTextAlignmentRight;
    self.goodPrice.textColor = colorWithRGB(0xFF6B24);
    self.goodPrice.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.goodPrice];
    self.goodPrice.sd_layout
    .topSpaceToView(self, 15)
    .rightSpaceToView(self, 15)
    .widthIs(100)
    .heightIs(20);
    
    self.goodName = [[UILabel alloc] init];
    //    self.goodName.text = @"商品名称";
    self.goodName.textColor = [UIColor blackColor];
    self.goodName.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.goodName];
    self.goodName.sd_layout
    .topSpaceToView(self, 15)
    .leftSpaceToView(self.goodIcon, 10)
    .rightSpaceToView(self.goodPrice, 10)
    .heightIs(20);
    
    self.goodSizeTitle = [[UILabel alloc] init];
    self.goodSizeTitle.text = @"规格:";
    self.goodSizeTitle.textColor = [UIColor grayColor];
    self.goodSizeTitle.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.goodSizeTitle];
    self.goodSizeTitle.sd_layout
    .topSpaceToView(self.goodName, 5)
    .leftSpaceToView(self.goodIcon, 10)
    .widthIs([self widthLabelWithModel:@"规格:" withFont:12])
    .heightIs(10);
    
    self.goodSize = [[UILabel alloc] init];
    self.goodSize.textColor = [UIColor grayColor];
    self.goodSize.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.goodSize];
    self.goodSize.sd_layout
    .topSpaceToView(self.goodName, 5)
    .leftSpaceToView(self.goodSizeTitle, 5)
    .rightSpaceToView(self, 60)
    .heightIs(10);
    
    self.goodNumber = [[UILabel alloc] init];
    self.goodNumber.textAlignment = NSTextAlignmentRight;
    self.goodNumber.text = @"x1";
    self.goodNumber.textColor = [UIColor grayColor];
    self.goodNumber.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.goodNumber];
    self.goodNumber.sd_layout
    .topSpaceToView(self.goodPrice, 5)
    .leftSpaceToView(self.goodSize, 10)
    .rightSpaceToView(self, 15)
    .heightIs(10);
    
    self.goodRemarkTitle = [[UILabel alloc] init];
    self.goodRemarkTitle.textAlignment = NSTextAlignmentLeft;
    self.goodRemarkTitle.text = @"备注:";
    self.goodRemarkTitle.textColor = colorWithRGB(0xFF6B24);
    self.goodRemarkTitle.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.goodRemarkTitle];
    self.goodRemarkTitle.sd_layout
    .topSpaceToView(self, 15+40)
    .leftSpaceToView(self.goodIcon, 10)
    .widthIs([self widthLabelWithModel:@"备注:" withFont:12])
    .heightIs(20);
    
    self.goodRemark = [[UILabel alloc] init];
    self.goodRemark.textAlignment = NSTextAlignmentLeft;
    self.goodRemark.textColor = colorWithRGB(0xFF6B24);
    self.goodRemark.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.goodRemark];
    self.goodRemark.sd_layout
    .topSpaceToView(self, 15+40)
    .leftSpaceToView(self.goodRemarkTitle, 5)
    .rightSpaceToView(self, 15)
    .heightIs(20);
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = colorWithRGB(0xEEEEEE);
    [self addSubview:self.lineView];
    self.lineView.sd_layout
    .topSpaceToView(self.goodIcon, 15)
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .heightIs(1);
    
    self.expressIcon = [[UIImageView alloc] init];
    self.expressIcon.backgroundColor = [UIColor grayColor];
    [self addSubview:self.expressIcon];
    self.goodIcon.sd_layout
    .topSpaceToView(self.lineView, 15)
    .leftSpaceToView(self, 15)
    .widthIs(20)
    .heightIs(20);
    self.expressIcon.layer.cornerRadius = 10;
    self.expressIcon.layer.masksToBounds = YES;
    
    self.expressNumber = [[UILabel alloc] init];
    self.expressNumber.text = @"165121212";
    self.expressName.textAlignment = NSTextAlignmentRight;
//    self.expressName.textColor = colorWithRGB(0xFF6B24);
    self.expressNumber.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.expressNumber];
    self.expressNumber.sd_layout
    .topSpaceToView(self.lineView, 15)
    .rightSpaceToView(self.expressIcon, 15)
    .widthIs([self widthLabelWithModel:@"165121212" withFont:14])
    .heightIs(20);
    
    self.expressNumberTtitle = [[UILabel alloc] init];
    self.expressNumberTtitle.text = @"快递单号:";
    self.expressNumberTtitle.textAlignment = NSTextAlignmentRight;
    //    self.expressName.textColor = colorWithRGB(0xFF6B24);
    self.expressNumberTtitle.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.expressNumberTtitle];
    self.expressNumberTtitle.sd_layout
    .topSpaceToView(self.lineView, 15)
    .rightSpaceToView(self.expressNumber, 0)
    .widthIs([self widthLabelWithModel:@"快递单号:" withFont:14])
    .heightIs(20);
    
    self.expressName = [[UILabel alloc] init];
    self.expressName.text = @"¥1000";
//    self.expressName.textAlignment = NSTextAlignmentRight;
//    self.expressName.textColor = colorWithRGB(0xFF6B24);
    self.expressName.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.expressName];
    self.expressName.sd_layout
    .topSpaceToView(self.lineView, 15)
    .leftSpaceToView(self.expressIcon, 5)
    .rightSpaceToView(self.expressNumberTtitle, 5)
    .heightIs(20);
    
}

-(void)configWithModel:(GoodLogisticsModel *)model
{
    self.goodName.text = model.goodName;
    self.goodSize.text = model.goodSize;
    self.goodPrice.text = model.goodPrice;
    self.goodNumber.text = model.goodNumber;
    self.goodRemark.text = model.goodRemark;
    self.goodIcon.image = [UIImage imageNamed:model.goodIcon];
    self.expressIcon.image = [UIImage imageNamed:model.expressIcon];
    self.expressName.text = model.expressName;
    self.expressNumber.text = model.expressNumber;
}
#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString withFont:(NSInteger)font
{
    CGSize size = CGSizeMake(self.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width+5;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
