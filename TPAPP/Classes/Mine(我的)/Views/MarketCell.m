//
//  MarketCell.m
//  TPAPP
//
//  Created by Frank on 2018/8/20.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "MarketCell.h"

@interface MineHeaderViewCell()<UIScrollViewDelegate>


@end

@implementation MarketCell

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
    self.scrollView = [[UIScrollView alloc] init];
//    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*2, 80);
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = YES;
    __weak __typeof(self)weakSelf = self;
    weakSelf.scrollView.delegate = self;
    [self.contentView addSubview:self.scrollView];
    self.scrollView.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .topSpaceToView(self.contentView, 0)
    .widthIs(kScreenWidth)
    .heightIs(80);
    self.pageController = [[UIPageControl alloc] init];
    self.pageController.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.pageController];
    self.pageController.sd_layout
    .topSpaceToView(self.scrollView, 0)
    .centerXEqualToView(self.contentView)
    .widthIs(kScreenWidth)
    .heightIs(20);
    self.pageController.numberOfPages = 2;//指定页面个数
    self.pageController.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
    //添加委托方法，当点击小白点就执行此方法
    self.pageController.pageIndicatorTintColor = [UIColor grayColor];// 设置非选中页的圆点颜色
    self.pageController.currentPageIndicatorTintColor = colorWithRGB(0xFF6B24); // 设置选中页的圆点颜色
    
//    self.changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-10,0 , 15, 100)];
    
//    UIColor *topColor = colorWithRGB(0xA3CEEE);
//    UIColor *bottomColor = colorWithRGB(0xEC8D92);
//    UIImage *bgImg = [self gradientColorImageFromColors:@[topColor, bottomColor] gradientType:GradientTypeTopToBottom imgSize:CGSizeMake(15, 100)];
//    [self.changeBtn setImage:[UIImage imageNamed:@"双箭头_right"] forState:UIControlStateNormal];
//    [self.changeBtn addTarget:self action:@selector(changeBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:self.changeBtn];
//    [self.changeBtn setBackgroundImage:bgImg forState:UIControlStateNormal];
//    self.changeBtn.imageEdgeInsets = UIEdgeInsetsMake((100-15)/2, 0, (100-15)/2, 0);
}
//- (void)changeBtnAction
//{
//    if (self.pageController.currentPage == 0) {
//        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
//        self.pageController.currentPage = 1;
//        [self.changeBtn setImage:[UIImage imageNamed:@"双箭头_left"] forState:UIControlStateNormal];
//
//        self.changeBtn.frame = CGRectMake(0, 0, 10, 100);
//    }else{
//        self.scrollView.contentOffset = CGPointMake(0, 0);
//        self.pageController.currentPage = 0;
//        [self.changeBtn setImage:[UIImage imageNamed:@"双箭头_right"] forState:UIControlStateNormal];
//        self.changeBtn.frame = CGRectMake(kScreenWidth-10,0 , 10, 100);
//    }
//}
//pagecontroll的委托方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 设置页码
    self.pageController.currentPage = (int)page;
//    if (page == 0) {
//        [self.changeBtn setImage:[UIImage imageNamed:@"双箭头_right"] forState:UIControlStateNormal];
//        self.changeBtn.frame = CGRectMake(kScreenWidth-10,0 , 10, 100);
//    }else{
//        [self.changeBtn setImage:[UIImage imageNamed:@"双箭头_left"] forState:UIControlStateNormal];
//        self.changeBtn.frame = CGRectMake(0, 0, 10, 100);
//    }
}


- (void)configWithMarketLimit:(NSMutableArray *)limitArr andLimitTitle:(NSMutableArray *)titleArr
{
    
    for (int i = 0; i < limitArr.count; i++) {
        //添加按钮
        MarketControl *markCtrl = [[MarketControl alloc] initWithFrame:CGRectMake(0+(kScreenWidth/3)*i, 0, kScreenWidth/3, 80)];
        [self.scrollView addSubview:markCtrl];
        markCtrl.marketLimitLabel.textColor = colorWithRGB(0xFF6B24);
        markCtrl.marketLimitLabel.text = limitArr[i];
        markCtrl.marketLimitLabel.font = [UIFont systemFontOfSize:21];
        markCtrl.marketTypeLabel.text = titleArr[i];
        markCtrl.marketTypeLabel.font = [UIFont systemFontOfSize:15];
    }
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
