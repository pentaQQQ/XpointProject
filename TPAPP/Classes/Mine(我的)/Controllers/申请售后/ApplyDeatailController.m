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
@interface ApplyDeatailController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)UIButton *submitBtn;
@end

@implementation ApplyDeatailController
{
    NSIndexPath *_indexPath;
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
        _listTableView.sd_layout
        .topSpaceToView(self.view, 0)
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
    
}
- (void)submitBtnAction
{
    
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
        
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return headerCell;
    }else if (indexPath.section == 1){
        ServiceTypeCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"ServiceTypeCellID"];
        if (!headerCell) {
            headerCell = [[ServiceTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ServiceTypeCellID"];
        }
        
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        return 165;
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
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
    
    
}
#pragma mark - UIImagePickerControllrDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
  
    
    //标题栏
    [picker dismissViewControllerAnimated:YES completion:^{
        QuestionDeatailCell *cell = [self.listTableView cellForRowAtIndexPath:_indexPath];
        UIImage *image = info[UIImagePickerControllerOriginalImage];
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
