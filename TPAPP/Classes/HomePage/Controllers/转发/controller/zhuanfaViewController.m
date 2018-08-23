//
//  zhuanfaViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/23.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "zhuanfaViewController.h"
#import "zhuanfaHeaderView.h"
#import "zhuanfaCell.h"
@interface zhuanfaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)zhuanfaHeaderView*headerview;
@property(nonatomic,strong)UITableView*tableview;
@end

@implementation zhuanfaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"选择品牌转发";
    
    [self setItems];
    [self setUpHeaderview];
}



-(void)setItems{
    
    UIBarButtonItem *gap = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    gap.width = -6;
    UIBarButtonItem *set = [[UIBarButtonItem alloc] initWithImage:@"back" complete:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.navigationItem.leftBarButtonItems = @[gap, set];
    
    UIBarButtonItem*rightitem  = [[UIBarButtonItem alloc]initWithTitle:@"转发设置" complete:^{
        
    }];
    
    self.navigationItem.rightBarButtonItem =rightitem;
    
}



-(void)setUpHeaderview{
    
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-380) style:UITableViewStylePlain];
    self.tableview = tableview;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    
    
    
    
    

    zhuanfaHeaderView*headerview = [[NSBundle mainBundle]loadNibNamed:@"zhuanfaHeaderView" owner:self options:nil].lastObject;
    self.headerview = headerview;
    
    headerview.frame = CGRectMake(0, CGRectGetMaxY(tableview.frame), kScreenWidth,380);
    
    [self.view addSubview:headerview];
    
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString*reuesId = @"zhuanfaCell";
    
    zhuanfaCell*cell =[tableView dequeueReusableCellWithIdentifier:reuesId];
    
    if (cell == nil) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"zhuanfaCell" owner:self options:nil].lastObject;
    }
    return cell;
    
}










@end
