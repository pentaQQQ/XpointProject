//
//  SearchHeaderView.h
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@property (weak, nonatomic) IBOutlet UITextField *textField;


@property(nonatomic, assign) CGSize intrinsicContentSize;

@end
