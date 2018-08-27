//
//  ApplyTXViewController.m
//  TPAPP
//
//  Created by Frank on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "ApplyTXViewController.h"

@interface ApplyTXViewController ()
@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)UILabel *todayMarketMoney;
//@property (nonatomic, strong)UILabel *todayMarketLabel;

@property (nonatomic, strong)UILabel *monthDGMoney;
//@property (nonatomic, strong)UILabel *monthDGLabel;

@property (nonatomic, strong)UILabel *todayDGMoney;
//@property (nonatomic, strong)UILabel *todayDGLabel;

@property (nonatomic, strong)UITextField *txMoneyTextField;

@end

@implementation ApplyTXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    self.title = @"申请提现";
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createUI];
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
    .heightIs(160);
    
    self.todayMarketMoney = [[UILabel alloc] init];
    self.todayMarketMoney.text = @"¥3000";
    self.todayMarketMoney.textAlignment = NSTextAlignmentCenter;
    self.todayMarketMoney.font = [UIFont systemFontOfSize:24];
    self.todayMarketMoney.textColor = colorWithRGB(0xFF6B24);
    [self.topView addSubview:self.todayMarketMoney];
    self.todayMarketMoney.sd_layout
    .topSpaceToView(self.topView, 10)
    .leftSpaceToView(self.topView, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(30);
    
    UILabel *todayMoney = [[UILabel alloc] init];
    todayMoney.text = @"今日销售额";
    todayMoney.textAlignment = NSTextAlignmentCenter;
    todayMoney.font = [UIFont systemFontOfSize:15];
    todayMoney.textColor = [UIColor grayColor];
    [self.topView addSubview:todayMoney];
    todayMoney.sd_layout
    .topSpaceToView(self.todayMarketMoney, 0)
    .leftSpaceToView(self.topView, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(20);
    
    self.todayDGMoney = [[UILabel alloc] init];
    self.todayDGMoney.text = @"¥10000";
    self.todayDGMoney.textAlignment = NSTextAlignmentCenter;
    self.todayDGMoney.font = [UIFont systemFontOfSize:24];
    self.todayDGMoney.textColor = colorWithRGB(0xFF6B24);
    [self.topView addSubview:self.todayDGMoney];
    self.todayDGMoney.sd_layout
    .topSpaceToView(self.topView, 10)
    .leftSpaceToView(self.todayMarketMoney, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(30);
    
    UILabel *todaydgMoney = [[UILabel alloc] init];
    todaydgMoney.text = @"今日代购费";
    todaydgMoney.textAlignment = NSTextAlignmentCenter;
    todaydgMoney.font = [UIFont systemFontOfSize:15];
    todaydgMoney.textColor = [UIColor grayColor];
    [self.topView addSubview:todaydgMoney];
    todaydgMoney.sd_layout
    .topSpaceToView(self.todayDGMoney, 0)
    .leftSpaceToView(todayMoney, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(20);
    
    self.monthDGMoney = [[UILabel alloc] init];
    self.monthDGMoney.text = @"¥100000";
    self.monthDGMoney.textAlignment = NSTextAlignmentCenter;
    self.monthDGMoney.font = [UIFont systemFontOfSize:24];
    self.monthDGMoney.textColor = colorWithRGB(0xFF6B24);
    [self.topView addSubview:self.monthDGMoney];
    self.monthDGMoney.sd_layout
    .topSpaceToView(self.topView, 10)
    .leftSpaceToView(self.todayDGMoney, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(30);
    
    UILabel *monthdgMoney = [[UILabel alloc] init];
    monthdgMoney.text = @"本月代购费";
    monthdgMoney.textAlignment = NSTextAlignmentCenter;
    monthdgMoney.font = [UIFont systemFontOfSize:15];
    monthdgMoney.textColor = [UIColor grayColor];
    [self.topView addSubview:monthdgMoney];
    monthdgMoney.sd_layout
    .topSpaceToView(self.monthDGMoney, 0)
    .leftSpaceToView(todaydgMoney, 0)
    .widthIs(kScreenWidth/3)
    .heightIs(20);
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = colorWithRGB(0xEEEEEE);
    [self.topView addSubview:lineView];
    lineView.sd_layout
    .topSpaceToView(monthdgMoney, 20)
    .leftSpaceToView(self.topView, 10)
    .widthIs(kScreenWidth-20)
    .heightIs(1);
    
    UILabel *remindLabel = [[UILabel alloc] init];
    remindLabel.text = @"提现金额   ¥";
    remindLabel.textAlignment = NSTextAlignmentCenter;
    remindLabel.font = [UIFont systemFontOfSize:14];
    remindLabel.textColor = [UIColor grayColor];
    [self.topView addSubview:remindLabel];
    remindLabel.sd_layout
    .topSpaceToView(lineView, 20)
    .leftSpaceToView(self.topView, 20)
    .widthIs(kScreenWidth/3-20)
    .heightIs(20);
    NSLog(@"%ld",remindLabel.text.length);
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:@"提现金额   ¥"];
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:32] range:NSMakeRange(7,1)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(7,1)];
    remindLabel.attributedText = attributedStr;
    
    UIButton *allTXbBtn = [[UIButton alloc] init];
    [allTXbBtn setTitle:@"全部提现" forState:UIControlStateNormal];
    [allTXbBtn setTitleColor:colorWithRGB(0xFF6B24) forState:UIControlStateNormal];
    [allTXbBtn addTarget:self action:@selector(allTXbBtnAction) forControlEvents:UIControlEventTouchUpInside];
    allTXbBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.topView addSubview:allTXbBtn];
    allTXbBtn.sd_layout
    .topSpaceToView(lineView, 20)
    .rightSpaceToView(self.topView, 15)
    .widthIs(70)
    .heightIs(30);
    allTXbBtn.layer.cornerRadius = 15;
    allTXbBtn.layer.masksToBounds = YES;
    allTXbBtn.layer.borderWidth = .5;
    allTXbBtn.layer.borderColor = colorWithRGB(0xFF6B24).CGColor;
    
    self.txMoneyTextField = [[UITextField alloc] init];
    self.txMoneyTextField.textColor = [UIColor grayColor];
    [self.topView addSubview:self.txMoneyTextField ];
    self.txMoneyTextField .font = [UIFont systemFontOfSize:24];
    self.txMoneyTextField .sd_layout
    .topSpaceToView(lineView, 20)
    .rightSpaceToView(allTXbBtn, 0)
    .leftSpaceToView(remindLabel, 0)
    .heightIs(20);
    //    self.roomNameTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.txMoneyTextField.textAlignment = NSTextAlignmentLeft;
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    style.alignment = NSTextAlignmentLeft;
//    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:arr[1] attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
//    self.txMoneyTextField .attributedPlaceholder = attri;
    
    UILabel *remiLabel = [[UILabel alloc] init];
    remiLabel.text = @"因支付原因，到账时间可能有延迟";
    remiLabel.textAlignment = NSTextAlignmentCenter;
    remiLabel.font = [UIFont systemFontOfSize:14];
    remiLabel.textColor = colorWithRGB(0xFF6B24);
    [self.view addSubview:remiLabel];
    remiLabel.sd_layout
    .topSpaceToView(self.topView, 40)
    .centerXEqualToView(self.view)
    .widthIs(kScreenWidth)
    .heightIs(20);
    
    UIButton *txbBtn = [[UIButton alloc] init];
    txbBtn.backgroundColor = colorWithRGB(0xFF6B24);
    [txbBtn setTitle:@"确定提现" forState:UIControlStateNormal];
    [txbBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [txbBtn addTarget:self action:@selector(txbBtnAction) forControlEvents:UIControlEventTouchUpInside];
    txbBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:txbBtn];
    txbBtn.sd_layout
    .topSpaceToView(remiLabel, 5)
    .rightSpaceToView(self.view, 20)
    .leftSpaceToView(self.view, 20)
    .heightIs(50);
    txbBtn.layer.cornerRadius = 6;
    txbBtn.layer.masksToBounds = YES;
    
    UIButton *txRecordBtn = [[UIButton alloc] init];
    [txRecordBtn setTitle:@"提现记录" forState:UIControlStateNormal];
    [txRecordBtn setTitleColor:colorWithRGB(0xFF6B24) forState:UIControlStateNormal];
    [txRecordBtn addTarget:self action:@selector(txRecordBtnAction) forControlEvents:UIControlEventTouchUpInside];
    txRecordBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:txRecordBtn];
    txRecordBtn.sd_layout
    .topSpaceToView(txbBtn, 10)
    .centerXEqualToView(self.view)
    .widthIs(120)
    .heightIs(30);

    UIButton *cardBtn = [[UIButton alloc] init];
    [cardBtn setTitle:@"银行卡信息" forState:UIControlStateNormal];
    [cardBtn setTitleColor:colorWithRGB(0xFF6B24) forState:UIControlStateNormal];
    [cardBtn addTarget:self action:@selector(cardBtnAction) forControlEvents:UIControlEventTouchUpInside];
    cardBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:cardBtn];
    cardBtn.sd_layout
    .topSpaceToView(txRecordBtn, 10)
    .centerXEqualToView(self.view)
    .widthIs(120)
    .heightIs(30);
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    bottomView.sd_layout
    .bottomEqualToView(self.view)
    .leftEqualToView(self.view)
    .widthIs(kScreenWidth)
    .heightIs(140);
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"icon_mine_line"];
    [bottomView addSubview:imageView];
    imageView.sd_layout
    .topSpaceToView(bottomView, 20)
    .leftSpaceToView(bottomView, 20)
    .widthIs(3)
    .heightIs(20);
    UILabel *ruleLabel = [[UILabel alloc] init];
    ruleLabel.text = @"提现规则";
    ruleLabel.textAlignment = NSTextAlignmentLeft;
    ruleLabel.font = [UIFont systemFontOfSize:15];
    ruleLabel.textColor = [UIColor blackColor];
    [bottomView addSubview:ruleLabel];
    ruleLabel.sd_layout
    .topSpaceToView(bottomView, 20)
    .leftSpaceToView(imageView, 5)
    .widthIs(120)
    .heightIs(20);
    
    UILabel *firstLabel = [[UILabel alloc] init];
    firstLabel.numberOfLines =2;
    firstLabel.text = @"一、提现次数：供货商不限制提现次数，到账规则详见”提现周期“规定。";
    firstLabel.textAlignment = NSTextAlignmentLeft;
    firstLabel.font = [UIFont systemFontOfSize:12];
    firstLabel.textColor = [UIColor lightGrayColor];
    [bottomView addSubview:firstLabel];
    firstLabel.sd_layout
    .topSpaceToView(ruleLabel, 5)
    .leftSpaceToView(bottomView, 20)
    .rightSpaceToView(bottomView, 0)
    .heightIs(30);
    
    UILabel *secondLabel = [[UILabel alloc] init];
    secondLabel.numberOfLines = 1;
    secondLabel.text = @"二、提现金额：每笔提现需大于2000元";
    secondLabel.textAlignment = NSTextAlignmentLeft;
    secondLabel.font = [UIFont systemFontOfSize:12];
    secondLabel.textColor = [UIColor lightGrayColor];
    [bottomView addSubview:secondLabel];
    secondLabel.sd_layout
    .topSpaceToView(firstLabel, 0)
    .leftSpaceToView(bottomView, 20)
    .rightSpaceToView(bottomView, 0)
    .heightIs(20);
    
    UILabel *thirdLabel = [[UILabel alloc] init];
    thirdLabel.numberOfLines = 2;
    thirdLabel.text =@"一、提现账户：可以选择工商银行、农业银行、支付宝、财付通和欧飞信用点账户";
    thirdLabel.textAlignment = NSTextAlignmentLeft;
    thirdLabel.font = [UIFont systemFontOfSize:12];
    thirdLabel.textColor = [UIColor lightGrayColor];
    [bottomView addSubview:thirdLabel];
    thirdLabel.sd_layout
    .topSpaceToView(secondLabel, 0)
    .leftSpaceToView(bottomView, 20)
    .rightSpaceToView(bottomView, 0)
    .heightIs(30);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.txMoneyTextField endEditing:YES];
}
- (void)cardBtnAction
{
    BankCardViewController *bankCtrl = [[BankCardViewController alloc] init];
    [self.navigationController pushViewController:bankCtrl animated:YES];
    
}
- (void)txRecordBtnAction
{
    TXRecordViewController *txCtrl = [[TXRecordViewController alloc] init];
    [self.navigationController pushViewController:txCtrl animated:YES];
}
- (void)txbBtnAction
{
    
}
- (void)allTXbBtnAction
{
    
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
