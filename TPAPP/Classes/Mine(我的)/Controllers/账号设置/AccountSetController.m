//
//  AccountSetController.m
//  TPAPP
//
//  Created by Frank on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "AccountSetController.h"
#import <Photos/Photos.h>
#import "EditNicknameController.h"
#import "VIPViewController.h"
#import "IdentificationController.h"
#import "AddressManageController.h"
#import "ZLNoAuthorityViewController.h"
#import <NMSSH/NMSSH.h>
#import "NewLoginViewController.h"
#import "ConsignmentAddressManageController.h"
@interface AccountSetController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,DeclareAbnormalAlertViewOrderListRemindDelegate>
@property (nonatomic, readwrite, strong) UITableView *tableView;

@end

@implementation AccountSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"账户设置";
    [self configureTableView];
}
- (void)configureTableView {
    [self tableView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self prepareData];
}
#pragma mark - Public Method
- (__kindof YSStaticCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sectionModelArray.count > indexPath.section) {
        YSStaticSectionModel *sectionModel = [self sectionModelInSection:indexPath.section];
        if (sectionModel.cellModelArray.count > indexPath.row) {
            return [sectionModel.cellModelArray objectAtIndex:indexPath.row];
        }
    }
    return nil;
}

- (YSStaticSectionModel *)sectionModelInSection:(NSInteger )section {
    if (self.sectionModelArray.count > section) {
        return [self.sectionModelArray objectAtIndex:section];
    }
    return nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YSStaticSectionModel *sectionModel = [self sectionModelInSection:section];
    return sectionModel.cellModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSStaticCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    
    YSStaticTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.cellIdentifier];
    if (!cell) {
        Class clazz = NSClassFromString(cellModel.cellClassName);
        NSAssert(clazz, @"自定义时，请使用这种方法设置cellClassName:NSStringFromClass([xxx class])");
        cell = [[clazz alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellModel.cellIdentifier];
    }
    
    cell.selectionStyle = cellModel.didSelectCellBlock ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
    
    [cell configureTableViewCellWithModel:cellModel];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    YSStaticSectionModel *sectionModel = [self sectionModelInSection:section];
    return sectionModel.sectionHeaderTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    YSStaticSectionModel *sectionModel = [self sectionModelInSection:section];
    return sectionModel.sectionFooterTitle;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSStaticCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    return cellModel.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    YSStaticSectionModel *sectionModel = [self sectionModelInSection:section];
    return sectionModel.sectionHeaderHeight < 0.01 ? 0.01 : sectionModel.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    YSStaticSectionModel *sectionModel = [self sectionModelInSection:section];
    return sectionModel.sectionFooterHeight < 0.01 ? 0.01 : sectionModel.sectionFooterHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YSStaticDefaultModel *cellModel = [self cellModelAtIndexPath:indexPath];
    !cellModel.didSelectCellBlock ?: cellModel.didSelectCellBlock(cellModel, indexPath);
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
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
            
        }else if (indexPath.row == 1){
            EditNicknameController *idCtrl = [[EditNicknameController alloc] init];
            [self.navigationController pushViewController:idCtrl animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            VIPViewController *vipCtrl = [[VIPViewController alloc] init];
            [self.navigationController pushViewController:vipCtrl animated:YES];
        }else if (indexPath.row == 1){
            
            AddressManageController *idCtrl = [[AddressManageController alloc] init];
            idCtrl.title = @"地址管理";
            [self.navigationController pushViewController:idCtrl animated:YES];
        }else if (indexPath.row == 2){
            
            ConsignmentAddressManageController *idCtrl = [[ConsignmentAddressManageController alloc] init];
            idCtrl.title = @"代发货地址管理";
            [self.navigationController pushViewController:idCtrl animated:YES];
        }else if (indexPath.row == 3){
            //                LYAccount *account = [LYAccount shareAccount];
            //                if ([account.realName isEqualToString:@"0"]) {
            IdentificationController *idCtrl = [[IdentificationController alloc] init];
            [self.navigationController pushViewController:idCtrl animated:YES];
            //                }else{
            //                }
        }else{

        }
    }else if (indexPath.section ==2){
        if (indexPath.row == 0) {
        }else{
        }
    }else{
        DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"确认退出登录吗"] selectType:@"确认退出登录" delegate:self leftButtonTitle:@"取消" rightButtonTitle:@"确定" comGoodList:nil];
        [alertView show];
        
    }
}
-(void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex selectType:(NSString *)type comGoodList:(MineIndentModel *)minModel
{
    if (buttonIndex == AlertButtonLeft) {
        if ([type isEqualToString:@"确认退出登录"]){
        }
    }else{
        if ([type isEqualToString:@"确认退出登录"]) {
            //退出登录在此处理
            [self existBoard];
        }
    }
}
#pragma mark - Setter && Getter
- (void)setSectionModelArray:(NSArray *)sectionModelArray {
    _sectionModelArray = sectionModelArray;
    [self.tableView reloadData];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedRowHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //获取状态栏的rect
        CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
        //获取导航栏的rect
        CGRect navRect = self.navigationController.navigationBar.frame;
        _tableView.sd_layout
        .topSpaceToView(self.view, statusRect.size.height+navRect.size.height)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomSpaceToView(self.view, SafeAreaBottomHeight);
    }
    return _tableView;
}
- (void)prepareData {
    LYAccount *lyAccount = [LYAccount shareAccount];
    AddressModel *addresModel = [AddressModel mj_objectWithKeyValues:lyAccount.defaultAddress];
//    DefaultAddressMessage *addressMes = [DefaultAddressMessage shareDefaultAddressMessage];
    YSStaticDefaultModel *model0 = [[YSStaticDefaultModel alloc] init];
    model0.cellHeight = 80;
    model0.title = @"头像";
//    model0.indicatorImageName = @"测试头像.jpeg";
    model0.indicatorImageUrl = lyAccount.headUrl;
    model0.indicatorImageSize = CGSizeMake(60, 60);
    
    YSStaticDefaultModel *model1 = [[YSStaticDefaultModel alloc] init];
    model1.title = @"昵称";
    model1.indicatorTitle = lyAccount.nickName;
    
    YSStaticDefaultModel *model2 = [[YSStaticDefaultModel alloc] init];
    model2.title = @"手机号";
    model2.indicatorTitle = lyAccount.phone;
    model2.cellType = YSStaticCellTypeAccessoryNone;
    
    YSStaticDefaultModel *model3 = [[YSStaticDefaultModel alloc] init];
    model3.title = @"代购编号";
    model3.indicatorTitle = lyAccount.buyNo;
    model3.cellType = YSStaticCellTypeAccessoryNone;
    
    YSStaticSectionModel *sm0 = [YSStaticSectionModel sectionWithItemArray:@[model0, model1, model2, model3]];
    
    YSStaticDefaultModel *model4 = [[YSStaticDefaultModel alloc] init];
    model4.title = @"会员等级";
    model4.indicatorTitle = [NSString stringWithFormat:@"VIP%@",lyAccount.level];
    
    YSStaticDefaultModel *model5 = [[YSStaticDefaultModel alloc] init];
    model5.title = @"地址管理";
    if ([addresModel.id length] == 0) {
        
    }else{
        model5.indicatorTitle = addresModel.recAddress;
    }
    
    YSStaticDefaultModel *models = [[YSStaticDefaultModel alloc] init];
    models.title = @"代发货地址管理";
    
    
    YSStaticDefaultModel *model6 = [[YSStaticDefaultModel alloc] init];
    model6.title = @"实名认证";
    LYAccount *account = [LYAccount shareAccount];
    if ([account.trueName isEqualToString:@"0"]) {
        model6.indicatorTitle = @"未认证";
    }else{
       model6.indicatorTitle = @"已认证";
    }
    YSStaticDefaultModel *model10 = [[YSStaticDefaultModel alloc] init];
    model10.title = @"下单备注开关";
    model10.cellType = YSStaticCellTypeAccessorySwitch;
    [model10 setSwitchValueDidChangeBlock:^(BOOL isOn) {
        [[NetworkManager sharedManager] postWithUrl:editUserMessage param:@{@"isRemark":[NSString stringWithFormat:@"%d",isOn]} success:^(id json) {
            NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
            if ([respCode isEqualToString:@"00000"]) {
                [LYAccount mj_objectWithKeyValues:json[@"data"]];
                [self prepareData];
                [self.tableView reloadData];
            }else{
                [self.tableView reloadData];
                [SVProgressHUD doAnythingFailedWithHUDMessage:json[@"respMessage"] withDuration:1.5];
            }
        } failure:^(NSError *error) {
            
        }];
    }];
    
    YSStaticSectionModel *sm1 = [YSStaticSectionModel sectionWithItemArray:@[model4, model5,models,model6,model10]];
    
    YSStaticDefaultModel *model7 = [[YSStaticDefaultModel alloc] init];
    model7.title = @"隐私政策";
    YSStaticDefaultModel *model8 = [[YSStaticDefaultModel alloc] init];
    model8.title = @"关于我们";
    
    YSStaticSectionModel *sm2 = [YSStaticSectionModel sectionWithItemArray:@[model7, model8]];
    YSStaticDefaultModel *model9 = [[YSStaticDefaultModel alloc] init];
    model9.title = @"退出登录";
    model9.cellType = YSStaticCellTypeButton;
    
    YSStaticSectionModel *sm3 = [YSStaticSectionModel sectionWithItemArray:@[model9]];
    
    
    self.sectionModelArray = @[sm0, sm1, sm2,sm3];
}
#pragma mark - 拍摄按钮的事件
- (void)cameraBtnAction
{
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        
    {
        //无相册访问权限
        ZLNoAuthorityViewController *nvc = [[ZLNoAuthorityViewController alloc] init];
        nvc.titleString = @"相机";
        nvc.remindlString = @"请在iPhone的\"设置-隐私-相机\"选项中，允许田洋仓访问你的相机";;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:nvc];
        nav.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }else{
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
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
        //无相册访问权限
        ZLNoAuthorityViewController *nvc = [[ZLNoAuthorityViewController alloc] init];
        nvc.titleString = @"照片";
        nvc.remindlString = @"请在iPhone的\"设置-隐私-照片\"选项中，允许田洋仓访问你的手机相册";;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:nvc];
        nav.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }else{
        
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        
        pickerController.editing = YES;
        
        pickerController.delegate = self;
        
        pickerController.allowsEditing = YES;
        
        pickerController.navigationBar.translucent = NO;//去除毛玻璃效果
        
        pickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:pickerController animated:YES completion:nil];
        
//        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        controller.delegate = self;
//        controller.allowsEditing = YES;
//        [self presentViewController:controller animated:YES completion:nil];
    }
}
#pragma mark - UIImagePickerControllrDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //标题栏
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        NSLog(@"%@",image);
//        [SVProgressHUD doAnythingWithHUDMessage:nil];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyyMMddHHmmssSSS";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
//        NSString *imageName = [NSString stringWithFormat:@"%@.jpg",str];
//        NSString *headUrl = [NSString stringWithFormat:@"http://47.92.193.30/images/%@",imageName];
//        // 创建文件管理器
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        //获取路径
//        //参数NSDocumentDirectory要获取那种路径
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//        NSString *documenDirectory = [paths objectAtIndex:0];//去处需要的路径
//        NSString *path = [documenDirectory stringByAppendingPathComponent:imageName];
//        BOOL isEXsit = [fileManager fileExistsAtPath:path];
//        if (isEXsit) {
//            [fileManager removeItemAtPath:path error:nil];
//            [fileManager createFileAtPath:path contents:nil attributes:nil];
//        }else {
//            [fileManager createFileAtPath:path contents:nil attributes:nil];
//        }
//        NSData *data = [[NSData alloc] init];
//        data = UIImageJPEGRepresentation(image,0.5);
//        [data writeToFile:path atomically:YES];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmssSSS";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg",str];

        [self uploadPicturesImage:image nsNo:imageName];
//        NMSSHSession *session = [NMSSHSession connectToHost:@"47.92.193.30" port:22 withUsername:@"root"];
//        if (session.isConnected) {
//            [session authenticateByPassword:@"yb0820@!8"];
//            if (session.isAuthorized) {
//                NSLog(@"Authentication succeeded");
//            }
//        }
//        NSError *error = nil;
//        NSString *response = [session.channel execute:@"ls -l /usr/local/files/" error:&error];
//        NSLog(@"List of my sites: %@", response);
//        BOOL success = [session.channel uploadFile:path to:@"/usr/local/files/images/"];
//        if (success) {
//            NSLog(@"上传成功");
//            [fileManager removeItemAtPath:path error:nil];
//            [[NetworkManager sharedManager] postWithUrl:editUserMessage param:@{@"headUrl":headUrl} success:^(id json) {
////                [SVProgressHUD dismiss];
//                NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
//                if ([respCode isEqualToString:@"00000"]) {
//                    [LYAccount mj_objectWithKeyValues:json[@"data"]];
//                    [SVProgressHUD doAnythingSuccessWithHUDMessage:@"昵称头像成功" withDuration:1.5];
//                    [self prepareData];
//                    [self.tableView reloadData];
//                }else{
//                    [SVProgressHUD doAnythingFailedWithHUDMessage:json[@"respMessage"] withDuration:1.5];
//                }
//            } failure:^(NSError *error) {
//
//            }];
//        }else{
//            NSLog(@"上传失败");
//        }
//         [session disconnect];
//
//
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
    NSData* imagedata = UIImageJPEGRepresentation(image, 1.0);
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
        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        NSLog(@"%.2lf%%", progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        //请求成功
        NSDictionary *dics = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([dics[@"respCode"] isEqualToString:@"00000"]) {
            NSString *imageUrl = dics[@"data"];
            if (imageUrl.length != 0) {
                [[NetworkManager sharedManager] postWithUrl:editUserMessage param:@{@"headUrl":imageUrl} success:^(id json) {
                    //                [SVProgressHUD dismiss];
                    NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
                    if ([respCode isEqualToString:@"00000"]) {
                        [LYAccount mj_objectWithKeyValues:json[@"data"]];
                        [SVProgressHUD doAnythingSuccessWithHUDMessage:@"昵称头像成功" withDuration:1.5];
                        [self prepareData];
                        [self.tableView reloadData];
                    }else{
                        [SVProgressHUD doAnythingFailedWithHUDMessage:json[@"respMessage"] withDuration:1.5];
                    }
                } failure:^(NSError *error) {
                    
                }];
            }
        }
        
        NSLog(@"返回的说明desc：%@", dics);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}
-(void)existBoard{
    
    
//    [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"token"];
//
//    LoginViewController*vc = [[LoginViewController alloc]init];
//    RTRootNavigationController *rootVC= [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:vc];
//    rootVC.rt_disableInteractivePop = YES ;
//    [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
//
    [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"token"];
    NewLoginViewController*vc = [[NewLoginViewController alloc]init];
    RTRootNavigationController *rootVC= [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:vc];
    rootVC.rt_disableInteractivePop = YES ;
    [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
//    [[NetworkManager sharedManager] getWithUrl:getexit param:nil success:^(id json) {
//        NSLog(@"%@",json);
//        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
//        if ([respCode isEqualToString:@"00000"]) {
////            [LYAccount clear];
//            [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"token"];
//            NewLoginViewController*vc = [[NewLoginViewController alloc]init];
//            RTRootNavigationController *rootVC= [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:vc];
//            rootVC.rt_disableInteractivePop = YES ;
//            [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
//        }
//    } failure:^(NSError *error) {
//    }];
}


@end
