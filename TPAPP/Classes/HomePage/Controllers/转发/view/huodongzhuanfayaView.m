//
//  huodongzhuanfayaView.m
//  TPAPP
//
//  Created by 崔文龙 on 2019/4/9.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import "huodongzhuanfayaView.h"

@interface huodongzhuanfayaView()<UITextViewDelegate>

@end


@implementation huodongzhuanfayaView


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self layoutAllSubviews];
        
    }
    return self;
}

- (void)layoutAllSubviews{
    
    CGPoint accountCenter = self.center;
    accountCenter.y += 550;
    self.center =accountCenter;
    accountCenter.y -= 550;
    [huodongzhuanfayaView animateWithDuration:0.5 animations:^{
        self.center = accountCenter;
        
        
    }];
}

-(void)removeView{
    
    CGPoint accountCenter = self.center;
    accountCenter.y -= 0;
    self.center =accountCenter;
    accountCenter.y += 550;
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







- (IBAction)tuichuClick:(id)sender {
    
    [self removeView];
    [self removeMengbanBlock];
    
}


@end
