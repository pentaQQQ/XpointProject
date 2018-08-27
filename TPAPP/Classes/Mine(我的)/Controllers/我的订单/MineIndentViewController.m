//
//  MineIndentViewController.m
//  TPAPP
//
//  Created by Frank on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "MineIndentViewController.h"
#import "JXCategoryTitleView.h"
@interface MineIndentViewController ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation MineIndentViewController
-(NSMutableArray *)titles
{
    if (_titles == nil) {
        _titles = [NSMutableArray arrayWithObjects:@"全部", @"待支付", @"待发货", @"拣货中", @"已发货", @"已取消", nil];
    }
    return _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.defaultSelectedIndex = self.selectIndex;
}
- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (NSUInteger)preferredListViewCount {
    return self.titles.count;
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryTitleView class];
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
