//
//  ShareView.m
//  Choose
//
//  Created by George on 16/11/24.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "ShareView.h"
#define cell_share @"share_item_cellId"

@interface PShareCollectionCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *title;
-(void)reloadCellWithData:(NSDictionary *)dic;
@end
@implementation PShareCollectionCell

-(instancetype)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    if (self) {
        self.imageView = ({
            UIImageView *imageView = [UIImageView new];
//            imageView.backgroundColor = colorWithRGB(0xDDDDDD);
            [self.contentView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.contentView);
                make.height.equalTo(imageView.mas_width);
            }];
            imageView;
        });
        
        self.title = ({
            UILabel *label = [UILabel new];
            label.font = font(13);
            label.textColor = colorWithRGB(0x333333);
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contentView);
                make.top.equalTo(self.imageView.mas_bottom).offset(6);
            }];
            label;
        });
    }
    return self;
}
-(void)reloadCellWithData:(NSDictionary *)dic {
    self.imageView.image = [UIImage imageNamed:dic.allValues.firstObject];
    self.title.text = dic.allKeys.firstObject;
}

@end

@interface ShareView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    CGFloat boardHeight;
}
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy  ) void(^selectItemBlock)(NSInteger index);
@end

@implementation ShareView

-(instancetype)init {
    self= [super init];
    if (self) {
        
        self.dataArray = @[@{@"新浪微博":@"share_sina"}, @{@"QQ好友":@"share_qq"}, @{@"QQ空间":@"share_qqzone"}, @{@"微信好友":@"share_wechat"}, @{@"朋友圈":@"share_moments"}, @{@"复制链接":@"share_copy"}];
        
        boardHeight = 44*2+(55+8+14)*2+20+50;
       
        UIView *backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.backgroundView = backgroundView;
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0;
        [backgroundView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [self dismiss];
        }];
        
        [self addSubview:backgroundView];
        
        self.bottomView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight(), screenWidth(), boardHeight)];
            view.backgroundColor = colorWithRGB(0xE5E5E5);
            [self addSubview:view];

            /* 标题 */
            UILabel *title = [UILabel new];
            title.font = font(14);
            title.textColor = [UIColor darkGrayColor];
            title.textAlignment = NSTextAlignmentCenter;
            title.backgroundColor = [UIColor whiteColor];
            title.text = @"分享到";
            [view addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(view);
                make.height.mas_equalTo(43.2);
            }];
            
            
            /* 取消按钮 */
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:colorWithRGB(0x333333) forState:UIControlStateNormal];
            button.titleLabel.font = font(14);
            [button jk_setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button jk_addActionHandler:^(NSInteger tag) {
                [self dismiss];
            }];
            [view addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.left.right.equalTo(view);
                make.height.mas_equalTo(43.2);
            }];
            
            view;
        });
        
        self.collectionView = ({
            UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
            flowLayout.minimumLineSpacing = 20;
            flowLayout.itemSize = CGSizeMake(55, 55+8+14);
//            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
            
            collectionView.delegate = self;
            collectionView.dataSource = self;
            collectionView.backgroundColor = [UIColor whiteColor];
            [self.bottomView addSubview:collectionView];
            
            [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.bottomView);
                make.height.mas_equalTo((55+8+14)*2+20+50);
                make.centerY.equalTo(self.bottomView);
            }];
            
            [collectionView registerClass:[PShareCollectionCell class] forCellWithReuseIdentifier:cell_share];
            
            collectionView;
        });
    }
    return self;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    CGFloat whiteSpace = self.width-55*4;
    
    CGFloat margin = whiteSpace/5.0;
    
    collectionView.contentInset = UIEdgeInsetsMake(25, margin, 25, margin);
    
    return margin;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PShareCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_share forIndexPath:indexPath];
    [cell reloadCellWithData:self.dataArray[indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectItemBlock) {
        self.selectItemBlock(indexPath.row);
    }
    [self dismiss];
}

-(void)show {
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundView.alpha = 0.5;
        self.bottomView.y = screenHeight()-boardHeight;
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)dismiss {
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundView.alpha = 0;
        self.bottomView.y = screenHeight();
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+(instancetype)shareWithDataArray:(NSArray *)dataArray didSelectIndex:(void(^)(NSInteger index))selectBlock {
    ShareView *share = [ShareView new];
    share.frame = [UIScreen mainScreen].bounds;
    if (dataArray && dataArray.count > 0) {
        share.dataArray = dataArray;
    }
    share.selectItemBlock = selectBlock;
    [[UIApplication sharedApplication].keyWindow addSubview:share];
    [share show];
    return share;
}


@end
