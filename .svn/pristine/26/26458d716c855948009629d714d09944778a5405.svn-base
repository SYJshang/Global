//
//  YJAllOrderController.m
//  全球向导
//
//  Created by SYJ on 2016/12/7.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJAllOrderController.h"
#import "YJAllOrderCell.h"
#import "YJDetailController.h"


@interface YJAllOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YJAllOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, screen_width, screen_height - 108) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];

    //注册cell
    [self.tableView registerClass:[YJAllOrderCell class] forCellReuseIdentifier:@"cell"];
    
    
//    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, screen_width, screen_height - 108)];
//    NSURL *htmlURL = [NSURL URLWithString:self.str];
//    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
//    
//    self.webView.backgroundColor = [UIColor clearColor];
//    // UIWebView 滚动的比较慢，这里设置为正常速度
//    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
//    [self.webView loadRequest:request];
//    [self.view addSubview:self.webView];
    
    // Do any additional setup after loading the view.
}

#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 190 * KHeight_Scale;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJAllOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) {
        cell = [[YJAllOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.orderState = (int)indexPath.row + 1;
    
    if (cell.orderState == 1) {
        cell.stateLab.text = @"等待评价";
        cell.disOrder.hidden = YES;
        [cell.buyOrder setTitle:@"评价" forState:UIControlStateNormal];
        [cell.relation setTitle:@"再次预定" forState:UIControlStateNormal];
    }else if (cell.orderState == 2){
        cell.stateLab.text = @"交易成功";
    }else if (cell.orderState == 3){
        cell.stateLab.text = @"已完成";
    }else if (cell.orderState == 4){
        cell.stateLab.text = @"退款中";
    }else{
        cell.stateLab.text = @"待购买";
    }

    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.navigationController pushViewController:[YJDetailController new] animated:YES];
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
