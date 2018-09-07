//
//  DeleteGoodsListController.m
//  TPAPP
//
//  Created by Frank on 2018/9/7.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "DeleteGoodsListController.h"
#import "GoodsCartModel.h"
#import "DeleteGoodsListCell.h"
#import "MMImageListView.h"
#import "MMImagePreviewView.h"
#import "imagesListModel.h"
#import "specsModel.h"
@interface DeleteGoodsListController ()<UITableViewDelegate,UITableViewDataSource,SelectedReBuyDelegate>
@property (nonatomic, strong)UITableView *cartTableView;
@property (nonatomic, strong)NSMutableArray *dataSource;

@property (nonatomic, strong)GoodsCartModel *goodsCartModel;

@end

@implementation DeleteGoodsListController
{
    MMImagePreviewView *_previewView;
    MMImageView *selectImage;
}
#pragma mark - 懒加载
-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.cartTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -SafeAreaBottomHeight) style:UITableViewStyleGrouped];
    self.cartTableView.estimatedRowHeight = 0;
    self.cartTableView.delegate = self;
    self.cartTableView.dataSource = self;
    self.cartTableView.backgroundColor = colorWithRGB(0xEEEEEE);
    self.cartTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.cartTableView];
    self.cartTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    //自动更改透明度
    self.cartTableView.mj_header.automaticallyChangeAlpha = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.cartTableView.mj_header isRefreshing]) {
        [self.cartTableView.mj_header endRefreshing];
    }
    //进入刷新状态
    [self.cartTableView.mj_header beginRefreshing];
    
}
- (void)loadData
{
    [self.dataSource removeAllObjects];
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setValue:[LYAccount shareAccount].id forKey:@"userId"];
    [dataDict setValue:@"1" forKey:@"status"];
    [LYTools postBossDemoWithUrl:cartList param:dataDict success:^(NSDictionary *dict) {
        [self.cartTableView.mj_header endRefreshing];
        NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
             self.goodsCartModel = [GoodsCartModel mj_objectWithKeyValues:dict[@"data"]];
            [self.dataSource addObjectsFromArray:self.goodsCartModel.cartDetails];
            [self.cartTableView reloadData];
        }else if([dict[@"code"]longValue] == 500){
            [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"msg"] withDuration:1.5];
        }
    } fail:^(NSError *error) {
        
    }];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
    view.backgroundColor = colorWithRGB(0xEEEEEE);
    return view;
}
//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 使用缓存行高，避免计算多次
//    CartDetailsModel *moment = [self.dataSource objectAtIndex:indexPath.row];
    return 175;
}
//有多少section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每个section有多少row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        CartDetailsModel *model = self.dataSource[indexPath.row];
        DeleteGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeleteGoodsListCellID"];
        if (cell==nil) {
            cell = [[DeleteGoodsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DeleteGoodsListCellID"];
        }
        [cell withData:model];
        cell.SelectedDelegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}

-(void)SelectedReBuyCell:(DeleteGoodsListCell *)cell
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:cell.detailModel.productId forKey:@"productId"];
    [dic setValue:cell.detailModel.size forKey:@"size"];
    [dic setValue:[LYAccount shareAccount].id forKey:@"userId"];
    [LYTools postBossDemoWithUrl:cartAddProduct param:dic success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            [SVProgressHUD doAnythingSuccessWithHUDMessage:@"已经成功添加购物车" withDuration:1.5];
        }else{
            [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"msg"] withDuration:1.5];
        }
    } fail:^(NSError *error) {

    }];
}
-(void)SelectedLookImageListCell:(DeleteGoodsListCell *)cell
{
    _previewView = [[MMImagePreviewView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 更新视图数据
    NSInteger count = cell.detailModel.productForm.imagesList.count;
    _previewView.pageNum = count;
    _previewView.scrollView.contentSize = CGSizeMake(_previewView.width*count, _previewView.height);
    [self singleTapSmallViewCallback:cell];
}
#pragma mark - 小图单击
- (void)singleTapSmallViewCallback:(DeleteGoodsListCell *)cell
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        // 解除隐藏
        [window addSubview:_previewView];
        [window bringSubviewToFront:_previewView];
        // 清空
        [_previewView.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        // 添加子视图
        NSInteger index = 0;
        NSInteger count = cell.detailModel.productForm.imagesList.count;
        CGRect convertRect;
        if (count == 1) {
            [_previewView.pageControl removeFromSuperview];
        }
        for (NSInteger i = 0; i < count; i ++)
        {
            imagesListModel *model = cell.detailModel.productForm.imagesList[i];
            
            CGRect rect1 = [cell.Goods_Icon convertRect:cell.Goods_Icon.frame fromView:cell.contentView];//获取button在contentView的位置
            
            CGRect rect2 = [cell.Goods_Icon convertRect:rect1 toView:window];
            // 转换Frame
//            MMImageView *pImageView = [[MMImageView alloc] initWithFrame:rect2];;
            convertRect = rect2;
            // 添加
            MMScrollView *scrollView = [[MMScrollView alloc] initWithFrame:CGRectMake(i*_previewView.width, 0, _previewView.width, _previewView.height)];
            scrollView.tag = 100+i;
            scrollView.maximumZoomScale = 2.0;
            // 根据图片的url下载图片数据
            dispatch_queue_t xrQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
            dispatch_async(xrQueue, ^{
                // 异步下载图片
                UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imgUrl]]];
                // 主线程刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    scrollView.image = img;
                    //                    [pImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:Image(@"share_sina")];
                    scrollView.contentRect = convertRect;
                    // 单击
                    [scrollView setTapBigView:^(MMScrollView *scrollView){
                        [self singleTapBigViewCallback:scrollView];
                    }];
                    // 长按
                    [scrollView setLongPressBigView:^(MMScrollView *scrollView){
                        [self longPresssBigViewCallback:scrollView.imageView];
                    }];
                    [_previewView.scrollView addSubview:scrollView];
                    if (i == index) {
                        [UIView animateWithDuration:0.3 animations:^{
                            _previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
                            _previewView.pageControl.hidden = NO;
                            [scrollView updateOriginRect];
                        }];
                    } else {
                        [scrollView updateOriginRect];
                    }
                });
                
            });
            
        }
        // 更新offset
        CGPoint offset = _previewView.scrollView.contentOffset;
        offset.x = index * k_screen_width;
        _previewView.scrollView.contentOffset = offset;
    });
    
}

#pragma mark - 大图单击||长按
- (void)singleTapBigViewCallback:(MMScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        _previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _previewView.pageControl.hidden = YES;
        scrollView.contentRect = scrollView.contentRect;
        scrollView.zoomScale = 1.0;
    } completion:^(BOOL finished) {
        [_previewView removeFromSuperview];
    }];
}

- (void)longPresssBigViewCallback:(UIImageView *)scrollView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                
                NSMutableArray *imageIds = [NSMutableArray array];
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    //
                    //写入图片到相册
                    PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:scrollView.image];
                    //记录本地标识，等待完成后取到相册中的图片对象
                    [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
                    //
                    
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    if (success) {
                        [SVProgressHUD doAnythingSuccessWithHUDMessage:@"保存成功" withDuration:1.0];
                    }else{
                        [SVProgressHUD doAnythingSuccessWithHUDMessage:@"保存失败" withDuration:1.0];
                    }
                    //        NSLog(@"success = %d, error = %@", success, error);
                }];
                
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
