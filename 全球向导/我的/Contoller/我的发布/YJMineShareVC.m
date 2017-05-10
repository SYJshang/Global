
//
//  YJMineShareVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/29.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJMineShareVC.h"
#import "YJShareCell.h"
#import "YJNearbyModel.h"
#import "YJPageModel.h"
#import "NoNetwork.h"
#import "YJEditUserShareVC.h"


@interface YJMineShareVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *orderList; //订单列表
@property (nonatomic, strong) YJPageModel *pageModel;  //页数列表

@property (nonatomic, strong) NoNetwork *noNetWork;

@property (nonatomic, assign) int cureenPage;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSMutableArray *totalCout; //总数



@end

@implementation YJMineShareVC

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
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:YJLocalizedString(@"我的发布") font:19.0];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    [self.tableView registerClass:[YJShareCell class] forCellReuseIdentifier:@"cell"];

    self.cureenPage = 1;
    self.count = 0;
    
    
    NSString *str = [YJBNetWorkNotifionTool stringFormStutas];
    XXLog(@"%@",str);
    if ([str isEqualToString:@"3"]) {
        
        //设置网络状态
        [self NetWorks];
    }
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getNetWork];
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
    
    
    
    // Do any additional setup after loading the view.
}


//设置网络状态
- (void)NetWorks{
    
    self.tableView.hidden = YES;
    
    [self.noNetWork removeFromSuperview];
    
    self.noNetWork = [[NoNetwork alloc]init];
    self.noNetWork.titleLabel.text = @"数据请求失败\n请设置网络之后重试";
    __weak typeof(self) weakSelf = self;
    self.noNetWork.btnBlock = ^{
        [weakSelf getNetWork];
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
        [weakSelf getNetWork];
    };
    [self.view addSubview:self.noNetWork];
}


- (void)getNetWork{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/userInfo/myUserRec/list",BaseUrl] parameters:nil success:^(id responseObject) {
        
        self.cureenPage = 1;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.totalCout = [YJNearbyModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"userRecList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryUserRec"][@"page"]];
            
            if (self.totalCout.count == 0) {
                [self noDatas];
            }
            
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }else if ([dict[@"code"] isEqualToString:@"2"]){
            
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"登录失效,请重新登录！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];
            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
            
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
        
    } failure:^(NSError *error) {
        
        [self getNetWork];
        
    }];
    
}

- (void)getMoreData{
    
    
    if (self.cureenPage < self.pageModel.totalPage) {
        self.cureenPage ++;
    }
    
    NSString *curee = [NSString stringWithFormat:@"%d",self.cureenPage];
    NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
    [parmeter setObject:curee forKey:@"currentPage"];
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myUserRec/list",BaseUrl] parameters:parmeter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.totalCout = [YJNearbyModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"userRecList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryUserRec"][@"page"]];
            
            for (YJNearbyModel *model in self.orderList) {
                [self.totalCout addObject:model];
            }
            
            if (self.orderList.count < 2) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            
            [self.tableView reloadData];
        }else if ([dict[@"code"] isEqualToString:@"2"]){
            
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"登录失效,请重新登录！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];
            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
            
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
        
    } failure:^(NSError *error) {
        
        [self getNetWork];
        
    }];
    
}


#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    XXLog(@"当前是共 %ld",self.totalCout.count);
    
    if (self.totalCout) {
        return self.totalCout.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180 * KWidth_Scale;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil) {
        cell = [[YJShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    YJNearbyModel *model = self.totalCout[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJNearbyModel *model = self.totalCout[indexPath.row];
    YJEditUserShareVC *vc = [[YJEditUserShareVC alloc]init];
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];

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
