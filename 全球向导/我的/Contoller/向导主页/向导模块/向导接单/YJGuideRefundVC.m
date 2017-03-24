
//
//  YJWaitOrderVC.m
//  全球向导
//
//  Created by SYJ on 2017/3/9.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJGuideRefundVC.h"
#import "YJOrderBgCell.h"
#import "YJRefundDetailVC.h"
#import "YJGuideRefundModel.h"
#import "YJPageModel.h"
#import "YJChatVC.h"

@interface YJGuideRefundVC ()<UITableViewDelegate,UITableViewDataSource,relationClickPush>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSDictionary *payMethodMap;//支付类型
@property (nonatomic, strong) NSDictionary *refundStatusMap;//退款状态
@property (nonatomic, strong) NSDictionary *userInfoMap;//用户映射
@property (nonatomic, strong) NSMutableArray *orderList; //订单列表

@property (nonatomic, strong) YJPageModel *pageModel;  //页数列表

@property (nonatomic, strong) NoNetwork *noNetWork;

@property (nonatomic, assign) int cureenPage;
@property (nonatomic, strong) NSMutableArray *totalCout; //总数


@end

@implementation YJGuideRefundVC

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
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, screen_width, screen_height - 108) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    [self.tableView registerClass:[YJOrderBgCell class] forCellReuseIdentifier:@"cell1"];
    
    //初始化
    self.payMethodMap = [NSDictionary dictionary];
    self.refundStatusMap = [NSDictionary dictionary];
    self.userInfoMap = [NSDictionary dictionary];
    
    self.cureenPage = 1;
    //    self.count = 0;
    
    
    NSString *str = [YJBNetWorkNotifionTool stringFormStutas];
    XXLog(@"%@",str);
    if ([str isEqualToString:@"3"]) {
        
        //设置网络状态
        [self NetWorks];
    }
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getNetWorkData];
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
        [weakSelf getNetWorkData];
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
        [weakSelf getNetWorkData];
    };
    [self.view addSubview:self.noNetWork];
}


//获取网络加载数据
- (void)getNetWorkData{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:@"1" forKey:@"currentPage"];
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/guide/trade/listRefundInit",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.totalCout = [YJGuideRefundModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"refundList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryRefund"][@"page"]];
            
            
            self.userInfoMap = dict[@"data"][@"userInfoMap"];
            self.payMethodMap = dict[@"data"][@"payMethodMap"];
            self.refundStatusMap = dict[@"data"][@"refundStatusMap"];
            
            
            if (self.totalCout.count == 0) {
                [self noDatas];
            }
            
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            
            [self.tableView reloadData];
            
        }else{
            
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
        }
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


//获取更多
- (void)getMoreData{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    
    if (self.cureenPage < self.pageModel.totalPage) {
        self.cureenPage ++;
    }
    
    NSString *curee = [NSString stringWithFormat:@"%d",self.cureenPage];
    NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
    [parmeter setObject:curee forKey:@"currentPage"];
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/guide/trade/listRefund",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.orderList = [YJGuideRefundModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"orderList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryOrder"][@"page"]];
            
            
            for (YJGuideRefundModel *model in self.orderList) {
                [self.totalCout addObject:model];
            }
            
            if (self.orderList.count < self.pageModel.pageSize) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            
            [self.tableView reloadData];
            
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
        }
        
    } failure:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}




#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180 * KHeight_Scale;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.totalCout.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJOrderBgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    
    YJGuideRefundModel *model = self.totalCout[indexPath.row];
    cell.payMethodMap = self.payMethodMap;
    cell.refundStatusMap = self.refundStatusMap;
    cell.userInfoMap = self.userInfoMap;
    cell.model = model;
    cell.delegate = self;
    cell.tag = indexPath.row;
    return cell;
    
}

- (void)btnClickEnvent:(UIButton *)sender{
    
    YJOrderBgCell *cell = (YJOrderBgCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    YJGuideRefundModel *model = self.totalCout[indexPath.row];
    XXLog(@">>>>>>>>>>>%ld",model.status);
    
        SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"是否联系用户" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            
            YJChatVC *vc = [[YJChatVC alloc]initWithConversationChatter:model.buyerId conversationType:EMConversationTypeChat];
            [self.navigationController pushViewController:vc animated:YES];

        }];
        alert.sure_btnTitleColor = TextColor;
        [alert show];

}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YJGuideRefundModel *model = self.totalCout[indexPath.row];
    YJRefundDetailVC *vc = [[YJRefundDetailVC alloc]init];
    vc.orderId = model.ID;
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
