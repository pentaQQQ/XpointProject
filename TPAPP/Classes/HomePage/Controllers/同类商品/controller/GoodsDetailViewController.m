//
//  GoodsDetailViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/29.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "SimilarProductModel.h"
#import "GoDetailTableViewCell.h"
#import "specsModel.h"

#import "imagesListModel.h"
#import "XinHeChengTuView.h"
#import "danshouView.h"
#import "ShareItem.h"
#import "oldhechengView.h"
#import "HuoDongCell.h"
#import "PiliangzhuanfaViewController.h"
#import "DeclareAbnormalAlertView.h"
#import "releaseActivitiesModel.h"
@interface GoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate,DeclareAbnormalAlertViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UITableView*tableview;


@property(nonatomic,copy)NSString * savedImagePath;

@property(nonatomic,strong)XinHeChengTuView*xinheview;
@property(nonatomic,strong)danshouView*danshouview;
@property(nonatomic,strong)oldhechengView*oldheview;
@property(nonatomic,strong)UIImageView*imageview;


@property (nonatomic, retain) UIDocumentInteractionController *docuController;




@end

@implementation GoodsDetailViewController
{
    int _buyGoodNumber;
    int _dataRefreshNumber;
    BOOL _isFetching;
    int _isFiveData;
}

-(NSMutableArray*)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTableview];
//    [self lodaHuodongData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setUpTableview{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight-49-SafeAreaBottomHeight) style:UITableViewStylePlain];
    self.tableview = tableview;
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    
    tableview.tableFooterView = [UIView new];
    
    
    [self.view addSubview:tableview];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [self.tableview.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
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

- (void)headerRereshing
{
    _dataRefreshNumber = 0;
    [self lodaHuodongData];
    
}
- (void)footerRereshing
{
    _dataRefreshNumber++;
    [self lodaHuodongData];
}


- (void)lodaData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.model.id forKey:@"id"];
    [[NetworkManager sharedManager] getWithUrl:getProductByActivityId param:dic success:^(id json) {
        
        NSLog(@"%@",json);
        
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            
            for (NSDictionary *dic in json[@"data"]) {
                SimilarProductModel *model = [SimilarProductModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
            [self.tableview reloadData];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}




- (void)lodaHuodongData
{
    _isFetching = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:self.model.id forKey:@"activityId"];
        [dic setValue:self.model.merchantId forKey:@"merchantId"];
        [dic setValue:@(self->_dataRefreshNumber) forKey:@"pageNum"];
        [dic setValue:@(5) forKey:@"pageSize"];
        [[NetworkManager sharedManager] getWithUrl:getActivityByMerchantId param:dic success:^(id json) {
            
            NSLog(@"%@",json);
            
            
            NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
            if ([respCode isEqualToString:@"00000"]) {
                if (self->_dataRefreshNumber == 0) {
                    
                    [self.dataArr removeAllObjects];
                    releaseActivitiesModel *model = [releaseActivitiesModel mj_objectWithKeyValues:json[@"data"][@"releaseActivityApiResult"]];
                    [self.dataArr addObject:model];
                    for (NSDictionary *dic in json[@"data"][@"productApiResults"][@"data"]) {
                        SimilarProductModel *model = [SimilarProductModel mj_objectWithKeyValues:dic];
                        [self.dataArr addObject:model];
                    }
                    [self performSelectorOnMainThread:@selector(reloadDeals) withObject:self waitUntilDone:NO];
                    
                }else{
                    
                    if ([json[@"data"][@"productApiResults"][@"data"] count] < 5) {
                        self->_isFiveData++;
                        if (self->_isFiveData > 1) {
                           [self.tableview.mj_footer endRefreshingWithNoMoreData];
                        }else{
                            for (NSDictionary *dic in json[@"data"][@"productApiResults"][@"data"]) {
                                SimilarProductModel *model = [SimilarProductModel mj_objectWithKeyValues:dic];
                                //                        [tempArray addObject:model];
                                [self.dataArr addObject:model];
                            }
                            [self performSelectorOnMainThread:@selector(reloadDeals) withObject:self waitUntilDone:NO];
                        }
                        
                    }else{
                        //                    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0]; //创建一个临时数组
                        for (NSDictionary *dic in json[@"data"][@"productApiResults"][@"data"]) {
                            SimilarProductModel *model = [SimilarProductModel mj_objectWithKeyValues:dic];
                            //                        [tempArray addObject:model];
                            [self.dataArr addObject:model];
                        }
                        [self performSelectorOnMainThread:@selector(reloadDeals) withObject:self waitUntilDone:NO];
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            self->_isFetching = NO;
//                            [self.tableview reloadData];
//                        });
                        //                    NSMutableArray *insertInexPaths = [NSMutableArray arrayWithCapacity:[tempArray count]];
                        //                    //创建一个临时数据存放indexpath
                        //                    for (NSInteger i = 0; i< tempArray.count; i++) {
                        //                        // 取出后面需要加入的indexPath放进刚刚的那个临时数组
                        //                        NSIndexPath *newPath = [NSIndexPath indexPathForRow:[self.dataArr indexOfObject:[tempArray objectAtIndex:i]] inSection:0];
                        //                        [insertInexPaths addObject:newPath];
                        //                    }
                        //                    //把新的数据插入到后面
                        //                    [self.tableview insertRowsAtIndexPaths:insertInexPaths withRowAnimation:(UITableViewRowAnimationNone)];
                    }
                    
                }
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    });
    
   
    
    
}

- (void)reloadDeals
{
    [self.tableview reloadData];
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SimilarProductModel*model = self.dataArr[indexPath.row];
    
    if (!([model.typeac isEqualToString:@"0"]||[model.typeac isEqualToString:@"1"])) {
        static NSString*reuesId = @"GoDetailTableViewCell";
        GoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"GoDetailTableViewCell" owner:self options:nil].lastObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = model;
        
        [cell setAddGoodsGoCartBlock:^(specsModel *model) {
            self->_buyGoodNumber = [cell.goodsNumberLabel.text intValue];
            LYAccount *lyAccount = [LYAccount shareAccount];
            if ([lyAccount.isRemark intValue] == 1) {
                DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"添加商品备注" message:@"请输入备注信息" delegate:self leftButtonTitle:@"不下单" rightButtonTitle:@"下单" comCell:nil isAddGood:YES spesmodel:model];
                [alertView show];
            }else{
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:model.productId forKey:@"productId"];
                [dic setValue:model.size forKey:@"size"];
                [dic setValue:lyAccount.id forKey:@"userId"];
                [dic setValue:[NSString stringWithFormat:@"%d",self->_buyGoodNumber] forKey:@"number"];
                [dic setValue:model.id forKey:@"cartDetailId"];
                [LYTools postBossDemoWithUrl:cartAddProduct param:dic success:^(NSDictionary *dict) {
                    NSLog(@"%@",dict);
                    NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
                    if ([respCode isEqualToString:@"00000"]) {
                        
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"getShopCarNumber" object:@{@"getShopCarNumber":@1}];
                        [SVProgressHUD doAnythingSuccessWithHUDMessage:@"已经成功添加购物车" withDuration:1.5];
                    
                    }else{
                        [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                    }
                } fail:^(NSError *error) {
                    
                }];
            }
        }];
        
        cell.ToZhuanfaBlock = ^(SimilarProductModel *model, int currentDEX) {
            
            
            if (currentDEX == 0) {
                self.danshouview.model = model;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSData *imagedata= UIImageJPEGRepresentation([self snapshotScreenInView:self.danshouview], 1.0f);
                    [self sharePictureWithImageData:imagedata];
                });
                
                
            }else if (currentDEX == 1){
                
                
                [self shareMangPictureWithModel:model];
                
            }else if (currentDEX == 2){
                
                self.oldheview.model = model;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSData *imagedata= UIImageJPEGRepresentation([self captureScrollView:self.oldheview.scrollview], 1.0f);
                    [self sharePictureWithImageData:imagedata];
                });
                
                
            }else{
                self.xinheview.model = model;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSData *imagedata= UIImageJPEGRepresentation([self snapshotScreenInView:self.xinheview], 1.0f);
                    [self sharePictureWithImageData:imagedata];
                });
            }
            
        };
        
        return cell;
    }else{
        
        
        static NSString *reuesId = @"HuoDongCell";
        HuoDongCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"HuoDongCell" owner:self options:nil].lastObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        
        cell.model = model;
        
        
        cell.zhuanfaBlock = ^(SimilarProductModel*model) {
            
            if ([model.typeac isEqualToString:@"0"]) {//批量转发
                PiliangzhuanfaViewController *vc = [[PiliangzhuanfaViewController alloc]init];
                vc.ID = model.id;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{//转发
                
            }
        };
        
        
        return cell;
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SimilarProductModel*model = self.dataArr[indexPath.row];
    
    
    if (!([model.typeac isEqualToString:@"0"]||[model.typeac isEqualToString:@"1"])) {
        
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
        
        
        NSString *chima = [NSString stringWithFormat:@"尺码 %@",str];
        NSString *kuanshi = [NSString stringWithFormat:@"款式 %@",model.design];
        NSString *kuanhao= [NSString stringWithFormat:@"款号 %@",model.designCode];
        
        
        
        
        CGFloat high1 = [LYTools getHeighWithTitle: model.productName font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
        
        CGFloat high2 = [LYTools getHeighWithTitle:  chima font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
        
        CGFloat high3= [LYTools getHeighWithTitle: kuanshi font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
        
        CGFloat high4 =[LYTools getHeighWithTitle: kuanhao font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
        
        
        
        int tmp = model.imagesList.count % 3;
        int row = (int)model.imagesList.count / 3;
        CGFloat width = (kScreenWidth-70-10)/3.0;
        row += tmp == 0 ? 0:1;
        CGFloat high5 = (width+5)*row;
        
        
        
        
        int tm = model.specs.count % 2;
        int rows = (int)model.specs.count / 2;
        CGFloat high = 20;
        rows += tm == 0 ? 0:1;
        CGFloat high6 = (high+10)*rows+50;
        
        
        
        return high1+high2+high3+high4+high5+high6+160;
    }else{
        
        CGFloat width = (kScreenWidth-70-10)/3.0;
        
        //content的高度
        CGFloat high = [LYTools getHeighWithTitle:model.context font:[UIFont systemFontOfSize:14] width:kScreenWidth-70];
        
        int tmp = model.imagesList.count % 3;
        int row = (int)model.imagesList.count / 3;
        row += tmp == 0 ? 0:1;
        return (width+5)*row+163+high;
    }
    
    
    
    
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
            
            for (int i = 0; i < activityItems.count; i++){
                NSString *imagePath = [docPath stringByAppendingString:[NSString stringWithFormat:@"/SharePic%d.jpg",i]];
                NSFileManager *manager = [NSFileManager defaultManager];
                [manager removeItemAtPath:imagePath error:nil];
            }
            
        }
        else
        {
            NSLog(@"cancel");
        }
        
    };
    
    // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
    activityVC.completionWithItemsHandler = myBlock;
    
    
    
}

#pragma mark - 添加备注
- (void)addRemarkMessage:(NSString *)mesText  andDetailModel:(CartDetailsModel *)model
{
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setValue:model.id forKey:@"cartDetailId"];
    [dict1 setValue:mesText forKey:@"remark"];
    [LYTools postBossDemoWithUrl:cartRemark param:dict1 success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            //            [SVProgressHUD doAnythingSuccessWithHUDMessage:@"成功添加备注" withDuration:1.5];
        }else if([dict[@"code"]longValue] == 500){
            [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
        }
    } fail:^(NSError *error) {
        
    }];
}
#pragma mark - Delegate - 带输入框的弹窗
// 输入框弹窗的button点击时回调
- (void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex selectCell:(CompileCell *)cell selectSpesModel:(specsModel *)model{
    if (buttonIndex == AlertButtonLeft) {
        
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:model.productId forKey:@"productId"];
        [dic setValue:model.size forKey:@"size"];
        LYAccount *lyAccount = [LYAccount shareAccount];
        [dic setValue:lyAccount.id forKey:@"userId"];
        [dic setValue:alertView.textView.text forKey:@"remark"];
        [dic setValue:[NSString stringWithFormat:@"%d",self->_buyGoodNumber] forKey:@"number"];
        [dic setValue:model.id forKey:@"cartDetailId"];
        [LYTools postBossDemoWithUrl:cartAddProduct param:dic success:^(NSDictionary *dict) {
            NSLog(@"%@",dict);
            NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
            if ([respCode isEqualToString:@"00000"]) {
//                CartDetailsModel *detailModel = [CartDetailsModel mj_objectWithKeyValues:dict[@"data"]];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"getShopCarNumber" object:@{@"getShopCarNumber":@1}];
                [SVProgressHUD doAnythingSuccessWithHUDMessage:@"已经成功添加购物车" withDuration:1.5];
//                [self addRemarkMessage:alertView.textView.text andDetailModel:detailModel];
            }else{
                [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
            }
        } fail:^(NSError *error) {
            
        }];
        
    }
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
