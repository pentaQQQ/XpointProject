//
//  GoDetailTableViewCell.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "GoDetailTableViewCell.h"
#import "specsModel.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "imagesListModel.h"
#import "UIButton+WebCache.h"

@implementation GoDetailTableViewCell

-(void)setImageview:(UIImageView *)imageview{
    _imageview = imageview;
    ViewBorderRadius(imageview, 5, 1, [UIColor lightGrayColor]);
}


-(void)setModel:(SimilarProductModel *)model{
    
    _model = model;
    self.title.text = model.merchantName;
    self.contentLab.text = model.productName;
    
    
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
    
    
    
    self.chimLab.text = [NSString stringWithFormat:@"尺码 %@",str];
    self.kuanshiLab.text = [NSString stringWithFormat:@"款式 %@",model.design];
    self.kuanhaoLab.text = [NSString stringWithFormat:@"款号 %@",model.designCode];
    
    
    self.PriceLab.text = model.realAmount;
    
    self.originPriceLab.text = model.marketAmount;
    
    self.feeLab.text = model.discountAmount;
    
    
    [self setImagewithArray:model.imagesList];
    
    [self setxianghaoBtnithArray:model.specs];
    
    
    self.contentHigh.constant = [LYTools getHeighWithTitle: self.contentLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
    
    self.chimaHigh.constant = [LYTools getHeighWithTitle:  self.chimLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
    
    self.kuanshiHigh.constant = [LYTools getHeighWithTitle: self.kuanshiLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
    
    self.kuanhaoHigh.constant =[LYTools getHeighWithTitle: self.kuanhaoLab.text font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
    
    
    
    int tmp = self.model.imagesList.count % 3;
    int row = (int)self.model.imagesList.count / 3;
    CGFloat width = (kScreenWidth-70-10)/3.0;
    row += tmp == 0 ? 0:1;
    self.pictureHigh.constant = (width+5)*row;
    
    

    
    int tm = self.model.specs.count % 2;
    int rows = (int)self.model.specs.count / 2;
    CGFloat high = 20;
    rows += tm == 0 ? 0:1;
    self.xianghaoViewHigh.constant = (high+5)*rows+40;
    
    
    
}




-(void)setImagewithArray:(NSArray*)array{
    
    int tmp = array.count % 3;
    int row = (int)array.count / 3;
    
    
    CGFloat width = (kScreenWidth-70-10)/3.0;
    CGFloat high = width;
    
    row += tmp == 0 ? 0:1;
    
    int i=0;
    int j=0;
    
    for (i=0; i<row; i++) {
        for (j=0; j<3; j++) {
            int k = 3*i +j;
            
            if (k<array.count) {
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((width+5)*j, (5+high)*i,  width, high)];
                
                [self.pictureView addSubview:btn];
                
                
                btn.tag = k;
                
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                imagesListModel *model =array[k];
                
                [btn sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] forState:UIControlStateNormal];
                
            }
        }
    }
    
    
}





-(void)btnClick:(UIButton*)btn{
    // 图片游览器
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 数据源/delegate
    
    
    NSMutableArray * ZLPhotosArry = [NSMutableArray array];
    
    
    int imagecount = (int)self.model.imagesList.count;
    
    for (int i = 0; i<imagecount; i++) {
        
        imagesListModel*model = self.model.imagesList[i];
        ZLPhotoPickerBrowserPhoto *photo1 = [[ZLPhotoPickerBrowserPhoto alloc] init];
        
        photo1.photoURL = [NSURL URLWithString:model.imgUrl];;
        
        [ZLPhotosArry addObject:photo1];
        
    }
    
    // 数据源可以不传，传photos数组 photos<里面是ZLPhotoPickerBrowserPhoto>
    pickerBrowser.photos = ZLPhotosArry;
    //    pickerBrowser.dataSource = self;
    // 是否可以删除照片
    //    pickerBrowser.editing = YES;
    // 当前选中的值
    pickerBrowser.currentIndex = btn.tag;
    pickerBrowser.status = UIViewAnimationAnimationStatusFade;
    // 展示控制器
    [pickerBrowser showPickerVc:[UIApplication sharedApplication].keyWindow.rootViewController];
    
}




-(void)setxianghaoBtnithArray:(NSArray*)array{
    
    int tmp = array.count % 2;
    int row = (int)array.count / 2;
    
    CGFloat high = 20;
    
    row += tmp == 0 ? 0:1;
    
    int i=0;
    int j=0;
    
    for (i=0; i<row; i++) {
        for (j=0; j<2; j++) {
            int k = 2*i +j;
            
            if (k<array.count) {
                
                specsModel *model =array[k];
                NSString *title = [NSString stringWithFormat:@"%@(%@)",model.stock,model.size];
                
                CGFloat widt = [LYTools widthForString:title fontSize:12 andHeight:20]+40;
                
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((widt+5)*j, (5+high)*i,  widt, high)];
                
                [self.xinghaoView addSubview:btn];
                btn.backgroundColor = [UIColor lightGrayColor];
                btn.titleLabel.font = [UIFont systemFontOfSize:12];
                [btn setTitle:title forState:UIControlStateNormal];
                [btn setTintColor:[UIColor blackColor]];
                btn.tag = k;
  
            }
        }
    }
    
    
}



























@end
