//
//  oldhechengView.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/9/6.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "oldhechengView.h"

@implementation oldhechengView

-(void)setFirstImageview:(UIImageView *)firstImageview{
    _firstImageview = firstImageview;
    ViewBorderRadius(firstImageview, 0, 1, [UIColor groupTableViewBackgroundColor]);
}



-(void)setSecondImageview:(UIImageView *)secondImageview{
    _secondImageview = secondImageview;
    ViewBorderRadius(secondImageview, 0, 1, [UIColor groupTableViewBackgroundColor]);
}


-(void)setThirdImageview:(UIImageView *)thirdImageview{
    
    
    _thirdImageview = thirdImageview;
    ViewBorderRadius(thirdImageview, 0, 1, [UIColor groupTableViewBackgroundColor]);
}




-(void)setFourthImageview:(UIImageView *)fourthImageview{
    
    _fourthImageview = fourthImageview;
    ViewBorderRadius(fourthImageview, 0, 1, [UIColor groupTableViewBackgroundColor]);
}






-(void)setModel:(SimilarProductModel *)model{
    
    _model = model;
    self.title.text = model.merchantName;
    self.title.text = model.productName;
    
    
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
    
    
    
    self.chimaLab.text = [NSString stringWithFormat:@"尺码 %@",str];
    self.kuanshiLab.text = [NSString stringWithFormat:@"款式 %@",model.design];
    self.kuanhaoLab.text = [NSString stringWithFormat:@"款号 %@",model.designCode];
    
    
    self.tejiaLab.text = model.realAmount;
    
    self.yuanjiaLab.text = model.marketAmount;
    
    
    self.contentHigh.constant = [LYTools getHeighWithTitle: self.title.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-20]+10;
    
    self.chimaHigh.constant = [LYTools getHeighWithTitle:  self.chimaLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-20]+10;
    
    self.kuanshiHigh.constant = [LYTools getHeighWithTitle: self.kuanshiLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-20]+10;
    
    self.kuanhaoHigh.constant =[LYTools getHeighWithTitle: self.kuanhaoLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-20]+10;
    
    
    
    self.viewHigh.constant = self.contentHigh.constant + self.chimaHigh.constant+  self.kuanshiHigh.constant +  self.kuanhaoHigh.constant+40;
    
    
    
    imagesListModel *firstmodel = model.imagesList[0];
    NSString *firsturl =[NSString stringWithFormat:@"%@",firstmodel.imgUrl];
    [self.firstImageview sd_setImageWithURL:[NSURL URLWithString:firsturl]];
    
    
    imagesListModel *secondmodel = model.imagesList[1];
    NSString *secondturl =[NSString stringWithFormat:@"%@",secondmodel.imgUrl];
    [self.secondImageview sd_setImageWithURL:[NSURL URLWithString:secondturl]];
    
    
    
    self.scrollwidth.constant = kScreenWidth*2;
    
    
}



@end
