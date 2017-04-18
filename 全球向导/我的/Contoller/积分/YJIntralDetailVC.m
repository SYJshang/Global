//
//  YJRanKDetailVC.m
//  全球向导
//
//  Created by SYJ on 2017/4/18.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJIntralDetailVC.h"
#import "YJPageModel.h"
#import "NoNetwork.h"
#import "YJIntrgralDetailCell.h"

@interface YJIntralDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) int cureenPage;
@property (nonatomic, strong) NSMutableArray *orderList; //订单列表
@property (nonatomic, strong) NSMutableArray *totalCout; //总数

@property (nonatomic, strong) YJPageModel *pageModel;  //页数列表

@property (nonatomic, strong) NoNetwork *noNetWork;

@end

@implementation YJIntralDetailVC

- (NSMutableArray *)totalCout{
    
    if (_totalCout == nil) {
        _totalCout = [NSMutableArray array];
    }
    return _totalCout;
}

- (NSMutableArray *)orderList{
    
    if (_orderList == nil) {
        _orderList = [NSMutableArray array];
    }
    return _orderList;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"成长值详情" font:19.0];
    
    [self getUserInfo];
    
}


- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO; //默认是YES
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    [self.tableView registerClass:[YJIntrgralDetailCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.cureenPage = 1;
    //    self.count = 0;
    
    
    NSString *str = [YJBNetWorkNotifionTool stringFormStutas];
    XXLog(@"%@",str);
    if ([str isEqualToString:@"3"]) {
        
        //设置网络状态
        [self NetWorks];
    }
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getUserInfo];
    }];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        
        if (self.pageModel.totalCount <= self.totalCout.count ) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            [self getMoreData];
        }
        
        
    }];
    
}


//设置网络状态
- (void)NetWorks{
    
    self.tableView.hidden = YES;
    
    [self.noNetWork removeFromSuperview];
    
    self.noNetWork = [[NoNetwork alloc]init];
    self.noNetWork.titleLabel.text = @"数据请求失败\n请设置网络之后重试";
    __weak typeof(self) weakSelf = self;
    self.noNetWork.btnBlock = ^{
        [weakSelf getUserInfo];
    };
    [self.view addSubview:self.noNetWork];
}

- (void)noDatas{
    
    self.tableView.hidden = YES;
    
    [self.noNetWork removeFromSuperview];
    
    self.noNetWork = [[NoNetwork alloc]init];
    self.noNetWork.btrefresh.hidden = YES;
    self.noNetWork.titleLabel.text = @"暂无数据\n赶快去整出动静吧。。";
    __weak typeof(self) weakSelf = self;
    self.noNetWork.btnBlock = ^{
        [weakSelf getUserInfo];
    };
    [self.view addSubview:self.noNetWork];
}


- (void)getUserInfo{
    
    
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myScore/list",BaseUrl] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.totalCout = [YJRankDetailModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"scoreDetailList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryScoreDetail"][@"page"]];
            
            if (self.totalCout.count == 0) {
                [self noDatas];
            }
            
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)getMoreData{
    
    
    if (self.cureenPage < self.pageModel.totalPage) {
        self.cureenPage ++;
    }
    
    NSString *curee = [NSString stringWithFormat:@"%d",self.cureenPage];
    NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
    [parmeter setObject:curee forKey:@"currentPage"];
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myScore/list",BaseUrl] parameters:parmeter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.orderList = [YJRankDetailModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"scoreDetailList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryScoreDetail"][@"page"]];
            
            for (YJRankDetailModel *model in self.orderList) {
                [self.totalCout addObject:model];
            }
            
            if (self.totalCout.count < self.pageModel.totalCount) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            
            
            [self.tableView reloadData];
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
}



#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.totalCout) {
        return self.totalCout.count;
    }
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJIntrgralDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.isIntegral = 3;
    cell.model = self.totalCout[indexPath.row];
    return cell;
    
    
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
