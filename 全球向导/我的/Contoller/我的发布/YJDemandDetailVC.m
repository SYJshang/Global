//
//  YJDemandDetailVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/29.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJDemandDetailVC.h"
#import "YJDescOrderCell.h"
#import "YJOtherDemandCell.h"

@interface YJDemandDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSArray *descArr;

@property (nonatomic, strong) NSString *text;

@end

@implementation YJDemandDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"需求详情" font:19.0];
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
    [self.tableView registerClass:[YJOtherDemandCell class] forCellReuseIdentifier:@"second"];
    
    self.titleArr = @[@"订单名称",@"目标位置",@"日期",@"人数",@"向导类型",@"预期费用"];
    self.descArr = @[@"宁波一日游",@"宁波",@"2016/10/28开始",@"3人",@"地接",@"100-200"];
    self.text = @"清风徐来又是一年花开时，漫天落英洋洋洒洒，十里纷扬，铺成一场盛世花雨又是一年花开时，漫天落英洋洋洒洒，十里纷扬，铺成一场盛世花雨又是一年花开时，漫天落英洋洋洒洒，十里纷扬，铺成一场盛世花雨又是一年花开时，漫天落英洋洋洒洒，十里纷扬，铺成一场盛世花雨又是一年花开时，漫天落英洋洋洒洒，十里纷扬，铺成一场盛世花雨";
    
    // Do any additional setup after loading the view.
}

#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 6) {
        return [YJOtherDemandCell cellHegith:self.text];
    }
    
    return 60 * KHeight_Scale;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 6) {
        YJOtherDemandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"second"];
        cell.name.text = @"其他要求";
        cell.desc.text = self.text;
        return cell;
    }
    
    YJDescOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first"];
    if (cell == nil) {
        cell = [[YJDescOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"first"];
    }
    cell.name.text = self.titleArr[indexPath.row];
    cell.desc.text = self.descArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
