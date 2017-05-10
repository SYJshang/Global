//
//  YJMyFindVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/14.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJMyFindVC.h"
#import "YJSecondCell.h"
#import "YJPageModel.h"
#import "YJEditGuideShareVC.h"

@interface YJMyFindVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *orderList; //订单列表
@property (nonatomic, strong) YJPageModel *pageModel;  //页数列表

@property (nonatomic, strong) NoNetwork *noNetWork;

@property (nonatomic, assign) int cureenPage;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSMutableArray *totalCout; //总数



@end

@implementation YJMyFindVC

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    [self.tableView registerClass:[YJSecondCell class] forCellReuseIdentifier:@"cell"];
    self.cureenPage = 1;
    self.count = 0;
    
    [self getNetWork];
    
    NSString *str = [YJBNetWorkNotifionTool stringFormStutas];
    XXLog(@"%@",str);
    if ([str isEqualToString:@"3"]) {
        
        //设置网络状态
        [self NetWorks];
    }
    
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
    self.noNetWork.imageView.frame = CGRectMake(100, screen_height - 340,screen_width - 200, 160);
    self.noNetWork.titleLabel.frame = CGRectMake(40, self.noNetWork.imageView.bottom , screen_width - 80, 40);
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
    self.noNetWork.titleLabel.text = @"暂无数据\n赶快去整出动静吧";
//    self.noNetWork.imageView.alignmentRectInsets = UIEdgeInsetsMake(0, 0, 40, 0);
//    self.noNetWork.titleLabel.alignmentRectInsets = UIEdgeInsetsMake(0, 0, 40, 0);
    self.noNetWork.imageView.frame = CGRectMake(100, screen_height - 340 * KHeight_Scale,screen_width - 200, 160);
    self.noNetWork.titleLabel.frame = CGRectMake(40, self.noNetWork.imageView.bottom , screen_width - 80, 40);
    __weak typeof(self) weakSelf = self;
    self.noNetWork.btnBlock = ^{
        [weakSelf getNetWork];
    };
    [self.view addSubview:self.noNetWork];
}


- (void)getNetWork{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/guide/guideRec/list",BaseUrl] parameters:nil success:^(id responseObject) {
        
        self.cureenPage = 1;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.totalCout = [YJNearbyModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"guideRecList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryGuideRec"][@"page"]];
            
            if (self.totalCout.count == 0) {
                [self noDatas];
            }
            
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
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/guideRec/list",BaseUrl] parameters:parmeter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.totalCout = [YJNearbyModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"guideRecList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryGuideRec"][@"page"]];
            
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


#pragma mark - sestemnt delegate
-(NSString *)segmentTitle
{
    return YJLocalizedString(@"向导发现");
}

-(UIScrollView *)streachScrollView
{
    return self.tableView;
}


#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 200 * KHeight_Scale;
    
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
    
    YJSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    YJNearbyModel *model = self.totalCout[indexPath.row];
    cell.shareList = model;

    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJNearbyModel *model = self.totalCout[indexPath.row];
    YJEditGuideShareVC *vc = [[YJEditGuideShareVC alloc]init];
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
