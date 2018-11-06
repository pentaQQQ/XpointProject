//
//  allGoodsView.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/11/2.
//  Copyright © 2018 cbl－　点硕. All rights reserved.
//

#import "allGoodsView.h"
#import "zhuanfaCell.h"

@interface allGoodsView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation allGoodsView

-(NSMutableArray*)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}







-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self layoutAllSubviews];
    }
    return self;
}
- (void)layoutAllSubviews{
    
    CGPoint accountCenter = self.center;
    accountCenter.y += kScreenHeight/4*3;
    self.center =accountCenter;
    accountCenter.y -= kScreenHeight/4*3;
    [allGoodsView animateWithDuration:0.5 animations:^{
        self.center = accountCenter;
    }];
    
    
}



-(void)removeView{
    
    CGPoint accountCenter = self.center;
    accountCenter.y -= 0;
    self.center =accountCenter;
    accountCenter.y += kScreenHeight/4*3;
    [allGoodsView animateWithDuration:0.5 animations:^{
        self.center = accountCenter;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }];
    
}



- (IBAction)cancelBtnClick:(id)sender {
    
    [self removeView];
}





-(void)setTableview:(UITableView *)tableview{
    _tableview = tableview;
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    tableview.tableFooterView = [UIView new];
    
    
    [self getdata];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString*reuesId = @"zhuanfaCell";
    
    zhuanfaCell*cell =[tableView dequeueReusableCellWithIdentifier:reuesId];
    
    if (cell == nil) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"zhuanfaCell" owner:self options:nil].lastObject;
    }
    
    
    
    if (indexPath.row == 0) {
        cell.title.text = @"全部";
    }else{
        shanghuModel *model = self.titleArray[indexPath.row-1];
        
        cell.model = model;
    }

    if (indexPath.row == self.currentIndex) {
        
        cell.seletimageview.hidden = NO;
    }else{
        cell.seletimageview.hidden = YES;
    }
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    

    
    if (indexPath.row == 0) {
        
        shanghuModel *model = [[shanghuModel alloc]init];
        if (self.goodviewBlock) {
            self.goodviewBlock((int)indexPath.row, model);
        }
    }else{
        
        shanghuModel *model = self.titleArray[indexPath.row-1];
        if (self.goodviewBlock) {
            self.goodviewBlock((int)indexPath.row, model);
        }
    }
    
   
    
    
    
}



//获取商户列表
-(void)getdata{
    
    [[NetworkManager sharedManager]getWithUrl:getMerchantList param:nil success:^(id json) {
        NSLog(@"%@",json);
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]){
            
            
            for (NSDictionary *dic in json[@"data"]) {
                shanghuModel *model = [shanghuModel mj_objectWithKeyValues:dic];
                [self.titleArray addObject:model];
                
            }
            [self.tableview reloadData];
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}

@end
