//
//  YJMessageVC.m
//  全球向导
//
//  Created by SYJ on 2017/3/23.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJMessageVC.h"
#import "YJChatVC.h"
#import "YJChatCell.h"

@interface YJMessageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;



@end

@implementation YJMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];

    [self.tableView registerClass:[YJChatCell class] forCellReuseIdentifier:@"cell"];
    
    // Do any additional setup after loading the view.
}

#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YJChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSArray *icon = @[@"bg1",@"bg2",@"login_bg",@"register_bg",@"HeaderIcon",@"123",@"456"];
    NSArray *name = @[@"小苗",@"张先生",@"全球向导",@"吖吖",@"w(ﾟДﾟ)w",@"JJ",@"阿拉蕾"];
    NSArray *message = @[@"到哪了？",@"[发来一段语音]",@"语音通话结束",@"退款已经打入你的账号",@"我到了",@"你看见了我了吗",@"没有来了"];
    NSArray *time = @[@"11:12",@"09:23",@"08:45",@"昨天",@"昨天",@"前天",@"12/29"];
    cell.icon.image = [UIImage imageNamed:icon[indexPath.row]];
    cell.name.text = name[indexPath.row];
    cell.message.text = message[indexPath.row];
    cell.time.text = time[indexPath.row];
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    kTipAlert(@"<%ld> selected...", indexPath.row);
    
    YJChatVC *vc = [[YJChatVC alloc]initWithConversationChatter:@"24" conversationType:EMConversationTypeChat];
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
