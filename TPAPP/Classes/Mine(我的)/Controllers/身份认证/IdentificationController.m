//
//  IdentificationController.m
//  TPAPP
//
//  Created by Frank on 2018/8/22.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "IdentificationController.h"
#import <Photos/Photos.h>
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CFNetwork/CFNetwork.h>
#import <Foundation/NSObjCRuntime.h>
#include <CoreFoundation/CFBase.h>
#import <NMSSH/NMSSH.h>
#import <iconv.h>
@interface IdentificationController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)UIButton *idZMBtn;
@property (nonatomic, strong)UIButton *idFMBtn;
@property (nonatomic, strong)UIButton *nextBtn;
@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UITextField *idNumberTextField;
@property (nonatomic, assign)BOOL facadeIDIsOK;
@property (nonatomic, assign)BOOL oppositeIDIsOK;
@property (nonatomic, assign)NSInteger selecTakeType;

@property (nonatomic, strong)UIImage *FacadeIDImage;
@property (nonatomic, strong)UIImage *oppositeIDImage;

@end

@implementation IdentificationController
{
    NSInteger _selectImageNum;
    NSString *_facadeImageFilePath;
    NSString *_oppositeImageFilePath;
    NSString *_facadeImageName;
    NSMutableArray *_imageNameArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实名认证";
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    LYAccount *account = [LYAccount shareAccount];
    if (account.identitPicZ.length != 0) {
        self.FacadeIDImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:account.identitPicZ]]];
    }
    if (account.identitPicF.length != 0) {
        self.oppositeIDImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:account.identitPicF]]];
    }
    [self listTableView];
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
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.showsHorizontalScrollIndicator = NO;
//        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.dataSource = self;
        [self.view addSubview:self.listTableView];
        //获取状态栏的rect
        CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
        //获取导航栏的rect
        CGRect navRect = self.navigationController.navigationBar.frame;
        _listTableView.sd_layout
        .topSpaceToView(self.view, statusRect.size.height+navRect.size.height)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomSpaceToView(self.view, SafeAreaBottomHeight);
    }
    return _listTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else{
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UITableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewFirstCell"];
        if (!headerCell) {
            headerCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewFirstCell"];
        }
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [headerCell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
       
        UILabel *remindLabel = [[UILabel alloc] init];
        remindLabel.textColor = colorWithRGB(0xFF6B24);
        [headerCell.contentView addSubview:remindLabel];
        remindLabel.sd_layout
        .topSpaceToView(headerCell.contentView, 10)
        .centerXEqualToView(headerCell.contentView)
        .widthIs(240)
        .heightIs(20);
        remindLabel.textAlignment = NSTextAlignmentCenter;
        remindLabel.font = [UIFont systemFontOfSize:14];
        remindLabel.text = @"提示:请上传本人身份证";
        
        self.idZMBtn = [[UIButton alloc] init];
        [self.idZMBtn addTarget:self action:@selector(idZMBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [headerCell.contentView addSubview:self.idZMBtn];
        if (self.FacadeIDImage == nil) {
            [self.idZMBtn setBackgroundImage:[UIImage imageNamed:@"mine_zhenmian"] forState:UIControlStateNormal];
            
        }else{
            [self.idZMBtn setBackgroundImage:self.FacadeIDImage forState:UIControlStateNormal];
        }
        UIImage *img = [UIImage imageNamed:@"mine_zhenmian"];
        self.idZMBtn.sd_layout
        .topSpaceToView(remindLabel, 15)
        .leftSpaceToView(headerCell.contentView, 30)
        .widthIs((kScreenWidth-3*30)/2)
        .heightIs(((kScreenWidth-3*30)/2)*img.size.height/img.size.width);
        
        
        self.idFMBtn = [[UIButton alloc] init];
        if (self.oppositeIDImage == nil) {
            
            [self.idFMBtn setBackgroundImage:[UIImage imageNamed:@"mine_fanmian"] forState:UIControlStateNormal];
        }else{
            [self.idFMBtn setBackgroundImage:self.oppositeIDImage forState:UIControlStateNormal];
        }
        [self.idFMBtn addTarget:self action:@selector(idFMBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [headerCell.contentView addSubview:self.idFMBtn];
        self.idFMBtn.sd_layout
        .topSpaceToView(remindLabel, 15)
        .rightSpaceToView(headerCell.contentView, 30)
        .widthIs((kScreenWidth-3*30)/2)
        .heightIs(((kScreenWidth-3*30)/2)*img.size.height/img.size.width);
        
        UILabel *idZMLabel = [[UILabel alloc] init];
        idZMLabel.textColor = [UIColor blackColor];
        [headerCell.contentView addSubview:idZMLabel];
        idZMLabel.sd_layout
        .topSpaceToView(self.idZMBtn, 15)
        .leftEqualToView(self.idZMBtn)
        .rightEqualToView(self.idZMBtn)
        .heightIs(20);
        idZMLabel.textAlignment = NSTextAlignmentCenter;
        idZMLabel.font = [UIFont systemFontOfSize:15];
        idZMLabel.text = @"身份证正面";
        
        UILabel *idFMLabel = [[UILabel alloc] init];
        idFMLabel.textColor = [UIColor blackColor];
        [headerCell.contentView addSubview:idFMLabel];
        idFMLabel.sd_layout
        .topSpaceToView(self.idFMBtn, 15)
        .leftEqualToView(self.idFMBtn)
        .rightEqualToView(self.idFMBtn)
        .heightIs(20);
        idFMLabel.textAlignment = NSTextAlignmentCenter;
        idFMLabel.font = [UIFont systemFontOfSize:15];
        idFMLabel.text = @"身份证反面";
        
        return headerCell;
    }else if(indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewSecondCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewSecondCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        NSArray *listArr = @[@"真实姓名",@"身份证号"];
        UILabel *remindLabel = [[UILabel alloc] init];
        remindLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:remindLabel];
        remindLabel.sd_layout
        .centerYEqualToView(cell.contentView)
        .leftSpaceToView(cell.contentView, 15)
        .widthIs([self widthLabelWithModel:listArr[indexPath.row]])
        .heightIs(20);
        remindLabel.textAlignment = NSTextAlignmentLeft;
        remindLabel.font = [UIFont systemFontOfSize:16];
        remindLabel.text = listArr[indexPath.row];
        if (indexPath.row == 0) {
            self.nameTextField = [[UITextField alloc] init];
            self.nameTextField.delegate = self;
            [cell.contentView addSubview:self.nameTextField];
            self.nameTextField.returnKeyType = UIReturnKeyNext;
            self.nameTextField.sd_layout
            .topSpaceToView(cell.contentView, 0)
            .leftSpaceToView(remindLabel, 5)
            .rightEqualToView(cell.contentView)
            .bottomSpaceToView(cell.contentView, 0);
        }else{
            self.idNumberTextField = [[UITextField alloc] init];
            self.idNumberTextField.delegate = self;
            self.idNumberTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.idNumberTextField.returnKeyType = UIReturnKeyDone;
            [cell.contentView addSubview:self.idNumberTextField];
            self.idNumberTextField.sd_layout
            .topSpaceToView(cell.contentView, 0)
            .leftSpaceToView(remindLabel, 5)
            .rightEqualToView(cell.contentView)
            .bottomSpaceToView(cell.contentView, 0);
        }
        LYAccount *account = [LYAccount shareAccount];
        if (self.nameTextField.text.length == 0) {
            self.nameTextField.text = account.trueName;
        }
        if (self.idNumberTextField.text.length == 0) {
            self.idNumberTextField.text = account.identit;
        }
        
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewThirdCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewThirdCell"];
        }
        cell.contentView.backgroundColor = colorWithRGB(0xFF6B24);
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.nextBtn = [[UIButton alloc] init];
        self.nextBtn.backgroundColor = colorWithRGB(0xFF6B24);
        [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.nextBtn setTitle:@"确定上传" forState:UIControlStateNormal];
        [self.nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:self.nextBtn];
        self.nextBtn.sd_layout
        .topSpaceToView(cell.contentView, 0)
        .rightSpaceToView(cell.contentView, 30)
        .leftSpaceToView(cell.contentView, 30)
        .heightIs(50);
        self.nextBtn.layer.cornerRadius = 6;
        self.nextBtn.layer.masksToBounds = YES;
        
        return cell;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.idNumberTextField) {
        [textField resignFirstResponder];//关闭键盘
    }else{
        [self.idNumberTextField becomeFirstResponder];
    }
    return YES;
}

#pragma mark-字体宽度自适应
- (CGFloat)widthLabelWithModel:(NSString *)titleString
{
    CGSize size = CGSizeMake(self.view.bounds.size.width, MAXFLOAT);
    CGRect rect = [titleString boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    return rect.size.width;
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
                [self->_imageNameArr addObject:imageUrl];
                if (self->_imageNameArr.count == 2) {
                    LYAccount *account = [LYAccount shareAccount];
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setValue:account.id forKey:@"id"];
                    [dic setValue:@"1" forKey:@"realName"];
                    [dic setValue:self.nameTextField.text forKey:@"trueName"];
                    [dic setValue:self.idNumberTextField.text forKey:@"identit"];
                    [dic setValue:self->_imageNameArr[0] forKey:@"identitPicZ"];
                    [dic setValue:self->_imageNameArr[1] forKey:@"identitPicF"];
                    [[NetworkManager sharedManager]postWithUrl:uploadIdeniti param:dic success:^(id json) {
                        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
                        if ([respCode isEqualToString:@"00000"]) {
                            [self getPeopleInfomation];
                            // 单例赋值
//                           [LYAccount mj_objectWithKeyValues:json[@"data"]];
                            [self.navigationController popViewControllerAnimated:YES];
                            [SVProgressHUD doAnythingSuccessWithHUDMessage:@"身份证信息上传成功" withDuration:1.5];
                        }else{
                            [SVProgressHUD doAnythingFailedWithHUDMessage:json[@"respMessage"] withDuration:1.5];
                        }
                    } failure:^(NSError *error) {
                        
                }];
            }
          }
        }
        NSLog(@"返回的说明desc：%@", dics);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}
//获取用户信息
-(void)getPeopleInfomation{
    [[NetworkManager sharedManager]getWithUrl:getinfomation param:nil success:^(id json) {
        NSLog(@"%@",json);
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]){
            // 单例赋值
            [LYAccount mj_objectWithKeyValues:json[@"data"]];
        }
    } failure:^(NSError *error) {
    }];
}
- (void)nextBtnAction
{
    if (!_facadeIDIsOK) {
       [SVProgressHUD doAnyRemindWithHUDMessage:@"请选择身份证正面照进行上传" withDuration:1.5];
    }else{
        if (!_oppositeIDIsOK) {
           [SVProgressHUD doAnyRemindWithHUDMessage:@"请选择身份证反面照进行上传" withDuration:1.5];
        }else{
            if (self.nameTextField.text.length == 0) {
                [SVProgressHUD doAnyRemindWithHUDMessage:@"请输入真实的用户名" withDuration:1.5];
            }else{
                if (self.idNumberTextField.text.length == 0) {
                    [SVProgressHUD doAnyRemindWithHUDMessage:@"请输入正确的身份证号码" withDuration:1.5];
                }else{
                    _imageNameArr = [NSMutableArray array];
                    NSArray *fileArr = @[self.FacadeIDImage,self.oppositeIDImage];
//                    NSMutableArray *fileNameArr = [NSMutableArray array];
                    for (UIImage *image in fileArr) {
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        formatter.dateFormat = @"yyyyMMddHHmmssSSS";
                        NSString *str = [formatter stringFromDate:[NSDate date]];
                        NSString *imageName = [NSString stringWithFormat:@"%@.jpg",str];
//                        [fileNameArr addObject:imageName];
                        [self uploadPicturesImage:image nsNo:imageName];
                    }
                }
            }
        }
    }
    
    
//    if (_facadeIDIsOK && _oppositeIDIsOK&&self.nameTextField.text.length > 0 && self.idNumberTextField.text.length > 0) {
//        _imageNameArr = [NSMutableArray array];
//        NSArray *fileArr = @[self.FacadeIDImage,self.oppositeIDImage];
//        for (UIImage *image in fileArr) {
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            formatter.dateFormat = @"yyyyMMddHHmmssSSS";
//            NSString *str = [formatter stringFromDate:[NSDate date]];
//            NSString *imageName = [NSString stringWithFormat:@"%@.jpg",str];
//            [self uploadPicturesImage:image nsNo:imageName];
//        }
//    }else{
////        (_facadeIDIsOK && _oppositeIDIsOK&&self.nameTextField.text.length > 0 && self.idNumberTextField.text.length > 0)
//        if (_facadeIDIsOK == NO) {
//            [SVProgressHUD doAnyRemindWithHUDMessage:@"" withDuration:1.5];
//        }
//    }
}
#pragma mark - imagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取到的图片
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    if (_selectImageNum == 1) {
        self.facadeIDIsOK = YES;
        self.FacadeIDImage = image;
        [self.idZMBtn setBackgroundImage:image forState:UIControlStateNormal];
    }else{
       self.oppositeIDIsOK = YES;
        self.oppositeIDImage = image;
       [self.idFMBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
}

- (void)idZMBtnAction
{
    _selectImageNum = 1;
    //创建UIImagePickerController对象，并设置代理和可编辑
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.editing = YES;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    //选择相册时，设置UIImagePickerController对象相关属性
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //跳转到UIImagePickerController控制器弹出相册
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)idFMBtnAction
{
    _selectImageNum = 2;
    //创建UIImagePickerController对象，并设置代理和可编辑
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.editing = YES;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    //选择相册时，设置UIImagePickerController对象相关属性
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //跳转到UIImagePickerController控制器弹出相册
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }else if (section == 1){
        return 30;
    }else{
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
        view.backgroundColor = colorWithRGB(0xEEEEEE);
        return view;
    }else if (section == 1){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        view.backgroundColor = colorWithRGB(0xEEEEEE);
        return view;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 ) {
        return 50;
    }else{
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] init];
        [view addSubview:lineView];
        lineView.backgroundColor = colorWithRGB(0xbfbfbf);
        lineView.sd_layout
        .topSpaceToView(view, 49.5)
        .leftEqualToView(view)
        .rightEqualToView(view)
        .heightIs(.5);
        
        UIImageView *lineImgeView = [[UIImageView alloc] init];
        [view addSubview:lineImgeView];
        lineImgeView.image = [UIImage imageNamed:@"icon_mine_line"];
        lineImgeView.sd_layout
        .topSpaceToView(view, 15)
        .leftSpaceToView(view, 15)
        .bottomSpaceToView(view, 15)
        .widthIs(3);
        
        UILabel *listLabel = [[UILabel alloc] init];
        [view addSubview:listLabel];
        listLabel.sd_layout
        .topSpaceToView(view, 15)
        .leftSpaceToView(lineImgeView, 5)
        .widthIs(150)
        .heightIs(20);
        listLabel.font = [UIFont systemFontOfSize:15];
        listLabel.text = @"确认身份证信息";
        return view;
    }else {
       return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UIImage *idImage = [UIImage imageNamed:@"mine_zhenmian"];
        return ((kScreenWidth-3*30)/2)*idImage.size.height/idImage.size.width+45+50;
    }else{
        return 50;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
