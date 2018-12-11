//
//  SearchViewController.m
//  TPAPP
//
//  Created by 崔文龙 on 2018/8/21.
//  Copyright © 2018年 cbl－　点硕. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchHeaderView.h"
#import "HeaderTabView.h"
#import "pingpaiCell.h"

#import "allGoodsView.h"
#import "SimilarProductModel.h"
#import "GoDetailTableViewCell.h"
#import "specsModel.h"
#import "DeclareAbnormalAlertView.h"
#import "danshouView.h"
#import "HuoDongCell.h"



#import "CXSearchCollectionViewCell.h"
#import "SelectCollectionReusableView.h"
#import "SelectCollectionLayout.h"
#import "CXSearchSectionModel.h"
#import "CXSearchModel.h"
#import "CXDBHandle.h"
static NSString *const cxSearchCollectionViewCell = @"CXSearchCollectionViewCell";

static NSString *const headerViewIden = @"HeadViewIden";


@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate,SelectCollectionCellDelegate,UICollectionReusableViewButtonDelegate,UISearchBarDelegate,DeclareAbnormalAlertViewDelegate>
@property(nonatomic,strong)SearchHeaderView*headerview;
@property(nonatomic,strong)UITableView*tableview;

@property(nonatomic,weak)UIView *mengbanView;
@property(nonatomic,strong)allGoodsView*goodsView;

@property(nonatomic,assign)int currentIndex;
@property(nonatomic,strong)UIButton *topbtn;





@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)shanghuModel *model;


@property(nonatomic,strong)UICollectionView *cxSearchCollectionView;
/**
 *  存储网络请求的热搜，与本地缓存的历史搜索model数组
 */
@property (nonatomic, strong) NSMutableArray *sectionArray;
/**
 *  存搜索的数组 字典
 */
@property (nonatomic,strong) NSMutableArray *searchArray;


@property(nonatomic,strong)UISearchBar*search;


@end




@implementation SearchViewController


-(NSMutableArray*)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


-(NSMutableArray *)sectionArray
{
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

-(NSMutableArray *)searchArray
{
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"搜索";
    
    
    self.currentIndex = 0;
    
    
    
    
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/3*2,30)];
    self.search = search;
    [search setPlaceholder:@"搜索商品名称/品牌/关键字"];
    
    //获取textField(也可以通过KVC获取)
    UITextField *searchField=[((UIView *)[search.subviews objectAtIndex:0]).subviews lastObject];
    //设置placeHolder字体的颜色
    searchField.tintColor = [UIColor lightGrayColor];
    searchField.textColor =[UIColor lightGrayColor];
    [searchField setValue:[UIColor lightGrayColor]forKeyPath:@"_placeholderLabel.textColor"];
    searchField.font = [UIFont systemFontOfSize:14];
    
    searchField.returnKeyType = UIReturnKeySend;
    searchField.backgroundColor = [UIColor whiteColor];
    
    
    search.delegate = self;
    
    self.navigationItem.titleView = search;
    
    
    
    
    [self setUpUI];
    
    [self prepareData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if (!searchBar.text.length) {
        [SVProgressHUD doAnyRemindWithHUDMessage:@"输入的内容不能为空" withDuration:1.5];
    }else{
        
        [self getTheSearchGoodsWithkeyword:searchBar.text AndmerchantId:self.model.merchantId];
        
        /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
        if (![self.searchArray containsObject:[NSDictionary dictionaryWithObject:searchBar.text forKey:@"content_name"]]) {
            [self reloadData:searchBar.text];
        }
        
        
    }
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length == 0) {
        self.tableview.hidden = YES;
    }
    
}








-(void)setUpUI{
    
    
    
    UIButton *topbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, SafeAreaTopHeight+10, kScreenWidth-20, 40)];
    self.topbtn = topbtn;
    [self.view addSubview:topbtn];
    topbtn.backgroundColor = [UIColor whiteColor];
    topbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    topbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [topbtn setTitle:@"搜索品牌：全部" forState:UIControlStateNormal];
    [topbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [topbtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    WeakSelf(weakSelf)
    [topbtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf loadgoodview];
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }];
    
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topbtn.frame), kScreenWidth, 1)];
    [self.view addSubview:vi];
    vi.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    
    UICollectionView *cxSearchCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topbtn.frame)+1, kScreenWidth, kScreenHeight-SafeAreaTopHeight-41) collectionViewLayout:[[SelectCollectionLayout alloc] init]];
    self.cxSearchCollectionView = cxSearchCollectionView;
    
    
    
    [self.cxSearchCollectionView registerClass:[SelectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIden];
    [self.cxSearchCollectionView registerNib:[UINib nibWithNibName:@"CXSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cxSearchCollectionViewCell];
    [self.view addSubview:cxSearchCollectionView];
    cxSearchCollectionView.backgroundColor = [UIColor whiteColor];
    cxSearchCollectionView.delegate = self;
    cxSearchCollectionView.dataSource = self;
    
    
    
    
    
    
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topbtn.frame)+1, kScreenWidth, kScreenHeight-SafeAreaTopHeight-41) style:UITableViewStylePlain];
    self.tableview = tableview;
    self.tableview.hidden = YES;
    [self.view addSubview:tableview];
    
    tableview.tableFooterView = [UIView new];
    tableview.delegate = self;
    tableview.dataSource = self;
}






-(void)loadgoodview{
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *mengbanView = [[UIView alloc]init];
    self.mengbanView = mengbanView;
    self.mengbanView.frame = keyWindow.bounds;
    [keyWindow addSubview:self.mengbanView];
    mengbanView.alpha = 0.5;
    mengbanView.backgroundColor=[UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mengbanViewClick)];
    [mengbanView addGestureRecognizer:tap];
    
    allGoodsView*goodsView = [[NSBundle mainBundle]loadNibNamed:@"allGoodsView" owner:self options:nil].lastObject;
    self.goodsView = goodsView;
    goodsView.currentIndex = self.currentIndex;
    
    goodsView.frame = CGRectMake(0, kScreenHeight/4, kScreenWidth, kScreenHeight/4*3);
    
    [keyWindow addSubview:goodsView];
    
    
    WeakSelf(weakSelf)
    goodsView.goodviewBlock = ^(int index, shanghuModel * _Nonnull model) {
        
        weakSelf.currentIndex = index;
        
        [weakSelf mengbanViewClick];
        
        weakSelf.model = model;
        
        if (index == 0) {
            
            [weakSelf.topbtn setTitle:@"搜索品牌：全部" forState:UIControlStateNormal];
        }else{
            NSString *tit = [NSString stringWithFormat:@"搜索品牌：%@",model.merchantName];
            [weakSelf.topbtn setTitle:tit forState:UIControlStateNormal];
        }
        
    };
    
}



-(void)mengbanViewClick{
    
    [self.goodsView removeView];
    [self.mengbanView removeFromSuperview];
}






-(void)getTheSearchGoodsWithkeyword:(NSString*)keyword AndmerchantId:(NSString *)merchantId{
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setValue:keyword forKey:@"keyword"];
    [dict1 setValue:merchantId forKey:@"merchantId"];
    
    
    [[NetworkManager sharedManager]getWithUrl:getsearchProductByKeyword param:dict1 success:^(id json) {
        NSLog(@"%@",json);
        
        
        NSString *respCode = [NSString stringWithFormat:@"%@",json[@"respCode"]];
        if ([respCode isEqualToString:@"00000"]) {
            
            [self.dataArr removeAllObjects];
            for (NSDictionary *dic in json[@"data"]) {
                SimilarProductModel *model = [SimilarProductModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
            
            if (self.dataArr.count == 0) {
                self.tableview.hidden = YES;
                [SVProgressHUD doAnyRemindWithHUDMessage:@"暂无商品" withDuration:1.5];
            }else{
                self.tableview.hidden = NO;
            }
            
            
            
            [self.tableview reloadData];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}












- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SimilarProductModel*model = self.dataArr[indexPath.row];
    
    if (!([model.typeac isEqualToString:@"0"]||[model.typeac isEqualToString:@"1"])) {
        static NSString*reuesId = @"GoDetailTableViewCell";
        GoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"GoDetailTableViewCell" owner:self options:nil].lastObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = model;
        
        [cell setAddGoodsGoCartBlock:^(specsModel *model) {
            LYAccount *lyAccount = [LYAccount shareAccount];
            if ([lyAccount.isRemark intValue] == 1) {
                DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"添加商品备注" message:@"请输入备注信息" delegate:self leftButtonTitle:@"不下单" rightButtonTitle:@"下单" comCell:nil isAddGood:YES spesmodel:model];
                [alertView show];
            }else{
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:model.productId forKey:@"productId"];
                [dic setValue:model.size forKey:@"size"];
                [dic setValue:lyAccount.id forKey:@"userId"];
                [dic setValue:@"1" forKey:@"number"];
                [dic setValue:model.id forKey:@"cartDetailId"];
                [LYTools postBossDemoWithUrl:cartAddProduct param:dic success:^(NSDictionary *dict) {
                    NSLog(@"%@",dict);
                    NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
                    if ([respCode isEqualToString:@"00000"]) {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"getShopCarNumber" object:@{@"getShopCarNumber":@1}];
                        [SVProgressHUD doAnythingSuccessWithHUDMessage:@"已经成功添加购物车" withDuration:1.5];
                    }else{
                        [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
                    }
                } fail:^(NSError *error) {
                    
                }];
            }
        }];
        
        
        return cell;
    }else{
        
        
        static NSString *reuesId = @"HuoDongCell";
        HuoDongCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesId];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"HuoDongCell" owner:self options:nil].lastObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        
        cell.model = model;
        
        
        
        return cell;
        
    }
    
}

// 输入框弹窗的button点击时回调
- (void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex selectCell:(CompileCell *)cell selectSpesModel:(specsModel *)model{
    if (buttonIndex == AlertButtonLeft) {
        
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:model.productId forKey:@"productId"];
        [dic setValue:model.size forKey:@"size"];
        [dic setValue:@"1" forKey:@"number"];
        LYAccount *lyAccount = [LYAccount shareAccount];
        [dic setValue:lyAccount.id forKey:@"userId"];
        [dic setValue:alertView.textView.text forKey:@"remark"];
        [dic setValue:model.id forKey:@"cartDetailId"];
        [LYTools postBossDemoWithUrl:cartAddProduct param:dic success:^(NSDictionary *dict) {
            NSLog(@"%@",dict);
            NSString *respCode = [NSString stringWithFormat:@"%@",dict[@"respCode"]];
            if ([respCode isEqualToString:@"00000"]) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"getShopCarNumber" object:@{@"getShopCarNumber":@1}];
                [SVProgressHUD doAnythingSuccessWithHUDMessage:@"已经成功添加购物车" withDuration:1.5];
            }else{
                [SVProgressHUD doAnythingFailedWithHUDMessage:dict[@"respMessage"] withDuration:1.5];
            }
        } fail:^(NSError *error) {
            
        }];
        
        
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SimilarProductModel*model = self.dataArr[indexPath.row];
    
    
    if (!([model.typeac isEqualToString:@"0"]||[model.typeac isEqualToString:@"1"])) {
        
        NSString *str = @"";
        for (int i=0; i<model.specs.count; i++) {
            specsModel*spmodel =model.specs[i];
            
            if (i== 0) {
                str = [NSString stringWithFormat:@"%ld(%@)",[spmodel.stock integerValue],spmodel.size];
            }else{
                
                NSString *tempstr = [NSString stringWithFormat:@"%ld(%@)",[spmodel.stock integerValue],spmodel.size];
                str = [NSString stringWithFormat:@"%@/%@",str,tempstr];
            }
        }
        
        
        NSString *chima = [NSString stringWithFormat:@"尺码 %@",str];
        NSString *kuanshi = [NSString stringWithFormat:@"款式 %@",model.design];
        NSString *kuanhao= [NSString stringWithFormat:@"款号 %@",model.designCode];
        
        
        
        
        CGFloat high1 = [LYTools getHeighWithTitle: model.productName font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
        
        CGFloat high2 = [LYTools getHeighWithTitle:  chima font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
        
        CGFloat high3= [LYTools getHeighWithTitle: kuanshi font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
        
        CGFloat high4 =[LYTools getHeighWithTitle: kuanhao font:[UIFont systemFontOfSize:14] width:kScreenWidth-70]+10;
        
        
        
        int tmp = model.imagesList.count % 3;
        int row = (int)model.imagesList.count / 3;
        CGFloat width = (kScreenWidth-70-10)/3.0;
        row += tmp == 0 ? 0:1;
        CGFloat high5 = (width+5)*row;
        
        
        
        
        int tm = model.specs.count % 2;
        int rows = (int)model.specs.count / 2;
        CGFloat high = 20;
        rows += tm == 0 ? 0:1;
        CGFloat high6 = (high+10)*rows+50;
        
        
        
        return high1+high2+high3+high4+high5+high6+160;
    }else{
        
        CGFloat width = (kScreenWidth-70-10)/3.0;
        
        //content的高度
        CGFloat high = [LYTools getHeighWithTitle:model.context font:[UIFont systemFontOfSize:14] width:kScreenWidth-70];
        
        int tmp = model.imagesList.count % 3;
        int row = (int)model.imagesList.count / 3;
        row += tmp == 0 ? 0:1;
        return (width+5)*row+163+high;
    }
    
    
}












- (void)prepareData
{
    /**
     *  测试数据 ，字段暂时 只用一个 titleString，后续可以根据需求 相应加入新的字段
     */
    NSDictionary *testDict = @{@"section_id":@"1",@"section_title":@"热搜",@"section_content":@[@{@"content_name":@"看看哪些光了"},@{@"content_name":@"看看哪些没光"}]};
    NSMutableArray *testArray = [@[] mutableCopy];
    [testArray addObject:testDict];
    
    /***  去数据查看 是否有数据*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    NSDictionary *dbDictionary =  [CXDBHandle statusesWithParams:parmDict];
    
    if (dbDictionary.count) {
        [testArray addObject:dbDictionary];
        [self.searchArray addObjectsFromArray:dbDictionary[@"section_content"]];
    }
    
    for (NSDictionary *sectionDict in testArray) {
        CXSearchSectionModel *model = [[CXSearchSectionModel alloc]initWithDictionary:sectionDict];
        [self.sectionArray addObject:model];
    }
}






#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CXSearchSectionModel *sectionModel =  self.sectionArray[section];
    return sectionModel.section_contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CXSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cxSearchCollectionViewCell forIndexPath:indexPath];
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    [cell.contentButton setTitle:contentModel.content_name forState:UIControlStateNormal];
    cell.selectDelegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sectionArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        SelectCollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIden forIndexPath:indexPath];
        view.delectDelegate = self;
        CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        [view setText:sectionModel.section_title];
        /***  此处完全 也可以自定义自己想要的模型对应放入*/
        if(indexPath.section == 0)
        {
            [view setImage:@"cxCool"];
            view.delectButton.hidden = YES;
        }else{
            [view setImage:@"cxSearch"];
            view.delectButton.hidden = NO;
        }
        reusableview = view;
    }
    return reusableview;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    if (sectionModel.section_contentArray.count > 0) {
        CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
        return [CXSearchCollectionViewCell getSizeWithText:contentModel.content_name];
    }
    return CGSizeMake(80, 24);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - SelectCollectionCellDelegate
- (void)selectButttonClick:(CXSearchCollectionViewCell *)cell;
{
    NSIndexPath* indexPath = [self.cxSearchCollectionView indexPathForCell:cell];
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    NSLog(@"您选的内容是：%@",contentModel.content_name);
    
    self.search.text = contentModel.content_name;
    
    [self getTheSearchGoodsWithkeyword:self.search.text AndmerchantId:self.model.merchantId];
    
    
    
    
}

#pragma mark - UICollectionReusableViewButtonDelegate
- (void)delectData:(SelectCollectionReusableView *)view;
{
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
        [self.searchArray removeAllObjects];
        [self.cxSearchCollectionView reloadData];
        [CXDBHandle saveStatuses:@{} andParam:@{@"category":@"1"}];
    }
}



- (void)reloadData:(NSString *)textString
{
    [self.searchArray addObject:[NSDictionary dictionaryWithObject:textString forKey:@"content_name"]];
    
    NSDictionary *searchDict = @{@"section_id":@"2",@"section_title":@"历史记录",@"section_content":self.searchArray};
    
    /***由于数据量并不大 这样每次存入再删除没问题  存数据库*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    [CXDBHandle saveStatuses:searchDict andParam:parmDict];
    
    CXSearchSectionModel *model = [[CXSearchSectionModel alloc]initWithDictionary:searchDict];
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
    }
    [self.sectionArray addObject:model];
    [self.cxSearchCollectionView reloadData];
    //    self.headerview.textField.text = @"";
}



@end
