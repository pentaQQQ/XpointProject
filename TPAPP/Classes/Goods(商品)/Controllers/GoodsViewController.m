//
//  GoodsViewController.m
//  TPAPP
//
//  Created by 上海点硕 on 2017/7/18.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "GoodsViewController.h"
#import "messageHeaderView.h"
#import "TPMessageCell.h"
#import "messageHeaderView.h"
#import "SystemInformationController.h"
#import "TransportationMessageViewController.h"







#import "QMChatRoomViewController.h"
#import <QMChatSDK/QMChatSDK.h>
#import <QMChatSDK/QMChatSDK-Swift.h>

#import "QMChatRoomGuestBookViewController.h"
#import "QMAlert.h"
#import "QMManager.h"



@interface GoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSMutableArray*dataArr;








@property (nonatomic, copy) NSDictionary * dictionary;
@property (nonatomic, assign) BOOL isPushed;
@property (nonatomic, assign) BOOL isConnecting;

@end

@implementation GoodsViewController
-(NSMutableArray*)dataArr{
    
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self setUpUI];
    
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerSuccess:) name:CUSTOM_LOGIN_SUCCEED object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerFailure:) name:CUSTOM_LOGIN_ERROR_USER object:nil];
    
    
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CUSTOM_LOGIN_SUCCEED object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CUSTOM_LOGIN_ERROR_USER object:nil];
}
-(void)setUpUI{
   
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-SafeAreaBottomHeight) style:UITableViewStylePlain];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    
    
 
    messageHeaderView *header = [[NSBundle mainBundle]loadNibNamed:@"messageHeaderView" owner:self options:nil].lastObject;
    
    header.frame = CGRectMake(0, 0, kScreenWidth, 80);
    self.tableview.tableHeaderView =header;
    __weak __typeof(self) weakSelf = self;

    header.messageBlock = ^{
        SystemInformationController*vc = [[SystemInformationController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    header.wuliuBlock = ^{
        TransportationMessageViewController*vc = [[TransportationMessageViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    
    
    
    self.tableview.tableFooterView = [UIView new];

    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *reuesId = @"TPMessageCell";
    TPMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TPMessageCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     [QMConnect registerSDKWithAppKey:@"5f12e670-c334-11e8-b0e0-5f753912b765" userName:@"8001" userId:@"8001_id"];
    
    
}









- (void)registerSuccess:(NSNotification *)sender {
    NSLog(@"注册成功");
    
    if ([QMManager defaultManager].selectedPush) {
        [self showChatRoomViewController:@"" processType:@"" entranceId:@""]; //
    }else{
        
        // 页面跳转控制
        if (self.isPushed) {
            return;
        }
        
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
    
    [QMManager defaultManager].selectedPush = NO;
    
    
}

- (void)registerFailure:(NSNotification *)sender {
    NSLog(@"注册失败::%@", sender.object);
    self.isConnecting = NO;
//    [self.indicatorView stopAnimating];
}





#pragma mark - 跳转聊天界面
- (void)showChatRoomViewController:(NSString *)peerId processType:(NSString *)processType entranceId:(NSString *)entranceId {
    QMChatRoomViewController *chatRoomViewController = [[QMChatRoomViewController alloc] init];
    chatRoomViewController.peerId = peerId;
    chatRoomViewController.isPush = NO;
    chatRoomViewController.avaterStr = @"";
    if ([self.dictionary[@"scheduleEnable"] intValue] == 1) {
        chatRoomViewController.isOpenSchedule = true;
        chatRoomViewController.scheduleId = self.dictionary[@"scheduleId"];
        chatRoomViewController.processId = self.dictionary[@"processId"];
        chatRoomViewController.currentNodeId = peerId;
        chatRoomViewController.processType = processType;
        chatRoomViewController.entranceId = entranceId;
    }else{
        chatRoomViewController.isOpenSchedule = false;
    }
    [self.navigationController pushViewController:chatRoomViewController animated:YES];
}



#pragma mark - 日程管理
- (void)starSchedule {
    self.isConnecting = NO;
   
    if ([self.dictionary[@"scheduleId"]  isEqual: @""] || [self.dictionary[@"processId"]  isEqual: @""] || [self.dictionary objectForKey:@"entranceNode"] == nil || [self.dictionary objectForKey:@"leavemsgNodes"] == nil) {
        [QMAlert showMessage:NSLocalizedString(@"title.sorryconfigurationiswrong", nil)];
    }else{
        NSDictionary *entranceNode = self.dictionary[@"entranceNode"];
        NSArray *entrances = entranceNode[@"entrances"];
        if (entrances.count == 1 && entrances.count != 0) {
            [self showChatRoomViewController:[entrances.firstObject objectForKey:@"processTo"] processType:[entrances.firstObject objectForKey:@"processType"] entranceId:[entrances.firstObject objectForKey:@"_id"]];
        }else{
            [self showPeersWithAlert:entrances messageStr:NSLocalizedString(@"title.schedule_type", nil)];
        }
    }
}




- (void)showPeersWithAlert: (NSArray *)peers messageStr: (NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"title.type", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"button.cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.isConnecting = NO;
    }];
    [alertController addAction:cancelAction];
    for (NSDictionary *index in peers) {
        UIAlertAction *surelAction = [UIAlertAction actionWithTitle:[index objectForKey:@"name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([self.dictionary[@"scheduleEnable"] integerValue] == 1) {
                [self showChatRoomViewController:[index objectForKey:@"processTo"] processType:[index objectForKey:@"processType"] entranceId:[index objectForKey:@"_id"]];
            }else{
                [self showChatRoomViewController:[index objectForKey:@"id"] processType:@"" entranceId:@""];
            }
        }];
        [alertController addAction:surelAction];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}



#pragma mark - 技能组选择
- (void)getPeers {
    [QMConnect sdkGetPeers:^(NSArray * _Nonnull peerArray) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *peers = peerArray;
            self.isConnecting = NO;
//            [_indicatorView stopAnimating];
            if (peers.count == 1 && peers.count != 0) {
                [self showChatRoomViewController:[peers.firstObject objectForKey:@"id"] processType:@"" entranceId:@""];
            }else {
                [self showPeersWithAlert:peers messageStr:NSLocalizedString(@"title.type", nil)];
            }
        });
    } failureBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.indicatorView stopAnimating];
            self.isConnecting = NO;
        });
    }];
}



@end
