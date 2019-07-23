//
//  QMChatRoomViewController.m
//  IMSDK-OC
//
//  Created by HCF on 16/3/9.
//  Copyright © 2016年 HCF. All rights reserved.
//

#import "QMChatRoomViewController.h"
#import "QMChatRoomInputView.h"
#import "TCMessageManagerFaceView.h"
#import "QMChatRoomMoreView.h"
#import <QMLineSDK/QMLineSDK.h>
#import "QMRecordIndicatorView.h"
#import "MJRefresh.h"
#import "TZImagePickerController.h"
#import "QMChatRoomShowImageController.h"
#import "QMProfileManager.h"
#import "QMTapGestureRecognizer.h"
#import "QMChatRoomGuestBookViewController.h"

#import "QMChatRoomRobotCell.h"
#import "QMChatRoomTextCell.h"
#import "QMChatRoomVoiceCell.h"
#import "QMChatRoomImageCell.h"
#import "QMChatRoomInvestigateCell.h"
#import "QMChatRoomFileCell.h"
#import "QMChatRoomIframeCell.h"
#import "QMChatRoomCellFactory.h"
#import "QMChatRoomRichTextCell.h"
#import "QMChatRoomNoteCell.h"
#import "QMChatRoomMp3Cell.h"
#import "QMChatRoomCardCell.h"

#import "QMAudioPlayer.h"
#import "QMAudioRecorder.h"
#import "SJVoiceTransform.h"

//new
#import "QMChatTileView.h"
#import "QMFileManagerController.h"
#import "QMAlert.h"
#import "QMTextAttachment.h"
#import "NSAttributedString+QMEmojiExtension.h"

#import <Photos/Photos.h>

#import "QMTextModel.h"

#import "QMManager.h"
#import "QMChatRoomEvaluationView.h"
#import "QMChatRoomAssociationInputView.h"

/**
 在线客服聊天界面
 */
@interface QMChatRoomViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, TCMessageManagerFaceViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate, AVAudioRecorderDelegate, QMKServiceDelegate, QMAudioRecorderDelegate> {
    
    NSMutableArray * _dataArray;
    
    int _dataNum;
    CGFloat _keyboardHigh;
    
    QMChatTileView *_titleView;
    
    NSTimer *breakTimer;
    NSTimer *breakTipTimer;
    NSTimer *backStatus;
    
    CGFloat _navHeight;
    
    NSString *_titleViewText;
    
    BOOL isShowEvaluate; //满意度评价按钮
    
    BOOL alreadEvaluate; //是否已经评价过(机器人和人工共用一个)
    
    NSString *_intelligentRobot; //智能机器人id
    
    BOOL isRemark;
        
    BOOL keyboardIsShow;
    
    BOOL isShowEvaluateView; //满意度view 是否展示
    
    BOOL isShowEvaluateBtn; //人工之后的满意度按钮是否展示
    
    BOOL isShowAssociatsInput; //是否开启联想输入
    
    BOOL isShowAssociatsView; //xbot联想view
    
    NSArray *_cateIdArr; //xbot机器人cateId
    
    NSArray *_questions; //xbot联想问题
}


@property (nonatomic, assign)float upProgress;

@property (nonatomic, strong)QMChatTileView *titleView;

@property (nonatomic, assign)BOOL isSpeak;

@property (nonatomic, copy) NSDictionary * dictionary;

@property (nonatomic, assign)BOOL isAleardyChat;

@end

@implementation QMChatRoomViewController

#pragma mark - 生命周期
// 注册通知
-(instancetype)init {
    self = [super init];
    if (self) {
        // 建议使用willshow和willhide
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewReload:) name:CHATMSG_RELOAD object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(robotAction) name:ROBOT_SERVICE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customOnline) name:CUSTOMSRV_ONLINE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customOffline) name:CUSTOMSRV_OFFLINE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customClaim) name:CUSTOMSRV_CLAIM object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customFinish:) name:CUSTOMSRV_FINISH object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customQueue:) name:CUSTOMSRV_QUEUENUM object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customAgentMessage:) name:CUSTOMSRV_AGENT object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customInvestigate) name:CUSTOMSRV_INVESTIGATE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customVIP) name:CUSTOMSRV_VIP object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customLeavemsg:) name:CUSTOMSRV_LEAVEMSG object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCustomStatus) name:CUSTOMSRV_IMPORTING object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cbangeDrowMessageStatus:) name:CUSTOMSRV_DRAWMESSAGE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customSatisfaction:) name:CUSTOMSRV_SATISFACTION object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customAssociatsInput:) name:CUSTOMSRV_ASSOCIATSINPUT object:nil];
    }
    return self;
}

// 基本配置
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:246/255.0 green:248/255.0 blue:249/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:13/255.0 green:139/255.0 blue:249/255.0 alpha:1];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
}

/**
 开始会话
 
 peer: 技能组id 必传
 params: @{@"agent":@"8000"} 专属坐席
 @{@"customField":@{@"姓名":@"李三"}} 自定义字段
 */
- (void)viewDidAppear:(BOOL)animated {
    if (self.isPush == NO) {
        [self beginNewChat];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self createUI];
    [self.circleViews startAnimating];
    /**
     创建文件管理类
     
     name: 可随便填写
     password: 可随便填写
     */
    QMProfileManager *manger = [QMProfileManager sharedInstance];
    [manger loadProfile:@"name" password:@"123456"];
    
    __weak QMChatRoomViewController *weakSelf = self;
    [QMConnect statusWithConneted:^{
        [weakSelf.titleView.activityIndicatorView stopAnimating];
    } connecting:^{
        [weakSelf.titleView.activityIndicatorView startAnimating];
    } dis:^{
        [weakSelf.titleView.activityIndicatorView stopAnimating];
    }];
    
    [self getInvestigateData];
    
    _dataArray = [[NSMutableArray alloc]init];
    if (_dataNum == 0) {
        _dataNum = 10;
    }
    
    [self getData];
    
    [self insertCardInfoMessage];
    
    [self.chatTableView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollToEnd];
    });
    
    [self createNSTimer];
    
    self.heightCaches = [NSMutableDictionary dictionary];
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([self.chatInputView.inputView isFirstResponder]) {
        [self.chatInputView.inputView resignFirstResponder];
        self.chatInputView.inputView.inputView = nil;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"Appear");
}

// 移除通知
- (void)dealloc {
    NSLog(@"销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 创建聊天室UI(消息列表、输入工具条、提示窗...)
- (void)createUI {
    if (@available(iOS 11.0, *)){
        [self.chatTableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect StatusRect = [[UIApplication sharedApplication] statusBarFrame];
    CGRect NavRect = self.navigationController.navigationBar.frame;
    _navHeight = StatusRect.size.height + NavRect.size.height;
    
    // 坐席信息提示
    _titleView = [[QMChatTileView alloc] initWithFrame: CGRectMake(0, 0, 150, 40)];
    _titleView.nameLabel.text = NSLocalizedString(@"title.people", nil);
    _titleView.stateInfoLabel.text = NSLocalizedString(@"title.connection", nil);
    _titleView.intrinsicContentSize = CGSizeMake(150, 40);
    self.navigationItem.titleView = _titleView;
    
    // 消息列表
    self.chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kInputViewHeight-_navHeight) style:UITableViewStylePlain];
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    self.chatTableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chatTableView.estimatedRowHeight = 0;
    [self.view addSubview:self.chatTableView];
    
    __weak QMChatRoomViewController * myChatView = self;
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [myChatView Refresh];
    }];
    [mj_header.lastUpdatedTimeLabel setHidden:true];
    self.chatTableView.mj_header = mj_header;
    
    // 输入工具条
    self.chatInputView = [[QMChatRoomInputView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kInputViewHeight-_navHeight, kScreenWidth, kInputViewHeight)];
    [self.chatInputView.voiceButton addTarget:self action:@selector(voiceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.chatInputView.faceButton addTarget:self action:@selector(faceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.chatInputView.addButton addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.chatInputView.RecordBtn addTarget:self action:@selector(cancelRecord:) forControlEvents:UIControlEventTouchUpOutside];
    [self.chatInputView.RecordBtn addTarget:self action:@selector(RecordBtnBegin:) forControlEvents:UIControlEventTouchDown];
    [self.chatInputView.RecordBtn addTarget:self action:@selector(RecordBtnEnd:) forControlEvents:UIControlEventTouchUpInside];
    [self.chatInputView.RecordBtn addTarget:self action:@selector(RecordBtnExit:) forControlEvents:UIControlEventTouchDragExit];
    [self.chatInputView.RecordBtn addTarget:self action:@selector(RecordBtnEnter:) forControlEvents:UIControlEventTouchDragEnter];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.chatInputView.coverView addGestureRecognizer:tapGesture];
    [self.chatInputView.coverView setHidden:YES];
    [QMManager defaultManager].isFinish = NO;
    self.chatInputView.inputView.delegate = self;
    [self.view addSubview:self.chatInputView];
    
    // 表情面板
    self.faceView = [[TCMessageManagerFaceView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, kScreenWidth, QM_IS_IPHONEX ? 250 : 216)];
    self.faceView.delegate = self;
    [self.faceView.sendButton addTarget:self action:@selector(sendBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 扩展面板
    self.addView = [[QMChatRoomMoreView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, kScreenWidth, QM_IS_IPHONEX ? 144 : 110)];
    [self.addView.takePicBtn addTarget:self action:@selector(takePicBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.addView.evaluateBtn addTarget:self action:@selector(evaluateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.addView.takeFileBtn addTarget:self action:@selector(takeFileBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.addView.evaluateBtn.hidden = YES;
    self.addView.evaluateLabel.hidden = YES;
    
    // 转人工
    self.manualButotn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.manualButotn.frame = CGRectMake(0, 0, 60, 30);
    self.manualButotn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.manualButotn setTitle: NSLocalizedString(@"button.topeople", nil) forState:UIControlStateNormal];
    [self.manualButotn setTitleColor:[UIColor colorWithRed:13/255.0 green:139/255.0 blue:249/255.0 alpha:1] forState:UIControlStateNormal];
    [self.manualButotn addTarget:self action:@selector(customClick) forControlEvents:UIControlEventTouchUpInside];
    self.manualButotn.hidden = YES;
    if (self.isOpenSchedule) {
        self.isRobot = true;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.manualButotn];
    }else {
        if ([QMConnect allowRobot]) {
            self.isRobot = true;
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.manualButotn];
        }else {
            self.isRobot = false;
        }
    }
    
    // 注销
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.logoutButton.frame = CGRectMake(0, 0, 50, 30);
    self.logoutButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.logoutButton setTitle:NSLocalizedString(@"button.logout", nil) forState:UIControlStateNormal];
    [self.logoutButton setTitleColor:[UIColor colorWithRed:13/255.0 green:139/255.0 blue:249/255.0 alpha:1] forState:UIControlStateNormal];
    [self.logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.logoutButton];
    
    self.indicatorView = [[QMRecordIndicatorView alloc] init];
    self.indicatorView.frame = CGRectMake((kScreenWidth-150)/2, (kScreenHeight-150-_navHeight-50)/2, 150, 150);
    
    UITapGestureRecognizer * gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.chatTableView addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    self.coverView = [[UIView alloc] init];
    self.coverView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.coverView];
    
    // 建议使用网络指示器
    self.circleViews = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.circleViews.layer.cornerRadius = 5;
    self.circleViews.layer.masksToBounds = YES;
    self.circleViews.frame = CGRectMake((kScreenWidth-100)/2, (kScreenHeight-100)/2-64, 100, 100);
    self.circleViews.backgroundColor = [UIColor blackColor];
    self.circleViews.color = [UIColor whiteColor];
    self.circleViews.alpha = 0.7;
    [self.coverView addSubview:self.circleViews];

}

- (void)hideKeyboard {
    [self.chatInputView.inputView resignFirstResponder];
    self.chatInputView.inputView.inputView = nil;
}

#pragma mark - 获取数据(数据模型已存储本地)
// 获取消息数据
- (void)getData {
    _dataArray = [NSMutableArray arrayWithArray:[QMConnect getDataFromDatabase:_dataNum]];
    
    /**
     获取同一个accessid(AppKey)下的全部信息 用下面此接口
     
     _dataArray = [NSMutableArray arrayWithArray:[QMConnect getAccessidAllDataFormDatabase:_dataNum]];
     */
    
    /**
     获取同一个userId下的全部信息 用下面此接口
     
     _dataArray = [NSMutableArray arrayWithArray:[QMConnect getUserIdDataFormDatabase:_dataNum]];
     */
}

// 获取后台配置信息 、 满意度调查 、回复超时时间
- (void)getInvestigateData {
    
    [QMConnect newSDKGetInvestigate:^(QMEvaluation * _Nonnull evaluation) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.evaluation = evaluation;
        });
    } failureBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }];
}

// 刷新TableView
-(void)reloadTableView {
    
    if (_titleViewText != nil) {
        _titleView.stateInfoLabel.text = _titleViewText;
    }
    
    NSLog(@"刷新信息");
    [self.chatTableView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollToEnd];
    });
}

/**
 新消息通知、发送和接收的消息 都会走这个通知 统一刷新聊天界面
 */
- (void)getNewReload: (NSNotification *)sender {
    NSLog(@"获取到新消息 %@", sender.object);
    [self getData];
    [self reloadTableView];
    
    if (backStatus.isValid) {
        [backStatus invalidate];
    }
    
    if (_isSpeak && isShowEvaluate && _isRobot && !alreadEvaluate) {
        self.addView.evaluateBtn.hidden = NO;
        self.addView.evaluateLabel.hidden = NO;
    }
    
    if ([QMConnect customerAccessAfterMessage]) {
        if (_isSpeak) {
            if (!_isRobot && !alreadEvaluate) {
                [QMConnect customerServiceIsSpeek:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        isShowEvaluateBtn = YES;
                        [self isShowEvaluateBtn:YES];
                    });
                } failBlock:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        isShowEvaluateBtn = NO;
                        [self isShowEvaluateBtn:NO];
                    });
                }];
            }
        }
    }else {
        if (!_isRobot && !alreadEvaluate) {
            [QMConnect customerServiceIsSpeek:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    isShowEvaluateBtn = YES;
                    [self isShowEvaluateBtn:YES];
                });
            } failBlock:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    isShowEvaluateBtn = NO;
                    [self isShowEvaluateBtn:NO];
                });
            }];
        }
    }
}

// 滑动到底部
- (void)scrollToEnd {
    if (_dataArray.count>0) {
        [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    }
}

// 下拉刷新
- (void)Refresh {
    if (_dataNum>_dataArray.count) {
    }
    _dataNum = _dataNum+10;
    [self getData];
    [_chatTableView reloadData];
    [self.chatTableView.mj_header endRefreshing];
}

//商品信息的卡片(默认是关闭的,需要手动打开注释)
- (void)insertCardInfoMessage {
    [QMConnect deleteCardTypeMessage];
    
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:@"https://fs-km.7moor.com/N00000000143/km/2018-06-15/1529044921332/35522b40-7067-11e8-ab29-a3347bfc2358" forKey:@"cardImage"]; //此参数需要填写的是URL
//    [dic setObject:@"标题水泥粉那的大萨达所多撒费大幅度第三方的辅导费等你顾得上弄" forKey:@"cardHeader"];
//    [dic setObject:@"氨基酸大家都哪三大" forKey:@"cardSubhead"];
//    [dic setObject:@"34345" forKey:@"cardPrice"];
//    [dic setObject:@"https://kf.7moor.com" forKey:@"cardUrl"]; //此参数需要填写的是URL
//
//    [QMConnect insertCardInfoData:dic];
    
    [self getData];
    [self reloadTableView];
}

- (void)applicationWillResignActive {
    NSLog(@"退到后台");
}

- (void)applicationDidBecomeActive {
    NSLog(@"返回前台");
}

#pragma mark - TableViewDelegate TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomMessage * message = _dataArray[_dataArray.count-indexPath.row-1];
    
    NSString * identifier = @"";
    if ([message.messageType isEqualToString:@"text"]) {
        if ([message.isRobot isEqualToString:@"1"]) {
            identifier = NSStringFromClass([QMChatRoomRobotCell class]);
        }else {
            identifier = NSStringFromClass([QMChatRoomTextCell class]);
        }
    }else if ([message.messageType isEqualToString:@"voice"]) {
        identifier = NSStringFromClass([QMChatRoomVoiceCell class]);
    }else if ([message.messageType isEqualToString:@"image"]) {
        identifier = NSStringFromClass([QMChatRoomImageCell class]);
    }else if ([message.messageType isEqualToString:@"investigate"]) {
        identifier = NSStringFromClass([QMChatRoomInvestigateCell class]);
    }else if ([message.messageType isEqualToString:@"file"]) {
        if ([message.fileName.pathExtension.lowercaseString isEqual: @"mp3"]) {
            identifier = NSStringFromClass([QMChatRoomMp3Cell class]);//MP3文件以语音形式播放
        }else{
            identifier = NSStringFromClass([QMChatRoomFileCell class]);
        }
    }else if ([message.messageType isEqualToString:@"iframe"]) {
        identifier = NSStringFromClass([QMChatRoomIframeCell class]);
    }else if ([message.messageType isEqualToString:@"richText"]){
        identifier = NSStringFromClass([QMChatRoomRichTextCell class]);
    }else if ([message.messageType isEqualToString:@"withdrawMessage"]) {
        identifier = NSStringFromClass([QMChatRoomNoteCell class]);
    }else if ([message.messageType isEqualToString:@"card"]){
        identifier = NSStringFromClass([QMChatRoomCardCell class]);
    }else if ([message.messageType isEqualToString:@"cardInfo"]) {
        identifier = NSStringFromClass([QMChatRoomRichTextCell class]);
    }else {
        identifier = NSStringFromClass([QMChatRoomTextCell class]);
    }
    
    QMChatRoomBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [QMChatRoomCellFactory createCellWithClassName:identifier cellModel:message indexPath:indexPath];
    }
    
    if (indexPath.row>0) {
        CustomMessage * preMessage = _dataArray[_dataArray.count-indexPath.row];
        UInt64 disTime = message.createdTime.longLongValue - preMessage.createdTime.longLongValue;
        if (disTime<3*60*1000) {
            cell.timeLabel.hidden = YES;
        }else {
            cell.timeLabel.hidden = NO;
        }
    }else {
        cell.timeLabel.hidden = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 如果需要设置头像、该方法加上一个头像路径参数
    [cell setData:message avater:self.avaterStr];
    
    if ([message.messageType isEqualToString:@"file"]) {
        [cell setProgress: self.upProgress];
    }
    
    if ([message.messageType isEqualToString:@"text"]) {
        cell.tapNetAddress = ^(NSString *address) {
            if ([address rangeOfString:@"http://"].location == NSNotFound && [address rangeOfString:@"https://"].location == NSNotFound) {
                address = [NSString stringWithFormat:@"http://%@", address];
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:address]];
        };
    }
    
    // 机器人消息可以选择问题代码 答案可以选择有帮助或无帮助
    if ([message.messageType isEqualToString:@"text"] && [message.isRobot isEqualToString:@"1"]) {
        __weak QMChatRoomViewController *weakSelf = self;
        
        cell.tapSendMessage = ^(NSString *text) {
            [weakSelf sendText:text];
        };
        
        cell.didBtnAction = ^(BOOL isUseful) {
            if (!message.isUseful||[message.isUseful isEqualToString:@"none"]) {
                if ([weakSelf.heightCaches objectForKey:message._id]) {
                    [weakSelf.heightCaches removeObjectForKey:message._id];
                }
                if ([message.robotType isEqualToString:@"xbot"]) {
                    [weakSelf sendXbotRobotFeedback:isUseful message:message];
                }else{
                    [weakSelf sendRobotFeedback:isUseful questionId:message.questionId messageId:message._id robotType:message.robotType robotId:message.robotId robotMsgId:message.robotMsgId];
                }
            }
        };
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomMessage * message = _dataArray[_dataArray.count-indexPath.row-1];
    if ([message.messageType isEqualToString:@"withdrawMessage"]) {
        
    }else if ([message.messageType isEqualToString:@"cardInfo"]) {
        
    }else{
        // 取已有cell高度 时间高度计算
//        if ([self.heightCaches objectForKey:message._id] && indexPath.row != 0) {
//            NSNumber *tmpHeight = [self.heightCaches objectForKey:message._id];
//            return tmpHeight.doubleValue;
//        }
    }
    
    CGFloat height = 15;
    if (indexPath.row>0) {
        CustomMessage * preMessage = _dataArray[_dataArray.count-indexPath.row];
        UInt64 disTime = message.createdTime.longLongValue - preMessage.createdTime.longLongValue;
        if (disTime<3*60*1000) {
            height = 15;
        }else {
            height = 45;
        }
    }else {
        height = 45;
    }
    
    if ([message.messageType isEqualToString:@"text"]) {
        if ([message.isRobot isEqualToString:@"1"]) {
            CGFloat robotHeight = [QMTextModel calcRobotHeight:message.message];
            height += (robotHeight+5+21);
        }else {
            CGFloat textHeight = [QMTextModel calcTextHeight:message.message];
            height += (textHeight+5+21);
        }
        
        height = height>65?height:65;
        if ([message.isRobot isEqualToString:@"1"] && ![message.questionId isEqualToString:@""]) {
            if (message.isUseful) {
                if ([message.isUseful isEqualToString:@"none"]) {
                    height += 30;
                }else {
                    height += 60;
                }
            }else {
                height += 30;
            }
        }
    }else if ([message.messageType isEqualToString:@"voice"]) {
        height += 45;
    }else if ([message.messageType isEqualToString:@"image"]) {
        height += 140;
    }else if ([message.messageType isEqualToString:@"investigate"]) {
        height += 145;
    }else if ([message.messageType isEqualToString:@"file"]) {
        height += 50;
    }else if ([message.messageType isEqualToString:@"iframe"]) {
        height += message.height.intValue+30;
    }else if ([message.messageType isEqualToString:@"richText"]) {
        height += 120;
    }else if ([message.messageType isEqualToString:@"withdrawMessage"]) {
        height = 45;
    }else if ([message.messageType isEqualToString:@"card"]) {
        height += 150;
    }else if ([message.messageType isEqualToString:@"cardInfo"]) {
        height += 80;
    }else {
        height += 45;
    }
    
    // 存储cell高度 如果高度有变化 请提前清除对应id的缓存
    NSNumber *number = [NSNumber numberWithDouble:height];
    [self.heightCaches setObject:number forKey:message._id];
    
    return height;
}

#pragma mark - InputView Action
//切换录音按钮
- (void)voiceBtnAction:(UIButton *)button {
    if (self.chatInputView.RecordBtn.hidden == YES) {
        [self.chatInputView showRecordButton:YES];
        [self.chatInputView.inputView endEditing:YES];
    }else {
        [self.chatInputView showRecordButton:NO];
        self.chatInputView.inputView.inputView = nil;
        [self.chatInputView.inputView becomeFirstResponder];
        [self.chatInputView.inputView reloadInputViews];
    }
}

//表情按钮
- (void)faceBtnAction:(UIButton *)button {
    if (button.tag == 1) {
        [self.chatInputView showEmotionView:YES];
        self.chatInputView.inputView.inputView = self.faceView;
    }else {
        [self.chatInputView showEmotionView:NO];
        self.chatInputView.inputView.inputView = nil;
    }
    [self.chatInputView.inputView becomeFirstResponder];
    [self.chatInputView.inputView reloadInputViews];
}

//扩展功能按钮
- (void)addBtnAction:(UIButton *)button {
    if (button.tag == 3) {
        [self.chatInputView showMoreView:YES];
        self.chatInputView.inputView.inputView = self.addView;
        [self.chatInputView.inputView becomeFirstResponder];
        [self.chatInputView.inputView reloadInputViews];
    }else {
        [self.chatInputView showMoreView:NO];
        self.chatInputView.inputView.inputView = nil;
        [self.chatInputView.inputView endEditing:YES];
    }
}

#pragma mark - Record Action
// 开始录音
- (void)RecordBtnBegin:(UIButton *)button {
    NSString *fileName = [[NSUUID new] UUIDString];
    // 验证权限
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (authorizationStatus) {
        case AVAuthorizationStatusNotDetermined:
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                
            }];
            break;
        case AVAuthorizationStatusAuthorized:
            self.indicatorView.isCount = false;
            [self.indicatorView changeViewStatus:QMIndicatorStatusNormal];
            [self.view addSubview:self.indicatorView];
            [self changeButtonStatus:YES];
            [[QMAudioRecorder sharedInstance] startAudioRecord:fileName maxDuration:60.0 delegate:self];
            break;
        case AVAuthorizationStatusRestricted:
            NSLog(@"麦克风访问受限!");
            break;
        case AVAuthorizationStatusDenied:
            NSLog(@"设置允许访问麦克风");
            break;
    }
}

// 结束录音
- (void)RecordBtnEnd:(UIButton *)button {
    [[QMAudioRecorder sharedInstance] stopAudioRecord];
}

// 取消录音
- (void)cancelRecord: (UIButton *)button {
    [[QMAudioRecorder sharedInstance] cancelAudioRecord];
    [self.indicatorView removeFromSuperview];
    [self changeButtonStatus:NO];
}

- (void)RecordBtnExit: (UIButton *)button {
    [self.indicatorView changeViewStatus:QMIndicatorStatusCancel];
}

- (void)RecordBtnEnter: (UIButton *)button {
    [self.indicatorView changeViewStatus:QMIndicatorStatusNormal];
}

// 更改按钮状态
- (void)changeButtonStatus:(BOOL)down {
    if (down == YES) {
        [self.chatInputView.RecordBtn setTitle:NSLocalizedString(@"button.recorder_recording", nil) forState:UIControlStateNormal];
        [self.chatInputView.RecordBtn setTitleColor:[UIColor colorWithRed:50/255.0f green:167/255.0f blue:255/255.0f alpha:1.0] forState:UIControlStateNormal];
        self.chatInputView.RecordBtn.layer.borderColor = [[UIColor colorWithRed:50/255.0f green:167/255.0f blue:255/255.0f alpha:1.0] CGColor];
        [self.chatInputView.RecordBtn setTintColor:[UIColor colorWithRed:50/255.0f green:167/255.0f blue:255/255.0f alpha:1.0]];
    }else {
        [self.chatInputView.RecordBtn setTitle:NSLocalizedString(@"button.recorder_normal", nil) forState:UIControlStateNormal];
        [self.chatInputView.RecordBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.chatInputView.RecordBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    }
}

- (void)audioRecorderStart {
    
}

- (void)audioRecorderCompletion:(NSString *)fileName duration:(NSString *)duration {
    NSString * path = [NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),@"Documents",fileName];
    [SJVoiceTransform stransformToMp3ByUrlWithUrl:path];
    [self sendAudio:fileName duration:duration];
    if (duration.intValue >= 60) {
        [self.indicatorView changeViewStatus:QMIndicatorStatusLong];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.indicatorView removeFromSuperview];
            [self changeButtonStatus:NO];
        });
    }else {
        [self.indicatorView removeFromSuperview];
        [self changeButtonStatus:NO];
    }
}

- (void)audioRecorderChangeInTimer:(NSTimeInterval)power total:(int)count {
    [self.indicatorView updateImageWithPower:power];
    self.indicatorView.count = count;
}

- (void)audioRecorderCancel {
    [self.indicatorView removeFromSuperview];
    [self changeButtonStatus:NO];
}

- (void)audioRecorderFail {
    [self.indicatorView changeViewStatus:QMIndicatorStatusShort];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.indicatorView removeFromSuperview];
        [self changeButtonStatus:NO];
    });
}

#pragma mark - MoreView Action
//通过摄像头获取图片
- (void)photoBtnAction {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

//相机代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImage * myImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImageWriteToSavedPhotosAlbum(myImage, nil, nil, nil);
        [self sendImage:myImage];
    }
}

//从相册获取图片
- (void)takePicBtnAction {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:5 delegate:nil];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isStop) {
        for (UIImage *image in photos) {
            [self sendImage:image];
        }
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

// 获取文件
- (void)takeFileBtnAction {
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case PHAuthorizationStatusAuthorized: {
                    QMFileManagerController * fileViewController = [[QMFileManagerController alloc] init];
                    [self.navigationController pushViewController:fileViewController animated:true];
                }
                    break;
                case PHAuthorizationStatusDenied: {
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"title.prompt", nil) message: NSLocalizedString(@"title.photoAuthority", nil) preferredStyle: UIAlertControllerStyleAlert];
                    
                    UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"button.set", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if (UIApplicationOpenSettingsURLString != NULL) {
                            NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                            [[UIApplication sharedApplication] openURL:appSettings];
                        }
                    }];
                    
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"button.cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertController addAction:action];
                    [alertController addAction:cancelAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                    break;
                case PHAuthorizationStatusRestricted:
                    NSLog(@"相册访问受限!");
                    break;
                default:
                    break;
            }
        });
    }];
    
}

// 满意度评价
- (void)evaluateBtnAction {
    
    if (_isRobot) {
        
        if (alreadEvaluate) {
            return;
        }
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"评价机器人服务" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * resolvedAction = [UIAlertAction actionWithTitle:@"已解决" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pushSatisfaction:@"true" robotId:_intelligentRobot];
        }];
        [alertController addAction:resolvedAction];
        
        UIAlertAction * unsolvedAction = [UIAlertAction actionWithTitle:@"未解决" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pushSatisfaction:@"false" robotId:_intelligentRobot];
        }];
        [alertController addAction:unsolvedAction];
        
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else {
        [self createEvaluationView:NO];
    }
}

- (void)createEvaluationView:(BOOL)isPop {
    if (isShowEvaluateView) {
        return;
    }
    
    if (self.evaluation.evaluats.count == 0) {
        [QMAlert showMessage:@"未配置满意度"];
        if (isPop) {
            [self popVC];
        }
        return;
    }
    __weak typeof(self) weakSelf = self;
    
    [self.chatInputView showMoreView:NO];
    self.chatInputView.inputView.inputView = nil;
    [self.chatInputView.inputView endEditing:YES];
    keyboardIsShow = true;
    isShowEvaluateView = true;
    
    self.evaluationView = [[QMChatRoomEvaluationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.evaluationView.evaluation = self.evaluation;
    [self.evaluationView createUI];
    [self.view addSubview:self.evaluationView];
    
    self.evaluationView.cancelSelect = ^(){
        [weakSelf.evaluationView removeFromSuperview];
        keyboardIsShow = false;
        isShowEvaluateView = false;
        if (isPop) {
            [weakSelf popVC];
        }
    };
    
    self.evaluationView.sendSelect = ^(NSString *optionName, NSString *optionValue, NSArray *radioValue, NSString *textViewValue) {
        [QMConnect sdkNewSubmitInvestigate:optionName value:optionValue radioValue:radioValue remark:textViewValue successBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [QMAlert showMessage:weakSelf.evaluation.thank ?: NSLocalizedString(@"button.chat_thank", nil)];
                alreadEvaluate = YES;
                isShowEvaluateBtn = false;
                [weakSelf isShowEvaluateBtn:NO];
            });
        } failBlock:^{
            NSLog(@"评价失败");
            isShowEvaluateBtn = true;
            [weakSelf isShowEvaluateBtn:YES];
        }];
        [weakSelf.evaluationView removeFromSuperview];
        keyboardIsShow = false;
        isShowEvaluateView = false;
        if (isPop) {
            [weakSelf popVC];
        }
    };
}

#pragma mark - Send Message
// 发送文本
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqual:@"\n"]) {
        if (![_chatInputView.inputView.text isEqualToString:@""]) {
            NSString *text = [_chatInputView.inputView.textStorage getRichString];
            [self sendText:text];
            _chatInputView.inputView.text = @"";
            [self.associationView removeFromSuperview];
            isShowAssociatsView = NO;
            return NO;
        }
        return NO;
    }
    return  YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        if (isShowAssociatsInput) {
            NSString *robotType = [QMConnect sdkRobotType];
            robotType = [robotType isEqual: @""] ? @"xbot" : robotType;
            [QMConnect sdkSubmitXbotRobotAssociationInput:textView.text cateIds:_cateIdArr robotId:_intelligentRobot robotType:robotType successBlock:^(NSArray *questions){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (questions.count > 0) {
                        _questions = questions;
                        [self createQuestionView:questions];
                    }else {
                        _questions = @[];
                        [self.associationView removeFromSuperview];
                        isShowAssociatsView = NO;
                    }
                });
            } failBlock:^{
                [self.associationView removeFromSuperview];
                isShowAssociatsView = NO;
            }];
        }else {
            [self.associationView removeFromSuperview];
            isShowAssociatsView = NO;
        }
    }else {
        [self.associationView removeFromSuperview];
        isShowAssociatsView = NO;
    }
}

//xbot联想输入view
- (void)createQuestionView:(NSArray *)questions {
    __weak typeof(self) weakSelf = self;
    
    if (isShowAssociatsView) {
        [self.associationView showData:questions];
        return;
    }
    self.associationView = [[QMChatRoomAssociationInputView alloc] init];
    self.associationView.frame = CGRectMake(0, CGRectGetMinY(self.chatInputView.frame)-questions.count*50, kScreenWidth, questions.count*50);
    [self.associationView showData:questions];
    self.associationView.questionsSelect = ^(NSString *question) {
        [weakSelf sendText:question];
        weakSelf.chatInputView.inputView.text = @"";
        [weakSelf.associationView removeFromSuperview];
    };
    isShowAssociatsView = YES;
    [self.view addSubview:self.associationView];
}

//发送表情
- (void)sendBtnAction:(UIButton *)button  {
    if (![_chatInputView.inputView.text isEqualToString:@""]) {
        NSString *text = [_chatInputView.inputView.textStorage getRichString];
        [self sendText:text];
        _chatInputView.inputView.text = @"";
    }
}

- (void)sendText:(NSString *)text {
    [QMConnect sendMsgText:text successBlock:^{
        NSLog(@"发送成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createNSTimer];
            _isSpeak = true;
        });
    } failBlock:^{
        NSLog(@"发送失败");
    }];
}

// 发送图片
- (void)sendImage:(UIImage *)image {
    [QMConnect sendMsgPic:image successBlock:^{
        NSLog(@"图片发送成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createNSTimer];
            _isSpeak = true;
        });
    } failBlock:^{
        NSLog(@"图片发送失败");
    }];
}

// 发送语音
- (void)sendAudio:(NSString *)fileName duration:(NSString *)duration {
    NSString *filePath = [NSString stringWithFormat:@"%@.mp3", fileName];
    [QMConnect sendMsgAudio:filePath duration:duration successBlock:^{
        NSLog(@"语音发送成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createNSTimer];
            _isSpeak = true;
        });
    } failBlock:^() {
        NSLog(@"语音发送失败");
    }];
}

// 发送文件消息
- (void)sendFileMessageWithName:(NSString *)fileName AndSize:(NSString *)fileSize AndPath:(NSString *)filePath {
    [QMConnect sendMsgFile:fileName filePath:filePath fileSize:fileSize progressHander:^(float progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.upProgress = progress;
            [self.chatTableView reloadData];
        });
    } successBlock:^{
        NSLog(@"文件上传成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createNSTimer];
            self.upProgress = 0;
            _isSpeak = true;
        });
    } failBlock:^{
        NSLog(@"文件上传失败");
        dispatch_async(dispatch_get_main_queue(), ^{
            self.upProgress = 0;
        });
    }];
}

// 失败消息重新发送
- (void)resendAction:(QMTapGestureRecognizer *)gestureRecognizer {
    NSArray * dataArray = [[NSArray alloc] init];
    dataArray = [QMConnect getOneDataFromDatabase:gestureRecognizer.messageId];
    for (CustomMessage * custom in dataArray) {
        [QMConnect resendMessage:custom successBlock:^{
            NSLog(@"重新发送成功");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self createNSTimer];
                _isSpeak = true;
            });
        } failBlock:^{
            NSLog(@"重新发送失败");
        }];
    }
}

// 表情代理及相关处理
- (void)SendTheFaceStr:(NSString *)faceStr isDelete:(BOOL)dele {
    if (dele) {
        [_chatInputView.inputView deleteBackward];
    }else {
        [self insertEmoji:faceStr];
    }
}

- (void)insertEmoji: (NSString *)code {
    QMTextAttachment * emojiTextAttemt = [QMTextAttachment new];
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"QMEmoticon" ofType:@"bundle"];
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"expressionImage" ofType:@"plist"];
    NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:fileName];
    
    if ([plistDict objectForKey:code] != nil) {
        emojiTextAttemt.emojiCode = code;
        emojiTextAttemt.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", bundlePath, [plistDict objectForKey:code]]];
        emojiTextAttemt.bounds = CGRectMake(0, 0, 18, 18);
        
        NSAttributedString * attributeString = [NSAttributedString attributedStringWithAttachment:emojiTextAttemt];
        NSRange range = [_chatInputView.inputView selectedRange];
        if (range.length > 0) {
            [_chatInputView.inputView.textStorage deleteCharactersInRange:range];
        }
        
        [_chatInputView.inputView.textStorage insertAttributedString:attributeString atIndex:[_chatInputView.inputView selectedRange].location];
        _chatInputView.inputView.selectedRange = NSMakeRange(_chatInputView.inputView.selectedRange.location+1, 0);
    }
    
    [self resetTextStyle];
}

- (void)resetTextStyle {
    NSRange wholeRange = NSMakeRange(0, _chatInputView.inputView.textStorage.length);
    [_chatInputView.inputView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    [_chatInputView.inputView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:wholeRange];
    _chatInputView.inputView.font = [UIFont systemFontOfSize:18];
}

// 机器人帮助评价
- (void)sendRobotFeedback: (BOOL)isUseful questionId: (NSString *)questionId messageId: (NSString *)messageId robotType: (NSString *)robotType robotId: (NSString *)robotId robotMsgId: (NSString *)robotMsgId {
    __weak QMChatRoomViewController *weakSelf = self;
    [QMConnect sdkSubmitRobotFeedback:isUseful questionId:questionId messageId:messageId robotType:robotType robotId:robotId robotMsgId:robotMsgId successBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf getData];
            [weakSelf.chatTableView reloadData];
        });
    } failBlock:^{
        
    }];
}

// xbot机器人帮助评价
- (void)sendXbotRobotFeedback:(BOOL)isUseful message:(CustomMessage *)message {
    __weak QMChatRoomViewController *weakSelf = self;
    [QMConnect sdkSubmitXbotRobotFeedback:isUseful message:message successBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf getData];
            [weakSelf.chatTableView reloadData];
        });
    } failBlock:^{
        
    }];
}

#pragma mark - Multi Function
// 注销事件
- (void)logoutAction {
    if (!_isRobot && isShowEvaluateBtn) {
        [self createEvaluationView:YES];
    }else{
        [self popVC];
    }
}

- (void)popVC {
    _isSpeak = NO;
    alreadEvaluate = NO;
    [[QMAudioPlayer sharedInstance] stopAudioPlayer];
    [QMConnect logout];
    [self removeTimer];
    [self.navigationController popViewControllerAnimated:YES];
}

// 转人工客服
- (void)customClick {
    [QMConnect sdkConvertManual:^{
        NSLog(@"转人工客服成功");
    } failBlock:^{
        NSLog(@"转人工客服失败");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.isOpenSchedule == false) {
                [self showGuestBookViewController];
            }
        });
    }];
}

#pragma mark - 留言提示
- (void)showGuestBookViewController {
    [self.chatInputView setHidden:true];
    [self.manualButotn setHidden:true];
    self.chatTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - _navHeight);
    
    self.msg = [QMConnect leaveMessageAlert];
    if ([self.msg isEqualToString:@""]) {
        self.msg = NSLocalizedString(@"title.messageprompts", nil);
    }
    
    if ([QMConnect allowedLeaveMessage]) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"" message: self.msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"button.leaveMessage", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            QMChatRoomGuestBookViewController *guestBookViewController = [[QMChatRoomGuestBookViewController alloc] init];
            guestBookViewController.peerId = self.peerId;
            [self.navigationController pushViewController:guestBookViewController animated:YES];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"button.signOut", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self logoutAction];
        }];
        [alertView addAction:sureAction];
        [alertView addAction:cancel];
        [self presentViewController:alertView animated:YES completion:nil];
    }else {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"" message: self.msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"title.iknow", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertView addAction:cancel];
        [self presentViewController:alertView animated:YES completion:nil];
    }
}

#pragma mark - 客服代理方法
/// 当前客服状态
- (void)currentAgentStatus:(QMKStatus)status{
    switch (status) {
        case 0:
            _titleView.stateInfoLabel.text = NSLocalizedString(@"title.now_robit", nil);
            self.manualButotn.hidden = NO;
            break;
        case 1:
            _titleView.stateInfoLabel.text = NSLocalizedString(@"title.people_now", nil);
            self.manualButotn.hidden = YES;
            break;
        case 2:
            _titleView.stateInfoLabel.text = NSLocalizedString(@"title.people_isline", nil);
            self.manualButotn.hidden = NO;
            break;
        case 3:
            _titleView.stateInfoLabel.text = NSLocalizedString(@"title.people_now", nil);
            self.manualButotn.hidden = YES;
            break;
        case 4:
            _titleView.stateInfoLabel.text = NSLocalizedString(@"title.people_isleave", nil);
            self.manualButotn.hidden = YES;
            break;
        default:
            break;
    }
}

/// 当前坐席信息
- (void)currentAgentInfoWithAgent:(QMAgent * _Nonnull)agent {
    NSString *string = [NSString stringWithFormat:@"%@(%@)", agent.name, agent.exten];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    _titleView.nameLabel.text = [NSString stringWithFormat:@"%@",string];
}

/// 当前会话排队数
- (void)currentSessionWaitNumberWithNumber:(NSInteger)number {
    NSArray *array =  [QMConnect sdkQueueMessage];
    if (array.count == 2) {
        NSString *title = array[0];
        NSString *alp = array[1];
        NSString *replacedStr = [title stringByReplacingOccurrencesOfString:alp withString:[NSString stringWithFormat:@"%ld",(long)number]];
        _titleView.stateInfoLabel.text = replacedStr;
    } else if (array.count == 1) {
        NSString *title = array[0];
        _titleView.stateInfoLabel.text = title;
    }else {
        _titleView.stateInfoLabel.text = [NSString stringWithFormat:@"%@: %ld",NSLocalizedString(@"title.line_up", nil), (long)number];
    }
    self.manualButotn.hidden = YES;
}

#pragma mark - Push Notification
// 键盘通知
- (void)keyboardFrameChange: (NSNotification *)notification {
    NSDictionary * userInfo =  notification.userInfo;
    NSValue * value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect newFrame = [value CGRectValue];
    if (newFrame.origin.y == [UIScreen mainScreen].bounds.size.height) {
        [UIView animateWithDuration:0.3 animations:^{
            self.chatInputView.frame = CGRectMake(0, kScreenHeight-kInputViewHeight-_navHeight, kScreenWidth, kInputViewHeight);
            self.chatTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-_navHeight-kInputViewHeight);
        }];
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            if (!keyboardIsShow) {
                self.chatInputView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-kInputViewHeight-newFrame.size.height-_navHeight, kScreenWidth, kInputViewHeight);
                self.chatTableView.frame = CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height-_navHeight-kInputViewHeight-newFrame.size.height);
                [self scrollToEnd];
            }
        }];
    }
    self.associationView.frame = CGRectMake(0, CGRectGetMinY(self.chatInputView.frame)-_questions.count*50, kScreenWidth, _questions.count*50);
}

// 机器人客服
- (void)robotAction {
    NSLog(@"机器人客服");
    _titleView.stateInfoLabel.text = NSLocalizedString(@"title.now_robit", nil);
    if ([QMConnect manualButtonStatus]) {
        self.manualButotn.hidden = NO;
    } else {
        self.manualButotn.hidden = YES;
    }
    self.isRobot = YES;
    alreadEvaluate = NO;
    _isSpeak = NO;
    if (_isSpeak && isShowEvaluate && _isRobot && !alreadEvaluate) {
        self.addView.evaluateBtn.hidden = NO;
        self.addView.evaluateLabel.hidden = NO;
    }else{
        self.addView.evaluateBtn.hidden = YES;
        self.addView.evaluateLabel.hidden = YES;
    }
}

// 客服在线
- (void)customOnline {
    NSLog(@"客服在线");
    _titleView.stateInfoLabel.text = NSLocalizedString(@"title.people_now", nil);
    self.manualButotn.hidden = YES;
    self.isRobot = NO;
    alreadEvaluate = NO;
    [self createNSTimer];
    
    self.addView.evaluateBtn.hidden = YES;
    self.addView.evaluateLabel.hidden = YES;
}

// 客服离线
- (void)customOffline {
    NSLog(@"客服离线");
    self.manualButotn.hidden = NO;
    _titleView.stateInfoLabel.text = NSLocalizedString(@"title.people_isline", nil);
    if (!_isOpenSchedule) {
        [self showGuestBookViewController];
    }
}

// 会话领取
- (void)customClaim {
    NSLog(@"会话被坐席领取");
    _titleView.stateInfoLabel.text = NSLocalizedString(@"title.people_now", nil);
    self.manualButotn.hidden = YES;
    self.isRobot = NO;
    alreadEvaluate = NO;
    self.addView.evaluateBtn.hidden = YES;
    self.addView.evaluateLabel.hidden = YES;
}

// 离线推送 （坐席在后台结束会话，返回上一界面）
- (void)customFinish:(NSNotification *)notification {
    
    NSLog(@"客服结束会话");
    [self.chatInputView.inputView endEditing:YES];
    _titleView.stateInfoLabel.text = NSLocalizedString(@"title.people_isleave", nil);
    
    [self.chatInputView.coverView setHidden:NO];
    [QMManager defaultManager].isFinish = YES;
    
    alreadEvaluate = NO;
    _isSpeak = NO;
    isShowEvaluateBtn = NO;
    
    if ([notification.object isEqualToString:@"tapAction"]) {
        [self tapAction];
    }
    [self.associationView removeFromSuperview];
    isShowAssociatsView = NO;
}

// 继续咨询
- (void)tapAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"当前会话已关闭，是否重新开始会话" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *beginAction = [UIAlertAction actionWithTitle:@"开始会话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.chatInputView.coverView setHidden:YES];
        [QMManager defaultManager].isFinish = NO;
        
        [self getConfig];
    }];
    
    UIAlertAction *outAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.chatInputView.coverView setHidden:YES];
        [QMManager defaultManager].isFinish = NO;

        [self logoutAction];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:beginAction];
    [alertController addAction:outAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 排队人数
- (void)customQueue: (NSNotification *)notification {
    NSLog(@"排队人数 %@", notification.object);
    
    NSArray *array =  [QMConnect sdkQueueMessage];
    if (array.count == 2) {
        NSString *title = array[0];
        NSString *alp = array[1];
        NSString *replacedStr = [title stringByReplacingOccurrencesOfString:alp withString:[NSString stringWithFormat:@"%@",notification.object]];
        _titleView.stateInfoLabel.text = replacedStr;
    } else if (array.count == 1) {
        NSString *title = array[0];
        if ([title isEqualToString:@""]) {
            _titleView.stateInfoLabel.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"title.line_up", nil), notification.object];
        }else{
            _titleView.stateInfoLabel.text = title;
        }
    }else {
        _titleView.stateInfoLabel.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"title.line_up", nil), notification.object];
    }
    
    self.manualButotn.hidden = YES;
    self.addView.evaluateBtn.hidden = YES;
    self.addView.evaluateLabel.hidden = YES;
}

// 满意度推送
- (void)customInvestigate {
    NSLog(@"满意度通知");
    
    [self createEvaluationView:NO];
}

// 坐席信息 (坐席工号、坐席名称、坐席头像) 可能为空字符串需要判断
- (void)customAgentMessage: (NSNotification *)notification {
    QMAgent *agent = notification.object;
    NSString *string;
    if ([agent.type isEqualToString:@"robot"]) {
        string = [NSString stringWithFormat:@"%@", agent.name];
    }else if ([agent.type isEqualToString:@"activeClaim"]){
        string = [NSString stringWithFormat:@"%@(%@)", agent.name, agent.exten];
        [self customOnline];
    }else {
        string = [NSString stringWithFormat:@"%@(%@)", agent.name, agent.exten];
    }
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    _titleView.nameLabel.text = [NSString stringWithFormat:@"%@",string];
}

// 专属坐席不在线通知 调用接受其他坐席服务接口成功后调用 beginSession
- (void)customVIP {
    [QMAlert showMessage:NSLocalizedString(@"title.schedule_notonline", nil)];
    __weak QMChatRoomViewController * myChatView = self;
    [QMConnect sdkAcceptOtherAgentWithPeer:self.peerId successBlock:^{
        NSLog(@"成功");
        [myChatView beginSession];
    } failBlock:^{
        NSLog(@"失败");
        [QMAlert showMessage:NSLocalizedString(@"title.schedule_faile", nil)];
    }];
}

#pragma mark - 日程管理的留言
- (void)customLeavemsg: (NSNotification*)notification {
    NSArray *array = notification.object;
    NSString *str = array[0];
    [QMConnect sdkGetWebchatScheduleConfig:^(NSDictionary * _Nonnull scheduleDic) {
        dispatch_async(dispatch_get_main_queue(), ^{
            for (NSDictionary*dic in scheduleDic[@"leavemsgNodes"]) {
                if ([str isEqualToString:dic[@"_id"]]){
                    NSMutableArray *fieldArray = [NSMutableArray array];
                    for (id field in dic[@"leavemsgFields"]) {
                        if ([field[@"enable"] boolValue] == YES) {
                            [fieldArray addObject:field];
                        }
                    }
                    QMChatRoomGuestBookViewController *guestBookViewController = [[QMChatRoomGuestBookViewController alloc] init];
                    guestBookViewController.peerId = array[1];
                    guestBookViewController.contactFields = fieldArray;
                    guestBookViewController.headerTitle = dic[@"title"];
                    guestBookViewController.leaveMsg = dic[@"contentTip"];
                    guestBookViewController.isScheduleLeave = true;
                    [self.navigationController pushViewController:guestBookViewController animated:YES];
                }
            }
        });
    } failBlock:^{
        NSLog(@"日程管理进入留言失败");
    }];
}

- (void)beginSession {
    __weak QMChatRoomViewController * myChatView = self;
    [QMConnect sdkBeginNewChatSession:self.peerId successBlock:^(BOOL remark) {
        NSLog(@"开始会话成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            // 是否启动了评价功能
            if (remark == NO) {
                myChatView.addView.evaluateBtn.hidden = YES;
                myChatView.addView.evaluateLabel.hidden = YES;
            }else {
                myChatView.addView.evaluateBtn.hidden = NO;
                myChatView.addView.evaluateLabel.hidden = NO;
            }
        });
    } failBlock:^{
        NSLog(@"开始会话失败");
    }];
}

// 坐席正在输入
- (void)changeCustomStatus {
    if (![_titleView.stateInfoLabel.text  isEqual: NSLocalizedString(@"title.other_writing", nil)]) {
        NSString *str = _titleView.stateInfoLabel.text;
        _titleViewText = str;
    }
    _titleView.stateInfoLabel.text = NSLocalizedString(@"title.other_writing", nil);
    
    backStatus = nil;
    backStatus = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(backCustomStatus:) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:backStatus forMode:NSRunLoopCommonModes];
}

- (void)backCustomStatus:(NSTimer *)time{
    _titleView.stateInfoLabel.text = _titleViewText;
    [backStatus invalidate];
}

// 撤回消息
- (void)cbangeDrowMessageStatus: (NSNotification*)notification {
    NSString *messageId = notification.object;
    [QMConnect changeDrawMessageStatus:messageId];
    [self getData];
    [self reloadTableView];
}

// 小陌机器人是否开启满意度评价
- (void)customSatisfaction:(NSNotification *)notification {
    NSArray *arr = notification.object;
    
    if (arr[1]) {
        _intelligentRobot = arr[1];
    }
    
    if ([arr[0] isEqualToString:@"true"]) {
        isShowEvaluate = true;
        if (_isSpeak) {
            self.addView.evaluateBtn.hidden = NO;
            self.addView.evaluateLabel.hidden = NO;
        }
    }
}

// xbot机器人开启联想输入
- (void)customAssociatsInput:(NSNotification *)notification {
    NSArray *arr = notification.object;
    _cateIdArr = arr[1];
    isShowAssociatsInput = arr[0];
    _intelligentRobot = arr[2];
}

- (void)pushSatisfaction:(NSString *)faction robotId:(NSString *)robotId {
    NSString *robotType = [QMConnect sdkRobotType];
    if ([robotType isEqualToString:@"xbot"]) {
        [QMConnect sdkSubmitXbotRobotSatisfaction:faction successBlock:^{
            NSLog(@"评价成功");
            dispatch_async(dispatch_get_main_queue(), ^{
                [QMAlert showMessage:@"机器人评价成功"];
                alreadEvaluate = YES;
                self.addView.evaluateBtn.hidden = YES;
                self.addView.evaluateLabel.hidden = YES;
            });
        } failBlock:^{
            NSLog(@"评价失败");
            dispatch_async(dispatch_get_main_queue(), ^{
                [QMAlert showMessage:@"机器人评价失败"];
            });
        }];
    }else if ([robotType isEqualToString:@"7mbot_ai"]) {
        [QMConnect sdkSubmitIntelligentRobotSatisfaction:robotId satisfaction:faction successBlock:^{
            NSLog(@"评价成功");
            dispatch_async(dispatch_get_main_queue(), ^{
                [QMAlert showMessage:@"机器人评价成功"];
                alreadEvaluate = YES;
                self.addView.evaluateBtn.hidden = YES;
                self.addView.evaluateLabel.hidden = YES;
            });
        } failBlock:^{
            NSLog(@"评价失败");
            dispatch_async(dispatch_get_main_queue(), ^{
                [QMAlert showMessage:@"机器人评价失败"];
            });
        }];
    }else {
        [QMConnect sdkSubmitXbotRobotSatisfaction:faction successBlock:^{
            NSLog(@"评价成功");
            dispatch_async(dispatch_get_main_queue(), ^{
                [QMAlert showMessage:@"机器人评价成功"];
                alreadEvaluate = YES;
                self.addView.evaluateBtn.hidden = YES;
                self.addView.evaluateLabel.hidden = YES;
            });
        } failBlock:^{
            NSLog(@"评价失败");
            dispatch_async(dispatch_get_main_queue(), ^{
                [QMAlert showMessage:@"机器人评价失败"];
            });
        }];
    }
}

- (void)getConfig {
    NSLog(@"进入config");
    [QMConnect sdkGetWebchatScheduleConfig:^(NSDictionary * _Nonnull scheduleDic) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dictionary = scheduleDic;
            if ([self.dictionary[@"scheduleEnable"] intValue] == 1) {
                NSLog(@"日程管理");
                [self starSchedule];
            }else{
                NSLog(@"技能组");
                [self getPeers];
            }
        });
    } failBlock:^{
        [self getPeers];
    }];

}

#pragma mark - 技能组选择
- (void)getPeers {
    NSLog(@"进入getPeers");

    [QMConnect sdkGetPeers:^(NSArray * _Nonnull peerArray) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *peers = peerArray;
            if (peers.count == 1 && peers.count != 0) {
                [self setPropertyValue:[peers.firstObject objectForKey:@"id"] processType:@"" entranceId:@""];
            }else {
                [self showPeersWithAlert:peers messageStr:NSLocalizedString(@"title.type", nil)];
            }
        });
    } failureBlock:^{

    }];
}

#pragma mark - 日程管理
- (void)starSchedule {
    NSLog(@"进入starSchedule");
    if ([self.dictionary[@"scheduleId"]  isEqual: @""] || [self.dictionary[@"processId"]  isEqual: @""] || [self.dictionary objectForKey:@"entranceNode"] == nil || [self.dictionary objectForKey:@"leavemsgNodes"] == nil) {
        [QMAlert showMessage:NSLocalizedString(@"title.sorryconfigurationiswrong", nil)];
    }else{
        NSDictionary *entranceNode = self.dictionary[@"entranceNode"];
        NSArray *entrances = entranceNode[@"entrances"];
        if (entrances.count == 1 && entrances.count != 0) {
            [self setPropertyValue:[entrances.firstObject objectForKey:@"processTo"] processType:[entrances.firstObject objectForKey:@"processType"] entranceId:[entrances.firstObject objectForKey:@"_id"]];
        }else{
            [self showPeersWithAlert:entrances messageStr:NSLocalizedString(@"title.schedule_type", nil)];
        }
    }
}

- (void)showPeersWithAlert: (NSArray *)peers messageStr: (NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"title.type", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"button.cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.chatInputView.coverView setHidden:NO];
        [QMManager defaultManager].isFinish = YES;
    }];
    [alertController addAction:cancelAction];
    for (NSDictionary *index in peers) {
        UIAlertAction *surelAction = [UIAlertAction actionWithTitle:[index objectForKey:@"name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([self.dictionary[@"scheduleEnable"] integerValue] == 1) {
                [self setPropertyValue:[index objectForKey:@"processTo"] processType:[index objectForKey:@"processType"] entranceId:[index objectForKey:@"_id"]];
            }else{
                [self setPropertyValue:[index objectForKey:@"id"] processType:@"" entranceId:@""];
            }
        }];
        [alertController addAction:surelAction];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)setPropertyValue:(NSString *)peerId processType:(NSString *)processType entranceId:(NSString *)entranceId {

    self.peerId = peerId;
    if ([self.dictionary[@"scheduleEnable"] intValue] == 1) {
        self.isOpenSchedule = true;
        self.scheduleId = self.dictionary[@"scheduleId"];
        self.processId = self.dictionary[@"processId"];
        self.currentNodeId = peerId;
        self.processType = processType;
        self.entranceId = entranceId;
    }else{
        self.isOpenSchedule = false;
    }
    [self beginNewChat];
}

- (void)beginNewChat {
    __weak QMChatRoomViewController * myChatView = self;
    
    if (self.isOpenSchedule) {
        [QMConnect sdkBeginNewChatSessionSchedule: self.scheduleId processId: self.processId currentNodeId: self.currentNodeId entranceId: self.entranceId params: @{@"":@""} successBlock:^(BOOL remark) {
            NSLog(@"开始会话成功");
            dispatch_async(dispatch_get_main_queue(), ^{
                isRemark = remark;
                // 是否启动了评价功能
                if (self.isRobot) {
                    if ([QMConnect manualButtonStatus]) {
                        self.manualButotn.hidden = NO;
                    } else {
                        self.manualButotn.hidden = YES;
                    }
                    if (_isSpeak && isShowEvaluate && _isRobot && !alreadEvaluate) {
                        myChatView.addView.evaluateBtn.hidden = NO;
                        myChatView.addView.evaluateLabel.hidden = NO;
                    }
                }else{
                    self.manualButotn.hidden = YES;
                }
                
                [self.circleViews stopAnimating];
                [self.coverView removeFromSuperview];
            });
        } failBlock:^{
            NSLog(@"开始会话失败");
        }];
    }else{
        NSLog(@"sdk走技能组方法");
        [QMConnect sdkBeginNewChatSession:self.peerId params:@{@"customField":@{@"扩展信息key":@"扩展信息value",},@"agent":@"1235"} successBlock:^(BOOL remark) {
            NSLog(@"开始会话成功");
            dispatch_async(dispatch_get_main_queue(), ^{
                isRemark = remark;
                // 是否启动了评价功能
                if (self.isRobot) {
                    if ([QMConnect manualButtonStatus]) {
                        self.manualButotn.hidden = NO;
                    } else {
                        self.manualButotn.hidden = YES;
                    }
                    if (_isSpeak && isShowEvaluate && _isRobot && !alreadEvaluate) {
                        myChatView.addView.evaluateBtn.hidden = NO;
                        myChatView.addView.evaluateLabel.hidden = NO;
                    }
                }else{
                    self.manualButotn.hidden = YES;
                }
                [self.circleViews stopAnimating];
                [self.coverView removeFromSuperview];
            });
        } failBlock:^{
            NSLog(@"开始会话失败");
        }];
        
    }
    self.isPush = YES;
}


// 访客无响应断开计时(开启无响应断开的需要把方法中的代码放开)
- (void)createNSTimer{
    NSLog(@"开启无响应定时器");
        [self removeTimer];
        self.breakDuration = [QMConnect breakSessionDuration];
        self.breakTipsDuration = [QMConnect breakSessionAlertDuration];
        if (self.breakDuration && self.breakTipsDuration && [QMConnect allowedBreakSession]) {
            breakTipTimer = [NSTimer scheduledTimerWithTimeInterval:self.breakTipsDuration * 60 target:self selector:@selector(breakTipTimerAction:) userInfo:nil repeats:NO];
            breakTimer = [NSTimer scheduledTimerWithTimeInterval:self.breakDuration * 60 target:self selector:@selector(breakTimerAction:) userInfo:nil repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:breakTimer forMode:NSRunLoopCommonModes];
            [[NSRunLoop mainRunLoop] addTimer:breakTipTimer forMode:NSRunLoopCommonModes];
        }
}

- (void)removeTimer {
    if (breakTipTimer) {
        [breakTipTimer invalidate];
        breakTipTimer = nil;
    }
    if (breakTimer) {
        [breakTimer invalidate];
        breakTimer = nil;
    }
}

- (void)breakTimerAction:(NSTimer *)time{
    [self.chatInputView setHidden:true];
    [self.manualButotn setHidden:true];
    self.chatTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - _navHeight);
}

- (void)breakTipTimerAction:(NSTimer *)timer{
    [QMAlert showMessage:[QMConnect breakSessionAlert]];
    [breakTipTimer invalidate];
}

- (void)isShowEvaluateBtn:(BOOL)speek {
    if (speek) {
        self.addView.evaluateBtn.hidden = NO;
        self.addView.evaluateLabel.hidden = NO;
    }else {
        self.addView.evaluateBtn.hidden = YES;
        self.addView.evaluateLabel.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
