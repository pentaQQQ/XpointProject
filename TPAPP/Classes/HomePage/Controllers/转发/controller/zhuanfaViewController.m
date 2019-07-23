//
//  zhuanfaViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/23.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "zhuanfaViewController.h"
#import "zhuanfaHeaderView.h"
#import "zhuanfaCell.h"
#import "zhuanfasetViewController.h"
#import "shanghuModel.h"
#import "SimilarProductModel.h"
#import "imagesListModel.h"
#import "XinHeChengTuView.h"
#import "danshouView.h"
#import "ShareItem.h"
#import "oldhechengView.h"

#import <Social/Social.h>
#import "ShareTool.h"

#import "zhuanfaModel.h"
#import "jiajiaView.h"
#import "zidingyijineView.h"

#import "huodongzhuanfayaView.h"
#import "HFiveDetailViewController.h"
#import "CustomActivity.h"
@interface zhuanfaViewController ()<UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate>
@property(nonatomic,strong)zhuanfaHeaderView*headerview;
@property(nonatomic,strong)UITableView*tableview;
@property (nonatomic, strong) NSMutableArray *titleArray;

@property(nonatomic,assign)int currentIndex;

@property(nonatomic,copy)NSString * savedImagePath;

@property(nonatomic,strong)XinHeChengTuView*xinheview;
@property(nonatomic,strong)danshouView*danshouview;
@property(nonatomic,strong)oldhechengView*oldheview;
@property(nonatomic,strong)UIImageView*imageview;


@property (nonatomic, retain) UIDocumentInteractionController *docuController;
@property(nonatomic,copy)NSString *price;

//@property(nonatomic,copy)NSString *price;


@property(nonatomic,weak)UIView *mengbanView;
@property(nonatomic,strong)jiajiaView*jiajiaview;
@property(nonatomic,strong)zidingyijineView*jineview;
@property(nonatomic,strong)huodongzhuanfayaView *huodongzhuanfayaview;
@property(nonatomic,strong)zhuanfaModel *zhuanfamodel;
@end

@implementation zhuanfaViewController
-(NSMutableArray*)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

-(void)viewWillAppear:(BOOL)animated{
    [self getTheUserForwardConfiSuccess:^(zhuanfaModel *model) {
        
        self.price = model.price;
        
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
            self.zhuanfamodel = [zhuanfaModel mj_objectWithKeyValues:json[@"data"]];
            success(model);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"选择品牌转发";
    self.currentIndex = 0;
    
//    [self setItems];
    [self setUpHeaderview];
    [self getdata];
}



-(void)setItems{
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithTitle:@"转发设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightitemClick)];
    
    self.navigationItem.rightBarButtonItem = rightitem;
    
}

-(void)leftitemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)rightitemClick{
    zhuanfasetViewController *vc = [[zhuanfasetViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setUpHeaderview{
    
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-380-SafeAreaTopHeight) style:UITableViewStylePlain];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    tableview.tableFooterView = [UIView new];
    
    
    zhuanfaHeaderView*headerview = [[NSBundle mainBundle]loadNibNamed:@"zhuanfaHeaderView" owner:self options:nil].lastObject;
    self.headerview = headerview;
    headerview.frame = CGRectMake(0, CGRectGetMaxY(tableview.frame), kScreenWidth,380);
    [self.view addSubview:headerview];
    
    
    headerview.ToNextMerchanBlock = ^{

        self.currentIndex++;
        if (self.currentIndex<self.titleArray.count) {

            [self.tableview reloadData];
        }else{
            [SVProgressHUD doAnyRemindWithHUDMessage:@"该活动已转发完" withDuration:1.5];
        }
    };
    
    
    headerview.zhuanfaBlock = ^(SimilarProductModel *model,int curretDEX) {

        if (curretDEX == 0) {
            [self setUpjiajiaView];
        }else{
            self.zhuanfamodel.price = self.price;
            [self getTheDiBuTanchuangWithModel:model AndzhuanfaModel:self.zhuanfamodel];
        }
//        if (curretDEX == 0) {
//            self.danshouview.price = self.price;
//            self.danshouview.model = model;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                NSData *imagedata= UIImageJPEGRepresentation([self snapshotScreenInView:self.danshouview], 1.0f);
//                [self sharePictureWithImageData:imagedata];
//            });
//
//
//        }else if (curretDEX == 1){
//            [SVProgressHUD doAnyRemindWithHUDMessage:@"多图转发朋友圈，请在列表中选择“朋友圈选项”" withDuration:3];
//            [self shareMangPictureWithModel:model];
//
//        }else if (curretDEX == 2){
//             self.oldheview.price = self.price;
//            self.oldheview.model = model;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                NSData *imagedata= UIImageJPEGRepresentation([self captureScrollView:self.oldheview.scrollview], 1.0f);
//                [self sharePictureWithImageData:imagedata];
//            });
//
//
//        }else{
//            self.xinheview.price = self.price;
//            self.xinheview.model = model;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                NSData *imagedata= UIImageJPEGRepresentation([self snapshotScreenInView:self.xinheview], 1.0f);
//                [self sharePictureWithImageData:imagedata];
//            });
//        }



    };
    
    
    XinHeChengTuView *xinheview = [[NSBundle mainBundle]loadNibNamed:@"XinHeChengTuView" owner:self options:nil].lastObject;
    self.xinheview = xinheview;
    xinheview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view insertSubview:xinheview belowSubview:tableview];



    danshouView*danshouview = [[NSBundle mainBundle]loadNibNamed:@"danshouView" owner:self options:nil].lastObject;
    self.danshouview = danshouview;
    danshouview.frame =  CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view insertSubview:danshouview belowSubview:xinheview];



    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.imageview = imageview;
    [self.view insertSubview:imageview belowSubview:tableview];




    oldhechengView*oldheview= [[NSBundle mainBundle]loadNibNamed:@"oldhechengView" owner:self options:nil].lastObject;
    self.oldheview = oldheview;
    oldheview.frame =  CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view insertSubview:oldheview belowSubview:tableview];
    
    
    
    
}
-(void)getTheDiBuTanchuangWithModel:(releaseActivitiesModel*)model AndzhuanfaModel:(zhuanfaModel*)mod{
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    
    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappp)];
    [mengbanView addGestureRecognizer:tapges];
    
    huodongzhuanfayaView *huodongzhuanfayaview = [[NSBundle mainBundle]loadNibNamed:@"huodongzhuanfayaView" owner:self options:nil].lastObject;
    ViewBorderRadius(huodongzhuanfayaview, 5, 1, [UIColor clearColor]);
    self.huodongzhuanfayaview = huodongzhuanfayaview;
    huodongzhuanfayaview.frame = CGRectMake(0, kScreenHeight-500-SafeAreaBottomHeight, kScreenWidth, 500+SafeAreaBottomHeight);
    
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
        NSString *titleName = model.merchantName;
        if (self.huodongzhuanfayaview.biaotiTextView.text.length == 0) {
            titleName = model.merchantName;
        }else{
            titleName = self.huodongzhuanfayaview.biaotiTextView.text;
        }
        // 1、设置分享的内容，并将内容添加到数组中
        NSString *shareText = titleName;
        UIImage *shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.merchantUrL]]];
        NSURL *shareUrl = [NSURL URLWithString:url];
        NSArray *activityItemsArray = @[shareText,shareImage,shareUrl];
        
        
        // 自定义的CustomActivity，继承自UIActivity
        CustomActivity *customActivity = [[CustomActivity alloc]initWithTitle:shareText ActivityImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.merchantUrL]]] URL:shareUrl ActivityType:@"Custom"];
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
                
                [self.headerview.piliangBtn setTitle:title forState:UIControlStateNormal];
                
                
                
            }else if ([title isEqualToString:@"+5元"]){
                
                
                self.price = @"5";
                
                NSString*title = [NSString stringWithFormat:@"批量转发(+%@)",self.price];
                
                [self.headerview.piliangBtn setTitle:title forState:UIControlStateNormal];
                
                
            }else if ([title isEqualToString:@"+10元"]){
                
                self.price = @"10";
                
                NSString*title = [NSString stringWithFormat:@"批量转发(+%@)",self.price];
                
                [self.headerview.piliangBtn setTitle:title forState:UIControlStateNormal];
                
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
                
                [self.headerview.piliangBtn setTitle:title forState:UIControlStateNormal];
                
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
        
        [self.headerview.piliangBtn setTitle:title forState:UIControlStateNormal];
        
        
        [weakSelf.mengbanView removeFromSuperview];
        [weakSelf.jineview removeFromSuperview];
        [self.view endEditing:YES];
    }];
    
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString*reuesId = @"zhuanfaCell";
    
    zhuanfaCell*cell =[tableView dequeueReusableCellWithIdentifier:reuesId];
    
    if (cell == nil) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"zhuanfaCell" owner:self options:nil].lastObject;
    }
    shanghuModel *model = self.titleArray[indexPath.row];
    
    cell.model = model;
    
    
    if (indexPath.row == self.currentIndex) {
        self.headerview.merchanid = model.merchantId;
        cell.seletimageview.hidden = NO;
    }else{
        cell.seletimageview.hidden = YES;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    shanghuModel *model = self.titleArray[indexPath.row];
    self.currentIndex = (int)indexPath.row;
    self.headerview.merchanid = model.merchantId;
    [self.tableview reloadData];
    
}



//获取商户列表
-(void)getdata{
    
    [[NetworkManager sharedManager]getWithUrl:getMerchantList param:nil success:^(id json) {
        NSLog(@"%@",json);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]){
            
            for (NSDictionary *dic in json[@"data"]) {
                shanghuModel *model = [shanghuModel mj_objectWithKeyValues:dic];
                [self.titleArray addObject:model];
                
            }
            [self.tableview reloadData];
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}




-(void)sharePictureWithImageData:(NSData*)imagedata{
    
    //            NSData *imagedata= UIImageJPEGRepresentation([self snapshotScreenInView:self.xinheview], 1.0f);
    
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentsDirectory=[paths objectAtIndex:0];
    
    _savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"hecheng.png"];
    
    [imagedata writeToFile:_savedImagePath atomically:YES];
    
    _docuController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:_savedImagePath]];
    _docuController.delegate = self;
    [_docuController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    
    
}


- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller
{
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:_savedImagePath error:nil];
}




//分享多张图片
-(void)shareMangPictureWithModel:(SimilarProductModel*)model{
    
    NSMutableArray *activityItems = [NSMutableArray array];
    for (imagesListModel *imaModel in model.imagesList) {
        [activityItems addObject:imaModel.imgUrl];
    }
    
    NSMutableArray *items = [NSMutableArray array];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    for (int i = 0; i < activityItems.count; i++) {
        
        if (i==4) {
            break;
        }
        //取出地址
        NSString *URL = [activityItems[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //把图片转成NSData类型
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
        //写入图片中
        UIImage *imagerang = [UIImage imageWithData:data];
        //图片缓存的地址，自己进行替换
        NSString *imagePath = [docPath stringByAppendingString:[NSString stringWithFormat:@"/SharePic%d.jpg",i]];
        //把图片写进缓存，一定要先写入本地，不然会分享出错
        [UIImageJPEGRepresentation(imagerang, .5) writeToFile:imagePath atomically:YES];
        //把缓存图片的地址转成NSUrl格式
        NSURL *shareobj = [NSURL fileURLWithPath:imagePath];
        //这个部分是自定义ActivitySource
        ShareItem *item = [[ShareItem alloc] initWithData: imagerang andFile:shareobj];
        //分享的数组
        [items addObject:item];
    }
    
    
  
    
//    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:activities];
//
//
//        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
//
//        //去除特定的分享功能
//        activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
//
//
//        [self presentViewController: activityVC animated:YES completion:nil];
//
//
//
//        //初始化Block回调方法,此回调方法是在iOS8之后出的，代替了之前的方法
//        UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(NSString *activityType,BOOL completed,NSArray *returnedItems,NSError *activityError)
//        {
//            NSLog(@"activityType :%@", activityType);
//            if (completed)
//            {
//                NSLog(@"completed");
//
//                for (int i = 0; i < activityItems.count; i++){
//                     NSString *imagePath = [docPath stringByAppendingString:[NSString stringWithFormat:@"/SharePic%d.jpg",i]];
//                    NSFileManager *manager = [NSFileManager defaultManager];
//                    [manager removeItemAtPath:imagePath error:nil];
//                }
//
//            }
//            else
//            {
//                NSLog(@"cancel");
//            }
//
//        };
//
//        // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
//        activityVC.completionWithItemsHandler = myBlock;
    

    
    [[[ShareTool alloc] init]shareWithItems:items completionHandler:^(UIActivityType  _Nullable activityType, BOOL completed) {
        for (int i = 0; i < activityItems.count; i++){
            NSString *imagePath = [docPath stringByAppendingString:[NSString stringWithFormat:@"/SharePic%d.jpg",i]];
            NSFileManager *manager = [NSFileManager defaultManager];
            [manager removeItemAtPath:imagePath error:nil];
        }
    }];
    
}





#pragma mark - 截取某视图的内容
- (UIImage *)snapshotScreenInView:(UIView *)view
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale*2);
    } else {
        UIGraphicsBeginImageContext(view.bounds.size);
    }
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
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



@end
