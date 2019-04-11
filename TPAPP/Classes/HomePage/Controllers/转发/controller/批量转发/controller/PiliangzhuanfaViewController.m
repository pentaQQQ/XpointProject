//
//  PiliangzhuanfaViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/9/7.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "PiliangzhuanfaViewController.h"
#import "PiLiangzhuanfaCell.h"
#import "SimilarProductModel.h"
#import "oldhechengView.h"
#import "zhuanfaModel.h"
#import "ShareItem.h"
#import "jiajiaView.h"
#import "zidingyijineView.h"

#import "huodongzhuanfayaView.h"
#import "HFiveDetailViewController.h"
#import "CustomActivity.h"
@interface PiliangzhuanfaViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UILabel *topLab;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;

@property (weak, nonatomic) IBOutlet UIButton *jiajiaBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhuanfaBtn;

@property (weak, nonatomic) IBOutlet UIView *bottomView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTopHigh;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)oldhechengView*oldheview;

@property(nonatomic,assign)int currentIndex;//判断转发样式 1 九宫格 2 合成长图 3 分享整场活动

@property(nonatomic,strong)zhuanfaModel *zhuanfamodel;

@property(nonatomic,strong)NSMutableArray *pictureArr;//存放分享的图片
@property(nonatomic,strong)NSMutableArray *indexArr;//存放要分享的商品的index


@property(nonatomic,strong)UIView*vi;


@property(nonatomic,assign)int shareCount;

@property(nonatomic,copy)NSString *price;


@property(nonatomic,weak)UIView *mengbanView;

@property(nonatomic,strong)jiajiaView*jiajiaview;
@property(nonatomic,strong)zidingyijineView*jineview;




@property(nonatomic,strong)huodongzhuanfayaView *huodongzhuanfayaview;


@end

@implementation PiliangzhuanfaViewController

-(NSMutableArray*)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray*)pictureArr{
    if (_pictureArr == nil) {
        _pictureArr = [NSMutableArray array];
    }
    return _pictureArr;
}
-(NSMutableArray*)indexArr{
    if (_indexArr == nil) {
        _indexArr = [NSMutableArray array];
    }
    return _indexArr;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.huodongzhuanfayaview.hidden = NO;
    self.mengbanView.hidden = NO;
    
    [self getTheUserForwardConfiSuccess:^(zhuanfaModel *model) {
        
        self.price = model.price;
        
        
        NSString*title = [NSString stringWithFormat:@"批量转发(+%@)",self.price];
        
        [self.zhuanfaBtn setTitle:title forState:UIControlStateNormal];
        
        
        
    }];
}


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
            success(model);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 1;
    ViewBorderRadius(self.jiajiaBtn, 5, 1, [UIColor redColor]);
    ViewBorderRadius(self.zhuanfaBtn, 5, 1, [UIColor clearColor]);
    self.toTopHigh.constant = SafeAreaTopHeight;
    
    
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [UIView new];
    
    [self getTheUserForwardConfi];
    
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.vi = vi;
    vi.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:vi belowSubview:self.bottomView];
    
    
    
    [self.jiajiaBtn addTarget:self action:@selector(jiajiabtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}




- (void)lodaData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.ID forKey:@"id"];
    [[NetworkManager sharedManager] getWithUrl:getProductByActivityId param:dic success:^(id json) {
        
        NSLog(@"%@",json);
        
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            
            for (NSDictionary *dic in json[@"data"]) {
                SimilarProductModel *model = [SimilarProductModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
            
            if (self.dataArr.count >=  self.shareCount) {
                self.topLab.text = [NSString stringWithFormat:@"当前已选中%d款商品",self.shareCount];
                
                for (int i =0; i<self.shareCount; i++) {
                    
                    NSString *ind = [NSString stringWithFormat:@"%d",i];
                    
                    [self.indexArr addObject:ind];
                }
                
            }else{
                self.topLab.text = [NSString stringWithFormat:@"当前已选中%lu款商品",(unsigned long)self.dataArr.count];
                
                for (int i =0; i<self.dataArr.count; i++) {
                    
                    NSString *ind = [NSString stringWithFormat:@"%d",i];
                    
                    [self.indexArr addObject:ind];
                }
                
            }
            
            
            [self.tableview reloadData];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuesrId = @"PiLiangzhuanfaCell";
    
    PiLiangzhuanfaCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesrId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"PiLiangzhuanfaCell" owner:self options:nil].lastObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SimilarProductModel *model = self.dataArr[indexPath.row];
    
    cell.model = model;
    
    NSString *ind = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    if ([self.indexArr containsObject:ind]) {
        cell.selctImageview.image = [UIImage imageNamed:@"已选中"];
    }else{
        
        cell.selctImageview.image = [UIImage imageNamed:@"未选中"];
        
    }
    
    
    return cell;
    
    
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *ind = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    
    
    if ([self.indexArr containsObject:ind]) {
        [self.indexArr removeObject:ind];
        self.topLab.text = [NSString stringWithFormat:@"当前已选中%lu款商品",(unsigned long)self.indexArr.count];
    }else{
        
        
        if (self.indexArr.count == self.shareCount) {
            NSString *ti = [NSString stringWithFormat:@"一次最多只能选%d个商品",self.shareCount];
            [SVProgressHUD doAnyRemindWithHUDMessage:ti withDuration:1.5];
            return;
        }else{
            [self.indexArr addObject:ind];
            
            self.topLab.text = [NSString stringWithFormat:@"当前已选中%lu款商品",(unsigned long)self.indexArr.count];
            
            
        }
        
    }
    [self.tableview reloadData];
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SimilarProductModel *model = self.dataArr[indexPath.row];
    
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
    
    
    
    NSString *str1 = [NSString stringWithFormat:@"尺码 %@",str];
    NSString *str2 = [NSString stringWithFormat:@"款式 %@",model.design];
    NSString *str3= [NSString stringWithFormat:@"款号 %@",model.designCode];
    
    CGFloat h1 = [LYTools getHeighWithTitle:model.productName font:[UIFont systemFontOfSize:14] width:kScreenWidth-183]+10;
    
    CGFloat h2 = [LYTools getHeighWithTitle:  str1 font:[UIFont systemFontOfSize:14] width:kScreenWidth-183]+10;
    
    CGFloat h3  = [LYTools getHeighWithTitle:str2 font:[UIFont systemFontOfSize:14] width:kScreenWidth-183]+10;
    
    CGFloat h4  =[LYTools getHeighWithTitle: str3 font:[UIFont systemFontOfSize:14] width:kScreenWidth-183]+10;
    
    
    return h1+h2+h3+h4+10;
}


- (IBAction)firstBtnclick:(id)sender {//九宫格
    self.currentIndex = 1;
    [self.firstBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
    [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
}



- (IBAction)secondBtnClick:(id)sender {//合并成长图
    self.currentIndex = 2;
    [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.secondBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
    [self.thirdBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
}



- (IBAction)thirdBtnClick:(id)sender {//分享整场活动
    self.currentIndex = 3;
    [self.firstBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.secondBtn setImage:[UIImage imageNamed:@"icon_未选择"] forState:UIControlStateNormal];
    [self.thirdBtn setImage:[UIImage imageNamed:@"已选中"] forState:UIControlStateNormal];
}





- (IBAction)zhuanfaClick:(id)sender {
    
    if (self.currentIndex == 1) {//九宫格
        
        [self getTheZhuanFaImage];
        
    }else if (self.currentIndex == 2){//合成长图
        [self zhuanfaChangTu];
        
    }else{//分享整场活动
//        [self zhuanfaChangTu];
        
       
        
        [self getTheDiBuTanchuangWithModel:self.model AndzhuanfaModel:self.zhuanfamodel];
    }
    
}








-(void)getTheDiBuTanchuangWithModel:(releaseActivitiesModel*)model AndzhuanfaModel:(zhuanfaModel*)mod{
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    
    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [mengbanView addGestureRecognizer:tapges];
    
    huodongzhuanfayaView *huodongzhuanfayaview = [[NSBundle mainBundle]loadNibNamed:@"huodongzhuanfayaView" owner:self options:nil].lastObject;
    ViewBorderRadius(huodongzhuanfayaview, 5, 1, [UIColor clearColor]);
    self.huodongzhuanfayaview = huodongzhuanfayaview;
    huodongzhuanfayaview.frame = CGRectMake(0, kScreenHeight-500, kScreenWidth, 500);
    
    huodongzhuanfayaview.zhuanfamodel = mod;
    huodongzhuanfayaview.model = model;
    
    WeakSelf(weakSelf);
    self.huodongzhuanfayaview.removeBlock = ^{
        
        
        [weakSelf.mengbanView removeFromSuperview];
    };
    
    
    self.huodongzhuanfayaview.toH5Block = ^(NSString * _Nonnull url) {
        HFiveDetailViewController *vc = [[HFiveDetailViewController alloc]init];
        vc.url = url;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    
    self.huodongzhuanfayaview.zhuanfaBlock = ^(NSString * _Nonnull url) {
        
        // 1、设置分享的内容，并将内容添加到数组中
        NSString *shareText = @"分享的标题";
        UIImage *shareImage = [UIImage imageNamed:@"logo"];
        NSURL *shareUrl = [NSURL URLWithString:url];
        NSArray *activityItemsArray = @[shareText,shareImage,shareUrl];
        
        // 自定义的CustomActivity，继承自UIActivity
        CustomActivity *customActivity = [[CustomActivity alloc]initWithTitle:shareText ActivityImage:[UIImage imageNamed:@"logo"] URL:shareUrl ActivityType:@"Custom"];
        NSArray *activityArray = @[customActivity];
        
        // 2、初始化控制器，添加分享内容至控制器
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItemsArray applicationActivities:activityArray];
        activityVC.modalInPopover = YES;
        // 3、设置回调
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            // ios8.0 之后用此方法回调
            UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
                NSLog(@"activityType == %@",activityType);
                if (completed == YES) {
                    NSLog(@"completed");
                }else{
                    NSLog(@"cancel");
                }
            };
            activityVC.completionWithItemsHandler = itemsBlock;
        }else{
            // ios8.0 之前用此方法回调
            UIActivityViewControllerCompletionHandler handlerBlock = ^(UIActivityType __nullable activityType, BOOL completed){
                NSLog(@"activityType == %@",activityType);
                if (completed == YES) {
                    NSLog(@"completed");
                }else{
                    NSLog(@"cancel");
                }
            };
            activityVC.completionHandler = handlerBlock;
        }
        // 4、调用控制器
        [weakSelf presentViewController:activityVC animated:YES completion:nil];
    };
    
    
    
    [keyWindow addSubview:huodongzhuanfayaview];
}


-(void)tappp{
    [self.mengbanView removeFromSuperview];
    [self.huodongzhuanfayaview removeView];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.huodongzhuanfayaview.hidden = YES;
    self.mengbanView.hidden = YES;
}
//
//-(void)viewWillAppear:(BOOL)animated{
//    self.huodongzhuanfayaview.hidden = NO;
//    self.mengbanView.hidden = NO;
//}











//九宫格转发
-(void)getTheZhuanFaImage{
    
    if (!self.indexArr.count) {
        [SVProgressHUD doAnyRemindWithHUDMessage:@"请选择要转发的商品" withDuration:1.5];
        return;
    }
    for (int i =0; i<self.indexArr.count; i++) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString *indetx = self.indexArr[i];
            int tempI = [indetx intValue];
            SimilarProductModel *model = self.dataArr[tempI];
            
            [self getThePictureWithModel:model Success:^(UIImage *image) {
                
                
                [self.pictureArr addObject:image];
                
                if (self.pictureArr.count == self.indexArr.count) {
                    
                    [self shareMangPictureWithArr:self.pictureArr];
                }
                
            }];
            
        });
        
        
        
    }
}




-(void)getThePictureWithModel:(SimilarProductModel *)model Success:(void(^)(UIImage *))success{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        oldhechengView*oldheview= [[NSBundle mainBundle]loadNibNamed:@"oldhechengView" owner:self options:nil].lastObject;
        self.oldheview = oldheview;
        oldheview.frame =  CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self.view insertSubview:oldheview belowSubview:self.vi];
        
        oldheview.price = self.price;
        oldheview.model = model;
        
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIImage *ima = [self captureScrollView:oldheview.scrollview];
            
            if (ima) {
                success(ima);
                [oldheview removeFromSuperview];
            }
            
        });
        
    });
    
}



//截取长图
- (UIImage *)captureScrollView:(UIScrollView *)scrollView {
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, NO, 0.0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.frame = CGRectMake(0 , 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    return nil;
}




//合并成长图
-(void)zhuanfaChangTu{
    
    if (!self.indexArr.count) {
        [SVProgressHUD doAnyRemindWithHUDMessage:@"请选择要转发的商品" withDuration:1.5];
        return;
    }
    
    for (int i =0; i<self.indexArr.count; i++) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString *indetx = self.indexArr[i];
            int tempI = [indetx intValue];
            SimilarProductModel *model = self.dataArr[tempI];
            
            [self getThePictureWithModel:model Success:^(UIImage *image) {
                
                
                [self.pictureArr addObject:image];
                
                if (self.pictureArr.count == self.indexArr.count) {
                    
                    [self getTheChangTuWithArr:self.pictureArr Success:^(UIImage *image) {
                        
                        NSMutableArray *tepArr = [NSMutableArray array];
                        [tepArr addObject:image];
                        [self shareMangPictureWithArr:tepArr];
                    }];
                }
                
            }];
            
        });
        
    }
    
}



//获取长图
-(void)getTheChangTuWithArr:(NSMutableArray*)arr Success:(void(^)(UIImage *))success{
    
    CGFloat high = 0;
    if (kScreenWidth<=375.0) {
        high = kScreenHeight/3+60;
    }else{
        high = kScreenHeight/3+20;
        
    }
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, high)];
    [self.view insertSubview:scroll belowSubview:self.vi];
    
    scroll.contentSize = CGSizeMake(kScreenWidth, (high+10) * arr.count);
    for (int i =0; i<arr.count; i++) {
        UIImage *imag = arr[i];
        UIImageView *ima = [[UIImageView alloc]initWithFrame:CGRectMake(0, (high+10)*i, kScreenWidth, high)];
        ima.image = imag;
        
        [ima setContentMode:UIViewContentModeScaleAspectFill];
        ima.clipsToBounds = YES;
        [scroll addSubview:ima];
    }
    
    
    
    UIImage *ima = [self captureScrollView:scroll];
    if (ima) {
        success(ima);
        [scroll removeFromSuperview];
    }
    
}



//获取转发设置
-(void)getTheUserForwardConfi{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    LYAccount *lyAccount = [LYAccount shareAccount];
    NSString *userId = [NSString stringWithFormat:@"%@",lyAccount.id];
    [dic setValue:userId forKey:@"userId"];
    
    [[NetworkManager sharedManager]getWithUrl:getUserForwardConfi param:dic success:^(id json) {
        NSLog(@"%@",json);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]){
            self.zhuanfamodel = [zhuanfaModel mj_objectWithKeyValues:json[@"data"]];
            self.shareCount =  [self.zhuanfamodel.num intValue];
            [self.tableview reloadData];
            
            [self lodaData];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}




//分享多张图片
-(void)shareMangPictureWithArr:(NSMutableArray*)arr{
    
    NSMutableArray *items = [NSMutableArray array];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    for (int i = 0; i < arr.count; i++) {
        //取出地址
        //        NSString *URL = [activityItems[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //把图片转成NSData类型
        //        NSData * data = arr[i];
        //写入图片中
        UIImage *imagerang = arr[i];
        //图片缓存的地址，自己进行替换
        NSString *imagePath = [docPath stringByAppendingString:[NSString stringWithFormat:@"/SharePicture%d.jpg",i]];
        //把图片写进缓存，一定要先写入本地，不然会分享出错
        [UIImageJPEGRepresentation(imagerang, .5) writeToFile:imagePath atomically:YES];
        //把缓存图片的地址转成NSUrl格式
        NSURL *shareobj = [NSURL fileURLWithPath:imagePath];
        //这个部分是自定义ActivitySource
        ShareItem *item = [[ShareItem alloc] initWithData: imagerang andFile:shareobj];
        //分享的数组
        [items addObject:item];
    }
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    //去除特定的分享功能
    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
    
    [self presentViewController: activityVC animated:YES completion:nil];
    
    
    
    //初始化Block回调方法,此回调方法是在iOS8之后出的，代替了之前的方法
    UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(NSString *activityType,BOOL completed,NSArray *returnedItems,NSError *activityError)
    {
        NSLog(@"activityType :%@", activityType);
        if (completed)
        {
            NSLog(@"completed");
            [self.pictureArr removeAllObjects];
            for (int i = 0; i < arr.count; i++){
                NSString *imagePath = [docPath stringByAppendingString:[NSString stringWithFormat:@"/SharePicture%d.jpg",i]];
                NSFileManager *manager = [NSFileManager defaultManager];
                [manager removeItemAtPath:imagePath error:nil];
            }
            
        }
        else
        {
            NSLog(@"cancel");
            [self.pictureArr removeAllObjects];
        }
        
    };
    
    // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
    activityVC.completionWithItemsHandler = myBlock;
    
    
    
}






-(void)jiajiabtnClick{
    [self setUpjiajiaView];
}




-(void)setUpjiajiaView{
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    jiajiaView *jiajiaview = [[NSBundle mainBundle]loadNibNamed:@"jiajiaView" owner:self options:nil].lastObject;
    self.jiajiaview = jiajiaview;
    jiajiaview.frame = CGRectMake(0, kScreenHeight-255-SafeAreaBottomHeight, kScreenWidth, 255+SafeAreaBottomHeight);
    
    [keyWindow addSubview:jiajiaview];
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [mengbanView addGestureRecognizer:tap];
    
    
    __weak __typeof(self) weakSelf = self;
    
    jiajiaview.jiajiaBlock = ^(NSString *title, NSString *detailTitle) {
        
        [weakSelf.mengbanView removeFromSuperview];
        
        if (![title isEqualToString:@""]) {
            
            
            
            if ([title isEqualToString:@"不加价"]) {
                
                self.price = @"0";
                
                NSString*title = [NSString stringWithFormat:@"批量转发(+%@)",self.price];
                
                [self.zhuanfaBtn setTitle:title forState:UIControlStateNormal];
                
                
                
            }else if ([title isEqualToString:@"+5元"]){
                
                
                self.price = @"5";
                
                NSString*title = [NSString stringWithFormat:@"批量转发(+%@)",self.price];
                
                [self.zhuanfaBtn setTitle:title forState:UIControlStateNormal];
                
                
            }else if ([title isEqualToString:@"+10元"]){
                
                self.price = @"10";
                
                NSString*title = [NSString stringWithFormat:@"批量转发(+%@)",self.price];
                
                [self.zhuanfaBtn setTitle:title forState:UIControlStateNormal];
                
            }
            
        }else{
            
            [weakSelf setUpZidingyijineView];
        }
        
    };
    jiajiaview.removeBlock = ^{
        [weakSelf.mengbanView removeFromSuperview];
    };
    
}

-(void)tap{
    
    [self.jiajiaview removeFromSuperview];
    [self.mengbanView removeFromSuperview];
}

-(void)setZhuanfaDataWithPrice:(NSString *)price{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.zhuanfamodel.defaultImg forKey:@"defaultImg"];
    [dic setValue:self.zhuanfamodel.id forKey:@"id"];
    [dic setValue:self.zhuanfamodel.lackSize forKey:@"lackSize"];
    [dic setValue:self.zhuanfamodel.num forKey:@"num"];
    [dic setValue:price forKey:@"price"];
    LYAccount *lyAccount = [LYAccount shareAccount];
    [dic setValue:lyAccount.id forKey:@"userId"];
    
    
    [LYTools postBossDemoWithUrl:updateUserForwardConfi param:dic success:^(NSDictionary *dict) {
        
        NSLog(@"%@",dict);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
        
        if ([respCode isEqualToString:@"00000"]){
            [self getTheUserForwardConfiSuccess:^(zhuanfaModel *model) {
                
                
                self.price = model.price;
                
                NSString*title = [NSString stringWithFormat:@"批量转发(+%@)",self.price];
                
                [self.zhuanfaBtn setTitle:title forState:UIControlStateNormal];
                
            }];
        }
        
    } fail:^(NSError *error) {
        
        
    }];
    
}




-(void)setUpZidingyijineView{
    
    
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
    __weak __typeof(self) weakSelf = self;
    [jineview.cancelBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf.mengbanView removeFromSuperview];
        [weakSelf.jineview removeFromSuperview];
        [self.view endEditing:YES];
    }];
    
    [jineview.sureBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        
        
        self.price = jineview.textField.text;
        
        NSString*title = [NSString stringWithFormat:@"批量转发(+%@)",self.price];
        
        [self.zhuanfaBtn setTitle:title forState:UIControlStateNormal];
        
        
        [weakSelf.mengbanView removeFromSuperview];
        [weakSelf.jineview removeFromSuperview];
        [self.view endEditing:YES];
    }];
    
}



@end
