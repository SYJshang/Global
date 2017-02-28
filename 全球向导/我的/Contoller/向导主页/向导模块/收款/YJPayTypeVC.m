//
//  YJPayTypeVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/16.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJPayTypeVC.h"
#import "YJPayFormCell.h"

@interface YJPayTypeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YJPayTypeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"付款类型" font:19.0];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    [self.tableView registerClass:[YJPayFormCell class] forCellReuseIdentifier:@"cell"];

    // Do any additional setup after loading the view.
}

#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50 * KHeight_Scale;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJPayFormCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[YJPayFormCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    switch (indexPath.row) {
        case 0:
            cell.icon.image = [UIImage imageNamed:@"微信"];
            cell.payName.text = @"微信支付";
            break;
        case 1:
            cell.icon.image = [UIImage imageNamed:@"支付宝A"];
            cell.payName.text = @"支付宝支付";
            break;
        default:
            break;
    }
    
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        

        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否绑定微信账号，绑定后更改请去设置页面" preferredStyle:UIAlertControllerStyleAlert];
        
        
        //修改title
        
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"提示"];
        
        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:TextColor range:NSMakeRange(0, alertControllerStr.length)];
        
        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, alertControllerStr.length)];
        
        [alert setValue:alertControllerStr forKey:@"attributedTitle"];
        
        //修改message
        
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"是否绑定微信账号，绑定后更改请去设置页面"];
        
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, alertControllerMessageStr.length)];
        
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, alertControllerMessageStr.length)];
        
        [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
        

        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [action setValue:[UIColor grayColor] forKey:@"titleTextColor"];

        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"现在绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    if (indexPath.row == 1) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否绑定微信账号，绑定后更改请去设置页面" preferredStyle:UIAlertControllerStyleAlert];
        
        
        //修改title
        
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"提示"];
        
        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:TextColor range:NSMakeRange(0, alertControllerStr.length)];
        
        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, alertControllerStr.length)];
        
        [alert setValue:alertControllerStr forKey:@"attributedTitle"];
        
        //修改message
        
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"是否绑定支付宝账号，绑定后更改请去设置页面"];
        
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, alertControllerMessageStr.length)];
        
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, alertControllerMessageStr.length)];
        
        [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
        
        
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [action setValue:[UIColor grayColor] forKey:@"titleTextColor"];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"现在绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
        
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
