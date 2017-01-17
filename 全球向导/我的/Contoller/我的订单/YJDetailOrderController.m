//
//  YJDetailOrderController.m
//  全球向导
//
//  Created by SYJ on 2016/12/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJDetailOrderController.h"
#import "YJDescOrderCell.h"
#import "YJConfirmCell.h"


@interface YJDetailOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSArray *descArr;

@end

@implementation YJDetailOrderController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
 
    [self setBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:btn];
//    [btn setTitle:@"ceshi" forState:UIControlStateNormal];
//    [btn setBackgroundColor:[UIColor grayColor]];
//    btn.frame = CGRectMake(0, 563, screen_width, 40);
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, screen_width, screen_height - 148) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    [self.tableView registerClass:[YJDescOrderCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[YJConfirmCell class] forCellReuseIdentifier:@"cell1"];
    
    self.titleArr = @[@"时间",@"人数",@"联系电话",@"徒步陪同",@"其他备注",@"合计"];
    self.descArr = @[@"1天",@"6人",@"1234567890",@"￥100 * 3",@"无",@"￥3000"];
    
    // Do any additional setup after loading the view.
}

- (void)setBtn{
    
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    view.frame = CGRectMake(0, screen_height - 104, screen_width, 1);
    view.backgroundColor = BackGray;
    
    
    
    
    YJButton *guide_home = [[YJButton alloc]initWithFrame:CGRectMake(0, screen_height - 103, 80 * KWidth_Scale, 39)];
    [self.view addSubview:guide_home];
    [guide_home setBackgroundColor:[UIColor whiteColor]];
    [guide_home setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [guide_home setTitle:@"向导主页" forState:UIControlStateNormal];
    [guide_home setImage:[UIImage imageNamed:@"guide_home"] forState:UIControlStateNormal];
    
    
    YJButton *contact_guide = [[YJButton alloc]initWithFrame:CGRectMake(80 * KWidth_Scale, screen_height - 103, 80 * KWidth_Scale, 39)];
    [self.view addSubview:contact_guide];
    [contact_guide setBackgroundColor:[UIColor whiteColor]];
    [contact_guide setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [contact_guide setTitle:@"联系向导" forState:UIControlStateNormal];
    [contact_guide setImage:[UIImage imageNamed:@"contact_guide"] forState:UIControlStateNormal];
    
    UIButton *buy = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buy];
    buy.frame = CGRectMake(160 * KWidth_Scale, screen_height - 103, screen_width - (160 * KWidth_Scale), 39);
    buy.backgroundColor = TextColor;
    [buy setTitle:@"付款" forState:UIControlStateNormal];
    [buy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}


#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.row == 0) {
        return 120;
    }

    return 50;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
        if (indexPath.row == 0) {
            YJConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    
        if (indexPath.row > 0 && indexPath.row < 7) {
            
            YJDescOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.name.text = self.titleArr[indexPath.row - 1];
            cell.desc.text = self.descArr[indexPath.row - 1];
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
