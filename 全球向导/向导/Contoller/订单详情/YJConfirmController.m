//
//  YJConfirmController.m
//  全球向导
//
//  Created by SYJ on 2016/11/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJConfirmController.h"
#import "YJDescOrderCell.h"
#import "YJPayFormCell.h"
#import "YJPriceCell.h"
#import "YJConfirmCell.h"

@interface YJConfirmController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSArray *descArr;


@end

@implementation YJConfirmController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"订单确认" font:19.0];
    UIBarButtonItem * leftItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackGray;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[YJDescOrderCell class] forCellReuseIdentifier:@"first"];
    [self.tableView registerClass:[YJPayFormCell class] forCellReuseIdentifier:@"second"];
    [self.tableView registerClass:[YJPriceCell class] forCellReuseIdentifier:@"three"];
    [self.tableView registerClass:[YJConfirmCell class] forCellReuseIdentifier:@"four"];
    
    self.titleArr = @[@"时间",@"人数",@"联系电话",@"徒步陪同",@"其他备注",@"订单编号"];
    self.descArr = @[@"1天",@"6人",@"1234567890",@"￥100",@"无",@"ass12345678"];
    
    
    // Do any additional setup after loading the view.
}


#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 8;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 120;
        }else{
            return 40;
        }
    }
    
    return 60;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }
    
        return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            YJConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"four"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row > 0 && indexPath.row < 7) {
            
            YJDescOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first"];
            cell.name.text = self.titleArr[indexPath.row - 1];
            cell.desc.text = self.descArr[indexPath.row - 1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    
        if (indexPath.row == 7) {
            YJPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"three"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        
        
 }
    
    if (indexPath.section == 1) {
        YJPayFormCell *cell = [tableView dequeueReusableCellWithIdentifier:@"second"];
        if (indexPath.row == 0) {
            cell.icon.image = [UIImage imageNamed:@"微信"];
            cell.payName.text = @"微信支付";
        }
        
        if (indexPath.row == 1) {
            cell.icon.image = [UIImage imageNamed:@"支付宝A"];
            cell.payName.text = @"支付宝支付";
        }
       
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    
    
    static NSString *cellIdentifier = @"MTCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        if (indexPath.row ==0 ) {
            NSLog(@"微信支付");
        }
        
        if (indexPath.row == 1) {
            NSLog(@"支付宝支付");
        }
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
