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
@interface AccountSetController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, readwrite, strong) UITableView *tableView;

@end

@implementation AccountSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"账户设置";
    [self configureTableView];
    [self prepareData];
}
- (void)configureTableView {
    [self.view addSubview:self.tableView];
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
            //                        dispatch_async(dispatch_get_main_queue(), ^{
            //                            UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"修改昵称" message: nil preferredStyle:UIAlertControllerStyleAlert];
            //                            [alertCtrl  addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            //
            //                                textField.text = cellModel.indicatorTitle;
            //                                textField.borderStyle = UITextBorderStyleNone;
            //                                textField.textColor = [UIColor blackColor];
            //                                textField.clearButtonMode = UITextFieldViewModeAlways;
            //                            }];
            //                            [alertCtrl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //                            }]];
            //                            [alertCtrl  addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //                                NSArray * textfields = alertCtrl.textFields;
            //                                UITextField * namefield = textfields[0];
            //                                NSLog(@"%@",namefield.text);
            //                            }]];
            //                            [self presentViewController:alertCtrl animated:YES completion:nil];
            //                        });
            
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            VIPViewController *vipCtrl = [[VIPViewController alloc] init];
            [self.navigationController pushViewController:vipCtrl animated:YES];
        }else if (indexPath.row == 1){
            AddressManageController *idCtrl = [[AddressManageController alloc] init];
            idCtrl.title = @"地址管理";
            [self.navigationController pushViewController:idCtrl animated:YES];
        }else{
                LYAccount *account = [LYAccount shareAccount];
                if ([account.realName isEqualToString:@"0"]) {
                    IdentificationController *idCtrl = [[IdentificationController alloc] init];
                    [self.navigationController pushViewController:idCtrl animated:YES];
                }else{
                    
                }
           
        }
    }else if (indexPath.section ==2){
        if (indexPath.row == 0) {
        }else{
        }
    }else{
        //退出登录在此处理
        [self existBoard];
    }
}
#pragma mark - Setter && Getter
- (void)setSectionModelArray:(NSArray *)sectionModelArray {
    _sectionModelArray = sectionModelArray;
    [self.tableView reloadData];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
    }
    return _tableView;
}
- (void)prepareData {
    YSStaticDefaultModel *model0 = [[YSStaticDefaultModel alloc] init];
    model0.cellHeight = 80;
    model0.title = @"头像";
    model0.indicatorImageName = @"测试头像.jpeg";
    //    model0.indicatorImageUrl = @"https://img3.duitang.com/uploads/item/201508/07/20150807082213_AcdWu.jpeg";
    model0.indicatorImageSize = CGSizeMake(60, 60);
    
    YSStaticDefaultModel *model1 = [[YSStaticDefaultModel alloc] init];
    model1.title = @"昵称";
    model1.indicatorTitle = @"kyson";
    
    YSStaticDefaultModel *model2 = [[YSStaticDefaultModel alloc] init];
    model2.title = @"手机号";
    model2.indicatorTitle = @"18601605699";
    model2.cellType = YSStaticCellTypeAccessoryNone;
    
    YSStaticDefaultModel *model3 = [[YSStaticDefaultModel alloc] init];
    model3.title = @"代购编号";
    model3.indicatorTitle = @"336854";
    model3.cellType = YSStaticCellTypeAccessoryNone;
    
    YSStaticSectionModel *sm0 = [YSStaticSectionModel sectionWithItemArray:@[model0, model1, model2, model3]];
    
    YSStaticDefaultModel *model4 = [[YSStaticDefaultModel alloc] init];
    model4.title = @"会员等级";
    model4.indicatorTitle = @"VIP2";
    
    YSStaticDefaultModel *model5 = [[YSStaticDefaultModel alloc] init];
    model5.title = @"地址管理";
    model5.indicatorTitle = @"上海市沪太路3100号";
    
    YSStaticDefaultModel *model6 = [[YSStaticDefaultModel alloc] init];
    model6.title = @"实名认证";
    LYAccount *account = [LYAccount shareAccount];
    if ([account.realName isEqualToString:@"0"]) {
        model6.indicatorTitle = @"未认证";
    }else{
       model6.indicatorTitle = @"已认证";
    }
    
    
    YSStaticSectionModel *sm1 = [YSStaticSectionModel sectionWithItemArray:@[model4, model5,model6]];
    
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
        //无权限
        //获取当前语言
        //        NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
        //        NSArray *languages = [defs objectForKey:@"AppleLanguages"];
        //        NSString *preferredLang = [languages objectAtIndex:0];
        //        if ([preferredLang isEqualToString:@"en-CN"]||[preferredLang isEqualToString:@"en-IN"]||[preferredLang isEqualToString:@"en-US"]||[preferredLang isEqualToString:@"en-UK"]) {
        //            //无相册访问权限
        //            //            ZLNoAuthorityViewController *nvc = [[ZLNoAuthorityViewController alloc] init];
        //            //            nvc.titleString = @"相机";
        //            //            nvc.remindString = @"请在iPhone的\"设置-隐私-相机\"选项中，允许%@访问你的相机";
        //            //            [self presentVC:nvc];
        //        }else{
        //            //无相册访问权限
        //            //            ZLNoAuthorityViewController *nvc = [[ZLNoAuthorityViewController alloc] init];
        //            //            nvc.titleString = @"相机";
        //            //            nvc.remindString = @"请在iPhone的\"设置-隐私-相机\"选项中，允许%@访问你的相机";
        //            //            [self presentVC:nvc];
        //        }
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
        //无相册访问权限
        ZLNoAuthorityViewController *nvc = [[ZLNoAuthorityViewController alloc] init];
        nvc.titleString = @"照片";
        nvc.remindlString = @"请在iPhone的\"设置-隐私-照片\"选项中，允许田洋仓访问你的手机相册";;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:nvc];
        nav.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        //获取当前语言
        //        NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
        //        NSArray *languages = [defs objectForKey:@"AppleLanguages"];
        //        NSString *preferredLang = [languages objectAtIndex:0];
        //        if ([preferredLang isEqualToString:@"en-CN"]||[preferredLang isEqualToString:@"en-IN"]||[preferredLang isEqualToString:@"en-US"]||[preferredLang isEqualToString:@"en-UK"]) {
        //无相册访问权限
        //            ZLNoAuthorityViewController *nvc = [[ZLNoAuthorityViewController alloc] init];
        //            nvc.titleString = @"相册";
        //            nvc.remindString = @"请在iPhone的\"设置-隐私-相机\"选项中，允许%@访问你的相册";
        //            [self presentVC:nvc];
        //        }else{
        //无相册访问权限
        //            ZLNoAuthorityViewController *nvc = [[ZLNoAuthorityViewController alloc] init];
        //            nvc.titleString = @"相册";
        //            nvc.remindString = @"请在iPhone的\"设置-隐私-相机\"选项中，允许%@访问你的相册";
        //            [self presentVC:nvc];
        //        }
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }else{
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        //            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.delegate = self;
        controller.allowsEditing = YES;
        [self presentViewController:controller animated:YES completion:nil];
    }
    
    
}
#pragma mark - UIImagePickerControllrDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //标题栏
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        NSLog(@"%@",image);
        //        self.selectImageView.sd_layout
        //        .topSpaceToView(self.view, statusRect.size.height+navRect.size.height)
        //        .centerXEqualToView(self.view)
        //        .widthIs(KScreenWidth-190)
        //        .heightIs((KScreenWidth-190)*(image.size.height)/image.size.width);
        //        self.selectImageView.image = image;
    }];
}

-(void)existBoard{
    
    [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"token"];
    
    LoginViewController*vc = [[LoginViewController alloc]init];
    RTRootNavigationController *rootVC= [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:vc];
    rootVC.rt_disableInteractivePop = YES ;
    [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
    
    
//    [[NetworkManager sharedManager] getWithUrl:getexit param:nil success:^(id json) {
//
//        NSLog(@"%@",json);
//
//        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
//        if ([respCode isEqualToString:@"00000"]) {
//
//            [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"token"];
//            LoginViewController*vc = [[LoginViewController alloc]init];
//            RTRootNavigationController *rootVC= [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:vc];
//            rootVC.rt_disableInteractivePop = YES ;
//            [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
//
//        }
//
//    } failure:^(NSError *error) {
//
//
//    }];
    
}


@end
