//
//  MineHeaderViewCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/20.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "MineHeaderViewCell.h"
@interface MineHeaderViewCell()

@property (nonatomic, strong)UIView *gradientBgView;
@property (nonatomic, strong) CAShapeLayer *sLayer;
@property (nonatomic, strong) CAGradientLayer *gLayer;

@end

@implementation MineHeaderViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = colorWithRGB(0xEEEEEE);
        [self addSubview:self.gradientBgView];
        [self addSubview:self.headerBgView];
//        [self.gradientBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.bottom.equalTo(self);
//        }];
        

    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.gradientBgView.frame = CGRectMake(0, -500, self.frame.size.width, 660);
    CGFloat x1 = 0, y1 = self.gradientBgView.frame.size.height - 44, x2 = CGRectGetMidX(self.gradientBgView.frame), y2 = CGRectGetMaxY(self.gradientBgView.frame), x3 = rect.size.width, y3 = y1;
    CGPoint p0 = CGPointMake(x1, x1);
    CGPoint p1 = CGPointMake(x1, y1);
    CGPoint p3 = CGPointMake(x3, 0);
    //计算圆心，半径和弧度
    CGFloat a = 2*(x2-x1);
    CGFloat b = 2*(y2-y1);
    CGFloat c = x2*x2+y2*y2-x1*x1-y1*y1;
    CGFloat d = 2*(x3-x2);
    CGFloat e = 2*(y3-y2);
    CGFloat f = x3*x3+y3*y3-x2*x2-y2*y2;
    CGFloat x = (b*f-e*c)/(b*d-e*a);
    CGFloat y = (d*c-a*f)/(b*d-e*a);
    CGFloat r = sqrt((x-x1)*(x-x1)+(y-y1)*(y-y1));
    
    CGFloat endAngle = acos((x3-x)/r);
    CGFloat startAngle = M_PI-acos((x-x1)/r);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:p0];
    [path addLineToPoint:p1];
    [path addArcWithCenter:CGPointMake(x, y) radius:r startAngle:startAngle endAngle:endAngle clockwise:NO];
    [path addLineToPoint:p3];
    
    [path closePath];
    
    self.gLayer.frame = self.gradientBgView.bounds;
    [self.gradientBgView.layer insertSublayer:self.gLayer atIndex:0];
    
    self.sLayer.path = path.CGPath;
    self.sLayer.position = CGPointZero;
    self.sLayer.frame = self.gradientBgView.bounds;
    self.gradientBgView.layer.mask = self.sLayer;
    
    self.headerBgView.frame = CGRectMake(20, 0, self.frame.size.width-40, 240);
    self.headerBgView.layer.cornerRadius = 4.0;
    self.headerBgView.layer.shadowColor = [UIColor grayColor].CGColor;//阴影颜色
    self.headerBgView.layer.shadowOffset = CGSizeMake(0, 1);//阴影偏移量
    self.headerBgView.layer.shadowOpacity = 1.0;//阴影透明度
    self.headerBgView.layer.shadowRadius = 1.0;//阴影半径
    [self createHeaderBgViewChilds];
    
//    UIColor *topColor = colorWithRGB(0xFF6062);
//    UIColor *bottomColor = colorWithRGB(0xE661E2);
//    UIImage *bgImg = [self gradientColorImageFromColors:@[topColor, bottomColor] gradientType:GradientTypeLeftToRight imgSize:CGSizeMake(kScreenWidth-40, 60)];
//    [self addSubview:self.myAwardBgView];
//    self.myAwardBgView.sd_layout
//    .bottomSpaceToView(self, 0)
//    .leftSpaceToView(self, 20)
//    .rightSpaceToView(self, 20)
//    .heightIs(50);
//    self.myAwardBgView.backgroundColor = [UIColor colorWithPatternImage:bgImg];
//    self.myAwardBgView.userInteractionEnabled = YES;
//    self.myAwardBgView.layer.cornerRadius = 25.0;
//    self.myAwardBgView.layer.masksToBounds = YES;
//    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesAtion)];
//    [self.myAwardBgView addGestureRecognizer:tapGes];
//
//    self.myAwardLabel = [[UILabel alloc] init];
//
//    [self.myAwardBgView addSubview:self.myAwardLabel];
//    self.myAwardLabel.sd_layout
//    .topSpaceToView(self.myAwardBgView, 10)
//    .leftSpaceToView(self.myAwardBgView, 30)
//    .rightSpaceToView(self.myAwardBgView, 40)
//    .heightIs(30);
//    self.myAwardLabel.font = [UIFont systemFontOfSize:17];
//    self.myAwardLabel.textColor = [UIColor whiteColor];
//    self.myAwardLabel.text = @"您的累积奖励¥0.00";
//
//    self.detailLabel = [[UILabel alloc] init];
//    self.detailLabel.numberOfLines = 2;
//    [self.myAwardBgView addSubview:self.detailLabel];
//    self.detailLabel.sd_layout
//    .topSpaceToView(self.myAwardBgView, 0)
//    .rightSpaceToView(self.myAwardBgView, 10)
//    .widthIs(40)
//    .heightIs(50);
//    self.detailLabel.font = [UIFont systemFontOfSize:15];
//    self.detailLabel.textColor = [UIColor whiteColor];
//    self.detailLabel.text = @"查看\n详情";
}

 -(void)createHeaderBgViewChilds
{
    LYAccount *lyAccount = [LYAccount shareAccount];
    self.headerBtn = [[UIButton alloc] init];
    [self.headerBgView addSubview:self.headerBtn];
    self.headerBtn.sd_layout
    .topSpaceToView(self.headerBgView, 15)
    .centerXEqualToView(self.headerBgView)
    .widthIs(80)
    .heightIs(80);
    [self.headerBtn addTarget:self action:@selector(headerAction) forControlEvents:UIControlEventTouchUpInside];
    self.headerBtn.backgroundColor = colorWithRGB(0xbfbfbf);
    self.headerBtn.layer.cornerRadius = 40;
    self.headerBtn.layer.masksToBounds = YES;
    [self.headerBtn sd_setImageWithURL:[NSURL URLWithString:lyAccount.headUrl]
                           forState:UIControlStateNormal
                      placeholderImage:[UIImage imageNamed:@"share_sina"]];
    
    self.authenticationBtn = [[UIButton alloc] init];
    [self.headerBgView addSubview:self.authenticationBtn];
    self.authenticationBtn.sd_layout
    .topSpaceToView(self.headerBgView, 15)
    .leftSpaceToView(self.headerBgView, 0)
    .widthIs(60)
    .heightIs(20);
    [self.authenticationBtn addTarget:self action:@selector(authenticationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.authenticationBtn setBackgroundImage:[UIImage imageNamed:@"icon_mine_tag_right"] forState:UIControlStateNormal];
    [self.authenticationBtn setTitle:@"去认证" forState:UIControlStateNormal];
    [self.authenticationBtn setTitleColor:colorWithRGB(0xFF6B24) forState:UIControlStateNormal];
    self.authenticationBtn.titleLabel.font = [UIFont systemFontOfSize:15];

    
    self.ruleBtn = [[UIButton alloc] init];
    [self.headerBgView addSubview:self.ruleBtn];
    self.ruleBtn.sd_layout
    .topSpaceToView(self.headerBgView, 15)
    .rightSpaceToView(self.headerBgView, 0)
    .widthIs(80)
    .heightIs(20);
    [self.ruleBtn addTarget:self action:@selector(ruleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.ruleBtn setBackgroundImage:[UIImage imageNamed:@"icon_mine_tag"] forState:UIControlStateNormal];
    [self.ruleBtn setTitle:@"等级规则" forState:UIControlStateNormal];
    [self.ruleBtn setTitleColor:colorWithRGB(0xFF6B24) forState:UIControlStateNormal];
    self.ruleBtn.titleLabel.font = [UIFont systemFontOfSize:15];

    
    self.vipBtn = [[UIButton alloc] init];
    [self.headerBgView addSubview:self.vipBtn];
    self.vipBtn.backgroundColor = [UIColor whiteColor];
    self.vipBtn.sd_layout
    .topSpaceToView(self.headerBtn, -15)
    .centerXEqualToView(self.headerBgView)
    .widthIs([self widthLabelWithModel:@"VIP1"]+20)
    .heightIs(20);
    self.vipBtn.layer.cornerRadius = 10;
    self.vipBtn.layer.masksToBounds = YES;
//    self.vipBtn.layer.borderWidth = 1.0;
//    self.vipBtn.layer.borderColor = colorWithRGB(0xFF6B24).CGColor;
    [self.vipBtn setBackgroundImage:[UIImage imageNamed:@"icon_mine_vip"] forState:UIControlStateNormal];
    [self.vipBtn addTarget:self action:@selector(vipAction) forControlEvents:UIControlEventTouchUpInside];
    [self.vipBtn setTitle:[NSString stringWithFormat:@"VIP%@",lyAccount.level] forState:UIControlStateNormal];
    [self.vipBtn setTitleColor:colorWithRGB(0xFF6B24) forState:UIControlStateNormal];
    self.vipBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    self.vipBtn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 5); self.vipBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight ;

    
    self.accountBtn = [[UIButton alloc] init];
    [self.headerBgView addSubview:self.accountBtn];
    self.accountBtn.sd_layout
    .topSpaceToView(self.vipBtn, 10)
    .centerXEqualToView(self.headerBgView)
    .widthIs(100)
    .heightIs(20);
    [self.accountBtn addTarget:self action:@selector(accountAction) forControlEvents:UIControlEventTouchUpInside];
    [self.accountBtn setTitle:lyAccount.nickName forState:UIControlStateNormal];
    [self.accountBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self.numberLabel = [[UILabel alloc] init];
    [self.headerBgView addSubview:self.numberLabel];
    self.numberLabel.sd_layout
    .topSpaceToView(self.accountBtn, 5)
    .centerXEqualToView(self.headerBgView)
    .widthIs(self.headerBgView.frame.size.width)
    .heightIs(15);
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.textColor = [UIColor lightGrayColor];
    self.numberLabel.text = [NSString stringWithFormat:@"代购编号:%@",lyAccount.buyNo];
    self.numberLabel.font = [UIFont systemFontOfSize:14];
    
    self.moneyBgView = [[UIView alloc] init];
    self.moneyBgView.backgroundColor = colorWithRGB(0xEEEEEE);
    [self.headerBgView addSubview:self.moneyBgView];
    self.moneyBgView.sd_layout
    .topSpaceToView(self.numberLabel, 20)
    .centerXEqualToView(self.headerBgView)
    .leftSpaceToView(self.headerBgView, 20)
    .rightSpaceToView(self.headerBgView, 20)
    .heightIs(20);
    self.moneyBgView.layer.cornerRadius = 10;
    self.moneyBgView.layer.masksToBounds = YES;
    
    
    self.moneyView = [[UIView alloc] init];
    self.moneyView.backgroundColor = colorWithRGB(0xFF6B24);
    [self.moneyBgView addSubview:self.moneyView];
    self.moneyView.sd_layout
    .topSpaceToView(self.moneyBgView, 0)
    .leftSpaceToView(self.moneyBgView, 0)
    .widthIs((self.headerBgView.frame.size.width-40)/2)
    .heightIs(20);
    self.moneyView.layer.cornerRadius = 10;
    self.moneyView.layer.masksToBounds = YES;
    
    self.moneyLabel = [[UILabel alloc] init];
    self.moneyLabel.backgroundColor = colorWithRGB(0xFF6B24);
    [self.moneyView addSubview:self.moneyLabel];
    self.moneyLabel.sd_layout
    .topSpaceToView(self.moneyView, 0)
    .rightSpaceToView(self.moneyView, 10)
    .widthIs(self.moneyView.frame.size.width-10)
    .heightIs(20);
    self.moneyLabel.layer.cornerRadius = 10;
    self.moneyLabel.layer.masksToBounds = YES;
    self.moneyLabel.textAlignment = NSTextAlignmentRight;
    self.moneyLabel.textColor = [UIColor whiteColor];
    self.moneyLabel.text = @"¥50";
    self.moneyLabel.font = [UIFont systemFontOfSize:12];
   
//    self.moneyLabel = [[UILabel alloc] init];
//    self.moneyLabel.backgroundColor = colorWithRGB(0xFF6B24);
//    [self.moneyBgView addSubview:self.moneyLabel];
//    self.moneyLabel.sd_layout
//    .topSpaceToView(self.moneyBgView, 0)
//    .leftSpaceToView(self.moneyBgView, 0)
//    .widthIs((self.headerBgView.frame.size.width-40)/2)
//    .heightIs(20);
//    self.moneyLabel.layer.cornerRadius = 10;
//    self.moneyLabel.layer.masksToBounds = YES;
//    self.moneyLabel.textAlignment = NSTextAlignmentRight;
//    self.moneyLabel.textColor = [UIColor whiteColor];
//    self.moneyLabel.text = @"¥50";
//    self.moneyLabel.font = [UIFont systemFontOfSize:12];
    
    
    self.distanceLabel = [[UILabel alloc] init];
    [self.headerBgView addSubview:self.distanceLabel];
    self.distanceLabel.sd_layout
    .topSpaceToView(self.moneyBgView, 10)
    .centerXEqualToView(self.headerBgView)
    .widthIs(self.headerBgView.frame.size.width)
    .heightIs(10);
    self.distanceLabel.textAlignment = NSTextAlignmentCenter;
    self.distanceLabel.textColor = [UIColor lightGrayColor];
    self.distanceLabel.text = @"距离升级还差 ¥50";
    self.distanceLabel.font = [UIFont systemFontOfSize:12];
}
#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString
{
    CGSize size = CGSizeMake(self.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil];
    return rect.size.width;
}
- (void)headerAction
{
    self.selectBlcok(0);
}
- (void)authenticationAction
{
    self.selectBlcok(1);
}
- (void)ruleAction
{
    self.selectBlcok(2);
}
- (void)vipAction
{
    self.selectBlcok(3);
}
- (void)accountAction
{
    self.selectBlcok(4);
}
//- (void)tapGesAtion
//{
//
//}
#pragma mark - lazy
- (UIView *)gradientBgView
{
    if (_gradientBgView) {
        return _gradientBgView;
    }
    _gradientBgView = [[UIView alloc]init];
    return _gradientBgView;
}
-(UIView *)headerBgView
{
    if (_headerBgView) {
        return _headerBgView;
    }
    
    _headerBgView = [[UIView alloc]init];
    _headerBgView.backgroundColor = [UIColor whiteColor];
    return _headerBgView;
}

- (UIView *)myAwardBgView
{
    if (_myAwardBgView) {
        return _myAwardBgView;
    }
    _myAwardBgView = [[UIView alloc]init];
    return _myAwardBgView;
}

- (CAShapeLayer *)sLayer
{
    if (_sLayer) {
        return _sLayer;
    }
    _sLayer = [CAShapeLayer layer];
    return _sLayer;
}

- (CAGradientLayer *)gLayer
{
    if (_gLayer) {
        return _gLayer;
    }
    _gLayer = [CAGradientLayer layer];
    _gLayer.colors = @[(__bridge id)colorWithRGB(0xFF6B24).CGColor,(__bridge id)colorWithRGB(0xFF6B24).CGColor];
    
    return _gLayer;
}
#pragma mark - 把颜色生成图片
- (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize {
    
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        
        [ar addObject:(id)c.CGColor];
        
    }
    
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGPoint start;
    
    CGPoint end;
    
    switch (gradientType) {
            
        case GradientTypeTopToBottom:
            
            start = CGPointMake(0.0, 0.0);
            
            end = CGPointMake(0.0, imgSize.height);
            
            break;
            
        case GradientTypeLeftToRight:
            
            start = CGPointMake(0.0, 0.0);
            
            end = CGPointMake(imgSize.width, 0.0);
            
            break;
            
        case GradientTypeUpleftToLowright:
            
            start = CGPointMake(0.0, 0.0);
            
            end = CGPointMake(imgSize.width, imgSize.height);
            
            break;
            
        case GradientTypeUprightToLowleft:
            
            start = CGPointMake(imgSize.width, 0.0);
            
            end = CGPointMake(0.0, imgSize.height);
            
            break;
            
        default:
            
            break;
            
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(colorSpace);
    
    UIGraphicsEndImageContext();
    
    return image;
    
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
