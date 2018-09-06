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
#import "ZhuanfaOtherView.h"

@interface GoDetailTableViewCell()
@property(nonatomic,strong)NSMutableArray*dataArr;
@property(nonatomic,strong)NSMutableArray*btnArr;
@property(nonatomic,weak)UIView *mengbanView;
@property(nonatomic,strong)ZhuanfaOtherView *zhuanfaotherview;
@end


@implementation GoDetailTableViewCell
-(NSMutableArray*)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(NSMutableArray*)btnArr{
    if (_btnArr == nil) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

- (IBAction)goShoppingAction:(id)sender {
    specsModel *model = self.dataArr[0];
    self.goShoppingBlock(model);
}

-(void)setImageview:(UIImageView *)imageview{
    _imageview = imageview;
    ViewBorderRadius(imageview, 5, 1, [UIColor lightGrayColor]);
}
-(void)setShouqianBtn:(UIButton *)shouqianBtn{
    _shouqianBtn = shouqianBtn;
    ViewBorderRadius(shouqianBtn, 5, 1, [UIColor clearColor]);
}
-(void)setZhuanfaBtn:(UIButton *)zhuanfaBtn{
    _zhuanfaBtn = zhuanfaBtn;
    ViewBorderRadius(zhuanfaBtn, 5, 1, [UIColor clearColor]);
    
    [zhuanfaBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self setUpZidingyijianshuView];
    }];
}
-(void)setShoppingcartBtn:(UIButton *)shoppingcartBtn{
    _shoppingcartBtn = shoppingcartBtn;
    ViewBorderRadius(shoppingcartBtn, 5, 1, [UIColor clearColor]);
    shoppingcartBtn.userInteractionEnabled = NO;
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
    self.xianghaoViewHigh.constant = (high+10)*rows+50;
    
    
    
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
                
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((widt+10)*j+10, (10+high)*i+10,  widt, high)];
                ViewBorderRadius(btn, 5, 1, [UIColor clearColor]);
                [self.xinghaoView addSubview:btn];
                btn.backgroundColor = [UIColor lightGrayColor];
                btn.titleLabel.font = [UIFont systemFontOfSize:12];
                [btn setTitle:title forState:UIControlStateNormal];
                [btn setTintColor:[UIColor blackColor]];
                btn.tag = k;
                btn.selected = NO;
                
                [self.btnArr addObject:btn];
                
                __weak __typeof(btn) weakSelfbtn = btn;
                __weak __typeof(self) weakSelf = self;
                [weakSelfbtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                    
                    
                    
                    for (UIButton *bt in weakSelf.btnArr) {
                        specsModel*spmodel = weakSelf.model.specs[bt.tag];
                        if (bt.tag == weakSelfbtn.tag) {
                            
                            if (bt.selected == NO) {
                                bt.selected = YES;
                                bt.backgroundColor = [UIColor redColor];
                                [weakSelf.dataArr addObject:spmodel];
                            }else{
                                bt.selected = NO;
                                bt.backgroundColor = [UIColor lightGrayColor];
                                [weakSelf.dataArr removeObject:spmodel];
                            }
                            
                        }else{
                            [weakSelf.dataArr removeObject:spmodel];
                            bt.selected = NO;
                            bt.backgroundColor = [UIColor lightGrayColor];
                        }
                    }
                    
                    
                    if (weakSelf.dataArr.count) {
                        weakSelf.shoppingcartBtn.backgroundColor = [UIColor redColor];
                        weakSelf.shoppingcartBtn.userInteractionEnabled = YES;
                    }else{
                        
                        weakSelf.shoppingcartBtn.backgroundColor = [UIColor lightGrayColor];
                        weakSelf.shoppingcartBtn.userInteractionEnabled = NO;
                    }
                    
                }];
            }
        }
    }
    
    
}







-(void)setUpZidingyijianshuView{
    
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    ZhuanfaOtherView *zhuanfaotherview = [[NSBundle mainBundle]loadNibNamed:@"ZhuanfaOtherView" owner:self options:nil].lastObject;
    ViewBorderRadius(zhuanfaotherview, 5, 1, [UIColor clearColor]);
    self.zhuanfaotherview = zhuanfaotherview;
    zhuanfaotherview.frame = CGRectMake(20, (kScreenHeight-283)/2, kScreenWidth-40, 283);
    
    [keyWindow addSubview:zhuanfaotherview];
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [mengbanView addGestureRecognizer:tap];
    
   

    __weak __typeof(self) weakSelf = self;
    
    [zhuanfaotherview.cancelBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf.mengbanView removeFromSuperview];
        [weakSelf.zhuanfaotherview removeFromSuperview];
        [self endEditing:YES];
    }];
    
    [zhuanfaotherview.sureBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
  
        [weakSelf.mengbanView removeFromSuperview];
        [weakSelf.zhuanfaotherview removeFromSuperview];
        [self endEditing:YES];
    }];
    
}





-(void)tap{
    
    [self.zhuanfaotherview removeFromSuperview];
    [self.mengbanView removeFromSuperview];
    
}











@end
