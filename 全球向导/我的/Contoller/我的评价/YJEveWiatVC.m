//
//  YJEveWiatVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/19.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJEveWiatVC.h"
#import "YJAllOrderCell.h"
#import "YJEvaluationController.h"
#import "YJEvaWaitModel.h"
#import "YJPageModel.h"
#import "NoNetwork.h"
#import "YJConfirmController.h"
#import "YJGuideDetailVC.h"


@interface YJEveWiatVC ()<UITableViewDelegate,UITableViewDataSource,YJBtnClickEvE>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *orderList; //订单列表
@property (nonatomic, strong) YJPageModel *pageModel;  //页数列表

@property (nonatomic, strong) NoNetwork *noNetWork;

@property (nonatomic, assign) int cureenPage;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSMutableArray *totalCout; //总数


@end

@implementation YJEveWiatVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self getNetWork];
    
}

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



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.tableView =  [[UITableView alloc]initWithFrame:CGRectMake(0, 108, screen_width, screen_height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    //注册cell
    [self.tableView registerClass:[YJAllOrderCell class] forCellReuseIdentifier:@"cell"];
    
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
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/userInfo/myEva/listWait",BaseUrl] parameters:nil success:^(id responseObject) {
        
        self.cureenPage = 1;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.totalCout = [YJEvaWaitModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"evaWaitList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryEvaWait"][@"page"]];
            
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
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myEva/listWait",BaseUrl] parameters:parmeter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.orderList = [YJEvaWaitModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"evaWaitList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryEvaWait"][@"page"]];
            
            for (YJEvaWaitModel *model in self.orderList) {
                [self.totalCout addObject:model];
            }
            
            if (self.totalCout.count == self.pageModel.totalPage) {
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
        
        [self getNetWork];
        
    }];
    
}


#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 190 * KHeight_Scale;
}

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJAllOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) {
        cell = [[YJAllOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.delegate = self;
    YJEvaWaitModel *model = self.totalCout[indexPath.row];
    cell.orderState = 1;
    cell.evaModel = model;
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.navigationController pushViewController:[YJDetailController new] animated:YES];
}


- (void)btnDidClickPlusButton:(UIButton *)ViewTag{
    
    YJAllOrderCell *cell = (YJAllOrderCell *)[[ViewTag superview]superview];
    //获取cell
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //获取当前选中cell
    //    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    YJOrderListModel *model = self.totalCout[indexPath.row];

    
    if (ViewTag.tag == 1) {
        XXLog(@"去评价");
        YJEvaluationController *VC = [[YJEvaluationController alloc]init];
        VC.ID = model.orderId;
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        
               XXLog(@"再次预定");
        YJGuideDetailVC *vc = [[YJGuideDetailVC alloc]init];
        vc.guideId = model.guideId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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
