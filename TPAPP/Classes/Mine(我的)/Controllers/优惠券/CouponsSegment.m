//
//  CouponsSegment.m
//  Fxapp
//
//  Created by Frank on 2018/11/1.
//  Copyright © 2018年 琅琊. All rights reserved.
//

#import "CouponsSegment.h"
#define LG_ScreenW [UIScreen mainScreen].bounds.size.width
#define LG_ScreenH [UIScreen mainScreen].bounds.size.height
//#define LG_ButtonColor_Selected [UIColor colorWithRed:111.0/255 green:68.0/255 blue:28.0/255 alpha:100]
//#define LG_ButtonColor_UnSelected [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:100]
//#define LG_BannerColor [UIColor colorWithRed:162.0/255 green:219.0/255 blue:246.0/255 alpha:100]
#define LG_BannerColor HEXCOLOR(0x004DA1, 1.0)
#define LG_ButtonColor_Selected HEXCOLOR(0x004DA1, 1.0)
#define LG_ButtonColor_UnSelected HEXCOLOR(0x666666, 1.0)
@implementation CouponsSegment
//@synthesize delegate;
- (id)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self commonInit];
    }
    return self;
}
- (NSMutableArray *)buttonList
{
    
    if (!_buttonList)
    {
        _buttonList = [NSMutableArray array];
    }
    return _buttonList;
}

- (NSMutableArray *)titleList
{
    if (!_titleList)
    {
        _titleList = [NSMutableArray array];
    }
    return _titleList;
}
-(void)commonInit {
    //按钮名称
    NSMutableArray *titleLis = [[NSMutableArray alloc]initWithObjects:@"可使用",@"已使用",@"已过期", nil];
    
    self.titleList = titleLis;
    
    [self createItem:self.titleList];
    
    [self buttonList];
}

- (void)createItem:(NSMutableArray *)item {
    
    int count = (int)item.count;
    CGFloat marginX = (self.frame.size.width - count * 60)/(count + 1);
    for (int i = 0; i<count; i++) {
        
        NSString *temp = [item objectAtIndex:i];
        //按钮的X坐标计算，i为列数
        CGFloat buttonX = marginX + i * (60 + marginX);
        UIButton *buttonItem = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, 0, 60, self.frame.size.height)];
        //设置
        buttonItem.tag = i + 1;
        [buttonItem setTitle:temp forState:UIControlStateNormal];
        if (@available(iOS 8.2, *)) {
            [buttonItem.titleLabel setFont:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]];
        } else {
            [buttonItem.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        }
        
        [buttonItem setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
        [buttonItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonItem];
        
        [_buttonList addObject:buttonItem];
        //第一个按钮默认被选中
        if (i == 0) {
            CGFloat firstX = buttonX;
            [buttonItem setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
            [self creatBanner:firstX];
        }
        
        buttonX += marginX;
    }
    
}

-(void)creatBanner:(CGFloat)firstX{
    //初始化
    CALayer *LGLayer = [[CALayer alloc]init];
    LGLayer.backgroundColor = LG_BannerColor.CGColor;
    
    LGLayer.frame = CGRectMake(firstX, self.frame.size.height - 6, 60, 2
                               );
    // 设定它的frame
    LGLayer.cornerRadius = 4;// 圆角处理
    [self.layer addSublayer:LGLayer]; // 增加到UIView的layer上面
    self.LGLayer = LGLayer;
    
}

-(void)buttonClick:(id)sender {
    //获取被点击按钮
    UIButton *btn = (UIButton *)sender;
    
    [btn setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
    //    NSLog(@"%ld",btn.tag);
    
    UIButton *bt1 = (UIButton *)[self viewWithTag:1];
    UIButton *bt2 = (UIButton *)[self viewWithTag:2];
    UIButton *bt3 = (UIButton *)[self viewWithTag:3];
    UIButton *bt4 = (UIButton *)[self viewWithTag:4];
    
    CGFloat bannerX = btn.center.x;
    
    [self bannerMoveTo:bannerX];
    
    switch (btn.tag) {
        case 1:
            [self didSelectButton:bt1];
            [self.delegate scrollToPage:0];
            break;
        case 2:
            [self didSelectButton:bt2];
            [self.delegate scrollToPage:1];
            break;
        case 3:
            [self didSelectButton:bt3];
            [self.delegate scrollToPage:2];
            break;
        case 4:
            [self didSelectButton:bt4];
            [self.delegate scrollToPage:3];
            break;
            
        default:
            break;
    }
    
    
}

-(void)moveToOffsetX:(CGFloat)offsetX {
    
    UIButton *bt1 = (UIButton *)[self viewWithTag:1];
    UIButton *bt2 = (UIButton *)[self viewWithTag:2];
    UIButton *bt3 = (UIButton *)[self viewWithTag:3];
    UIButton *bt4 = (UIButton *)[self viewWithTag:4];
    CGFloat bannerX = bt1.center.x;
    CGFloat offSet = offsetX;
    CGFloat addX = offSet/LG_ScreenW*(bt2.center.x - bt1.center.x);
    
    bannerX += addX;
    
    [self bannerMoveTo:bannerX];
    
    if (bannerX == bt1.center.x) {
        [self didSelectButton:bt1];
    }else if (bannerX == bt2.center.x) {
        [self didSelectButton:bt2];
    }else if (bannerX == bt3.center.x){
        [self didSelectButton:bt3];
    }
    else if (bannerX == bt4.center.x){
        [self didSelectButton:bt4];
    }
    
    
}

-(void)bannerMoveTo:(CGFloat)bannerX{
    //基本动画，移动到点击的按钮下面
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    pathAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(bannerX, 100)];
    //组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:pathAnimation, nil];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.duration = 0.3;
    //设置代理
    animationGroup.delegate = self;
    //1.3设置动画执行完毕后不删除动画
    animationGroup.removedOnCompletion=NO;
    //1.4设置保存动画的最新状态
    animationGroup.fillMode=kCAFillModeForwards;
    
    //监听动画
    [animationGroup setValue:@"animationStep1" forKey:@"animationName"];
    //动画加入到changedLayer上
    [_LGLayer addAnimation:animationGroup forKey:nil];
}
//点击按钮后改变字体颜色
-(void)didSelectButton:(UIButton*)Button {
    
    UIButton *bt1 = (UIButton *)[self viewWithTag:1];
    UIButton *bt2 = (UIButton *)[self viewWithTag:2];
    UIButton *bt3 = (UIButton *)[self viewWithTag:3];
    UIButton *bt4 = (UIButton *)[self viewWithTag:4];
    UIButton *btn = Button;
    
    switch (btn.tag) {
        case 1:
            [bt1 setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
            [bt2 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt3 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt4 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            break;
        case 2:
            [bt1 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt2 setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
            [bt3 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt4 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            break;
        case 3:
            [bt1 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt2 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt3 setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
            [bt4 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            break;
            
        case 4:
            [bt1 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt2 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt3 setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
            [bt4 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            break;
            
            
        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
