//
//  YJSendOrderController.m
//  全球向导
//
//  Created by SYJ on 2016/11/14.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJSendOrderController.h"
#import "YJPhoneNumCell.h"
#import "YJAddNumCell.h"
#import "YJDataController.h"
#import "YJTimeCell.h"
#import "YJOderDataController.h"
#import "YJTextViewController.h"

@interface YJSendOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

//向导类型
@property (nonatomic, strong) UILabel *gudieLab;
//预期费用
@property (nonatomic, strong) UILabel *expectCost;


@end

@implementation YJSendOrderController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    [self setLaoutView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title= YJLocalizedString(@"发布订单");
    
    
//    [self setLaoutView];
    
    
    // Do any additional setup after loading the view.
}

- (void)setLaoutView{
    
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(8, 14, 16, 16);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    

    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = BackGray;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableview registerClass:[YJPhoneNumCell class] forCellReuseIdentifier:@"first"];
    [self.tableview registerClass:[YJAddNumCell class] forCellReuseIdentifier:@"second"];
    [self.tableview registerClass:[YJTimeCell class] forCellReuseIdentifier:@"three"];

}

- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        YJPhoneNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first"];
        switch (indexPath.row) {
            case 0:
                cell.phoneNum.text = @"订单名称";
                cell.phoneTF.placeholder = @"请输入订单名称";
                break;
            case 1:
                cell.phoneNum.text = @"目标位置";
                cell.phoneTF.placeholder = @"请输入目标位置";
                break;
   
            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
    
    if (indexPath.row == 2) {
        YJAddNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"second"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
    if (indexPath.row == 3) {
        YJTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"three"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *select = [userDefaults objectForKey:saveSelectArr];
        
        if (select.count > 0) {
            cell.time.text = [NSString stringWithFormat:@"%@开始",select.firstObject];
            cell.time.textAlignment = NSTextAlignmentRight;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
    
    if (indexPath.row > 3 && indexPath.row < 7) {
        
        YJTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"three"];
        switch (indexPath.row) {
                
            case 4:
                cell.title.text = @"向导类型";
                cell.time.text = @"选择向导类型";
                self.gudieLab = cell.time;
                break;
            case 5:
                cell.title.text = @"预期费用";
                cell.time.text = @"选择预期费用";
                self.expectCost = cell.time;
                break;
                
            case 6:
                cell.title.text = @"其他要求";
                cell.time.text = @"点击输入其他要求";
                if (self.request) {
                cell.time.text = self.request;
                }
                break;
            
            default:
                break;
        }
        
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    if (indexPath.row == 8) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cell addSubview:btn];
        [btn setTitle:YJLocalizedString(@"发布") forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sendOder) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = TextColor;
        btn.frame = CGRectMake(20, 5, screen_width - 40, 40);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10;
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor = BackGroundColor.CGColor;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BackGray;
        return cell;
  
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = BackGray;

    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
        return 40;
    }
    return 50;
    
    
    
}


#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 3) {
        
        YJOderDataController *vc = [[YJOderDataController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (indexPath.row == 4) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        // 添加按钮
        [alert addAction:[UIAlertAction actionWithTitle:@"走路向导" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.gudieLab.text = @"走路向导";
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"漂亮女向导" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.gudieLab.text = @"漂亮女向导";
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"阳光气质男向导" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.gudieLab.text = @"阳光气质男向导";
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if (indexPath.row == 5) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        // 添加按钮
        [alert addAction:[UIAlertAction actionWithTitle:@"￥1000以下" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.expectCost.text = @"￥1000以下";
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"￥1000-￥3000" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.expectCost.text = @"￥1000-￥3000";
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"￥3000以上" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.expectCost.text = @"￥3000以上";
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
    
    if (indexPath.row == 6) {
        YJTextViewController *vc = [[YJTextViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        vc.block = ^(NSString *str){
            self.request = str;
        };
    }
    
}



- (void)sendOder{
    
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
