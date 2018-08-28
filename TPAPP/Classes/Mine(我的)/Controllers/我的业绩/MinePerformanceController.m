//
//  MinePerformanceController.m
//  TPAPP
//
//  Created by Frank on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "MinePerformanceController.h"
#import "JXCategoryNumberView.h"
@interface MinePerformanceController ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) JXCategoryNumberView *myCategoryView;

@end

@implementation MinePerformanceController

-(NSMutableArray *)titles
{
    if (_titles == nil) {
        _titles = [NSMutableArray arrayWithObjects:@"日销售业绩", @"月销售业绩", nil];
    }
    return _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *numbers = @[@0, @0];
    self.myCategoryView.counts = numbers;
    self.myCategoryView.zoomEnabled = YES;
    self.myCategoryView.titleColorGradientEnabled = YES;
    self.myCategoryView.indicatorLineViewShowEnabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.myCategoryView.titles = self.titles;
}
- (JXCategoryNumberView *)myCategoryView {
    return (JXCategoryNumberView *)self.categoryView;
}

- (NSUInteger)preferredListViewCount {
    return self.titles.count;
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryNumberView class];
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
