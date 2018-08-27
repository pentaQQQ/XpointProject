//
//  InviteAwardController.m
//  TPAPP
//
//  Created by Frank on 2018/8/24.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "InviteAwardController.h"

@interface InviteAwardController ()<UITableViewDelegate, UITableViewDataSource,UIDocumentInteractionControllerDelegate>

@property (nonatomic, retain) UIDocumentInteractionController *docuController;
@property (nonatomic, strong)UITableView *listTableView;
@property (nonatomic, strong)NSMutableArray *listDataArr;
@property (nonatomic, strong)UIView *myQRBgview;
@property (nonatomic, strong)UIView *myQRView;
@property (nonatomic, strong)UIImageView *qrImageView;
@property (nonatomic, strong)UIView *bgview;
@property (nonatomic, strong)UILabel *codeLabel;
@property (nonatomic, strong)UIView *lineview;
@property (nonatomic, strong)UIButton *sendBtn;
@property (nonatomic, strong)UIButton *cancelBtn;
@end

@implementation InviteAwardController
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
//        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_listTableView];
        _listTableView.sd_layout
        .topSpaceToView(self.view, 0)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomEqualToView(self.view);
        if ([self.listTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.listTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.listTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.listTableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return _listTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"邀请有奖";
    self.view.backgroundColor = colorWithRGB(0xEEEEEE);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.listDataArr = [NSMutableArray arrayWithObjects:@[@[@"36654",@0],@[@"38554",@0],@[@"69885",@1],@[@"25669",@1]],@[@[@"36654",@0],@[@"38554",@0],@[@"69885",@1],@[@"25669",@1]], nil];
    [self listTableView];
}
#pragma mark - tableview代理
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listDataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listDataArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InviteAwardCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"InviteAwardCellID"];
    if (!headerCell) {
        headerCell = [[InviteAwardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InviteAwardCellID"];
    }
    NSArray *arr = self.listDataArr[indexPath.section][indexPath.row];
    if ([arr[1] intValue] == 0) {
        headerCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [headerCell configWithModel:self.listDataArr[indexPath.section][indexPath.row]];
    return headerCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

        NSArray *listArr = @[@"2018-07-23",@"2018-06-23"];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        view.backgroundColor = colorWithRGB(0xEEEEEE);

        UIImageView *lineImgeView = [[UIImageView alloc] init];
        [view addSubview:lineImgeView];
        lineImgeView.image = [UIImage imageNamed:@"icon_mine_line"];
        lineImgeView.sd_layout
        .topSpaceToView(view, 7)
        .leftSpaceToView(view, 15)
        .bottomSpaceToView(view, 7)
        .widthIs(3);
        
        UILabel *listLabel = [[UILabel alloc] init];
        [view addSubview:listLabel];
        listLabel.sd_layout
        .topSpaceToView(view, 5)
        .leftSpaceToView(lineImgeView, 5)
        .widthIs(150)
        .heightIs(20);
        listLabel.font = [UIFont systemFontOfSize:15];
        listLabel.text = listArr[section];
        
        return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NSArray *arr = self.listDataArr[indexPath.section][indexPath.row];
    self.myQRBgview = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2.0, kScreenHeight/2.0, 0, 0)];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qrTapAction)];
//    [self.myQRBgview addGestureRecognizer:tap];
    self.myQRBgview.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.myQRBgview];
    
    
    [UIView animateWithDuration:.5 animations:^{
        self.myQRBgview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        self.myQRView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-260)/2.0, (kScreenHeight-350)/2.0, 260, 350)];
        self.myQRView.backgroundColor = [UIColor whiteColor];
        [self.myQRBgview addSubview:self.myQRView];
        self.myQRView.layer.cornerRadius = 8;
        self.myQRView.layer.masksToBounds = YES;
        
        
        self.bgview = [[UIView alloc] initWithFrame:CGRectMake(30, 30, 200, 200)];
        self.bgview.backgroundColor = colorWithRGB(0xFF5760);
        [self.myQRView addSubview:self.bgview];
        
        self.qrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 190, 190)];
        self.qrImageView.image = [self createQRImageWithString:@"1234" size:CGSizeMake(190, 190)];
        [self.bgview addSubview:self.qrImageView];
        
        
        self.codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bgview.frame)+10, 260, 20)];
        self.codeLabel.text = [NSString stringWithFormat:@"邀请码: %@",arr[0]];
        self.codeLabel.textAlignment = NSTextAlignmentCenter;
        self.codeLabel.font = [UIFont systemFontOfSize:15];
        self.codeLabel.textColor = [UIColor blackColor];
        [self.myQRView addSubview:self.codeLabel];
        
        self.lineview = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.codeLabel.frame)+19.5, 240, 1)];
        self.lineview.backgroundColor = colorWithRGB(0xEEEEEE);
        [self.myQRView addSubview:self.lineview];
        
        
        self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.codeLabel.frame)+40, 100, 30)];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.cancelBtn setTitleColor:colorWithRGB(0xFF5760) forState:UIControlStateNormal];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.myQRView addSubview:self.cancelBtn];
        self.cancelBtn.layer.cornerRadius = 6;
        self.cancelBtn.layer.masksToBounds = YES;
        self.cancelBtn.layer.borderWidth = 1;
        self.cancelBtn.layer.borderColor = colorWithRGB(0xFF5760).CGColor;
        
        self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(40+100, CGRectGetMaxY(self.codeLabel.frame)+40, 100, 30)];
         self.sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        self.sendBtn.backgroundColor = colorWithRGB(0xFF5760);
        [self.sendBtn setTitle:@"发送给朋友" forState:UIControlStateNormal];
        [self.sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sendBtn addTarget:self action:@selector(sendBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.myQRView addSubview:self.sendBtn];
        self.sendBtn.layer.cornerRadius = 6;
        self.sendBtn.layer.masksToBounds = YES;
        
    }];
    
}
- (void)cancelBtnAction
{
    [UIView animateWithDuration:0.25 animations:^{
        self.myQRBgview.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        self.myQRBgview.frame = CGRectMake(kScreenWidth/2, kScreenHeight/2, 0, 0);
        self.myQRView.frame = CGRectZero;
        self.bgview.frame = CGRectZero;
        self.qrImageView.frame = CGRectZero;
        self.codeLabel.frame = CGRectZero;
        self.lineview.frame = CGRectZero;
        self.cancelBtn.frame = CGRectZero;
        self.sendBtn.frame = CGRectZero;
        
        [self.codeLabel removeFromSuperview];
        [self.bgview removeFromSuperview];
        [self.lineview removeFromSuperview];
        [self.cancelBtn removeFromSuperview];
        [self.sendBtn removeFromSuperview];
        [self.qrImageView removeFromSuperview];
        
    } completion:^(BOOL finished) {
        [ self.myQRBgview removeFromSuperview];
        [self.myQRView removeFromSuperview];
    }];
}

- (void)sendBtnAction
{
    _docuController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"测试头像" ofType:@"jpeg"]]];
    _docuController.delegate = self;
    [_docuController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    [self cancelBtnAction];
}
#pragma mark - 生成制定大小的黑白二维码
- (UIImage *)createQRImageWithString:(NSString *)string size:(CGSize)size
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 1.创建过滤器
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [qrFilter setDefaults];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CIImage *qrImage = qrFilter.outputImage;
    //放大并绘制二维码（上面生成的二维码很小，需要放大）
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    //翻转一下图片 不然生成的QRCode就是上下颠倒的
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    CGImageRelease(cgImage);
    return codeImage;
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
