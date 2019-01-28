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




-(void)setPrice:(NSString *)price{
    _price = price;
}

-(void)setModel:(SimilarProductModel *)model{
    
    _model = model;
    self.title.text = model.merchantName;
    self.title.text = model.productName;
    
    
    NSString *str = @"";
    for (int i=0; i<model.specs.count; i++) {
        specsModel*spmodel =model.specs[i];
        
        if (i== 0) {
            str = [NSString stringWithFormat:@"%ld(%@)",[spmodel.stock integerValue],spmodel.size];
        }else{
            
            NSString *tempstr = [NSString stringWithFormat:@"%ld(%@)",[spmodel.stock integerValue],spmodel.size];
            str = [NSString stringWithFormat:@"%@/%@",str,tempstr];
        }
    }
    
    
    
    self.chimaLab.text = [NSString stringWithFormat:@"尺码 %@",str];
    self.kuanshiLab.text = [NSString stringWithFormat:@"款式 %@",model.design];
    self.kuanhaoLab.text = [NSString stringWithFormat:@"款号 %@",model.designCode];
    
    
//    self.tejiaLab.text = model.realAmount;
    
    NSString *jiage =[NSString stringWithFormat:@"%.2f",[model.realAmount floatValue]+[model.discountAmount floatValue]+[self.price floatValue]] ;
    
    self.tejiaLab.text = jiage;
    self.yuanjiaLab.text = model.marketAmount;
    
    
    self.contentHigh.constant = [LYTools getHeighWithTitle: self.title.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-20]+10;
    
    self.chimaHigh.constant = [LYTools getHeighWithTitle:  self.chimaLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-20]+10;
    
    self.kuanshiHigh.constant = [LYTools getHeighWithTitle: self.kuanshiLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-20]+10;
    
    self.kuanhaoHigh.constant =[LYTools getHeighWithTitle: self.kuanhaoLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-20]+10;
    
    
    
    self.viewHigh.constant = self.contentHigh.constant + self.chimaHigh.constant+  self.kuanshiHigh.constant +  self.kuanhaoHigh.constant+40;
    

    
    [self setImagewithArray:model.imagesList];
    
    self.scrollwidth.constant = kScreenWidth*2;
    
    
}

-(void)setImagewithArray:(NSArray*)array{
    
    
    
    if (array.count == 1) {
        imagesListModel *model1 =array[0];
        [self.firstImageview sd_setImageWithURL:[NSURL URLWithString:model1.imgUrl]];
        [self.secondImageview sd_setImageWithURL:[NSURL URLWithString:@""]];
        
        [self.thirdImageview sd_setImageWithURL:[NSURL URLWithString:@""]];
        [self.fourthImageview sd_setImageWithURL:[NSURL URLWithString:@""]];
        
        
        
    }else if (array.count == 2){
        imagesListModel *model1 =array[0];
        imagesListModel *model2 =array[1];
        
        [self.firstImageview sd_setImageWithURL:[NSURL URLWithString:model1.imgUrl]];
        [self.secondImageview sd_setImageWithURL:[NSURL URLWithString:model2.imgUrl]];
        [self.thirdImageview sd_setImageWithURL:[NSURL URLWithString:@""]];
        [self.fourthImageview sd_setImageWithURL:[NSURL URLWithString:@""]];
    }else if (array.count == 3){
        imagesListModel *model1 =array[0];
        imagesListModel *model2 =array[1];
        imagesListModel *model3 =array[2];
        
        [self.firstImageview sd_setImageWithURL:[NSURL URLWithString:model1.imgUrl]];
        [self.secondImageview sd_setImageWithURL:[NSURL URLWithString:model2.imgUrl]];
        
        [self.thirdImageview sd_setImageWithURL:[NSURL URLWithString:model3.imgUrl]];
        [self.fourthImageview sd_setImageWithURL:[NSURL URLWithString:@""]];
        
    }else if (array.count == 4){
        imagesListModel *model1 =array[0];
        imagesListModel *model2 =array[1];
        imagesListModel *model3 =array[2];
        imagesListModel *model4 =array[3];
        [self.firstImageview sd_setImageWithURL:[NSURL URLWithString:model1.imgUrl]];
        [self.secondImageview sd_setImageWithURL:[NSURL URLWithString:model2.imgUrl]];
        
        [self.thirdImageview sd_setImageWithURL:[NSURL URLWithString:model3.imgUrl]];
        [self.fourthImageview sd_setImageWithURL:[NSURL URLWithString:model4.imgUrl]];
        
    }else{
        
        imagesListModel *model1 =array[0];
        imagesListModel *model2 =array[1];
        imagesListModel *model3 =array[2];
        imagesListModel *model4 =array[3];
        [self.firstImageview sd_setImageWithURL:[NSURL URLWithString:model1.imgUrl]];
        [self.secondImageview sd_setImageWithURL:[NSURL URLWithString:model2.imgUrl]];
        
        [self.thirdImageview sd_setImageWithURL:[NSURL URLWithString:model3.imgUrl]];
        [self.fourthImageview sd_setImageWithURL:[NSURL URLWithString:model4.imgUrl]];
    }
    
    
    
    
}



@end
