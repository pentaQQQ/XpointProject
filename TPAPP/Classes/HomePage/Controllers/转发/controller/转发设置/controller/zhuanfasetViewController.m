//
//  zhuanfasetViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/28.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "zhuanfasetViewController.h"
#import "tupiansetview.h"
#import "chimasetview.h"
#import "jiajiaView.h"
#import "zidingyijineView.h"
#import "zhuanfashuView.h"
#import "zhuanfaModel.h"

@interface zhuanfasetViewController ()

@property (weak, nonatomic) IBOutlet UIView *tupianView;
@property (weak, nonatomic) IBOutlet UILabel *miaoshuLab;
@property (weak, nonatomic) IBOutlet UILabel *miaoshuDetailLab;


@property (weak, nonatomic) IBOutlet UIView *zhuanfachimaView;
@property (weak, nonatomic) IBOutlet UILabel *timelab;
@property (weak, nonatomic) IBOutlet UILabel *timeDetailLab;


@property (weak, nonatomic) IBOutlet UIView *jiajiaView;
@property (weak, nonatomic) IBOutlet UILabel *jiajiaLab;
@property (weak, nonatomic) IBOutlet UILabel *jiajiaDetailLab;


@property (weak, nonatomic) IBOutlet UIView *peizhiView;
@property (weak, nonatomic) IBOutlet UILabel *jianshuLab;
@property (weak, nonatomic) IBOutlet UILabel *jianshuDetailLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollHigh;




@property(nonatomic,weak)UIView *mengbanView;
@property(nonatomic,strong)tupiansetview*tupianview;
@property(nonatomic,strong)chimasetview*chimaview;
@property(nonatomic,strong)jiajiaView*jiajiaview;
@property(nonatomic,strong)zidingyijineView*jineview;
@property(nonatomic,strong)zhuanfashuView*zhuanfashuview;


@property(nonatomic,copy)NSString*first;
@property(nonatomic,copy)NSString*second;
@property(nonatomic,copy)NSString*third;
@property(nonatomic,copy)NSString*fourth;
@property(nonatomic,strong)zhuanfaModel*model;

@end

@implementation zhuanfasetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转发配置选项";
    self.scrollHigh.constant = kScreenHeight-SafeAreaTopHeight+1;
    
    
    [self.tupianView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self setUpTuPianView];
        
    }];
    
    [self.zhuanfachimaView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self setUpchimaView];
    }];
    
    
    [self.jiajiaView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self setUpjiajiaView];
    }];
    
    [self.peizhiView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self setUpzhuanfashuView];
    }];
    
    
    
    [self getTheUserForwardConfiSuccess:^(zhuanfaModel *model) {
        self.model = model;
        [self setDadaWithModel:model];
        
    }];
    
}



-(void)setUpTuPianView{
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    tupiansetview *tupianview = [[NSBundle mainBundle]loadNibNamed:@"tupiansetview" owner:self options:nil].lastObject;
    self.tupianview = tupianview;
    tupianview.frame = CGRectMake(0, kScreenHeight-255-SafeAreaBottomHeight, kScreenWidth, 255+SafeAreaBottomHeight);
    
    [keyWindow addSubview:tupianview];
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [mengbanView addGestureRecognizer:tap];
    
    
    __weak __typeof(self) weakSelf = self;
    
    tupianview.TupianviewBlock = ^(NSString *title, NSString *detailTitle) {
        [weakSelf.mengbanView removeFromSuperview];
        weakSelf.miaoshuLab.text =title;
        weakSelf.miaoshuDetailLab.text =detailTitle;
        
        
        if ([title isEqualToString:@"单张图（商品首图+描述）"]) {
            weakSelf.first = @"0";
            [weakSelf setZhuanfaData];
        }else if ([title isEqualToString:@"四张图（描述默认复制）"]){
            weakSelf.first = @"1";
            [weakSelf setZhuanfaData];
        }else if ([title isEqualToString:@"合成图（四图组合+描述）"]){
            weakSelf.first = @"2";
            [weakSelf setZhuanfaData];
        }else{
            weakSelf.first = @"3";
            [weakSelf setZhuanfaData];
        }
        
        
    };
    tupianview.removeBlock = ^{
        [weakSelf.mengbanView removeFromSuperview];
    };
    
    
}




-(void)setUpchimaView{
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    chimasetview *chimaview = [[NSBundle mainBundle]loadNibNamed:@"chimasetview" owner:self options:nil].lastObject;
    self.chimaview = chimaview;
    chimaview.frame = CGRectMake(0, kScreenHeight-255-SafeAreaBottomHeight, kScreenWidth, 255+SafeAreaBottomHeight);
    
    [keyWindow addSubview:chimaview];
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [mengbanView addGestureRecognizer:tap];
    
    
    __weak __typeof(self) weakSelf = self;
    
    chimaview.chimaBlock = ^(NSString *title, NSString *detailTitle) {
        [weakSelf.mengbanView removeFromSuperview];
        weakSelf.timelab.text =title;
        weakSelf.timeDetailLab.text =detailTitle;
        
        
        if ([title isEqualToString:@"不转发"]) {
            weakSelf.second = @"0";
            [weakSelf setZhuanfaData];
        }else if ([title isEqualToString:@"始终转发"]){
            weakSelf.second = @"1";
            [weakSelf setZhuanfaData];
        }else if ([title isEqualToString:@"活动1小时内转发"]){
            weakSelf.second = @"2";
            [weakSelf setZhuanfaData];
        }else{
            weakSelf.second = @"3";
            [weakSelf setZhuanfaData];
        }
        
    };
    
    chimaview.removeBlock = ^{
        [weakSelf.mengbanView removeFromSuperview];
    };
    
    
}





-(void)setUpjiajiaView{
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    jiajiaView *jiajiaview = [[NSBundle mainBundle]loadNibNamed:@"jiajiaView" owner:self options:nil].lastObject;
    self.jiajiaview = jiajiaview;
    jiajiaview.frame = CGRectMake(0, kScreenHeight-255-SafeAreaBottomHeight, kScreenWidth, 255+SafeAreaBottomHeight);
    
    [keyWindow addSubview:jiajiaview];
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [mengbanView addGestureRecognizer:tap];
    
    
    __weak __typeof(self) weakSelf = self;
    
    jiajiaview.jiajiaBlock = ^(NSString *title, NSString *detailTitle) {
        
        [weakSelf.mengbanView removeFromSuperview];
        
        if (![title isEqualToString:@""]) {
            
            weakSelf.jiajiaLab.text =title;
            weakSelf.jiajiaDetailLab.text =detailTitle;
            
            if ([title isEqualToString:@"不加价"]) {
                weakSelf.third = @"0";
                [weakSelf setZhuanfaData];
            }else if ([title isEqualToString:@"+5元"]){
                weakSelf.third = @"5";
                [weakSelf setZhuanfaData];
            }else if ([title isEqualToString:@"+10元"]){
                weakSelf.third = @"10";
                [weakSelf setZhuanfaData];
            }
            
            
        }else{
            
            
            [weakSelf setUpZidingyijineView];
        }

    };
    jiajiaview.removeBlock = ^{
        [weakSelf.mengbanView removeFromSuperview];
    };
    
}




-(void)setUpZidingyijineView{
    
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    zidingyijineView *jineview = [[NSBundle mainBundle]loadNibNamed:@"zidingyijineView" owner:self options:nil].lastObject;
    ViewBorderRadius(jineview, 5, 1, [UIColor clearColor]);
    self.jineview = jineview;
    jineview.frame = CGRectMake(20, 150, kScreenWidth-40, 135);
    
    [keyWindow addSubview:jineview];
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [mengbanView addGestureRecognizer:tap];
    
    
    [jineview.textField becomeFirstResponder];
    __weak __typeof(self) weakSelf = self;
    [jineview.cancelBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf.mengbanView removeFromSuperview];
        [weakSelf.jineview removeFromSuperview];
        [self.view endEditing:YES];
    }];
    
    [jineview.sureBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        NSString *jine = [NSString stringWithFormat:@"+%@元",jineview.textField.text];
        NSString *detailjine = [NSString stringWithFormat:@"所有商品在平台播货价基础上+%@元转发",jineview.textField.text];
        
        weakSelf.third =jineview.textField.text;
        
        weakSelf.jiajiaLab.text =jine;
        weakSelf.jiajiaDetailLab.text = detailjine;
        [weakSelf setZhuanfaData];
        [weakSelf.mengbanView removeFromSuperview];
        [weakSelf.jineview removeFromSuperview];
        [self.view endEditing:YES];
    }];
    
}



-(void)setUpzhuanfashuView{
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    zhuanfashuView *zhuanfashuview = [[NSBundle mainBundle]loadNibNamed:@"zhuanfashuView" owner:self options:nil].lastObject;
    self.zhuanfashuview = zhuanfashuview;
    zhuanfashuview.frame = CGRectMake(0, kScreenHeight-255-SafeAreaBottomHeight, kScreenWidth, 255+SafeAreaBottomHeight);
    
    [keyWindow addSubview:zhuanfashuview];
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [mengbanView addGestureRecognizer:tap];
    
    
    __weak __typeof(self) weakSelf = self;
    
    zhuanfashuview.zhuanfashuBlock = ^(NSString *title, NSString *detailTitle) {
        
        [weakSelf.mengbanView removeFromSuperview];
        
        if (![title isEqualToString:@""]) {
            
            weakSelf.jianshuLab.text =title;
            weakSelf.jianshuDetailLab.text =detailTitle;
            
            if ([title isEqualToString:@"4件"]) {
                weakSelf.fourth = @"4";
                [weakSelf setZhuanfaData];
            }else if ([title isEqualToString:@"6件"]){
                weakSelf.fourth = @"6";
                [weakSelf setZhuanfaData];
            }else if ([title isEqualToString:@"9件"]){
                weakSelf.fourth = @"9";
                [weakSelf setZhuanfaData];
            }
            
        }else{
            
            [weakSelf setUpZidingyijianshuView];
        }
        
    };
    zhuanfashuview.removeBlock = ^{
        [weakSelf.mengbanView removeFromSuperview];
    };
    
}



-(void)setUpZidingyijianshuView{
    
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    zidingyijineView *jineview = [[NSBundle mainBundle]loadNibNamed:@"zidingyijineView" owner:self options:nil].lastObject;
    ViewBorderRadius(jineview, 5, 1, [UIColor clearColor]);
    self.jineview = jineview;
    jineview.frame = CGRectMake(20, 150, kScreenWidth-40, 135);
    
    [keyWindow addSubview:jineview];
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [mengbanView addGestureRecognizer:tap];
    
    
    [jineview.textField becomeFirstResponder];
    jineview.title.text = @"自定义件数";
    jineview.textField.placeholder = @"请输入1到9之间的数字";
    
    
    
    __weak __typeof(self) weakSelf = self;
    
    [jineview.cancelBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf.mengbanView removeFromSuperview];
        [weakSelf.jineview removeFromSuperview];
        [self.view endEditing:YES];
    }];
    
    [jineview.sureBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        NSString *jine = [NSString stringWithFormat:@"%@件",jineview.textField.text];
        NSString *detailjine = [NSString stringWithFormat:@"批量转发自定义%@件",jineview.textField.text];
        
        weakSelf.fourth =jineview.textField.text;
        
        weakSelf.jianshuLab.text =jine;
        weakSelf.jianshuDetailLab.text = detailjine;
        [weakSelf setZhuanfaData];
        [weakSelf.mengbanView removeFromSuperview];
        [weakSelf.jineview removeFromSuperview];
        [self.view endEditing:YES];
    }];
    
}




-(void)tap{
    
    
    [self.tupianview removeView];
    [self.chimaview removeView];
    [self.jiajiaview removeView];
    [self.zhuanfashuview removeView];
    [self.jineview removeFromSuperview];
    [self.mengbanView removeFromSuperview];
    
    
}





-(void)getTheUserForwardConfiSuccess:(void(^)(zhuanfaModel*model))success{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *userId = [NSString stringWithFormat:@"%@",[LYAccount shareAccount].id];
    [dic setValue:userId forKey:@"userId"];
    
    [[NetworkManager sharedManager]getWithUrl:getUserForwardConfi param:dic success:^(id json) {
        NSLog(@"%@",json);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]){
            zhuanfaModel*model = [zhuanfaModel mj_objectWithKeyValues:json[@"data"]];
            success(model);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}




-(void)setDadaWithModel:(zhuanfaModel*)model{
    
    
    if ([model.defaultImg isEqualToString:@"0"]) {
        self.miaoshuLab.text = @"单张图（商品首图+描述）";
        self.miaoshuDetailLab.text = @"商品第一张图和描述文字合成一张图片再转发";
        
    }else if ([model.defaultImg isEqualToString:@"1"]){
        self.miaoshuLab.text = @"四张图（描述默认复制）";
        self.miaoshuDetailLab.text = @"仅转发商品图片，描述文字需手动复制粘贴";
        
    }else if ([model.defaultImg isEqualToString:@"2"]){
        self.miaoshuLab.text = @"合成图（四图组合+描述）";
        self.miaoshuDetailLab.text = @"旧版四张商品图片和描述文字合成一张图片再转发";
        
    }else{
        self.miaoshuLab.text = @"合成图（新版四图组合+描述）";
        self.miaoshuDetailLab.text = @"新版四张商品图片和描述文字合成一张图片再转发";
        
    }
    
    
    
    if ([model.lackSize isEqualToString:@"0"]) {
        self.timelab.text = @"不转发";
        self.timeDetailLab.text =@"不转发缺货尺码";
        
    }else if ([model.lackSize isEqualToString:@"1"]){
        self.timelab.text = @"始终转发";
        self.timeDetailLab.text =@"始终转发缺货尺码";
        
    }else if ([model.lackSize isEqualToString:@"2"]){
        self.timelab.text = @"活动1小时内转发";
        self.timeDetailLab.text =@"活动开始1小时内 转发缺货尺码";
        
    }else{
        self.timelab.text = @"活动2小时内转发";
        self.timeDetailLab.text = @"活动开始2小时内 转发缺货尺码";
        
    }
    
    
    if ([model.price isEqualToString:@"0"]) {
        self.jiajiaLab.text = @"不加价";
        self.jiajiaDetailLab.text = @"所有商品以平台播货价格转发";
        
    }else{
        
        self.jiajiaLab.text = [NSString stringWithFormat:@"+%@元",model.price];
        self.jiajiaDetailLab.text = [NSString stringWithFormat:@"所有商品在平台播货价基础上+%@元转发",model.price];
        
    }
    
    
    
    self.jianshuLab.text = [NSString stringWithFormat:@"%@件",model.num];
    self.jianshuDetailLab.text =  [NSString stringWithFormat:@"批量转发自定义%@件",model.num];
    
    
    self.first = model.defaultImg;
    self.second = model.lackSize;
    self.third = model.price;
    self.fourth =model.num;
    
    
}





-(void)setZhuanfaData{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.first forKey:@"defaultImg"];
    [dic setValue:self.model.id forKey:@"id"];
    [dic setValue:self.second forKey:@"lackSize"];
    [dic setValue:self.fourth forKey:@"num"];
    [dic setValue:self.third forKey:@"price"];
    [dic setValue:[LYAccount shareAccount].id forKey:@"userId"];
    
    
    [LYTools postBossDemoWithUrl:updateUserForwardConfi param:dic success:^(NSDictionary *dict) {
        
        NSLog(@"%@",dict);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
       
        if ([respCode isEqualToString:@"00000"]){
            [self getTheUserForwardConfiSuccess:^(zhuanfaModel *model) {
                self.model = model;
                [self setDadaWithModel:model];
                
            }];
        }
        
        
    } fail:^(NSError *error) {
        
        
    }];

}




@end
