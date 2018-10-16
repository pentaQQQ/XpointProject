//
//  QMChatRoomRobotCell.m
//  IMSDK-OC
//
//  Created by haochongfeng on 2018/1/23.
//  Copyright © 2018年 HCF. All rights reserved.
//

#import "QMChatRoomRobotCell.h"
#import "QMChatRoomRobotReplyView.h"
#import <QMChatSDK/QMChatSDK.h>
#import "QMTextModel.h"
#import "QMTapGestureRecognizer.h"
#import "QMChatRoomShowImageController.h"

@interface QMChatRoomRobotCell() <MLEmojiLabelDelegate>

@end

@implementation QMChatRoomRobotCell
{
    NSString *_messageId;
    
    QMChatRoomRobotReplyView *_replyView;
    
    // 内容高度
    CGFloat height;
    
    // 内容宽度
    CGFloat width;
    
    // 链接集合
    NSMutableArray *srcArrs;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        srcArrs = [NSMutableArray array];
    }
    return self;
}

- (void)setData:(CustomMessage *)message avater:(NSString *)avater {
    self.message = message;
    _messageId = message._id;
    [super setData:message avater:avater];
    
    [srcArrs removeAllObjects];
    
    
    if ([message.fromType isEqualToString:@"1"]) {
        height = 10;
        width = 0;
        
        for(UIView *view in self.chatBackgroudImage.subviews){
            if(view){
                [view removeFromSuperview];
            }
        }
        
        //html标签替换
        message.message = [message.message stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        message.message = [message.message stringByReplacingOccurrencesOfString:@"</br>" withString:@"\n"];
        message.message = [message.message stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
        NSMutableArray * srcArr = [self showHtml:message.message];
        
        //获取分段类型 文本 图片
        for (QMTextModel *model in srcArr) {
            if ([model.type isEqualToString:@"text"]) {
                [self createLabel:model.content];
            }else {
                [self createImage:model.content];
            }
        }
        
        //机器人评价
        _replyView = [[QMChatRoomRobotReplyView alloc] init];
        _replyView.backgroundColor = [UIColor clearColor];
        [_replyView.helpBtn addTarget:self action:@selector(helpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_replyView.noHelpBtn addTarget:self action:@selector(noHelpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.chatBackgroudImage addSubview:_replyView];
        if ([message.isRobot isEqualToString:@"1"] && ![message.questionId isEqualToString:@""]) {
            [_replyView setHidden:NO];
            if (message.isUseful) {
                _replyView.status = message.isUseful;
                if ([message.isUseful isEqualToString:@"none"]) {
                    _replyView.frame = CGRectMake(10, height + 5, [UIScreen mainScreen].bounds.size.width - 150, 25);
                    self.chatBackgroudImage.frame = CGRectMake(CGRectGetMaxX(self.iconImage.frame)+5, CGRectGetMaxY(self.timeLabel.frame)+10, [UIScreen mainScreen].bounds.size.width-130, height+15 + 30);
                }else {
                    _replyView.frame = CGRectMake(10, height + 5, [UIScreen mainScreen].bounds.size.width - 150, 55);
                    self.chatBackgroudImage.frame = CGRectMake(CGRectGetMaxX(self.iconImage.frame)+5, CGRectGetMaxY(self.timeLabel.frame)+10, [UIScreen mainScreen].bounds.size.width-130, height+15 + 60);
                }
            }else {
                _replyView.status = @"none";
                _replyView.frame = CGRectMake(10, height + 5, [UIScreen mainScreen].bounds.size.width - 150, 25);
                self.chatBackgroudImage.frame = CGRectMake(CGRectGetMaxX(self.iconImage.frame)+5, CGRectGetMaxY(self.timeLabel.frame)+10, [UIScreen mainScreen].bounds.size.width-130, height+15 + 30);
            }
        }else {
            [_replyView setHidden:YES];
            _replyView.frame = CGRectZero;
            self.chatBackgroudImage.frame = CGRectMake(CGRectGetMaxX(self.iconImage.frame)+5, CGRectGetMaxY(self.timeLabel.frame)+10, width+30, height+15);
        }
    }
}

// 创建文本
- (void)createLabel: (NSString *)text {
    NSMutableArray *array = [self getAHtml:text];
    NSRegularExpression *regularExpretion = [[NSRegularExpression alloc] initWithPattern:@"<[^>]*>" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *tempString = [regularExpretion stringByReplacingMatchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, text.length) withTemplate:@""];
    
    MLEmojiLabel *tLabel = [MLEmojiLabel new];
    tLabel.numberOfLines = 0;
    tLabel.font = [UIFont systemFontOfSize:14.0f];
    tLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    tLabel.delegate = self;
    tLabel.disableEmoji = NO;
    tLabel.disableThreeCommon = NO;
    tLabel.isNeedAtAndPoundSign = YES;
    tLabel.customEmojiRegex = @"\\:[^\\:]+\\:";
    tLabel.customEmojiPlistName = @"expressionImage.plist";
    tLabel.customEmojiBundleName = @"QMEmoticon.bundle";
    [self.chatBackgroudImage addSubview:tLabel];
    
    tLabel.checkResults = array;
    tLabel.checkColor = [UIColor colorWithRed:32/255.0f green:188/255.0f blue:158/255.0f alpha:1];
    
    tLabel.text = tempString;
    
    // labelFrame
    CGSize size = [tLabel preferredSizeWithMaxWidth: [UIScreen mainScreen].bounds.size.width - 160];
    tLabel.frame = CGRectMake(15, height, size.width, size.height);
    
    // 宽高适配
    height += size.height;
    width = width > size.width ? width : size.width;
}

// 创建图片 图片大小可调整
- (void)createImage: (NSString *)imageUrl {
    
    NSArray *temArray = nil;
    if ([imageUrl rangeOfString:@"src=\""].location != NSNotFound) {
        temArray = [imageUrl componentsSeparatedByString:@"src=\""];
    }else if ([imageUrl rangeOfString:@"src="].location != NSNotFound) {
        temArray = [imageUrl componentsSeparatedByString:@"src="];
    }

    if (temArray.count >= 2) {
        NSString *src = temArray[1];
        
        NSUInteger loc = [src rangeOfString:@"\""].location;
        if (loc != NSNotFound) {
            
            // 图片地址
            src = [src substringToIndex:loc];
            src = [src stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(15, height, 140, 100);
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            [self.chatBackgroudImage addSubview:imageView];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:src] placeholderImage:[UIImage imageNamed:@"icon"]];
            
            QMTapGestureRecognizer * tapPressGesture = [[QMTapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressGesture:)];
            tapPressGesture.picName = src;
            tapPressGesture.picType = @"1";
            tapPressGesture.image = imageView.image;
            [imageView addGestureRecognizer:tapPressGesture];

            height += 100;
        }
    }
}

#pragma mark 文本处理
- (NSMutableArray *)showHtml: (NSString *)htmlString {
    // 拆分文本和图片
    __block NSString *tempString = htmlString;
    __block NSMutableArray *srcArr = [NSMutableArray array];
    
    NSRegularExpression *regularExpretion = [[NSRegularExpression alloc] initWithPattern:@"<[^>]*>" options:NSRegularExpressionCaseInsensitive error:nil];
    [regularExpretion enumerateMatchesInString:htmlString options:NSMatchingReportProgress range:NSMakeRange(0, [htmlString length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        if (result.range.length != 0) {
            // 字符串
            NSString *actionString = [NSString stringWithFormat:@"%@",[htmlString substringWithRange:result.range]];
            
            // 新的range
            NSRange range = [tempString rangeOfString:actionString];
            
            NSArray *components = nil;
            if ([actionString rangeOfString:@"<img src=\""].location != NSNotFound) {
                components = [actionString componentsSeparatedByString:@"src=\""];
            }else if ([actionString rangeOfString:@"<img src="].location != NSNotFound) {
                components = [actionString componentsSeparatedByString:@"src="];
            }
            if (components.count >= 2) {
                // 文本内容
                QMTextModel *model1 = [[QMTextModel alloc] init];
                model1.type = @"text";
                model1.content = [tempString substringToIndex:range.location];
                [srcArr addObject:model1];
                
                // 图片内容
                QMTextModel *model2 = [[QMTextModel alloc] init];
                model2.type = @"image";
                model2.content = [tempString substringWithRange:range];;
                [srcArr addObject:model2];
                tempString = [tempString substringFromIndex:range.location+range.length];
            }
        }
    }];
    
    QMTextModel *model3 = [[QMTextModel alloc] init];
    model3.type = @"text";
    model3.content = tempString;
    [srcArr addObject:model3];
    
    return srcArr;
}

- (NSMutableArray *)getAHtml: (NSString *)htmlString {
    // 文本匹配A标签
    __block NSString *tempString = htmlString;
    __block NSMutableArray *srcArr = [NSMutableArray array];
    __block int length = 0;

    NSRegularExpression *regularExpretion = [[NSRegularExpression alloc] initWithPattern:@"<a href=(?:.*?)>(.*?)</a>" options:NSRegularExpressionCaseInsensitive error:nil];
    [regularExpretion enumerateMatchesInString:htmlString options:NSMatchingReportProgress range:NSMakeRange(0, [htmlString length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        if (result.range.length != 0) {
            NSRegularExpression *regularExpretion1 = [[NSRegularExpression alloc] initWithPattern:@"<[^>]*>" options:NSRegularExpressionCaseInsensitive error:nil];
            
            QMTextModel *model = [[QMTextModel alloc] init];

            // 获取高亮字符串
            NSString *actionString = [NSString stringWithFormat:@"%@",[htmlString substringWithRange:result.range]];
            // 获取链接 actionString -> https
            NSArray *components = [actionString componentsSeparatedByString:@"href=\""];
            if (components.count > 1) {
                NSString *src = components[1];
                NSUInteger loc = [src rangeOfString:@"\""].location;
                if (loc != NSNotFound) {
                    // 地址
                    src = [src substringToIndex:loc];
                    src = [src stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                    model.content = src;
                }
            }
            
            actionString = [regularExpretion1 stringByReplacingMatchesInString:actionString options:NSMatchingReportProgress range:NSMakeRange(0, actionString.length) withTemplate:@""];

            // 获取高亮range 防止重复
            actionString = [NSString stringWithFormat:@">%@<", actionString];
            model.type = actionString;
            
            NSRange range = [tempString rangeOfString:actionString];
            // 高亮之前的字符串
            if (tempString.length > range.location+1) {
                NSString *preString = [tempString substringToIndex:range.location+1];

                preString = [regularExpretion1 stringByReplacingMatchesInString:preString options:NSMatchingReportProgress range:NSMakeRange(0, preString.length) withTemplate:@""];
            
                actionString = [NSString stringWithFormat:@"at->%@",actionString];
                NSTextCheckingResult *aResult = [NSTextCheckingResult correctionCheckingResultWithRange:NSMakeRange(preString.length+length, range.length-2) replacementString:actionString];
            
                // 截取掉a标签前的字符串（防止a标签名称重复）
                tempString = [tempString substringFromIndex:range.location+1];
            
                // 字符串截取部分的长度
                length += preString.length;
            
                [srcArr addObject:aResult];
                [srcArrs addObject:model];
            }
        }
    }];
    
    return srcArr;
}

#pragma mark MLEmojiLabelDelegate
- (void)mlEmojiLabel:(MLEmojiLabel *)emojiLabel didSelectLink:(NSString *)link withType:(MLEmojiLabelLinkType)type {
    switch (type) {
        case 1:
            self.tapNetAddress(link);
            break;
        case 3:
            for (QMTextModel *model in srcArrs) {
                if ([model.type isEqualToString:link]) {
                    self.tapNetAddress(model.content);
                    break;
                }
            }
            break;
        default:{
            NSString *newLink = [link stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSArray *array = [newLink componentsSeparatedByString:@"："];
            if (array.count > 1) {
                self.tapSendMessage(array[1]);
            }
            break;
        }
    }
}

#pragma mark 点击图片GestureRecognizer
- (void)imagePressGesture:(QMTapGestureRecognizer *)gestureRecognizer {
    QMChatRoomShowImageController * showPicVC = [[QMChatRoomShowImageController alloc] init];
    showPicVC.picName = gestureRecognizer.picName;
    showPicVC.picType = gestureRecognizer.picType;
    showPicVC.image = gestureRecognizer.image;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicVC animated:true completion:nil];
}

#pragma mark 机器人答案反馈点击事件
- (void)helpBtnAction: (UIButton *)sender {
    self.didBtnAction(YES);
}

- (void)noHelpBtnAction: (UIButton *)sender {
    self.didBtnAction(NO);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
