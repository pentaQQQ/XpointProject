//
//  BottomView.m
//  仿淘宝
//
//  Created by 郭军 on 2017/3/16.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "BottomView.h"
#import "GoodsCartModel.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Image(name) [UIImage imageNamed:name]
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]


@interface BottomView ()
{
    UIButton *SelectedAll;
    UILabel *label2;
    UILabel *AllPrice;
    UIButton *BalanceAccount;
}
@property (nonatomic, strong)NSMutableArray *selectedGoodsListArr;
@end

@implementation BottomView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
     
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = COLOR(230, 230, 230, 1);
        [self addSubview:line];
        
        SelectedAll = [UIButton buttonWithType:UIButtonTypeCustom];
        [SelectedAll setImage:Image(@"未选中支付") forState:UIControlStateNormal];
        SelectedAll.frame = CGRectMake(5, 7, 30, 30);
        [SelectedAll addTarget:self action:@selector(touchSelectedALL) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:SelectedAll];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(SelectedAll.frame), 12, 40, 20)];
        label1.text = @"全选";
        label1.font = [UIFont systemFontOfSize:15];
        [self addSubview:label1];
        
        //结算
        BalanceAccount = [UIButton buttonWithType:UIButtonTypeCustom];
        [BalanceAccount setTitle:@"结算" forState:UIControlStateNormal];
        [BalanceAccount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        BalanceAccount.backgroundColor = colorWithRGB(0xFF6B24);
        BalanceAccount.frame = CGRectMake(self.frame.size.width/3 * 2 + 10, 0, self.frame.size.width/3 - 10, 44);
        BalanceAccount.titleLabel.font = [UIFont systemFontOfSize:15];
        [BalanceAccount addTarget:self action:@selector(BalanceAccountAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:BalanceAccount];
        
        
        label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(BalanceAccount.frame) - 50, 12, 50, 20)];
        label2.text = @"共(0)件";
        label2.font = [UIFont systemFontOfSize:10];
        label2.textColor = colorWithRGB(0xFF6B24);
        [self addSubview:label2];
        
        //合计商品价格
        AllPrice = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 12, self.frame.size.width - CGRectGetMaxX(label1.frame) - (self.frame.size.width - CGRectGetMinX(label2.frame)) - 10, 20)];
        AllPrice.text = @"合计: ￥0";
        AllPrice.font = [UIFont systemFontOfSize:13];
        AllPrice.textAlignment = UITextLayoutDirectionRight;
        [self addSubview:AllPrice];
        
        AllPrice.attributedText = [self String:AllPrice.text RangeString:@"￥0"];
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Refresh:) name:@"BottomRefresh" object:nil];
        
    }
    return self;

}
- (void)BalanceAccountAction
{
     [self.delegate BalanceSelectedGoods:self.selectedGoodsListArr goodsNum:self.GoodsNum goodsPrice:self.GoodsPrice];
}
-(void)init:(NSDictionary *)dict GoodsData:(NSMutableArray *)goods
{
    [SelectedAll setImage:Image(dict[@"SelectIcon"]) forState:UIControlStateNormal];
    
    _AllSelected = [dict[@"SelectedType"] boolValue];
    
    NSLog(@"%@",dict[@"SelectedType"]);
    
    [self setMoney:goods];

}
-(void)Refresh:(NSNotification *)info
{
    [self setMoney:info.userInfo[@"Data"]];

}
-(void)setMoney:(NSMutableArray *)data
{
    self.selectedGoodsListArr = [NSMutableArray array];
    int index1 = 0;
    int index2 = 0;

    double goodsSum = 0.0;
    
    for (NSInteger i = 0; i < data.count; i ++) {
        NSArray *arr = data[i];
        NSMutableArray *dataArr = [NSMutableArray array];
        for (NSInteger j = 0 ; j < arr.count; j ++) {
            index1 ++;
//            NSDictionary *goodsDict = arr[j];
            CartDetailsModel *model = arr[j];
            if ([model.Type isEqualToString:@"1"]) {
                [dataArr addObject:model];
                index2 = index2 +model.number;
                double product;
                double Price = [model.productForm.realAmount doubleValue];
                NSInteger goodsNum = model.number;
                product = Price * goodsNum;
                
                goodsSum = goodsSum + product;
            }
        }
        if (dataArr.count !=0) {
            [self.selectedGoodsListArr addObject:dataArr];
        }
        
    }
   
    self.GoodsNum = index2;
    self.GoodsPrice = [NSString stringWithFormat:@"￥%.2f",goodsSum];
    
    NSString *String  = [NSString stringWithFormat:@"合计: ￥%.2f",goodsSum];
    label2.text = [NSString stringWithFormat:@"共(%d)件",index2];
    
    AllPrice.attributedText = [self String:String RangeString:[NSString stringWithFormat:@"￥%.2f",goodsSum]];
    if (index2 == index1 ) {
        [SelectedAll setImage:Image(@"已选中") forState:UIControlStateNormal];
        
    }
    if (index2 > 0) {
        BalanceAccount.backgroundColor = colorWithRGB(0xFF6B24);
        BalanceAccount.userInteractionEnabled = YES;
    }else{
        [SelectedAll setImage:Image(@"未选中支付") forState:UIControlStateNormal];
        _AllSelected = YES;
        BalanceAccount.backgroundColor = [UIColor lightGrayColor];
        BalanceAccount.userInteractionEnabled = YES;
    }
}

//计算总价
-(void)touchSelectedALL
{

    if (_AllSelected) {
        [self.delegate DidSelectedAllGoods];
        [SelectedAll setImage:Image(@"已选中") forState:UIControlStateNormal];
        BalanceAccount.backgroundColor = colorWithRGB(0xFF6B24);
        BalanceAccount.userInteractionEnabled = YES;
    }else{
        [self.delegate NoDidSelectedAllGoods];
        [SelectedAll setImage:Image(@"未选中支付") forState:UIControlStateNormal];
        BalanceAccount.backgroundColor = [UIColor lightGrayColor];
        BalanceAccount.userInteractionEnabled = YES;
    }
    
    _AllSelected = !_AllSelected;

}

- (NSMutableAttributedString *)String:(NSString *)String RangeString:(NSString *)RangeString
{
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:String];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:RangeString];
    [hintString addAttribute:NSForegroundColorAttributeName value:colorWithRGB(0xFF6B24) range:range1];
    
    return hintString;
}

@end
