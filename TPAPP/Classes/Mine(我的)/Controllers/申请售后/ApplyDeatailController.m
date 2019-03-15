//
//  ApplyDeatailController.m
//  TPAPP
//
//  Created by Frank on 2018/8/27.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "ApplyDeatailController.h"
#import "ApplyDeatailCell.h"
#import "ServiceTypeCell.h"
#import "QuestionDeatailCell.h"
#import <Photos/Photos.h>
#import "MineIndentViewController.h"
#import "ApplyReturnGoodsModel.h"
@interface ApplyDeatailController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,DeclareAbnormalAlertViewOrderListRemindDelegate>

@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)UIButton *submitBtn;

@property (nonatomic, strong)ApplyReturnGoodsModel *returnGoodsModel;
@end

@implementation ApplyDeatailController
{
    NSIndexPath *_indexPath;
    NSMutableArray *_imageNameArr;
    NSMutableArray *_imagesArr;
    NSInteger _selectType;
    NSString *_questionString;
    NSInteger _successNumber;
    NSInteger _failNumber;
}
#pragma mark - 懒加载
-(NSMutableArray *)listDataArr
{
    if (_listDataArr == nil) {
        _listDataArr = [NSMutableArray array];
    }
    return _listDataArr;
}
#pragma mark - 创建tableview
-(UITableView *)listTableView
{
    if (_listTableView == nil) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _listTableView.backgroundColor = colorWithRGB(0xEEEEEE);
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.showsHorizontalScrollIndicator = NO;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_listTableView];
        //获取状态栏的rect
        CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
        //获取导航栏的rect
        CGRect navRect = self.navigationController.navigationBar.frame;
        _listTableView.sd_layout
        .topSpaceToView(self.view, statusRect.size.height+navRect.size.height)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomSpaceToView(self.view, 70);
        
    }
    return _listTableView;
}
-(UIButton *)submitBtn
{
    if (_submitBtn == nil) {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.backgroundColor = colorWithRGB(0xFF6B24);
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitBtn];
        _submitBtn.sd_layout
        .bottomSpaceToView(self.view, SafeAreaBottomHeight+15)
        .leftSpaceToView(self.view, 50)
        .widthIs(kScreenWidth-100)
        .heightIs(40);

    }
    return _submitBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"售后申请";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    self.listDataArr = [NSMutableArray arrayWithObjects:@[@[@"36654",@0],@[@"38554",@0],@[@"69885",@1],@[@"25669",@1]],@[@[@"36654",@0],@[@"38554",@0],@[@"69885",@1],@[@"25669",@1]], nil];
    [self listTableView];
    [self submitBtn];
    _imagesArr = [NSMutableArray array];
    [self loadData];
}
- (void)loadData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.minModel.id forKey:@"orderId"];
    [[NetworkManager sharedManager] getWithUrl:getReturnDetail param:dic success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"respCode"] isEqualToString:@"00000"]) {
            self.returnGoodsModel = [ApplyReturnGoodsModel mj_objectWithKeyValues:json[@"data"]];
            
            [self.returnGoodsModel.detailResult removeAllObjects];
            for (NSDictionary *newDic in json[@"data"][@"detailResult"]) {
                ApplyReturnDetailResultModel *orderDetailModel = [ApplyReturnDetailResultModel mj_objectWithKeyValues:newDic];
                [self.returnGoodsModel.detailResult addObject:orderDetailModel];
            }
            [self.returnGoodsModel.images removeAllObjects];
            self->_imageNameArr = [NSMutableArray array];
            for (NSDictionary *newDic in json[@"data"][@"images"]) {
                
                ApplyReturnGoodsImagesModel *orderImagesModel = [ApplyReturnGoodsImagesModel mj_objectWithKeyValues:newDic];
                [self.returnGoodsModel.images addObject:orderImagesModel];
                [self->_imagesArr addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:orderImagesModel.imgUrl]]]];
            }
            [self.listTableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)uploadPicturesImage:(UIImage* )image nsNo:(NSString* )nsNo
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"multipart/form-data",@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    NSData* imagedata = [NSData dataWithContentsOfFile:nsNo];
    NSData* imagedata = UIImageJPEGRepresentation(image, 0.1);
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:imagedata forKey:@"multipartFile"];
    NSLog(@"字典的值：%@", parameters);
    [manager POST:fileUploadFile parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>_Nonnull formData) {
        //上传文件参数
        if (imagedata) {
            NSString * type;
            NSString * mimeType;
            type = @"jpg";
            mimeType = @"image/jpeg";
            NSString * fileName = nsNo;
            [formData appendPartWithFileData:imagedata name:@"multipartFile" fileName:fileName mimeType:mimeType];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印上传进度
//        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
//        NSLog(@"%.2lf%%", progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        //请求成功
        NSDictionary *dics = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([dics[@"respCode"] isEqualToString:@"00000"]) {
            NSString *imageUrl = dics[@"data"];
            if (imageUrl.length != 0) {
                self->_successNumber++;
                [self->_imageNameArr addObject:imageUrl];
                if (self->_successNumber+self->_failNumber == self->_imagesArr.count) {
                    [SVProgressHUD dismiss];
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    if (self->_questionString.length != 0) {
                        [dic setValue:self->_questionString forKey:@"why"];
                    }
                    [dic setValue:self.minModel.id forKey:@"orderNo"];
                    [dic setValue:[NSString stringWithFormat:@"%ld",self->_selectType] forKey:@"state"];
                    [dic setValue:@(self.minModel.orderAmountTotal) forKey:@"applyAmount"];
                    for (int i = 0; i < self->_imageNameArr.count; i++) {
                        [dic setValue:self->_imageNameArr[i] forKey:[NSString stringWithFormat:@"images[%d].imgUrl",i]];
                    }
                    
                    NSString *urlStr = orderReturnsApply;
                    [[NetworkManager sharedManager]postWithUrl:urlStr param:dic success:^(id json) {
                        NSLog(@"%@",json);
                        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
                        if ([respCode isEqualToString:@"00000"]) {
                            DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:@"申请成功" selectType:@"退款审核中" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:self.minModel];
                            [alertView show];
                        }else{
                            [SVProgressHUD doAnyRemindWithHUDMessage:json[@"respMessage"] withDuration:1.5];
                        }
                    } failure:^(NSError *error) {
                        
                    }];
                }else{
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyyMMddHHmmssSSS";
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",str];
                    NSInteger nums = self->_imageNameArr.count;
                    [self uploadPicturesImage:self->_imagesArr[nums] nsNo:imageName];
                }
            }
        }
        
        NSLog(@"返回的说明desc：%@", dics);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self->_failNumber++;
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}
- (void)submitBtnAction
{
    if (_selectType != 0) {
        DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"确认退款" message:[NSString stringWithFormat:@"您的退款金额为%.2lf,确认退款?",self.minModel.orderAmountTotal] selectType:@"退款" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:self.minModel];
        [alertView show];
        
        
    }else{
        DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:@"请选择退货原因" selectType:@"提示" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:self.minModel];
        [alertView show];
    }
    
}

-(void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex selectType:(NSString *)type comGoodList:(MineIndentModel *)minModel
{
    if (buttonIndex == AlertButtonLeft) {
        
    }else{
        if ([type isEqualToString:@"退款"]) {
            
            if (_imagesArr.count == 0) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                if (_questionString.length != 0) {
                   [dic setValue:_questionString forKey:@"why"];
                }
                [dic setValue:minModel.id forKey:@"orderNo"];
                [dic setValue:[NSString stringWithFormat:@"%ld",_selectType] forKey:@"state"];
                [dic setValue:@(minModel.orderAmountTotal) forKey:@"applyAmount"];
                NSString *urlStr = orderReturnsApply;
                [[NetworkManager sharedManager]postWithUrl:urlStr param:dic success:^(id json) {
                    NSLog(@"%@",json);
                    NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
                    if ([respCode isEqualToString:@"00000"]) {
                        DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:@"申请成功" selectType:@"退款审核中" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:minModel];
                        [alertView show];
                    }else{
                        [SVProgressHUD doAnyRemindWithHUDMessage:json[@"respMessage"] withDuration:1.5];
                    }
                } failure:^(NSError *error) {
                    
                }];
            }else{
//                if (_imageNameArr.count != 0) {
//                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                    if (self->_questionString.length != 0) {
//                        [dic setValue:self->_questionString forKey:@"why"];
//                    }
//                    [dic setValue:self.minModel.id forKey:@"orderNo"];
//                    [dic setValue:[NSString stringWithFormat:@"%ld",self->_selectType] forKey:@"state"];
//                    [dic setValue:@(self.minModel.orderAmountTotal) forKey:@"applyAmount"];
//                    for (int i = 0; i < self->_imageNameArr.count; i++) {
//                        [dic setValue:self->_imageNameArr[i] forKey:[NSString stringWithFormat:@"images[%d].imgUrl",i]];
//                    }
//
//                    NSString *urlStr = orderReturnsApply;
//                    [[NetworkManager sharedManager]postWithUrl:urlStr param:dic success:^(id json) {
//                        NSLog(@"%@",json);
//                        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
//                        if ([respCode isEqualToString:@"00000"]) {
//                            DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:@"申请成功" selectType:@"退款审核中" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:minModel];
//                            [alertView show];
//                        }else{
//                            [SVProgressHUD doAnyRemindWithHUDMessage:json[@"respMessage"] withDuration:1.5];
//                        }
//                    } failure:^(NSError *error) {
//
//                    }];
//                }else{
                    _successNumber = 0;
                    _failNumber = 0;
                    _imageNameArr = [NSMutableArray array];
                    //                for (UIImage *image in _imagesArr) {
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyyMMddHHmmssSSS";
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",str];
                    [self uploadPicturesImage:_imagesArr[0] nsNo:imageName];
                    [SVProgressHUD doAnythingWithHUDMessage:nil];
//                }

//                }
            }
            
            
            
            
            
            
        }else if ([type isEqualToString:@"退款审核中"]){
            MineIndentViewController *minePerCtrl = [[MineIndentViewController alloc] init];
            minePerCtrl.title = @"我的订单";
            minePerCtrl.selectIndex = 7;
            [self.navigationController pushViewController:minePerCtrl animated:YES];
        }else{
        }
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ApplyDeatailCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"ApplyDeatailCellID"];
        if (!headerCell) {
            headerCell = [[ApplyDeatailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ApplyDeatailCellID"];
        }
        [headerCell configWithModel:self.returnGoodsModel];
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return headerCell;
    }else if (indexPath.section == 1){
        ServiceTypeCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"ServiceTypeCellID"];
        if (!headerCell) {
            headerCell = [[ServiceTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ServiceTypeCellID"];
        }
        
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        headerCell.selectTypeBlock = ^(ServiceTypeCell *cell, NSInteger selectType) {
            self->_selectType = selectType;
        };
        [headerCell configWithModel:self.returnGoodsModel];
        return headerCell;
    }else{
        QuestionDeatailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionDeatailCellID"];
        if (!cell) {
            cell = [[QuestionDeatailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QuestionDeatailCellID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _indexPath = indexPath;
        [cell setSelectCameraBlock:^(QuestionDeatailCell *qCell) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self cameraBtnAction];
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"从系统相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self getPicBtnAction];
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            });
            
        }];
        [cell setTextViewTextBlock:^(NSString *text) {
            NSLog(@"text == %@",text);
            self->_questionString = text;
        }];
        [cell setDeleteImageBlock:^(NSInteger num) {
            NSLog(@"num == %ld",num);
            [self->_imagesArr removeObjectAtIndex:num];
        }];
        [cell configWithModel:self.returnGoodsModel];
        
        
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = colorWithRGB(0xEEEEEE);
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 130;
    }else if (indexPath.section == 1){
        return 95;
    }else{
        return 240;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
}

#pragma mark - 拍摄按钮的事件
- (void)cameraBtnAction
{
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        
    {
       
    }else{
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        //            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}
#pragma mark - 获取相册按钮的事件
- (void)getPicBtnAction
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        
    }else{
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        
        pickerController.editing = YES;
        
        pickerController.delegate = self;
        
        pickerController.allowsEditing = YES;
        
        pickerController.navigationBar.translucent = NO;//去除毛玻璃效果
        
        pickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:pickerController animated:YES completion:nil];
    }
    
    
}
#pragma mark - UIImagePickerControllrDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //标题栏
    [picker dismissViewControllerAnimated:YES completion:^{
        QuestionDeatailCell *cell = [self.listTableView cellForRowAtIndexPath:self->_indexPath];
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        [self->_imagesArr addObject:image];
        [cell configWithImage:image];
    }];
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
