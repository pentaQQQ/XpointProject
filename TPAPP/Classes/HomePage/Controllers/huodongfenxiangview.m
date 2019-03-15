//
//  huodongfenxiangview.m
//  TPAPP
//
//  Created by 崔文龙 on 2019/1/23.
//  Copyright © 2019 cbl－　点硕. All rights reserved.
//

#import "huodongfenxiangview.h"
#import "imagesListModel.h"
@implementation huodongfenxiangview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





-(void)setFirstimageview:(UIImageView *)firstimageview{
    _firstimageview = firstimageview;
    [_firstimageview setContentMode:UIViewContentModeScaleAspectFill];
    _firstimageview.clipsToBounds = YES;
}



-(void)setSecondimageview:(UIImageView *)secondimageview{
    _secondimageview = secondimageview;
    [_secondimageview setContentMode:UIViewContentModeScaleAspectFill];
    _secondimageview.clipsToBounds = YES;
}


-(void)setThirdImageview:(UIImageView *)thirdImageview{
    _thirdImageview = thirdImageview;
    
    [_thirdImageview setContentMode:UIViewContentModeScaleAspectFill];
    _thirdImageview.clipsToBounds = YES;
    
}
-(void)setFourthImageview:(UIImageView *)fourthImageview{
    
    _fourthImageview = fourthImageview;
    [_fourthImageview setContentMode:UIViewContentModeScaleAspectFill];
    _fourthImageview.clipsToBounds = YES;
    
}
-(void)setModel:(releaseActivitiesModel *)model{
    
    _model = model;
    
    
    if (model.imagesList.count>=4) {
        
        imagesListModel *mode1 =model.imagesList[0];
        imagesListModel *mode2 =model.imagesList[1];
        imagesListModel *mode3 =model.imagesList[2];
        imagesListModel *mode4 =model.imagesList[3];
        
        
        [self.firstimageview sd_setImageWithURL:[NSURL URLWithString:mode1.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
        [self.secondimageview sd_setImageWithURL:[NSURL URLWithString:mode2.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
        [self.thirdImageview sd_setImageWithURL:[NSURL URLWithString:mode3.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
        [self.fourthImageview sd_setImageWithURL:[NSURL URLWithString:mode4.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
    }else if (model.imagesList.count==3){
        
        imagesListModel *mode1 =model.imagesList[0];
        imagesListModel *mode2 =model.imagesList[1];
        imagesListModel *mode3 =model.imagesList[2];

        [self.firstimageview sd_setImageWithURL:[NSURL URLWithString:mode1.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
        [self.secondimageview sd_setImageWithURL:[NSURL URLWithString:mode2.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
        [self.thirdImageview sd_setImageWithURL:[NSURL URLWithString:mode3.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
      
    }else if (model.imagesList.count==2){
        
        imagesListModel *mode1 =model.imagesList[0];
        imagesListModel *mode2 =model.imagesList[1];
      
        [self.firstimageview sd_setImageWithURL:[NSURL URLWithString:mode1.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
        [self.secondimageview sd_setImageWithURL:[NSURL URLWithString:mode2.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
      
    }else if (model.imagesList.count==1){
        
        imagesListModel *mode1 =model.imagesList[0];
     
        [self.firstimageview sd_setImageWithURL:[NSURL URLWithString:mode1.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
      
    }
    
  
 
}
@end
