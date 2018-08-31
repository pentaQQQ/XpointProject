//
//  MomentCell.m
//  MomentKit
//
//  Created by LEA on 2017/12/14.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MomentCell.h"

#pragma mark - ------------------ 动态 ------------------

// 最大高度限制
CGFloat maxLimitHeight = 0;

@implementation MomentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    // 头像视图
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, kBlank, kFaceWidth, kFaceWidth)];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.userInteractionEnabled = YES;
    _headImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_headImageView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHead:)];
    [_headImageView addGestureRecognizer:tapGesture];
    // 名字视图
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right+10, _headImageView.top, kTextWidth, 20)];
    _nameLab.font = [UIFont boldSystemFontOfSize:17.0];
    _nameLab.textColor = kHLTextColor;
    _nameLab.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_nameLab];
    // 正文视图
    _linkLabel = kMLLinkLabel();
    _linkLabel.font = kTextFont;
    _linkLabel.delegate = self;
    _linkLabel.linkTextAttributes = @{NSForegroundColorAttributeName:kLinkTextColor};
    _linkLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:kLinkTextColor,NSBackgroundColorAttributeName:kHLBgColor};
    [self.contentView addSubview:_linkLabel];
    // 查看'全文'按钮
    _showAllBtn = [[UIButton alloc]init];
    _showAllBtn.titleLabel.font = kTextFont;
    _showAllBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _showAllBtn.backgroundColor = [UIColor clearColor];
    [_showAllBtn setTitle:@"全文" forState:UIControlStateNormal];
    [_showAllBtn setTitleColor:kHLTextColor forState:UIControlStateNormal];
    [_showAllBtn addTarget:self action:@selector(fullTextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_showAllBtn];
    // 图片区
    _imageListView = [[MMImageListView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageListView];
    // 位置视图
//    _locationLab = [[UILabel alloc] init];
//    _locationLab.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1.0];
//    _locationLab.font = [UIFont systemFontOfSize:13.0f];
//    [self.contentView addSubview:_locationLab];
    // 时间视图
    _timeLab = [[UILabel alloc] init];
    _timeLab.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1.0];
    _timeLab.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_timeLab];
    // 删除视图
//    _deleteBtn = [[UIButton alloc] init];
//    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
//    _deleteBtn.backgroundColor = [UIColor clearColor];
//    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//    [_deleteBtn setTitleColor:kHLTextColor forState:UIControlStateNormal];
//    [_deleteBtn addTarget:self action:@selector(deleteMoment:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:_deleteBtn];
    
    // 转发视图
        _transpondBtn = [[UIButton alloc] init];
        _transpondBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _transpondBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:87.0/255.0 blue:96.0/255.0 alpha:1.0];
        [_transpondBtn setTitle:@"转发" forState:UIControlStateNormal];
        [_transpondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_transpondBtn addTarget:self action:@selector(transpondMoment) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_transpondBtn];
    
    // 评论视图
        _commentBtn = [[UIButton alloc] init];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _commentBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:87.0/255.0 blue:96.0/255.0 alpha:1.0];
        [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
        [_commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(commentMoment) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_commentBtn];
    
    // 保存相册视图
        _saveBtn = [[UIButton alloc] init];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _saveBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:87.0/255.0 blue:96.0/255.0 alpha:1.0];
        [_saveBtn setTitle:@"保存到相册" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveMoment) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_saveBtn];
    
    // 评论视图
    _bgImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_bgImageView];
    _commentView = [[UIView alloc] init];
    [self.contentView addSubview:_commentView];
    // 操作视图
//    _menuView = [[MMOperateMenuView alloc] initWithFrame:CGRectZero];
//    __weak typeof(self) weakSelf = self;
//    [_menuView setLikeMoment:^{
//        if ([weakSelf.delegate respondsToSelector:@selector(didLikeMoment:)]) {
//            [weakSelf.delegate didLikeMoment:weakSelf];
//        }
//    }];
//    [_menuView setCommentMoment:^{
//        if ([weakSelf.delegate respondsToSelector:@selector(didAddComment:)]) {
//            [weakSelf.delegate didAddComment:weakSelf];
//        }
//    }];
//    [self.contentView addSubview:_menuView];
    // 最大高度限制
    maxLimitHeight = _linkLabel.font.lineHeight * 6;
}
#pragma mark - 转发
- (void)transpondMoment{
   __weak typeof(self) weakSelf = self;
    if ([weakSelf.delegate respondsToSelector:@selector(didLikeMoment:)]) {
        [weakSelf.delegate didLikeMoment:weakSelf];
    }
}
#pragma mark - 评论
- (void)commentMoment{
    __weak typeof(self) weakSelf = self;
    if ([weakSelf.delegate respondsToSelector:@selector(didAddComment:)]) {
        [weakSelf.delegate didAddComment:weakSelf];
    }
}
#pragma mark - 保存相册
- (void)saveMoment{
    __weak typeof(self) weakSelf = self;
    if ([weakSelf.delegate respondsToSelector:@selector(saveVideoComment:)]) {
        [weakSelf.delegate saveVideoComment:weakSelf];
    }
}
#pragma mark - setter
- (void)setMoment:(Moment *)moment
{
    _moment = moment;
    // 头像
    _headImageView.image = [UIImage imageNamed:@"moment_head"];
    // 昵称
    _nameLab.text = moment.userName;
    // 正文
    _showAllBtn.hidden = YES;
    _linkLabel.hidden = YES;
    CGFloat bottom = _headImageView.bottom + kPaddingValue;
    CGFloat rowHeight = 0;
    if ([moment.text length]) {
        _linkLabel.hidden = NO;
        _linkLabel.text = moment.text;
        // 判断显示'全文'/'收起'
        CGSize attrStrSize = [_linkLabel preferredSizeWithMaxWidth:kTextWidth];
        CGFloat labH = attrStrSize.height;
        if (labH > maxLimitHeight) {
            if (!_moment.isFullText) {
                labH = maxLimitHeight;
                [self.showAllBtn setTitle:@"全文" forState:UIControlStateNormal];
            } else {
                [self.showAllBtn setTitle:@"收起" forState:UIControlStateNormal];
            }
            _showAllBtn.hidden = NO;
        }
        _linkLabel.frame = CGRectMake(_headImageView.left, bottom, attrStrSize.width, labH);
        _showAllBtn.frame = CGRectMake(_headImageView.left, _linkLabel.bottom + kArrowHeight, kMoreLabWidth, kMoreLabHeight);
        if (_showAllBtn.hidden) {
            bottom = _linkLabel.bottom + kPaddingValue;
        } else {
            bottom = _showAllBtn.bottom + kPaddingValue;
        }
    }
    // 图片
    _imageListView.moment = moment;
    if (moment.fileCount > 0) {
        _imageListView.origin = CGPointMake(_headImageView.left, bottom);
        bottom = _imageListView.bottom + kPaddingValue;
    }
    // 位置
//    _locationLab.frame = CGRectMake(_headImageView.left, bottom, _nameLab.width, kTimeLabelH);
    _timeLab.text = [NSString stringWithFormat:@"%@ 发布",[Utility getDateFormatByTimestamp:moment.time]];
    CGFloat textW = [_timeLab.text boundingRectWithSize:CGSizeMake(200, kTimeLabelH)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:_timeLab.font}
                                                context:nil].size.width;
//    if ([moment.location length]) {
//        _locationLab.hidden = NO;
//        _locationLab.text = moment.location;
//        _timeLab.frame = CGRectMake(_headImageView.left, _locationLab.bottom+kPaddingValue, textW, kTimeLabelH);
//    } else {
//        _locationLab.hidden = YES;
        _timeLab.frame = CGRectMake(_headImageView.right+10, _nameLab.bottom+5, textW, kTimeLabelH);
//    }
//    _deleteBtn.frame = CGRectMake(_timeLab.right + 25, _timeLab.top, 30, kTimeLabelH);

    
    _transpondBtn.frame = CGRectMake(k_screen_width-50-20, bottom+7, 50, 20);
    _transpondBtn.layer.cornerRadius = 4;
    _transpondBtn.layer.masksToBounds = YES;
    _commentBtn.frame = CGRectMake(k_screen_width-50-20-10-50, bottom+7, 50, 20);
    _commentBtn.layer.cornerRadius = 4;
    _commentBtn.layer.masksToBounds = YES;
    _saveBtn.frame = CGRectMake(k_screen_width-50-20-10-50-10-80, bottom+7, 80, 20);
    _saveBtn.layer.cornerRadius = 4;
    _saveBtn.layer.masksToBounds = YES;
    bottom = _transpondBtn.bottom + kPaddingValue;
    // 操作视图
//    _menuView.frame = CGRectMake(k_screen_width-kOperateWidth-10, _timeLab.top-(kOperateHeight-kTimeLabelH)/2, kOperateWidth, kOperateHeight);
//    _menuView.show = NO;
    // 处理评论/赞
    _commentView.frame = CGRectZero;
    _bgImageView.frame = CGRectZero;
    _bgImageView.image = nil;
    [_commentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 处理赞
    CGFloat top = 0;
    CGFloat width = k_screen_width-kRightMargin-_headImageView.left;
    if (moment.praiseNameList.length) {
        MLLinkLabel *likeLabel = kMLLinkLabel();
        likeLabel.delegate = self;
        likeLabel.attributedText = kMLLinkLabelAttributedText(moment.praiseNameList);
        CGSize attrStrSize = [likeLabel preferredSizeWithMaxWidth:kTextWidth];
        likeLabel.frame = CGRectMake(5, 8, attrStrSize.width-10, attrStrSize.height);
        [_commentView addSubview:likeLabel];
        // 分割线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, likeLabel.bottom + 7, width, 0.5)];
        line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        [_commentView addSubview:line];
        // 更新
        top = attrStrSize.height + 15;
    }
    // 处理评论
    NSInteger count = [moment.commentList count];
    if (count > 0) {
        for (NSInteger i = 0; i < count; i ++) {
            CommentLabel *label = [[CommentLabel alloc] initWithFrame:CGRectMake(0, top, width, 0)];
            label.comment = [moment.commentList objectAtIndex:i];
            [label setDidClickText:^(Comment *comment) {
                if ([self.delegate respondsToSelector:@selector(didSelectComment:)]) {
                    [self.delegate didSelectComment:comment];
                }
            }];
            [label setDidClickLinkText:^(MLLink *link, NSString *linkText) {
                if ([self.delegate respondsToSelector:@selector(didClickLink:linkText:)]) {
                    [self.delegate didClickLink:link linkText:linkText];
                }
            }];
            [_commentView addSubview:label];
            // 更新
            top += label.height;
        }
    }
    // 更新UI
    if (top > 0) {
        _bgImageView.frame = CGRectMake(_headImageView.left, bottom, width, top + kArrowHeight);
        _bgImageView.image = [[UIImage imageNamed:@"comment_bg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30];
        _commentView.frame = CGRectMake(_headImageView.left, bottom + kArrowHeight, width, top);
        rowHeight = _commentView.bottom + kBlank;
    } else {
        rowHeight = _transpondBtn.bottom + kBlank;
    }
    
    // 这样做就是起到缓存行高的作用，省去重复计算!!!
    _moment.rowHeight = rowHeight;
}

#pragma mark - 点击事件
// 查看全文/收起
- (void)fullTextClicked:(UIButton *)sender
{
    _showAllBtn.titleLabel.backgroundColor = kHLBgColor;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        _showAllBtn.titleLabel.backgroundColor = [UIColor clearColor];
        _moment.isFullText = !_moment.isFullText;
        if ([self.delegate respondsToSelector:@selector(didSelectFullText:)]) {
            [self.delegate didSelectFullText:self];
        }
    });
}

// 点击头像
- (void)clickHead:(UITapGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(didClickProfile:)]) {
        [self.delegate didClickProfile:self];
    }
}

// 删除动态
- (void)deleteMoment:(UIButton *)sender
{
    _deleteBtn.titleLabel.backgroundColor = [UIColor lightGrayColor];
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        _deleteBtn.titleLabel.backgroundColor = [UIColor clearColor];
        if ([self.delegate respondsToSelector:@selector(didDeleteMoment:)]) {
            [self.delegate didDeleteMoment:self];
        }
    });
}

#pragma mark - MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    // 点击动态正文或者赞高亮
    if ([self.delegate respondsToSelector:@selector(didClickLink:linkText:)]) {
        [self.delegate didClickLink:link linkText:linkText];
    }
}
@end

#pragma mark - ------------------ 评论 ------------------
@implementation CommentLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _linkLabel = kMLLinkLabel();
        _linkLabel.delegate = self;
        [self addSubview:_linkLabel];
    }
    return self;
}

#pragma mark - Setter
- (void)setComment:(Comment *)comment
{
    _comment = comment;
    _linkLabel.attributedText = kMLLinkLabelAttributedText(comment);

    CGSize attrStrSize = [_linkLabel preferredSizeWithMaxWidth:kTextWidth];
    _linkLabel.frame = CGRectMake(5, 3, attrStrSize.width-10, attrStrSize.height);

    CGSize attrStrSize = [_linkLabel preferredSizeWithMaxWidth:kTextWidth-10];
    _linkLabel.frame = CGRectMake(5, 3, kTextWidth-10, attrStrSize.height);

    self.height = attrStrSize.height + 5;
}

#pragma mark - MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    if (self.didClickLinkText) {
        self.didClickLinkText(link,linkText);
    }
}

#pragma mark - 点击
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = kHLBgColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self.backgroundColor = [UIColor clearColor];
        if (self.didClickText) {
            self.didClickText(_comment);
        }
    });
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor clearColor];
}

@end
