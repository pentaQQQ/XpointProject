//
//  EditNicknameController.m
//  TPAPP
//
//  Created by Frank on 2018/8/24.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "EditNicknameController.h"

@interface EditNicknameController ()
@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)UILabel *nickNameLabel;
@property (nonatomic, strong)UITextField *nickNameTextField;
@property (nonatomic, strong)UIButton *saveBtn;
@end

@implementation EditNicknameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改昵称";
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    [self createUI];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)createUI
{
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    // 状态栏(statusbar)
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    //标题栏
    CGRect navRect = self.navigationController.navigationBar.frame;
    self.topView.sd_layout
    .topSpaceToView(self.view, statusRect.size.height+navRect.size.height)
    .leftEqualToView(self.view)
    .widthIs(kScreenWidth)
    .heightIs(50);
    
    self.nickNameLabel = [[UILabel alloc] init];
    self.nickNameLabel.text = @"昵称";
    self.nickNameLabel.textColor = [UIColor blackColor];
    self.nickNameLabel.textAlignment = NSTextAlignmentCenter;
    self.nickNameLabel.font = [UIFont systemFontOfSize:15];
    [self.topView addSubview:self.nickNameLabel];
    self.nickNameLabel.sd_layout
    .topSpaceToView(self.topView, 15)
    .leftSpaceToView(self.topView, 0)
    .widthIs(80)
    .heightIs(20);
    
    self.nickNameTextField = [[UITextField alloc] init];
    LYAccount *account = [LYAccount shareAccount];
    self.nickNameTextField.text = account.nickName;
    self.nickNameTextField.textColor = [UIColor grayColor];
    [self.topView addSubview:self.nickNameTextField];
    self.nickNameTextField.font = [UIFont systemFontOfSize:14];
    self.nickNameTextField.placeholder = @"请输入昵称";
    self.nickNameTextField.sd_layout
    .topSpaceToView(self.topView, 10)
    .rightSpaceToView(self.topView, 15)
    .leftSpaceToView(self.nickNameLabel, 0)
    .heightIs(30);
    //    self.roomNameTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.nickNameTextField.textAlignment = NSTextAlignmentRight;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentRight;
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"请输入昵称" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
    self.nickNameTextField.attributedPlaceholder = attri;
    
    self.saveBtn = [[UIButton alloc] init];
    self.saveBtn.backgroundColor = colorWithRGB(0xFF6B24);
    [self.saveBtn setTitle:@"确定提交" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveBtn];
    self.saveBtn.sd_layout
    .bottomSpaceToView(self.view,30)
    .rightSpaceToView(self.view, 20)
    .leftSpaceToView(self.view, 20)
    .heightIs(50);
    self.saveBtn.layer.cornerRadius = 6;
    self.saveBtn.layer.masksToBounds = YES;
}
- (void)submitBtnAction
{
    if (self.nickNameTextField.text.length != 0) {
        [[NetworkManager sharedManager] postWithUrl:editUserMessage param:@{@"nickName":self.nickNameTextField.text} success:^(id json) {
            NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
            if ([respCode isEqualToString:@"00000"]) {
                [LYAccount mj_objectWithKeyValues:json[@"data"]];
                [SVProgressHUD doAnythingSuccessWithHUDMessage:@"昵称修改成功" withDuration:1.5];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD doAnythingFailedWithHUDMessage:json[@"respMessage"] withDuration:1.5];
            }
        } failure:^(NSError *error) {
            
        }];
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
