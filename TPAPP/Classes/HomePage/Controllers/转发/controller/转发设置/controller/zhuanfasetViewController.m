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
    
    
    NSString *tupian = [[NSUserDefaults standardUserDefaults]objectForKey:@"title"];
    NSString *tupiandetail = [[NSUserDefaults standardUserDefaults]objectForKey:@"detailTitle"];
    NSString *chima = [[NSUserDefaults standardUserDefaults]objectForKey:@"chima"];
    NSString *chimadetail = [[NSUserDefaults standardUserDefaults]objectForKey:@"detailChima"];
    NSString *jiajia = [[NSUserDefaults standardUserDefaults]objectForKey:@"jiajia"];
    NSString *jiajiadetail = [[NSUserDefaults standardUserDefaults]objectForKey:@"detailjiajia"];
    NSString *zhuanfashu = [[NSUserDefaults standardUserDefaults]objectForKey:@"zhuanfasgu"];
    NSString *zhuanfashudetail = [[NSUserDefaults standardUserDefaults]objectForKey:@"detailzhuanfasgu"];
    
    
    
    self.miaoshuLab.text = tupian;
    self.miaoshuDetailLab.text = tupiandetail;
    
    self.timelab.text = chima;
    self.timeDetailLab.text =chimadetail;
    
    self.jiajiaLab.text = jiajia;
    self.jiajiaDetailLab.text = jiajiadetail;
    
    self.jianshuLab.text = zhuanfashu;
    self.jianshuDetailLab.text = zhuanfashudetail;
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
        
        [[NSUserDefaults standardUserDefaults]setObject:jine forKey:@"jiajia"];
        [[NSUserDefaults standardUserDefaults]setObject:detailjine forKey:@"detailjiajia"];
        
        weakSelf.jiajiaLab.text =jine;
        weakSelf.jiajiaDetailLab.text = detailjine;
        
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
        
        [[NSUserDefaults standardUserDefaults]setObject:jine forKey:@"zhuanfasgu"];
        [[NSUserDefaults standardUserDefaults]setObject:detailjine forKey:@"detailzhuanfasgu"];
        
        weakSelf.jianshuLab.text =jine;
        weakSelf.jianshuDetailLab.text = detailjine;
        
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
@end
