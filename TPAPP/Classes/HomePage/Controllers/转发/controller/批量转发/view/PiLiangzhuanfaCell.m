//
//  PiLiangzhuanfaCell.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/9/7.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "PiLiangzhuanfaCell.h"

@implementation PiLiangzhuanfaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}






-(void)setModel:(SimilarProductModel *)model{
    
    _model = model;
    self.titleLab.text = model.productName;
    
    
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
    
    
    
    [self setImagewithArray:model.imagesList];
    
    
    self.contentHigh.constant = [LYTools getHeighWithTitle: self.titleLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-183]+10;
    
    self.chimaHigh.constant = [LYTools getHeighWithTitle:  self.chimaLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-183]+10;
    
    self.kuanshiHigh.constant = [LYTools getHeighWithTitle: self.kuanshiLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-183]+10;
    
    self.kuanhaoHigh.constant =[LYTools getHeighWithTitle: self.kuanhaoLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-183]+10;
    
    
    
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
        
    }
    
    
    
    
}


@end
