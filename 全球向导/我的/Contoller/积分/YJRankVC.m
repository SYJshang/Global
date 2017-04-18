
//
//  YJRankVC.m
//  全球向导
//
//  Created by SYJ on 2017/4/17.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJRankVC.h"
#import "YJRankTopCell.h"
#import "YJRankRuleCell.h"
#import "YJDescRankCell.h"
#import "YJRankModel.h"
#import "YJRanKDetailVC.h"

@interface YJRankVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YJRankModel *model;

@end

@implementation YJRankVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"星级评定" font:19.0];
    
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
    
    //    [self setImage];
    
    //    if (self.tableView.style == UITableViewStylePlain) {
    //        UIEdgeInsets contentInset = self.tableView.contentInset;
    //        contentInset.top = -20;
    //        [self.tableView setContentInset:contentInset];
    //    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];    
    [self.tableView registerClass:[YJRankTopCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[YJRankRuleCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerClass:[YJDescRankCell class] forCellReuseIdentifier:@"cell2"];


    
    // Do any additional setup after loading the view.
}


- (void)getUserInfo{
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/gv/findMain",BaseUrl] parameters:nil success:^(id responseObject) {
        
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",data);
        
        if ([data[@"code"] isEqualToString:@"1"]) {
            
            self.model = [YJRankModel mj_objectWithKeyValues:data[@"data"]];
            
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
        text.text = @"星级评定";
    }else if (section == 2){
        
        text.text = @"成长值来源";

    }else{
        text.text = @"成长值消除";
  
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
        return 200;
    }else if (indexPath.section == 1){
        
        return 230;
    }else{
        
        NSString *test;
        if (indexPath.section == 2) {
            test = @"成交金额:1元=1个成长值\n客户评分:一个好评=10个成长值;一般=0个成长值;一个差评=-10个成长值;\n发展向导:发展1人=50个成长值;\n攻略分享:发表一篇=10个成长值;\n每日登陆:1个成长值";
        }else{
            test = @"年交易额累积不足1万元，扣除1万成长值，成长值最低为0（星级是由成长值决定，向导特权）";
        }

        return [YJDescRankCell cellHegith:test];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        YJRankTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.model = self.model;
        
        [cell.detailBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

    }else if (indexPath.section == 1){
        
        YJRankRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        return cell;
    }else{
        
        YJDescRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        
        if (indexPath.section == 2) {
            cell.textLab.text = @"成交金额:1元=1个成长值\n客户评分:一个好评=10个成长值;一般=0个成长值;一个差评=-10个成长值;\n发展向导:发展1人=50个成长值;\n攻略分享:发表一篇=10个成长值;\n每日登陆:1个成长值";
        }else{
            cell.textLab.text = @"年交易额累积不足1万元，扣除1万成长值，成长值最低为0（星级是由成长值决定，向导特权）";
        }
        return cell;

    }
    
    
}

- (void)btnClick{
    
    [self.navigationController pushViewController:[YJRanKDetailVC new] animated:YES];
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
