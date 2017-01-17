//
//  YJServerStateVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/12.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJServerStateVC.h"
#import "YJServerStateCell.h"
#import "YJOtherServerVC.h"
#import "YJEditServerVC.h"

@interface YJServerStateVC ()<UITableViewDelegate,UITableViewDataSource,editBtnClickPush>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *descArr;
@property (nonatomic, strong) NSArray *iconArr;


@end

@implementation YJServerStateVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"服务类型" font:19.0];
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    [self.tableView registerClass:[YJServerStateCell class] forCellReuseIdentifier:@"cell"];
    
    self.titleArr = @[@"徒步接机",@"带车接机",@"徒步陪游",@"带车陪游",@"徒步送机",@"带车送机"];
    self.iconArr = @[@"icon3",@"icon4",@"icon5",@"icon6",@"icon7",@"icon8"];
    self.descArr = @[@"搭乘公交地铁等接机",@"向导专车接机",@"搭乘公交陪游",@"向导专车陪游",@"搭乘公众交通送机",@"向导开车送机"];
    
    // Do any additional setup after loading the view.
}



#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130 * KHeight_Scale;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJServerStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil) {
        cell = [[YJServerStateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.server.text = self.titleArr[indexPath.row];
    cell.descLab.text = self.descArr[indexPath.row];
    cell.icon.image = [UIImage imageNamed:self.iconArr[indexPath.row]];
    cell.delegate = self;
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [self.navigationController pushViewController:[YJOtherServerVC new] animated:YES];
    
}

- (void)editClickPush{
    
    XXLog(@"点击进入编辑页面");
    [self.navigationController pushViewController:[YJEditServerVC new] animated:YES];
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
