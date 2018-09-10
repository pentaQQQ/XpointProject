//
//  SectionView.h
//  仿淘宝
//
//  Created by 郭军 on 2017/3/16.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectedSectionDelegate <NSObject>

//全选和取消
-(void)SelectedSection:(NSInteger)section;
-(void)SelectedSectionCancel:(NSInteger)section;
//编辑
-(void)SelectedEdit:(NSInteger)section;
//点击店铺
-(void)SelectedShop:(NSInteger)section;

@end

@interface SectionView : UIView

-(void)InfuseData:(NSString *)selected;

@property (nonatomic, assign)NSInteger Section;

//@property (nonatomic, copy)NSString *Type;

@property (nonatomic, weak)id<SelectedSectionDelegate> delegate;

-(void)InfMerchantNameData:(NSString *)merchantName;
@end
