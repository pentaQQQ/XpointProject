//
//  ClassDetailViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/20.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "ClassDetailViewController.h"
#import "SDCycleScrollView.h"
#import "goodsDetailCell.h"
#import "releaseActivitiesModel.h"
#import "GoodsDetailViewController.h"
#import "homePageHeaderModel.h"
#import "AdvertisingModel.h"

#import "fenxiangTanchuangView.h"
#import "huodongfenxiangview.h"
#import "ShareItem.h"
@interface ClassDetailViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSMutableArray*dataArr;
@property(nonatomic,strong)SDCycleScrollView*scrollview;
@property(nonatomic,strong)NSMutableArray*imagesArr;
//@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property(nonatomic,weak)UIView *mengbanView;
@property(nonatomic,strong)fenxiangTanchuangView *zhuanfaotherview;

@property(nonatomic,strong)huodongfenxiangview*oldheview;
@property(nonatomic,strong)UIView*vi;

@property(nonatomic,strong)NSMutableArray*pictureArr;

@end

@implementation ClassDetailViewController

- (NSMutableArray *)imagesArr
{
    if (_imagesArr == nil) {
        _imagesArr = [NSMutableArray array];
    }
    return _imagesArr;
}


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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpUI];
    [self getAdvertisingData];
}
- (void)getAdvertisingData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.pageModel.id forKey:@"labelId"];
    [[NetworkManager sharedManager] getWithUrl:getAdvertising param:dict success:^(id json) {
        
        NSLog(@"%@",json);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in json[@"data"]) {
                AdvertisingModel *advModel = [AdvertisingModel mj_objectWithKeyValues:dic];
                [arr addObject:advModel.imgUrl];
                [self.imagesArr addObject:advModel];
            }
            if (arr.count != 0) {
                self.scrollview.imageURLStringsGroup = arr;
            }else{
                self.tableview.tableHeaderView = [UIView new];
            }
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)setUpUI{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-SafeAreaTopHeight-44-49-SafeAreaBottomHeight) style:UITableViewStylePlain];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    
    SDCycleScrollView*scrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 150) delegate:self placeholderImage:nil];
    scrollview.currentPageDotColor = [UIColor colorWithRed:255.0/255.0 green:107.0/255.0 blue:36.0/255.0 alpha:1.0];
    scrollview.pageDotColor = [UIColor lightGrayColor];
    self.scrollview = scrollview;
    self.tableview.tableHeaderView = scrollview;
    
    
    
    self.tableview.tableFooterView = [UIView new];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.vi = vi;
    vi.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:vi belowSubview:self.tableview];
    
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *reuesId = @"goodsDetailCell";
    goodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"goodsDetailCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    releaseActivitiesModel *model = self.arr[indexPath.row];
    cell.model = model;
    
    cell.qianggouBlock = ^(releaseActivitiesModel *model) {
        GoodsDetailViewController *vc = [[GoodsDetailViewController alloc]init];
        vc.title = model.merchantName;
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    cell.zhuanfaBlock = ^(releaseActivitiesModel *model) {
        //        PiliangzhuanfaViewController *vc = [[PiliangzhuanfaViewController alloc]init];
        //        vc.ID = model.id;
        //        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        [self tanchuangWithModel:model];
    };
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    releaseActivitiesModel*model = self.arr[indexPath.row];
    
    CGFloat width = (kScreenWidth-70-10)/3.0;
    
    //content的高度
    CGFloat high = [LYTools getHeighWithTitle:model.context font:[UIFont systemFontOfSize:14] width:kScreenWidth-70];
    
    int tmp = model.imagesList.count % 3;
    int row = (int)model.imagesList.count / 3;
    row += tmp == 0 ? 0:1;
    return (width+5)*row+163+high;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    releaseActivitiesModel*model = self.arr[indexPath.row];
    GoodsDetailViewController *vc = [[GoodsDetailViewController alloc]init];
    vc.title = model.merchantName;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}








-(void)tanchuangWithModel:(releaseActivitiesModel*)model

{
    
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    fenxiangTanchuangView *zhuanfaotherview = [[NSBundle mainBundle]loadNibNamed:@"fenxiangTanchuangView" owner:self options:nil].lastObject;
    ViewBorderRadius(zhuanfaotherview, 5, 1, [UIColor clearColor]);
    self.zhuanfaotherview = zhuanfaotherview;
    zhuanfaotherview.frame = CGRectMake(20, (kScreenHeight-322)/2, kScreenWidth-40, 322);
    
    [keyWindow addSubview:zhuanfaotherview];
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [mengbanView addGestureRecognizer:tap];
    
    
    
    __weak __typeof(self) weakSelf = self;
    
    
    
    [zhuanfaotherview.shareBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
      UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NSString stringWithFormat:@"%@",model.context];
        [weakSelf tap];
        
        if (model.imagesList.count>0) {
            [weakSelf zhuanfaChangTuWithIndexArr:model];
        }else{
            
            
            
           
            
       
            UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:[NSArray array] applicationActivities:nil];
            
            //去除特定的分享功能
            activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
            
            [self presentViewController: activityVC animated:YES completion:nil];
        }
        
        
    }];
    
}



-(void)tap{
    
    [self.zhuanfaotherview removeFromSuperview];
    [self.mengbanView removeFromSuperview];
    
}



















//合并成长图
-(void)zhuanfaChangTuWithIndexArr:(releaseActivitiesModel*)model{
    
    
    
    [self getThePictureWithModel:model Success:^(UIImage *image) {
        
        
        [self.pictureArr addObject:image];

        [self getTheChangTuWithArr:self.pictureArr Success:^(UIImage *image) {
            NSMutableArray *tepArr = [NSMutableArray array];
            [tepArr addObject:image];
            [self shareMangPictureWithArr:tepArr];
        }];
    }];
   
}


-(void)getThePictureWithModel:(releaseActivitiesModel *)model Success:(void(^)(UIImage *))success{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        huodongfenxiangview*oldheview= [[NSBundle mainBundle]loadNibNamed:@"huodongfenxiangview" owner:self options:nil].lastObject;
        self.oldheview = oldheview;
        oldheview.frame =  CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        oldheview.model = model;
        
        [self.view insertSubview:oldheview belowSubview:self.vi];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIImage *ima = [self captureScrollView:oldheview.scrollview];
            
            if (ima) {
                success(ima);
                [oldheview removeFromSuperview];
            }
            
        });
        
    });
    
}


//获取长图
-(void)getTheChangTuWithArr:(NSMutableArray*)arr Success:(void(^)(UIImage *))success{
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view insertSubview:scroll belowSubview:self.vi];
    
    scroll.contentSize = CGSizeMake(kScreenWidth,kScreenHeight);
    for (int i =0; i<arr.count; i++) {
        UIImage *imag = arr[i];
        UIImageView *ima = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
        ima.image = imag;
        [scroll addSubview:ima];
    }
    
    
    
    UIImage *ima = [self captureScrollView:scroll];
    if (ima) {
        success(ima);
        [scroll removeFromSuperview];
    }
    
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


@end
