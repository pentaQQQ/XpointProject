//
//  IdentificationController.m
//  TPAPP
//
//  Created by Frank on 2018/8/22.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "IdentificationController.h"
#import <Photos/Photos.h>
@interface IdentificationController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)UIButton *idZMBtn;
@property (nonatomic, strong)UIButton *idFMBtn;
@property (nonatomic, strong)UIButton *nextBtn;
@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UITextField *idNumberTextField;
@end

@implementation IdentificationController
{
    NSInteger _selectImageNum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实名认证";
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
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
        self.listTableView.sd_layout
        .topSpaceToView(self.view, 0)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomEqualToView(self.view);
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
        UIImage *idImage = [UIImage imageNamed:@"mine_zhenmian"];
        [self.idZMBtn setBackgroundImage:idImage forState:UIControlStateNormal];
        [self.idZMBtn addTarget:self action:@selector(idZMBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [headerCell.contentView addSubview:self.idZMBtn];
        self.idZMBtn.sd_layout
        .topSpaceToView(remindLabel, 15)
        .leftSpaceToView(headerCell.contentView, 30)
        .widthIs((kScreenWidth-3*30)/2)
        .heightIs(((kScreenWidth-3*30)/2)*idImage.size.height/idImage.size.width);
        
        self.idFMBtn = [[UIButton alloc] init];
        [self.idFMBtn setBackgroundImage:[UIImage imageNamed:@"mine_fanmian"] forState:UIControlStateNormal];
        [self.idFMBtn addTarget:self action:@selector(idFMBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [headerCell.contentView addSubview:self.idFMBtn];
        self.idFMBtn.sd_layout
        .topSpaceToView(remindLabel, 15)
        .rightSpaceToView(headerCell.contentView, 30)
        .widthIs((kScreenWidth-3*30)/2)
        .heightIs(((kScreenWidth-3*30)/2)*idImage.size.height/idImage.size.width);
        
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

- (void)nextBtnAction
{
    

}
#pragma mark - imagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取到的图片
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    if (_selectImageNum == 1) {
        [self.idZMBtn setBackgroundImage:image forState:UIControlStateNormal];
    }else{
       [self.idFMBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    
}

- (void)idZMBtnAction
{
    _selectImageNum = 1;
    //创建UIImagePickerController对象，并设置代理和可编辑
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.editing = YES;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    //创建sheet提示框，提示选择相机还是相册
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
//    //相机选项
//    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        //选择相机时，设置UIImagePickerController对象相关属性
//        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
//        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
//        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
//        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
//        //跳转到UIImagePickerController控制器弹出相机
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    }];
    
    //相册选项
//    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        //选择相册时，设置UIImagePickerController对象相关属性
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //跳转到UIImagePickerController控制器弹出相册
        [self presentViewController:imagePicker animated:YES completion:nil];
//    }];
    
    //取消按钮
//    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
    
    //添加各个按钮事件
//    [alert addAction:camera];
//    [alert addAction:photo];
//    [alert addAction:cancel];
    
    //弹出sheet提示框
//    [self presentViewController:alert animated:YES completion:nil];
}
- (void)idFMBtnAction
{
    _selectImageNum = 2;
    //创建UIImagePickerController对象，并设置代理和可编辑
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.editing = YES;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    //创建sheet提示框，提示选择相机还是相册
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //相机选项
//    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        //选择相机时，设置UIImagePickerController对象相关属性
//        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
//        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
//        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
//        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
//        //跳转到UIImagePickerController控制器弹出相机
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    }];
    
    //相册选项
//    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        //选择相册时，设置UIImagePickerController对象相关属性
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //跳转到UIImagePickerController控制器弹出相册
        [self presentViewController:imagePicker animated:YES completion:nil];
//    }];
    
    //取消按钮
//    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
    
    //添加各个按钮事件
//    [alert addAction:camera];
//    [alert addAction:photo];
//    [alert addAction:cancel];
//
//    //弹出sheet提示框
//    [self presentViewController:alert animated:YES completion:nil];
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
