//
//  zhuanfaHeaderView.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/23.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "zhuanfaHeaderView.h"

@implementation zhuanfaHeaderView


- (void)setFirstImageview:(UIImageView *)firstImageview{
    _firstImageview = firstImageview;
    [firstImageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571326962&di=8f502445613592dc9dd19dde4032c6ec&imgtype=0&src=http%3A%2F%2Fimg009.hc360.cn%2Fm6%2FM0A%2F98%2F05%2FwKhQoVVat96Ee_nyAAAAANCKIXo389.jpg"]];
}


-(void)setSecondImageview:(UIImageView *)secondImageview{
    _secondImageview = secondImageview;
      [secondImageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571328758&di=0f9dafd5ef73a3eff0a125ae310174ac&imgtype=0&src=http%3A%2F%2Fpic36.nipic.com%2F20131205%2F12477111_155227608129_2.jpg"]];
}

-(void)setThirdImageview:(UIImageView *)thirdImageview{
    _thirdImageview = thirdImageview;
      [thirdImageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571383364&di=3aea37c3e86ada28783624a5475d27cf&imgtype=0&src=http%3A%2F%2Fimg.shushi100.com%2F2017%2F02%2F15%2F1487169103-2682884336966288.jpg"]];
}

-(void)setFourthImageview:(UIImageView *)fourthImageview{
    _fourthImageview = fourthImageview;
      [fourthImageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571404170&di=93c67271812592cb3483b4e88d633e2c&imgtype=0&src=http%3A%2F%2Fpic16.nipic.com%2F20110911%2F3059559_103205656510_2.png"]];
}




-(void)setFirstSaveBtn:(UIButton *)firstSaveBtn{
    _firstSaveBtn = firstSaveBtn;
    ViewBorderRadius(firstSaveBtn, 5, 1, [UIColor clearColor]);
}

-(void)setSecondSaveBtn:(UIButton *)secondSaveBtn{
    _secondSaveBtn = secondSaveBtn;
    ViewBorderRadius(secondSaveBtn, 5, 1, [UIColor clearColor]);
}

-(void)setThirdSaveBtn:(UIButton *)thirdSaveBtn{
    _thirdSaveBtn = thirdSaveBtn;
    ViewBorderRadius(thirdSaveBtn, 5, 1, [UIColor clearColor]);
}

-(void)setFourthSaveBtn:(UIButton *)fourthSaveBtn{
    _fourthSaveBtn = fourthSaveBtn;
    ViewBorderRadius(fourthSaveBtn, 5, 1, [UIColor clearColor]);
}




- (IBAction)firstBtnClick:(id)sender {
    
    [self.firstBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
    [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.fourthBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    
    self.firstSaveBtn.hidden = NO;
    self.secondSaveBtn.hidden = YES;
    self.thirdSaveBtn.hidden = YES;
    self.fourthSaveBtn.hidden = YES;
    
    
    
}

- (IBAction)secondBtnClick:(id)sender {
    [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.secondBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
    [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.fourthBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    
    self.firstSaveBtn.hidden = YES;
    self.secondSaveBtn.hidden = NO;
    self.thirdSaveBtn.hidden = YES;
    self.fourthSaveBtn.hidden = YES;
}

- (IBAction)thirdBtnClick:(id)sender {
    [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.thirdBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
    [self.fourthBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    
    self.firstSaveBtn.hidden = YES;
    self.secondSaveBtn.hidden = YES;
    self.thirdSaveBtn.hidden = NO;
    self.fourthSaveBtn.hidden = YES;
}

- (IBAction)fourthBtnClick:(id)sender {
    [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.fourthBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
    
    self.firstSaveBtn.hidden = YES;
    self.secondSaveBtn.hidden = YES;
    self.thirdSaveBtn.hidden = YES;
    self.fourthSaveBtn.hidden = NO;
}





-(void)setModel:(SimilarProductModel *)model{
    
    _model = model;

    NSString *str = @"";
    for (int i=0; i<model.specs.count; i++) {
        specsModel*spmodel =model.specs[i];
        if (i== 0) {
            str = [NSString stringWithFormat:@"%@(%@)",spmodel.stock,spmodel.size];
        }else{
            
            NSString *tempstr = [NSString stringWithFormat:@"%@(%@)",spmodel.stock,spmodel.size];
            str = [NSString stringWithFormat:@"%@/%@",str,tempstr];
        }
    }
    
    
    
    self.xinghaoLab.text = model.merchantName;
    self.kuanshiLab.text = [NSString stringWithFormat:@"尺码 %@",str];
    self.kuanhaoLab.text = [NSString stringWithFormat:@"款式 %@",model.design];

    
     [self setImagewithArray:model.imagesList];
    
    
    
    
}


-(void)setImagewithArray:(NSArray*)array{
  
    imagesListModel *model1 =array[0];
    imagesListModel *model2 =array[1];
    
     [self.firstImageview sd_setImageWithURL:[NSURL URLWithString:model1.imgUrl]];
     [self.secondImageview sd_setImageWithURL:[NSURL URLWithString:model2.imgUrl]];
}











@end
