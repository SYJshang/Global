//
//  YJIntegralVC.m
//  全球向导
//
//  Created by SYJ on 2017/4/17.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJIntegralVC.h"
#import "YJIntegralTopCell.h"
#import "YJIntrgralDetailCell.h"
#import "YJDescRankCell.h"
#import "YJDIYButton.h"
#import "YJIntegraModel.h"
#import "YJRanKDetailVC.h"


@interface YJIntegralVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *listScore;

@property (nonatomic, strong) YJIntegraModel *model;


@end

@implementation YJIntegralVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"积分" font:19.0];
    
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
    [self.tableView registerClass:[YJIntegralTopCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[YJIntrgralDetailCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerClass:[YJDescRankCell class] forCellReuseIdentifier:@"cell2"];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)getUserInfo{
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myScore/findMain",BaseUrl] parameters:nil success:^(id responseObject) {
        
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",data);
        
        if ([data[@"code"] isEqualToString:@"1"]) {
            
            self.model = [YJIntegraModel mj_objectWithKeyValues:data[@"data"]];
            
            self.listScore = self.model.scoreDetailList;
            
            [self.tableView reloadData];
            
        }else{
            
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:data[@"msg"] alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}



#pragma mark - table view dataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = BackGray;
    
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = TextColor;
    [view addSubview:label];
    label.sd_layout.leftSpaceToView(view, 10).centerYEqualToView(view).heightIs(20).widthIs(5);
    
    UILabel *text = [[UILabel alloc]init];
    [view addSubview:text];
    text.textColor = [UIColor blackColor];
    text.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    text.sd_layout.leftSpaceToView(label, 5).centerYEqualToView(view).widthIs(150).heightIs(20);
    if (section == 1) {
        text.text = @"积分明细";
        
        YJDIYButton *btn = [YJDIYButton buttonWithFrame:CGRectMake(screen_width - 50, 5, 40, 20) title:@"MORE" imageName:@"arrow-right" Block:^{
            
            YJRanKDetailVC *vc = [[YJRanKDetailVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0,33, 0, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -17, 0, 10)];
        [view addSubview:btn];

    }else if (section == 2){
        
        text.text = @"积分简介";
        
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else{
        
        return 30;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 240;
    }else if (indexPath.section == 1){
        
        return 50;
    }else{
        
        NSString *test = @"1.积分换算方法为：消费积分以1元为最小单位，每消费满1元累积1分，不满1元，积分为0！\n2.积分计算以实收金额为准，会员消费金额中，不满1元部分不进行前后累计积分，如发生退换货，将从积分中扣除由于退换货部分产生的积分差额。\n3.积分只在同一会员帐户内累计，不同帐户的积分不能合并。";
        
        return [YJDescRankCell cellHegith:test];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return self.listScore.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YJIntegralTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.model = self.model;
        return cell;
        
    }else if (indexPath.section == 1){
        
        YJIntrgralDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.isIntegral = 3;
        cell.model = self.listScore[indexPath.row];
        return cell;
    }else{
        
        YJDescRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell.textLab.text = @"1.积分换算方法为：消费积分以1元为最小单位，每消费满1元累积1分，不满1元，积分为0！\n2.积分计算以实收金额为准，会员消费金额中，不满1元部分不进行前后累计积分，如发生退换货，将从积分中扣除由于退换货部分产生的积分差额。\n3.积分只在同一会员帐户内累计，不同帐户的积分不能合并。";
        return cell;
        
    }
    
    
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
