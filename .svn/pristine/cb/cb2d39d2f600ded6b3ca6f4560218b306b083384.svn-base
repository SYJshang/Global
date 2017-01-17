//
//  YJReveingDetailVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/12.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJReveingDetailVC.h"
#import "YJDescOrderCell.h"



@interface YJReveingDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSArray *descArr;

@end

@implementation YJReveingDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"接单" font:19.0];
    
    [self setBtn];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)setBtn{
    
    //拒绝接单
    UIButton *reduse = [UIButton buttonWithType:UIButtonTypeCustom];
    [reduse setTitle:@"拒绝接单" forState:UIControlStateNormal];
    [reduse setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:reduse];
    [reduse addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    reduse.tag = 1;
    reduse.layer.borderColor = BackGray.CGColor;
    reduse.layer.borderWidth = 0.5;
    reduse.sd_layout.leftEqualToView(self.view).bottomSpaceToView(self.view,0).heightIs(44).widthIs(screen_width / 4);
   
    //联系客户
    UIButton *lianxi = [UIButton buttonWithType:UIButtonTypeCustom];
    [lianxi setTitle:@"联系客户" forState:UIControlStateNormal];
    [lianxi setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:lianxi];
    [lianxi addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    lianxi.tag = 2;
    lianxi.layer.borderColor = BackGray.CGColor;
    lianxi.layer.borderWidth = 0.5;
    lianxi.sd_layout.leftSpaceToView(reduse,0).bottomSpaceToView(self.view,0).heightIs(44).widthIs(screen_width / 4);

    //联系客户
    UIButton *jiedan = [UIButton buttonWithType:UIButtonTypeCustom];
    [jiedan setTitle:@"接单" forState:UIControlStateNormal];
    [jiedan setBackgroundColor:TextColor];
    [jiedan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:jiedan];
    [jiedan addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    jiedan.tag = 3;
    jiedan.layer.borderColor = BackGray.CGColor;
    jiedan.layer.borderWidth = 0.5;
    jiedan.sd_layout.leftSpaceToView(lianxi,0).bottomSpaceToView(self.view,0).heightIs(44).rightSpaceToView(self.view,0);
    
}

- (void)btnClick:(UIButton *)btn{
    
    XXLog(@"点击了第%ld个按钮",(long)btn.tag);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 108) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    [self.tableView registerClass:[YJDescOrderCell class] forCellReuseIdentifier:@"cell"];
    
    self.titleArr = @[@"订单号",@"预订人名称",@"发现名称",@"人数",@"时间",@"联系电话",@"徒步陪同",@"其他备注",@"支付方式",@"支付金额"];
    self.descArr = @[@"1234567890",@"小傻",@"带你去看你没有见过的地方",@"2人",@"3天",@"13456678854",@"￥300 *2",@"去玩儿童与对方过后阿斯顿法国",@"微信",@"￥1000.00"];
    

    // Do any additional setup after loading the view.
}



#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJDescOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil) {
        cell = [[YJDescOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row == 4) {
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的_进入箭头"]];
    }
    
    cell.name.text = self.titleArr[indexPath.row];
    cell.name.font = [UIFont systemFontOfSize:14.0];
    cell.desc.text = self.descArr[indexPath.row];
    cell.desc.textColor = [UIColor grayColor];
    
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
