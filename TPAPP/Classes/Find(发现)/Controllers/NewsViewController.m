//
//  NewsViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//
#define   TOPBAR_HEIGHT       ([[UIApplication sharedApplication] statusBarFrame].size.height + [UINavigationController new].navigationBar.frame.size.height)
#import "NewsViewController.h"
#import "MomentCell.h"
#import "Moment.h"
#import "Comment.h"

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource,MomentCellDelegate,UITextViewDelegate,UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) UIDocumentInteractionController *docuController;

@property (nonatomic, strong) NSMutableArray *momentList;
@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UIView *tableHeaderView;
//@property (nonatomic, strong) UIImageView *coverImageView;
//@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, assign) NSInteger selectedSection;
@property (nonatomic, strong) UITextView *kTextView;
@property (nonatomic, strong) UIView *kInputView;
@property (nonatomic, assign) CGFloat kInputHeight;

@property (nonatomic, strong) MomentCell *cell;
@end

@implementation NewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = @"好友动态";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"moment_camera"] style:UIBarButtonItemStylePlain target:self action:@selector(addMoment)];
    
    [self initTestInfo];
    [self setUpUI];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.kInputHeight = 50;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self addInputView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideKeyBoard];
    [self.kInputView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)startComment {
    [self.kTextView becomeFirstResponder];
}
// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hideKeyBoard];
}
- (void)hideKeyBoard {
    [self.kTextView resignFirstResponder];
}
- (void)addInputView {
    self.kInputView = [UIView new];
    _kInputView.backgroundColor = colorWithRGB(0xeeeeee);
    [[UIApplication sharedApplication].keyWindow addSubview:_kInputView];
    [_kInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.left.right.equalTo([UIApplication sharedApplication].keyWindow);
        make.bottom.equalTo(@(self.kInputHeight));
    }];
    
    self.kTextView = [UITextView new];
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"添加评论";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [self.kTextView addSubview:placeHolderLabel];
    placeHolderLabel.font = [UIFont systemFontOfSize:16.f];
    [self.kTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    _kTextView.backgroundColor = [UIColor whiteColor];
    _kTextView.layer.cornerRadius = 5;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _kTextView.typingAttributes = attributes;
    _kTextView.returnKeyType = UIReturnKeySend;
    _kTextView.delegate = self;
    [_kInputView addSubview:_kTextView];
    [_kTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@7);
        make.bottom.equalTo(@(-7));
        make.left.equalTo(@14);
        make.right.equalTo(@(-14));
    }];
}
#pragma mark - 测试数据
- (void)initTestInfo
{
    self.momentList = [[NSMutableArray alloc] init];
    NSMutableArray *commentList = nil;
    for (int i = 0;  i < 10; i ++)  {
        // 评论
        commentList = [[NSMutableArray alloc] init];
        int num = arc4random()%5 + 1;
        for (int j = 0; j < num; j ++) {
            Comment *comment = [[Comment alloc] init];
            comment.userName = @"胡一菲";
            comment.text = @"天界大乱，九州屠戮，当初被推下地狱的她已经浴火归来.";
            comment.time = 1487649503;
            comment.pk = j;
            [commentList addObject:comment];
        }
        
        Moment *moment = [[Moment alloc] init];
        moment.commentList = commentList;
        //        moment.praiseNameList = @"胡一菲，唐悠悠，陈美嘉，吕小布，曾小贤，张伟，关谷神奇";
        moment.userName = @"Jeanne";
        moment.time = [[NSString stringWithFormat:@"1535%d31852",i] longLongValue];
  
        if (i== 0) {
            moment.fileCount = 1;
           
        }else{
            moment.fileCount = i;
        }
            
        moment.singleWidth = 500;
        moment.singleHeight = 315;
        //        moment.location = @"北京 · 西单";
        if (i == 5) {
            moment.commentList = nil;
            moment.praiseNameList = nil;
            moment.text = @"蜀绣又名“川绣”，是在丝绸或其他织物上采用蚕丝线绣出花纹图案的中国传统工艺，18107891687主要指以四川成都为中心的川西平原一带的刺绣。😁蜀绣最早见于西汉的记载，当时的工艺已相当成熟，同时传承了图案配色鲜艳、常用红绿颜色的特点。😁蜀绣又名“川绣”，是在丝绸或其他织物上采用蚕丝线绣出花纹图案的中国传统工艺，https://www.baidu.com，主要指以四川成都为中心的川西平原一带的刺绣。蜀绣最早见于西汉的记载，当时的工艺已相当成熟，同时传承了图案配色鲜艳、常用红绿颜色的特点。";
            moment.fileCount = 1;
        } else if (i == 1) {
            moment.text = @"天界大乱，九州屠戮，当初被推下地狱的她已经浴火归发大水发士大夫撒打发斯蒂芬斯蒂芬；啥反垄断法发大水发生的发生大幅度发剑指仙界'你们杀了他，我便覆了你的天，毁了你的界，永世不得超生又如何！";
            moment.fileCount = arc4random()%10;
            moment.praiseNameList = nil;
        } else if (i == 2) {
            moment.text = @"十分大法师打发斯蒂芬打法是否打算的发送到发送到发送到发送到发送到发生大阿斯顿发沙发舒服的的撒打法是否达到事发地上的发生发的所发生的发的说法是打发的范德萨大大盯上了；大胜靠德就按士大夫撒地方斯蒂芬是规范等十多个收费规定是否给对方是个发生的撒旦飞洒的发送到发送到发送到发士大夫士大夫发送；鲁大师的；就奥斯卡大师大师大师的天界大乱，九州屠戮，当初被推下地狱cheerylau@126.com的她已经浴火归来，😭剑指仙界'你们杀了他，我便覆了你的天，毁了你的界，永世不得超生又如何！👍👍";
            moment.fileCount = 9;
        } else {
            moment.text = @"大大盯上了；大胜靠德就按士大夫撒地方斯蒂芬是规范等十多个收费规定是否给对方是个发生的撒旦飞洒的发送到发送到发送到发士大夫士大夫发送；鲁大师的；就奥斯卡大师大师大师的天界大乱，九州屠戮，当初被推下地狱cheerylau@126.com的她已经浴火归来，😭剑指仙界'你们杀了他，我便覆了你的天，毁了你的界，永世不得超生又如何！👍👍";
//            moment.fileCount = arc4random()%10;
        }
        [self.momentList addObject:moment];
    }
}

#pragma mark - UI
- (void)setUpUI
{
    // 表格
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, k_screen_width, k_screen_height-k_top_height-self.tabBarController.tabBar.bounds.size.height)];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    tableView.separatorInset = UIEdgeInsetsZero;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [UIView new];
    //    tableView.tableHeaderView = self.tableHeaderView;
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
}


#pragma mark - MomentCellDelegate
// 点击用户头像
- (void)didClickProfile:(MomentCell *)cell
{
    NSLog(@"击用户头像");
}

// 点赞
- (void)didLikeMoment:(MomentCell *)cell
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _docuController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"测试头像" ofType:@"jpeg"]]];
        _docuController.delegate = self;
        [_docuController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    });
    
    NSLog(@"转发");
}

// 评论
- (void)didAddComment:(MomentCell *)cell
{
//    self.selectedSection = section;
//    CircleItem *item = self.dataMuArr[section];
//    self.toPeople = @{
//                      @"comment_to_user_id": @(item.user_id),
//                      @"comment_to_user_name": item.user_name,
//                      };
    self.cell = cell;
    [self startComment];
    NSLog(@"评论");
}
// 保存到相册
- (void)saveVideoComment:(MomentCell *)cell
{
    NSLog(@"保存到相册");
}
// 查看全文/收起
- (void)didSelectFullText:(MomentCell *)cell
{
    NSLog(@"全文/收起");
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

// 删除
- (void)didDeleteMoment:(MomentCell *)cell
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 取消
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 删除
        [self.momentList removeObject:cell.moment];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"删除");
}

// 选择评论
- (void)didSelectComment:(Comment *)comment
{
    NSLog(@"点击评论");
}

// 点击高亮文字
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText
{
    NSLog(@"点击高亮文字：%@",linkText);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.momentList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MomentCell";
    MomentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MomentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.moment = [self.momentList objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 使用缓存行高，避免计算多次
    Moment *moment = [self.momentList objectAtIndex:indexPath.row];
    return moment.rowHeight;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSIndexPath *indexPath =  [self.tableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    MomentCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.menuView.show = NO;
}
#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 5000) { // 限制5000字内
        textView.text = [textView.text substringToIndex:5000];
    }
    static CGFloat maxHeight = 36 + 24 * 2;//初始高度为36，每增加一行，高度增加24
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height >= maxHeight) {
        size.height = maxHeight;
        textView.scrollEnabled = YES;   // 允许滚动
    } else {
        textView.scrollEnabled = NO;    // 不允许滚动
    }
    if ((ceil(size.height) + 14) != self.kInputHeight) {
        CGPoint offset = self.tableView.contentOffset;
        CGFloat delta = ceil(size.height) + 14 - self.kInputHeight;
        offset.y += delta;
        if (offset.y < 0) {
            offset.y = 0;
        }
        [self.tableView setContentOffset:offset animated:NO];
        self.kInputHeight = ceil(size.height) + 14;
        [self.kInputView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(ceil(size.height) + 14));
        }];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        if (self.kTextView.text.length > 0) {     // send Text
            [self sendMessage:self.kTextView.text];
        }
        [self.kInputView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
        }];
        [self.kTextView setText:@""];
        self.kInputHeight = 50;
        [self hideKeyBoard];
        return NO;
    }
    return YES;
}
- (void)sendMessage:(NSString *)text {
//    CircleItem *item = self.dataMuArr[self.selectedSection];
//    NSDictionary *dic = @{
//                          @"commet_id": @10,
//                          @"comment_user_id": @(USER_ID),
//                          @"comment_user_name": USER_NAME,
//                          @"comment_text": text,
//                          @"comment_to_user_id": [_toPeople valueForKey:@"comment_to_user_id"],
//                          @"comment_to_user_name": [_toPeople valueForKey:@"comment_to_user_name"],
//                          };
//    NSMutableArray *comments = [NSMutableArray arrayWithArray:item.comments];
//    [comments addObject:dic];
//    item.comments = [comments copy];
//    [[FriendCircleViewModel new] calculateItemHeight:item];
    Moment *moment = self.cell.moment;
    NSMutableArray *arr = [NSMutableArray arrayWithArray:moment.commentList];
    Comment *comment = [[Comment alloc] init];

    comment.userName = @"我";
    comment.text = text;
    comment.time = 1487649503;
    comment.pk = 1;

    comment.userName = @"我自己";
    comment.text = text;
    comment.time = 1487649503;
    comment.pk = 1000;

    [arr addObject:comment];
    moment.commentList = [arr copy];
    NSIndexPath *indexPath=[self.tableView indexPathForCell:(MomentCell *)self.cell];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark - 通知方法

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    // 1,取出键盘动画的时间
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2,取得键盘将要移动到的位置的frame
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 3,计算kInputView需要平移的距离
    CGFloat moveY = self.view.frame.size.height + TOPBAR_HEIGHT - keyboardFrame.origin.y+44;
    // 4,执行动画
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    SectionHeaderView *headerView = (SectionHeaderView *)[self.tableView headerViewForSection:self.selectedSection];
    CGRect rect = [self.cell.superview convertRect:self.cell.frame toView:window];
    Moment *item = self.momentList[self.selectedSection];
//    CGFloat cellHeight = item.rowHeight;
//    for (NSNumber *num in item.commentHeightArr) {
//        cellHeight += [num floatValue];
//    }
    CGFloat footerMaxY =CGRectGetMaxY(rect);
    CGFloat delta = footerMaxY - ((MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) - (moveY + self.kInputHeight));
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    [self.tableView setContentOffset:offset animated:NO];
    [self.kInputView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (moveY == 0) {
            make.bottom.equalTo(@(self.kInputHeight));
        } else {
            make.bottom.equalTo(@(-moveY));
        }
    }];
    [UIView animateWithDuration:duration animations:^{
        [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
    }];
}

//- (void)dealloc {
//    [self.kInputView removeFromSuperview];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
//    NSLog(@"132132321123231%@--dealloc",[self class]);
//}
#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
