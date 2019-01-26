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

#import "OYCountDownManager.h"


@interface goodsDetailCell ()

@property(nonatomic,assign)NSInteger count;


@end

@implementation goodsDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


// xib创建
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:OYCountDownNotification object:nil];
    }
    return self;
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
        [self.zhuanfaBtn setTitle:@"转发全场" forState:UIControlStateNormal];
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
    
    
    NSString *str = [LYTools inputTimeStr:model.endTime];
    
    if ([str isEqualToString:@"已结束"]) {
        self.beginTime.text = str;
        self.beginDetailTime.hidden = YES;
        self.tianLab.hidden = YES;
        self.begintimeWidth.constant = 60;
    }else if ([str containsString:@"倒计时"]){
        self.tianLab.hidden = YES;
        
//        customLabel *lab = [[customLabel alloc]initWithFrame: self.beginTime.bounds];
//        lab.string = [model.endTime substringFromIndex:11];
//
//        NSLog(@"%@",lab.string);
        self.beginTime.hidden = YES;
//        [self addSubview:lab];
//        lab.backgroundColor = [UIColor redColor];
        
        
        NSInteger count = [[str substringFromIndex:4]integerValue];
        
        self.count = count;
        
         [self countDownNotification];
        
        NSLog(@"%ld",(long)count);
    }else{
        self.beginTime.text = str;
        self.tianLab.hidden = NO;
        self.begintimeWidth.constant = 30;
    }
    
    
    NSString *tempStr = [model.endTime substringFromIndex:11];
    NSString *tempStr1 = [tempStr substringToIndex:2];
    
    NSString *tempStr2 = [tempStr substringFromIndex:3];
    NSString *tempStr3 = [tempStr2 substringToIndex:2];
   
    
    NSLog(@"%@",tempStr1);
    
    int tempTime = [tempStr1 intValue];
    if (tempTime>12) {
        self.beginDetailTime.text = [NSString stringWithFormat:@"下午%d:%@",tempTime -12,tempStr3];
    }else{
        self.beginDetailTime.text = [NSString stringWithFormat:@"上午%@",tempStr2];
    }
    
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
    [pickerBrowser setSelectImagesClick:^(NSString *num) {
        
    }];
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



#pragma mark - 倒计时通知回调
- (void)countDownNotification {
    
    
    
    
    NSString *str = [LYTools inputTimeStr:self.model.endTime];
    
  if ([str containsString:@"倒计时"]){

    NSInteger count = self.count;
        
      /// 计算倒计时
      //    OYModel *model = self.model;
      NSInteger timeInterval;
      //    if (model.countDownSource) {
      //        timeInterval = [kCountDownManager timeIntervalWithIdentifier:model.countDownSource];
      //    }else {
      timeInterval = kCountDownManager.timeInterval;
      //    }
      NSInteger countDown = count - timeInterval+1;
      // 当倒计时到了进行回调
          if (countDown <= 0) {
//              self.detailTextLabel.text = @"活动开始";
//              // 回调给控制器
//              if (self.countDownZero) {
//                  self.countDownZero(model);
//              }
              return;
          }
      /// 重新赋值
      self.daojishiLab.text = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", countDown/3600, (countDown/60)%60, countDown%60];
      self.daojishiLab.textColor = [UIColor blackColor];
      self.daojishiLab.hidden = NO;
        NSLog(@"%ld",(long)count);
    }
    
    
   
}


@end
