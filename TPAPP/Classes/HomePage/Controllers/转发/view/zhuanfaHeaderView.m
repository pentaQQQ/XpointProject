//
//  zhuanfaHeaderView.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/23.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "zhuanfaHeaderView.h"
#import "zidingyijineView.h"
#import "releaseActivitiesModel.h"
@interface zhuanfaHeaderView()
@property(nonatomic,strong)NSMutableArray*MerchanArray;
@property(nonatomic,assign)int count;
@property(nonatomic,weak)UIView *mengbanView;
@property(nonatomic,strong)zidingyijineView*jineview;

@property(nonatomic,assign)int currentDEX;
@property(nonatomic,strong)zhuanfaModel *zhuanfamodel;
@property(nonatomic,copy)NSString * price;

@end

@implementation zhuanfaHeaderView


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.count = 0;
        [SVProgressHUD doAnythingWithHUDMessage:@"获取中..."];
        [self getTheUserForwardConfiSuccess:^(zhuanfaModel *zhuanfamodel) {
            
            [self setBtnStateWithzhuanfaModel:zhuanfamodel];
            self.price = zhuanfamodel.price;
            
            NSString*title = [NSString stringWithFormat:@"批量转发 (+%@)",self.price];
            if (self.piliangBtn.titleLabel.text.length != 0) {
               [self.piliangBtn setTitle:title forState:UIControlStateNormal];
            }
            
            
        }];
        
        self.jiajiaBtn = [[UIButton alloc] init];
        [self.jiajiaBtn setTitle:@"加价" forState:UIControlStateNormal];
        [self.jiajiaBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.jiajiaBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.jiajiaBtn addTarget:self action:@selector(jiajiaBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.jiajiaBtn];
        [self.jiajiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(315);
            make.height.equalTo(@(40));
            make.width.equalTo(@(80));
        }];
        self.jiajiaBtn.layer.borderWidth = 1;
        self.jiajiaBtn.layer.borderColor = [[UIColor redColor] CGColor];
        self.jiajiaBtn.layer.masksToBounds = YES;
        self.jiajiaBtn.layer.cornerRadius = 5;
        
        self.piliangBtn = [[UIButton alloc] init];
        self.piliangBtn.backgroundColor = [UIColor redColor];
        NSString*title = [NSString stringWithFormat:@"批量转发 (+%@)",self.price];
        [self.piliangBtn setTitle:title forState:UIControlStateNormal];
        [self.piliangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.piliangBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.piliangBtn addTarget:self action:@selector(piliangBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.piliangBtn];
        [self.piliangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.jiajiaBtn.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self).offset(315);
            make.height.equalTo(@(40));
        }];
        self.piliangBtn.layer.borderWidth = 1;
        self.piliangBtn.layer.borderColor = [[UIColor redColor] CGColor];
        self.piliangBtn.layer.masksToBounds = YES;
        self.piliangBtn.layer.cornerRadius = 5;
        
    }
    return self;
}
- (void)piliangBtnAction
{
    if (self.MerchanArray.count == 0) {
        [SVProgressHUD doAnyRemindWithHUDMessage:@"暂无商品，无法批量转发" withDuration:1.5];
    }else{
        SimilarProductModel *model = self.MerchanArray[self.count];
        [self getMerchanData:model num:1];
    }
    
}
- (void)jiajiaBtnAction
{
    if (self.MerchanArray.count == 0) {
        [SVProgressHUD doAnyRemindWithHUDMessage:@"暂无商品，无法进行加价" withDuration:1.5];
    }else{
        SimilarProductModel *model = self.MerchanArray[self.count];
        [self getMerchanData:model num:0];
    }
}
-(void)getMerchanData:(SimilarProductModel *)model num:(int)num
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:nil forKey:@"activityId"];
    [dic setValue:model.merchantId forKey:@"merchantId"];
    [dic setValue:@(0) forKey:@"pageNum"];
    [dic setValue:@(5) forKey:@"pageSize"];
    [[NetworkManager sharedManager] getWithUrl:getActivityByMerchantId param:dic success:^(id json) {
        
        NSLog(@"%@",json);
        
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            releaseActivitiesModel *model1 = [releaseActivitiesModel mj_objectWithKeyValues:json[@"data"][@"releaseActivityApiResult"]];
            self.zhuanfaBlock(model1, num);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


-(NSMutableArray*)MerchanArray{
    if (_MerchanArray == nil) {
        _MerchanArray = [NSMutableArray array];
    }
    return _MerchanArray;
}



- (void)setFirstImageview:(UIImageView *)firstImageview{
    _firstImageview = firstImageview;
    //    [firstImageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571326962&di=8f502445613592dc9dd19dde4032c6ec&imgtype=0&src=http%3A%2F%2Fimg009.hc360.cn%2Fm6%2FM0A%2F98%2F05%2FwKhQoVVat96Ee_nyAAAAANCKIXo389.jpg"]];
}


-(void)setSecondImageview:(UIImageView *)secondImageview{
    _secondImageview = secondImageview;
    //    [secondImageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571328758&di=0f9dafd5ef73a3eff0a125ae310174ac&imgtype=0&src=http%3A%2F%2Fpic36.nipic.com%2F20131205%2F12477111_155227608129_2.jpg"]];
}

-(void)setThirdImageview:(UIImageView *)thirdImageview{
    _thirdImageview = thirdImageview;
    //    [thirdImageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571383364&di=3aea37c3e86ada28783624a5475d27cf&imgtype=0&src=http%3A%2F%2Fimg.shushi100.com%2F2017%2F02%2F15%2F1487169103-2682884336966288.jpg"]];
}

-(void)setFourthImageview:(UIImageView *)fourthImageview{
    _fourthImageview = fourthImageview;
    //    [fourthImageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487571404170&di=93c67271812592cb3483b4e88d633e2c&imgtype=0&src=http%3A%2F%2Fpic16.nipic.com%2F20110911%2F3059559_103205656510_2.png"]];
}




-(void)setFirstSaveBtn:(UIButton *)firstSaveBtn{
    _firstSaveBtn = firstSaveBtn;
    ViewBorderRadius(firstSaveBtn, 5, 1, [UIColor clearColor]);
    
    
    [firstSaveBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        NSString *str = [NSString stringWithFormat:@"%d",self.currentDEX];
        [self setZhuanfaDataWithdefaultImg:str];
    }];
    
    
}

-(void)setSecondSaveBtn:(UIButton *)secondSaveBtn{
    _secondSaveBtn = secondSaveBtn;
    ViewBorderRadius(secondSaveBtn, 5, 1, [UIColor clearColor]);
    [secondSaveBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        NSString *str = [NSString stringWithFormat:@"%d",self.currentDEX];
        [self setZhuanfaDataWithdefaultImg:str];
    }];
    
}

-(void)setThirdSaveBtn:(UIButton *)thirdSaveBtn{
    _thirdSaveBtn = thirdSaveBtn;
    ViewBorderRadius(thirdSaveBtn, 5, 1, [UIColor clearColor]);
}

-(void)setFourthSaveBtn:(UIButton *)fourthSaveBtn{
    _fourthSaveBtn = fourthSaveBtn;
    ViewBorderRadius(fourthSaveBtn, 5, 1, [UIColor clearColor]);
    [fourthSaveBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        NSString *str = [NSString stringWithFormat:@"%d",self.currentDEX];
        [self setZhuanfaDataWithdefaultImg:str];
    }];
}




- (IBAction)firstBtnClick:(id)sender {
    self.currentDEX = 3;
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
    self.currentDEX = 0;
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
    self.currentDEX = 1;
    [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.thirdBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
    [self.fourthBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    
    self.firstSaveBtn.hidden = YES;
    self.secondSaveBtn.hidden = YES;
    self.thirdSaveBtn.hidden = YES;
    self.fourthSaveBtn.hidden = YES;
}

- (IBAction)fourthBtnClick:(id)sender {
    self.currentDEX = 2;
    [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.fourthBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
    
    self.firstSaveBtn.hidden = YES;
    self.secondSaveBtn.hidden = YES;
    self.thirdSaveBtn.hidden = YES;
    self.fourthSaveBtn.hidden = NO;
}




- (IBAction)previousPageBtnClick:(id)sender {
    
    
    if (self.count==0) {
        self.previousPageBtn.userInteractionEnabled = NO;
    }else{
        self.previousPageBtn.userInteractionEnabled = YES;
    }
    
    
    
    if (self.count>0) {
        self.count--;
        [self setDadaWithModel:self.MerchanArray[self.count]];
    }else{
        
        self.count = 0;
        self.previousPageBtn.userInteractionEnabled = NO;
    }
    
    
    if (self.count<9&&self.count>=0) {
        NSString *title = [NSString stringWithFormat:@"第00%d号",self.count+1];
        [self.numberBtn setTitle:title forState:UIControlStateNormal];
    }else if (self.count<99&&self.count>=9){
        NSString *title = [NSString stringWithFormat:@"第0%d号",self.count+1];
        [self.numberBtn setTitle:title forState:UIControlStateNormal];
    }else{
        NSString *title = [NSString stringWithFormat:@"第%d号",self.count+1];
        [self.numberBtn setTitle:title forState:UIControlStateNormal];
    }
    
    
    
}



- (IBAction)numberBtnClick:(id)sender {
    
    [self setUpZidingyijianshuView];
}




- (IBAction)nextBtnClick:(id)sender {
    
    if (self.count<self.MerchanArray.count-1) {
        self.count++;
        if (self.MerchanArray.count>=1) {
            
            [self setDadaWithModel:self.MerchanArray[self.count]];
        }else{
            [SVProgressHUD doAnyRemindWithHUDMessage:@"该活动暂无商品，开始转发下一场活动" withDuration:1.5];
            if (self.ToNextMerchanBlock) {
                self.ToNextMerchanBlock();
            }
        }
      
    }else{
        
        [SVProgressHUD doAnyRemindWithHUDMessage:@"该活动已经转发完，开始转发下一场活动" withDuration:1.5];
        if (self.ToNextMerchanBlock) {
            self.ToNextMerchanBlock();
        }
        
    }
    
    
    if (self.count<9&&self.count>0) {
        NSString *title = [NSString stringWithFormat:@"第00%d号",self.count+1];
        [self.numberBtn setTitle:title forState:UIControlStateNormal];
    }else if (self.count<99&&self.count>=9){
        NSString *title = [NSString stringWithFormat:@"第0%d号",self.count+1];
        [self.numberBtn setTitle:title forState:UIControlStateNormal];
    }else{
        NSString *title = [NSString stringWithFormat:@"第%d号",self.count+1];
        [self.numberBtn setTitle:title forState:UIControlStateNormal];
    }
    
    
    self.previousPageBtn.userInteractionEnabled = YES;
    
}




- (IBAction)zhuanfaBtnClick:(id)sender {
    
    SimilarProductModel *model = self.MerchanArray[self.count];
    
    if (self.zhuanfaBlock) {
        self.zhuanfaBlock(model,self.currentDEX);
    }
}








-(void)setMerchanid:(NSString *)merchanid{
    _merchanid = merchanid;
    
    [self.MerchanArray removeAllObjects];
    self.count = 0;
    [self getTheMerchanWitnTheMerchanId:merchanid];
    
    if (self.count<9&&self.count>=0) {
        NSString *title = [NSString stringWithFormat:@"第00%d号",self.count+1];
        [self.numberBtn setTitle:title forState:UIControlStateNormal];
    }else if (self.count<99&&self.count>=9){
        NSString *title = [NSString stringWithFormat:@"第0%d号",self.count+1];
        [self.numberBtn setTitle:title forState:UIControlStateNormal];
    }else{
        NSString *title = [NSString stringWithFormat:@"第%d号",self.count+1];
        [self.numberBtn setTitle:title forState:UIControlStateNormal];
    }
    
}



-(void)setImagewithArray:(NSArray*)array{
    
    if (array.count != 0) {
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
    }else {
        [self.firstImageview sd_setImageWithURL:[NSURL URLWithString:@""]];
        [self.secondImageview sd_setImageWithURL:[NSURL URLWithString:@""]];
        
        [self.thirdImageview sd_setImageWithURL:[NSURL URLWithString:@""]];
        [self.fourthImageview sd_setImageWithURL:[NSURL URLWithString:@""]];
    }
    
    
    
    
    
    
}





//获取配置设置
-(void)getTheUserForwardConfiSuccess:(void(^)(zhuanfaModel*model))success{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    LYAccount *lyAccount = [LYAccount shareAccount];
    NSString *userId = [NSString stringWithFormat:@"%@",lyAccount.id];
    [dic setValue:userId forKey:@"userId"];
    
    [[NetworkManager sharedManager]getWithUrl:getUserForwardConfi param:dic success:^(id json) {
        NSLog(@"%@",json);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]){
            zhuanfaModel*model = [zhuanfaModel mj_objectWithKeyValues:json[@"data"]];
            self.zhuanfamodel = model;
            success(model);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}




-(void)setBtnStateWithzhuanfaModel:(zhuanfaModel*)model{
    
    
    if ([model.defaultImg isEqualToString:@"0"]) {
        self.currentDEX = 0;
        [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.secondBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
        [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.fourthBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        
        self.firstSaveBtn.hidden = YES;
        self.secondSaveBtn.hidden = NO;
        self.thirdSaveBtn.hidden = YES;
        self.fourthSaveBtn.hidden = YES;
        
    }else if ([model.defaultImg isEqualToString:@"1"]){
        self.currentDEX = 1;
        [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.thirdBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
        [self.fourthBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        
        self.firstSaveBtn.hidden = YES;
        self.secondSaveBtn.hidden = YES;
        self.thirdSaveBtn.hidden = YES;
        self.fourthSaveBtn.hidden = YES;
        
    }else if ([model.defaultImg isEqualToString:@"2"]){
        self.currentDEX = 2;
        [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.fourthBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
        
        self.firstSaveBtn.hidden = YES;
        self.secondSaveBtn.hidden = YES;
        self.thirdSaveBtn.hidden = YES;
        self.fourthSaveBtn.hidden = NO;
        
    }else if ([model.defaultImg isEqualToString:@"3"]){
        self.currentDEX = 3;
        [self.firstBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
        [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        [self.fourthBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
        
        self.firstSaveBtn.hidden = NO;
        self.secondSaveBtn.hidden = YES;
        self.thirdSaveBtn.hidden = YES;
        self.fourthSaveBtn.hidden = YES;
        
    }
    
    
}


//根据商户id拿到对应的全部商品
-(void)getTheMerchanWitnTheMerchanId:(NSString*)merchanid{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setValue:merchanid forKey:@"id"];//  getProductByMerchantId
    [dic setValue:nil forKey:@"activityId"];
    [dic setValue:merchanid forKey:@"merchantId"];
    [dic setValue:@(0) forKey:@"pageNum"];
    [dic setValue:@(10) forKey:@"pageSize"];
    //getProductByActivityId   getActivityByMerchantId
    [[NetworkManager sharedManager] getWithUrl:getActivityByMerchantId param:dic success:^(id json) {
    
        NSLog(@"%@",json);
        [SVProgressHUD dismiss];
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]){
            [self.MerchanArray removeAllObjects];
//            releaseActivitiesModel *model = [releaseActivitiesModel mj_objectWithKeyValues:json[@"data"][@"releaseActivityApiResult"]];
//            [self.MerchanArray addObject:model];
            for (NSDictionary *dic in json[@"data"][@"productApiResults"][@"data"]) {
                SimilarProductModel *model = [SimilarProductModel mj_objectWithKeyValues:dic];
                [self.MerchanArray addObject:model];
            }
//            for (NSDictionary *dic in json[@"data"]) {
//
//                SimilarProductModel *model = [SimilarProductModel mj_objectWithKeyValues:dic];
//                [self.MerchanArray addObject:model];
//
//            }
            if (self.MerchanArray.count>=1 ) {
//                NSInteger num = self.count;
//                if (self.MerchanArray.count > 0) {
//                   SimilarProductModel *model = self.MerchanArray[num];
                    [self setDadaWithModel:self.MerchanArray[self.count]];
//                }
                
                
            }
          
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        
    }];
    
}





//设置相应的数据
-(void)setDadaWithModel:(SimilarProductModel *)model{
    
    
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
    
    
    self.xinghaoLab.text = model.merchantName;
    self.kuanshiLab.text = [NSString stringWithFormat:@"尺码 %@",str];
    self.kuanhaoLab.text = [NSString stringWithFormat:@"款式 %@",model.design];
    
    
    [self setImagewithArray:model.imagesList];
    
}



-(void)setUpZidingyijianshuView{
    
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    zidingyijineView *jineview = [[NSBundle mainBundle]loadNibNamed:@"zidingyijineView" owner:self options:nil].lastObject;
    ViewBorderRadius(jineview, 5, 1, [UIColor clearColor]);
    self.jineview = jineview;
    jineview.frame = CGRectMake(20, (kScreenHeight-135)/2, kScreenWidth-40, 135);
    
    [keyWindow addSubview:jineview];
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [mengbanView addGestureRecognizer:tap];
    
    
    [jineview.textField becomeFirstResponder];
    jineview.title.text = @"输入商品序列号";
    jineview.textField.placeholder = @"请输入商品序列号后3位";
    
    
    
    __weak __typeof(self) weakSelf = self;
    
    [jineview.cancelBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf.mengbanView removeFromSuperview];
        [weakSelf.jineview removeFromSuperview];
        [self endEditing:YES];
    }];
    
    [jineview.sureBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        if (jineview.textField.text.length !=3) {
            [SVProgressHUD doAnyRemindWithHUDMessage:@"输入正确的序列号" withDuration:1.5];
        }else{
            int tempNum = [jineview.textField.text intValue];
            if (tempNum > weakSelf.MerchanArray.count||tempNum == 0) {
                [SVProgressHUD doAnyRemindWithHUDMessage:@"输入正确的序列号" withDuration:1.5];
            }else{
                weakSelf.count = [jineview.textField.text intValue]-1;
                NSString *title = [NSString stringWithFormat:@"第%@号",jineview.textField.text];
                [weakSelf.numberBtn setTitle:title forState:UIControlStateNormal];
                [weakSelf setDadaWithModel:self.MerchanArray[weakSelf.count]];
            }
        }
        
        [weakSelf.mengbanView removeFromSuperview];
        [weakSelf.jineview removeFromSuperview];
        [self endEditing:YES];
    }];
    
}


-(void)tap{
    
    [self.jineview removeFromSuperview];
    [self.mengbanView removeFromSuperview];
    
}



//存储转发设置
-(void)setZhuanfaDataWithdefaultImg:(NSString*)defaultImg{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    
    [dic setValue:defaultImg forKey:@"defaultImg"];
    [dic setValue:self.zhuanfamodel.id forKey:@"id"];
    [dic setValue:self.zhuanfamodel.lackSize forKey:@"lackSize"];
    [dic setValue:self.zhuanfamodel.num forKey:@"num"];
    [dic setValue:self.zhuanfamodel.price forKey:@"price"];
    LYAccount *lyAccount = [LYAccount shareAccount];
    [dic setValue:lyAccount.id forKey:@"userId"];
    
    
    [LYTools postBossDemoWithUrl:updateUserForwardConfi param:dic success:^(NSDictionary *dict) {
        
        NSLog(@"%@",dict);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
        
        if ([respCode isEqualToString:@"00000"]){
            [SVProgressHUD doAnythingSuccessWithHUDMessage:@"保存成功" withDuration:1.5];
        }
        
        
    } fail:^(NSError *error) {
        
        
        
    }];
    
}


@end
