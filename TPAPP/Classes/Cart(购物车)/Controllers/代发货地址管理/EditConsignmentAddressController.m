//
//  EditConsignmentAddressController.m
//  TPAPP
//
//  Created by frank on 2018/9/14.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "EditConsignmentAddressController.h"
#import "AddAddressController.h"
#import "AddAddressCell.h"
#import "BRPickerView.h"
#import "NSDate+BRAdd.h"
#import "AddConsignmentAddressCell.h"
@interface EditConsignmentAddressController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)UIButton *saveBtn;
@property (nonatomic, strong)UIButton *deleteBtn;
@property (nonatomic, strong)NSMutableDictionary *dataDict;
@property (nonatomic, strong)NSMutableArray *modelDataArr;
@end

@implementation EditConsignmentAddressController
-(NSMutableDictionary *)dataDict
{
    if (_dataDict == nil) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑地址";
    
    self.listDataArr = [NSMutableArray arrayWithObjects:@[@[@"寄件人:",@"请输入寄件人名字",@0],@[@"电    话:",@"请输入寄件人电话",@0],@[@"省 市 区",@"",@1],@[@"请输入详细地址",@"",@2],@[@"身份证号码:",@"请输入身份证号码",@0]],@[@[@"收件人:",@"请输入收件人名字",@0],@[@"电    话:",@"请输入收件人电话",@0],@[@"省 市 区",@"",@1],@[@"请输入详细地址",@"",@2],@[@"身份证号码:",@"请输入身份证号码",@0]],@[@[@"是否设置为默认地址",@"",@3]], nil];
    self.modelDataArr = [NSMutableArray arrayWithObjects:@[@[self.addressModel.senderNickName],@[self.addressModel.senderPhone],@[[NSString stringWithFormat:@"%@ %@ %@",self.addressModel.senderProv,self.addressModel.senderCity,self.addressModel.senderArea]],@[self.addressModel.senderAddress],@[self.addressModel.senderIdentityCardNo]],@[@[self.addressModel.recNickName],@[self.addressModel.recPhone],@[[NSString stringWithFormat:@"%@ %@ %@",self.addressModel.recProv,self.addressModel.recCity,self.addressModel.recArea]],@[self.addressModel.recAddress],@[self.addressModel.recIdentityCardNo]],@[@[[NSString stringWithFormat:@"%ld",[self.addressModel.isDefault integerValue]]]], nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self listTableView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataDict addEntriesFromDictionary:@{@"userId":self.addressModel.userId}];
    [self.dataDict addEntriesFromDictionary:@{@"recNickName":self.addressModel.recNickName}];
    [self.dataDict addEntriesFromDictionary:@{@"recPhone":self.addressModel.recPhone}];
    [self.dataDict addEntriesFromDictionary:@{@"isGeneration":self.addressModel.isGeneration}];
    [self.dataDict addEntriesFromDictionary:@{@"recIdentityCardNo":self.addressModel.recIdentityCardNo}];
    [self.dataDict addEntriesFromDictionary:@{@"recAddress":self.addressModel.recAddress}];
    [self.dataDict addEntriesFromDictionary:@{@"isDefault":[NSString stringWithFormat:@"%ld",[self.addressModel.isDefault integerValue]]}];
    [self.dataDict addEntriesFromDictionary:@{@"recProv":self.addressModel.recProv}];
    [self.dataDict addEntriesFromDictionary:@{@"recCity":self.addressModel.recCity}];
    [self.dataDict addEntriesFromDictionary:@{@"recArea":self.addressModel.recArea}];
    [self.dataDict addEntriesFromDictionary:@{@"id":self.addressModel.id}];
    
    [self.dataDict addEntriesFromDictionary:@{@"senderNickName":self.addressModel.senderNickName}];
    [self.dataDict addEntriesFromDictionary:@{@"senderPhone":self.addressModel.senderPhone}];
    [self.dataDict addEntriesFromDictionary:@{@"senderIdentityCardNo":self.addressModel.senderIdentityCardNo}];
    [self.dataDict addEntriesFromDictionary:@{@"senderAddress":self.addressModel.senderAddress}];
    [self.dataDict addEntriesFromDictionary:@{@"senderProv":self.addressModel.senderProv}];
    [self.dataDict addEntriesFromDictionary:@{@"senderCity":self.addressModel.senderCity}];
    [self.dataDict addEntriesFromDictionary:@{@"senderArea":self.addressModel.senderArea}];
}

#pragma mark -自定义导航栏返回按钮
- (void)createItems
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    //    self.leftBtn.backgroundColor = [UIColor whiteColor];
    [leftBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = itemleft;
}

- (void)leftBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)saveBtnAction
{
    if ([self.dataDict[@"recNickName"] length] == 0) {
        
    }else{
        if ([self.dataDict[@"recPhone"] length] == 0) {
            
        }else{
            if ([self.dataDict[@"recProv"] length] == 0) {
                
            }else{
                if ([self.dataDict[@"recAddress"] length] == 0) {
                    
                }else{
                    if ([self.dataDict[@"recIdentityCardNo"] length] == 0) {
                        
                    }else{
                            if ([self.dataDict[@"senderNickName"] length] == 0) {
                                
                            }else{
                                if ([self.dataDict[@"senderPhone"] length] == 0) {
                                    
                                }else{
                                    if ([self.dataDict[@"senderProv"] length] == 0) {
                                        
                                    }else{
                                        if ([self.dataDict[@"senderAddress"] length] == 0) {
                                            
                                        }else{
                                            if ([self.dataDict[@"senderIdentityCardNo"] length] == 0) {
                                                
                                            }else{
                                                [LYTools postBossDemoWithUrl:updateAddress param:self.dataDict success:^(NSDictionary *dict) {
                                                    NSLog(@"%@",dict);
                                                    NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
                                                    if ([respCode isEqualToString:@"00000"]) {
                                                        [SVProgressHUD doAnythingSuccessWithHUDMessage:@"编辑成功" withDuration:1.5];
                                                        [self.navigationController popViewControllerAnimated:YES];
                                                    }else{
                                                        [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                                                    }
                                                } fail:^(NSError *error) {
                                                    
                                                }];
                                            }
                                        }
                                    }
                                }
                            }
                        
                       
                    }
                }
            }
        }
    }
}
- (void)deleteBtnAction
{
    [[NetworkManager sharedManager] postWithUrl:deleteAddress param:@{@"id":self.addressModel.id} success:^(id json) {
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            DefaultAddressMessage *defaultMess = [DefaultAddressMessage shareDefaultAddressMessage];
            if ([defaultMess.id isEqualToString:self.addressModel.id]) {
                [DefaultAddressMessage mj_objectWithKeyValues:[[NSDictionary alloc]init]];
            }
            [SVProgressHUD doAnythingSuccessWithHUDMessage:@"删除成功" withDuration:1.5];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD doAnythingFailedWithHUDMessage:json[@"respMessage"] withDuration:1.5];
        }
    } failure:^(NSError *error) {
        
    }];
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
        .bottomSpaceToView(self.view, 0);
        if ([self.listTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.listTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.listTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.listTableView setLayoutMargins:UIEdgeInsetsZero];
        }
        
        
    }
    return _listTableView;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
    }else{
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
        }
        if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listDataArr.count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==3) {
        return 1;
    }else{
        NSArray *arr = self.listDataArr[section];
        return arr.count;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        static NSString *cellId = @"UITableViewCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        cell.backgroundColor = [UIColor clearColor];
        self.saveBtn = [[UIButton alloc] init];
        self.saveBtn.backgroundColor = colorWithRGB(0xFF6B24);
        [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:self.saveBtn];
        self.saveBtn.sd_layout
        .topSpaceToView(cell.contentView,30)
        .rightSpaceToView(cell.contentView, 20)
        .leftSpaceToView(cell.contentView, 20)
        .heightIs(50);
        self.saveBtn.layer.cornerRadius = 6;
        self.saveBtn.layer.masksToBounds = YES;
        
        self.deleteBtn = [[UIButton alloc] init];
        self.deleteBtn.backgroundColor = [UIColor lightGrayColor];
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:self.deleteBtn];
        self.deleteBtn.sd_layout
        .topSpaceToView(self.saveBtn,20)
        .rightSpaceToView(cell.contentView, 20)
        .leftSpaceToView(cell.contentView, 20)
        .heightIs(50);
        self.deleteBtn.layer.cornerRadius = 6;
        self.deleteBtn.layer.masksToBounds = YES;
        
        return cell;
    }else{
        static NSString *cellId = @"AddConsignmentAddressCellID";
        AddConsignmentAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AddConsignmentAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        if ((indexPath.section == 0 || indexPath.section == 1) && indexPath.row == 2) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setMyBlock:^(NSString *str) {
            //            NSIndexPath *inde  = [tableView indexPathForCell:cell];
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    [self.dataDict addEntriesFromDictionary:@{@"senderNickName":str}];
                }else if(indexPath.row == 1){
                    [self.dataDict addEntriesFromDictionary:@{@"senderPhone":str}];
                }else if(indexPath.row == 2){
                }else if(indexPath.row == 3){
                    [self.dataDict addEntriesFromDictionary:@{@"senderAddress":str}];
                }else{
                    [self.dataDict addEntriesFromDictionary:@{@"senderIdentityCardNo":str}];
                }
            }else if (indexPath.section == 1) {
                if (indexPath.row == 0) {
                    [self.dataDict addEntriesFromDictionary:@{@"recNickName":str}];
                }else if(indexPath.row == 1){
                    [self.dataDict addEntriesFromDictionary:@{@"recPhone":str}];
                }else if(indexPath.row == 2){
                }else if(indexPath.row == 3){
                    [self.dataDict addEntriesFromDictionary:@{@"recAddress":str}];
                }else{
                    [self.dataDict addEntriesFromDictionary:@{@"recIdentityCardNo":str}];
                }
            }
            //            [self.dataDict addEntriesFromDictionary:dict];
        }];
        NSInteger num = 1;
        [cell configWithModel:self.listDataArr[indexPath.section][indexPath.row] withModelData:self.modelDataArr[indexPath.section][indexPath.row] withNumber:num];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 1 || indexPath.section == 0) && indexPath.row == 3) {
        return 50;
    }else if (indexPath.section == 3){
        return 80+20+50;;
    }
    else{
        return 40;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 0;
    }else{
        return 15;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return nil;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
        view.backgroundColor = colorWithRGB(0xEEEEEE);
        
        return view;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddAddressCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 1 && indexPath.row == 0) {
        [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
            
            cell.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
            [self.dataDict addEntriesFromDictionary:@{@"recProv":selectAddressArr[0]}];
            [self.dataDict addEntriesFromDictionary:@{@"recCity":selectAddressArr[1]}];
            [self.dataDict addEntriesFromDictionary:@{@"recArea":selectAddressArr[2]}];
        }];
        
        
        //        //        __weak __typeof(self)weakSelf = self;
        //        self.shplacePicker = [[SHPlacePickerView alloc] initWithIsRecordLocation:YES SendPlaceArray:^(NSArray *placeArray) {
        //            NSLog(@"省:%@ 市:%@ 区:%@",placeArray[0],placeArray[1],placeArray[2]);
        //            cell.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",placeArray[0],placeArray[1],placeArray[2]];
        //        }];
        //        [self.view addSubview:self.shplacePicker];
    }
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
