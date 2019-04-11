//
//  huodongzhuanfayaView.m
//  TPAPP
//
//  Created by 崔文龙 on 2019/4/9.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import "huodongzhuanfayaView.h"
#import "pickzhuangaView.h"



@interface huodongzhuanfayaView()<UITextViewDelegate>
@property(nonatomic,copy)NSString *count;
@property(nonatomic,assign)BOOL iszidingyi;
@property(nonatomic,copy)NSString *zidingcount;

@property(nonatomic,weak)UIView *mengbanView;
@property(nonatomic,strong)pickzhuangaView*pickzhuangaview;





@property(nonatomic,copy)NSString *shanghuId;

@property(nonatomic,copy)NSString *cishanghuId;


@end


@implementation huodongzhuanfayaView


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.count = @"0";
        self.iszidingyi = NO;
        self.zidingcount = @"0";
        [self layoutAllSubviews];
        
    }
    return self;
}

- (void)layoutAllSubviews{
    
    CGPoint accountCenter = self.center;
    accountCenter.y += 550+SafeAreaBottomHeight;
    self.center =accountCenter;
    accountCenter.y -= 550+SafeAreaBottomHeight;
    [huodongzhuanfayaView animateWithDuration:0.5 animations:^{
        self.center = accountCenter;
        
        
    }];
}

-(void)removeView{
    
    CGPoint accountCenter = self.center;
    accountCenter.y -= 0;
    self.center =accountCenter;
    accountCenter.y += 550+SafeAreaBottomHeight;
    [huodongzhuanfayaView animateWithDuration:0.5 animations:^{
        self.center = accountCenter;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }];
}


-(void)removeMengbanBlock{
    
    if (self.removeBlock) {
        self.removeBlock();
    }
    
}

-(void)setFirstimageview:(UIImageView *)firstimageview{
    _firstimageview = firstimageview;
    ViewBorderRadius(firstimageview, 5, 1, [UIColor lightGrayColor]);
}

-(void)setBiaotiTextView:(UITextView *)biaotiTextView{
    _biaotiTextView = biaotiTextView;
    biaotiTextView.delegate = self;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length>0) {
        self.dianjiBiaotiLab.hidden = YES;
    }else{
        self.dianjiBiaotiLab.hidden = NO;
    }
    
    self.countLab.text = [NSString stringWithFormat:@"%lu/26",(unsigned long)textView.text.length];
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (range.location>=26) {
        return NO;
    }else{
        return YES;
    }
    
}



-(void)setJiajiaView:(UIView *)jiajiaView{
    _jiajiaView = jiajiaView;
    
    WeakSelf(weakSelf);
    [jiajiaView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakSelf.jiajiaLab.textColor = [UIColor redColor];
        weakSelf.jiajiaLineView.hidden = NO;
        
        weakSelf.zidingyiLab.textColor = [UIColor blackColor];
        weakSelf.zidingyiLineView.hidden = YES;
        
        weakSelf.zidingyihahhaView.hidden = YES;
        
        weakSelf.iszidingyi = NO;
    }];
    
}


-(void)setZidingyiLineView:(UIView *)zidingyiLineView{
    _zidingyiLineView = zidingyiLineView;
    WeakSelf(weakSelf);
    [zidingyiLineView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakSelf.jiajiaLab.textColor = [UIColor blackColor];
        weakSelf.jiajiaLineView.hidden = YES;
        
        weakSelf.zidingyiLab.textColor = [UIColor redColor];
        weakSelf.zidingyiLineView.hidden = NO;
        weakSelf.zidingyihahhaView.hidden = NO;
        
        weakSelf.iszidingyi = YES;
        
    }];
}


-(void)setZidingyiLab:(UILabel *)zidingyiLab{
    _zidingyiLab = zidingyiLab;
    WeakSelf(weakSelf);
    [zidingyiLab addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakSelf.jiajiaLab.textColor = [UIColor blackColor];
        weakSelf.jiajiaLineView.hidden = YES;
        
        weakSelf.zidingyiLab.textColor = [UIColor redColor];
        weakSelf.zidingyiLineView.hidden = NO;
        
        
        weakSelf.zidingyihahhaView.hidden = NO;
        
        weakSelf.iszidingyi = YES;
    }];
}





-(void)setBujiajiaBtn:(UIButton *)bujiajiaBtn{
    _bujiajiaBtn = bujiajiaBtn;
    
    ViewBorderRadius(bujiajiaBtn, 12.5, 1, [UIColor clearColor]);
    WeakSelf(weakSelf)
    [bujiajiaBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf.bujiajiaBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [weakSelf.fiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weakSelf.tenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weakSelf.fitenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        ViewBorderRadius(weakSelf.bujiajiaBtn, 12.5, 1, [UIColor redColor]);
        ViewBorderRadius(weakSelf.fiveBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(weakSelf.tenBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(weakSelf.fitenBtn, 12.5, 1, [UIColor clearColor]);
        weakSelf.count = @"0";
    }];
    
}
-(void)setFiveBtn:(UIButton *)fiveBtn{
    _fiveBtn = fiveBtn;
    ViewBorderRadius(fiveBtn, 12.5, 1, [UIColor clearColor]);
    WeakSelf(weakSelf)
    [fiveBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf.bujiajiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weakSelf.fiveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [weakSelf.tenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weakSelf.fitenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        ViewBorderRadius(weakSelf.bujiajiaBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(weakSelf.fiveBtn, 12.5, 1, [UIColor redColor]);
        ViewBorderRadius(weakSelf.tenBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(weakSelf.fitenBtn, 12.5, 1, [UIColor clearColor]);
        
        weakSelf.count = @"5";
    }];
}

-(void)setTenBtn:(UIButton *)tenBtn{
    _tenBtn = tenBtn;
    ViewBorderRadius(tenBtn, 12.5, 1, [UIColor clearColor]);
    WeakSelf(weakSelf)
    [tenBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf.bujiajiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weakSelf.fiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weakSelf.tenBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [weakSelf.fitenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        ViewBorderRadius(weakSelf.bujiajiaBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(weakSelf.fiveBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(weakSelf.tenBtn, 12.5, 1, [UIColor redColor]);
        ViewBorderRadius(weakSelf.fitenBtn, 12.5, 1, [UIColor clearColor]);
        
        weakSelf.count = @"10";
    }];
}

-(void)setFitenBtn:(UIButton *)fitenBtn{
    _fitenBtn = fitenBtn;
    ViewBorderRadius(fitenBtn, 12.5, 1, [UIColor clearColor]);
    WeakSelf(weakSelf)
    [fitenBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf.bujiajiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weakSelf.fiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weakSelf.tenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weakSelf.fitenBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        ViewBorderRadius(weakSelf.bujiajiaBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(weakSelf.fiveBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(weakSelf.tenBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(weakSelf.fitenBtn, 12.5, 1, [UIColor redColor]);
        weakSelf.count = @"15";
    }];
}


-(void)setSecondImageview:(UIImageView *)secondImageview{
    
    _secondImageview = secondImageview;
    ViewBorderRadius(secondImageview, 5, 1, [UIColor lightGrayColor]);
}


-(void)setYulanBtn:(UIButton *)yulanBtn{
    _yulanBtn = yulanBtn;
    ViewBorderRadius(yulanBtn, 20, 1, [UIColor redColor]);
}

-(void)setZhuanfaBtn:(UIButton *)zhuanfaBtn{
    _zhuanfaBtn = zhuanfaBtn;
    ViewBorderRadius(zhuanfaBtn, 20, 1, [UIColor redColor]);
}


-(void)setZhuanfaView:(UIView *)zhuanfaView{
    _zhuanfaView = zhuanfaView;
    WeakSelf(weakSelf)
    [zhuanfaView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf setui];
    }];
    
    
}




-(void)setui{
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    
    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [mengbanView addGestureRecognizer:tapges];
    
    pickzhuangaView *pickzhuangaview = [[NSBundle mainBundle]loadNibNamed:@"pickzhuangaView" owner:self options:nil].lastObject;
    
    self.pickzhuangaview = pickzhuangaview;
    
    
    pickzhuangaview.frame = CGRectMake(0, kScreenHeight-171, kScreenWidth, 171);
    
    [keyWindow addSubview:pickzhuangaview];
    
    
    WeakSelf(weakSelf)
    pickzhuangaview.buzhuanfaBlock = ^{
        
        weakSelf.zhuanfaLab.text = @"不转发";
        [weakSelf.mengbanView removeFromSuperview];
        
    };
    
    pickzhuangaview.zhuanfaBlock = ^{
        weakSelf.zhuanfaLab.text = @"转发";
        [weakSelf.mengbanView removeFromSuperview];
        
    };
    
    pickzhuangaview.quxiaoBlock = ^{
        [weakSelf.mengbanView removeFromSuperview];
    };
    
    
}

-(void)tap{
    
    [self.mengbanView removeFromSuperview];
    
    [self.pickzhuangaview removeView];
}



-(void)setModel:(releaseActivitiesModel *)model{
    
    _model = model;
    
    
    self.shanghuId = model.merchantId;
    self.cishanghuId = model.id;
    
    [self.firstimageview sd_setImageWithURL:[NSURL URLWithString:model.merchantUrL] placeholderImage:[UIImage imageNamed:@""]];
    
    self.huodongTitle.text = model.merchantName;
    
    if ([self.zhuanfamodel.price isEqualToString:@"5"]) {
        [self.bujiajiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fiveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.tenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fitenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        ViewBorderRadius(self.bujiajiaBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(self.fiveBtn, 12.5, 1, [UIColor redColor]);
        ViewBorderRadius(self.tenBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(self.fitenBtn, 12.5, 1, [UIColor clearColor]);
        self.count = @"5";
    }else if ([self.zhuanfamodel.price isEqualToString:@"10"]){
        [self.bujiajiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.tenBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.fitenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        ViewBorderRadius(self.bujiajiaBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(self.fiveBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(self.tenBtn, 12.5, 1, [UIColor redColor]);
        ViewBorderRadius(self.fitenBtn, 12.5, 1, [UIColor clearColor]);
        self.count = @"10";
    }else if ([self.zhuanfamodel.price isEqualToString:@"15"]){
        [self.bujiajiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.tenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fitenBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        ViewBorderRadius(self.bujiajiaBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(self.fiveBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(self.tenBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(self.fitenBtn, 12.5, 1, [UIColor redColor]);
        self.count = @"15";
    }else{
        [self.bujiajiaBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.fiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.tenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.fitenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        ViewBorderRadius(self.bujiajiaBtn, 12.5, 1, [UIColor redColor]);
        ViewBorderRadius(self.fiveBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(self.tenBtn, 12.5, 1, [UIColor clearColor]);
        ViewBorderRadius(self.fitenBtn, 12.5, 1, [UIColor clearColor]);
        self.count = @"0";
    }
}


-(void)setMerchantId:(NSString *)merchantId{
    
    _merchantId = merchantId;
    
    self.shanghuId = merchantId;
}

-(void)setActivityId:(NSString *)activityId{
    
    _activityId = activityId;
    self.cishanghuId = activityId;
}


-(void)setImageurl:(NSString *)imageurl{
    _imageurl = imageurl;
    [self.firstimageview sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@""]];
    
    
}

-(void)setName:(NSString *)name{
    _name = name;
    
    self.huodongTitle.text = name;
}












- (IBAction)tuichuClick:(id)sender {
    
    [self removeView];
    [self removeMengbanBlock];
    
}

- (IBAction)xiaoguoyulanClick:(id)sender {
    
    [self getTheh5forgoods];
}


- (IBAction)zhuanfaClick:(id)sender {
    
    [self getzhuanfa];
}





-(void)getTheh5forgoods{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:self.model.merchantId forKey:@"merchantId"];
    [dic setValue:self.model.id forKey:@"activityId"];
    
    if (self.iszidingyi) {
        
        if (!self.textfield.text.length) {
            [SVProgressHUD doAnyRemindWithHUDMessage:@"请输入加价金额" withDuration:1.5];
            return;
        }else{
            [dic setValue:self.textfield.text forKey:@"amount"];
        }
        
    }else{
        [dic setValue:self.count forKey:@"amount"];
    }
    
    
    
    [[NetworkManager sharedManager]getWithUrl:geth5forgoods param:dic success:^(id json) {
        NSLog(@"%@",json);
        
        
        if (self.toH5Block) {
            
            NSString *url = [NSString stringWithFormat:@"%@",json[@"data"]];
            self.toH5Block(url);
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)getzhuanfa{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:self.shanghuId forKey:@"merchantId"];
    [dic setValue:self.cishanghuId forKey:@"activityId"];
    
    if (self.iszidingyi) {
        
        if (!self.textfield.text.length) {
            [SVProgressHUD doAnyRemindWithHUDMessage:@"请输入加价金额" withDuration:1.5];
            return;
        }else{
            [dic setValue:self.textfield.text forKey:@"amount"];
        }
        
    }else{
        [dic setValue:self.count forKey:@"amount"];
    }
    
    
    
    [[NetworkManager sharedManager]getWithUrl:geth5forgoods param:dic success:^(id json) {
        NSLog(@"%@",json);
        
        
        if (self.toH5Block) {
            
            NSString *url = [NSString stringWithFormat:@"%@",json[@"data"]];
            self.zhuanfaBlock(url);
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}



@end
