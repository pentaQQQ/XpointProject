//
//  goodsDetailCell.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/20.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "goodsDetailCell.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "imagesListModel.h"
#import "UIButton+WebCache.h"
@implementation goodsDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setImageview:(UIImageView *)imageview{
    _imageview = imageview;
    ViewBorderRadius(imageview, 5, 1, [UIColor lightGrayColor]);
}

-(void)setBeginTime:(UILabel *)beginTime{
    _beginTime = beginTime;
    ViewBorderRadius(beginTime, 5, 1, [UIColor clearColor]);
}


-(void)setZhuanfaBtn:(UIButton *)zhuanfaBtn{
    _zhuanfaBtn = zhuanfaBtn;
    ViewBorderRadius(zhuanfaBtn, 5, 1, [UIColor clearColor]);
}


-(void)setQianggouBtn:(UIButton *)qianggouBtn{
    _qianggouBtn = qianggouBtn;
    ViewBorderRadius(qianggouBtn, 5, 1, [UIColor clearColor]);
}


-(void)setModel:(releaseActivitiesModel *)model{
    _model = model;
    
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.merchantUrL]];
    
    self.title.text = model.merchantName;
    self.content.text = model.context;
//    self.beginTime.text = model.beginTime;
    self.endtime.text = model.endTime;
    
    
    [self setImagewithArray:model.imagesList];
    
    if ([model.typeac isEqualToString:@"0"]) {
        [self.zhuanfaBtn setTitle:@"分享整场活动" forState:UIControlStateNormal];
    }else{
         [self.zhuanfaBtn setTitle:@"转发" forState:UIControlStateNormal];
    }
    
    
    
    
    
    
    
    int tmp = self.model.imagesList.count % 3;
    int row = (int)self.model.imagesList.count / 3;
    CGFloat width = (kScreenWidth-70-10)/3.0;
    row += tmp == 0 ? 0:1;
    self.pictureViewHigh.constant = (width+5)*row;
    
    
    
    
    CGFloat high = [LYTools getHeighWithTitle:model.context font:[UIFont systemFontOfSize:14] width:kScreenWidth-70];
    self.contentHigh.constant = high;
    
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



- (IBAction)qianggouBtnClick:(id)sender {
    if (self.qianggouBlock) {
        self.qianggouBlock(self.model);
    }
}



- (IBAction)zhuanfaBtnClick:(id)sender {
    
    if (self.zhuanfaBlock) {
        self.zhuanfaBlock(self.model);
    }
    
    
}






@end
