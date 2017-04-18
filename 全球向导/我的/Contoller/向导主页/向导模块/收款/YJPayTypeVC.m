//
//  YJPayTypeVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/16.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJPayTypeVC.h"
#import "YJPayFormCell.h"
#import "YJPayBindingVC.h"

@interface YJPayTypeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isReal;

@end

@implementation YJPayTypeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:YJLocalizedString(@"付款类型") font:19.0];
    
    [self getIsRealName];

}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    [self.tableView registerClass:[YJPayFormCell class] forCellReuseIdentifier:@"cell"];
    
    self.isReal = NO;
    

    // Do any additional setup after loading the view.
}

//获取是否绑定状态
- (void)getIsRealName{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/guide/accountBind/viewCur",BaseUrl] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"] ) {
            
            NSString *str = dict[@"data"][@"alipayAccount"];
            XXLog(@"%@",str);
            
            if (![str isEqual:[NSNull null]]) {
                self.isReal = YES;
            }else{
                self.isReal = NO;
            }
            
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];

        }
        
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        XXLog(@"......%@",error);
        
    }];
    
}


#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        YJPayFormCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.icon.image = [UIImage imageNamed:@"pay-treasure"];
        cell.payName.text = YJLocalizedString(@"支付宝");
        if (self.isReal == YES) {
            cell.isReal.text = @"已绑定";
            cell.isReal.textColor = TextColor;
        }else{
            cell.isReal.text = @"未绑定";
            cell.isReal.textColor = [UIColor lightGrayColor];
        }
        return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        
        if (self.isReal) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否立即绑定微信账号" preferredStyle:UIAlertControllerStyleAlert];
            
            
            //修改title
            
            NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"提示"];
            
            [alertControllerStr addAttribute:NSForegroundColorAttributeName value:TextColor range:NSMakeRange(0, alertControllerStr.length)];
            
            [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, alertControllerStr.length)];
            
            [alert setValue:alertControllerStr forKey:@"attributedTitle"];
            
            //修改message
            
            NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"是否解除绑定"];
            
            [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, alertControllerMessageStr.length)];
            
            [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, alertControllerMessageStr.length)];
            
            [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
            
            
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [action setValue:[UIColor grayColor] forKey:@"titleTextColor"];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                //取消绑定
                [self cancleBinding];
            }];
            
            [alert addAction:action];
            [alert addAction:action1];
            [self presentViewController:alert animated:YES completion:nil];
            

        }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否立即绑定账号" preferredStyle:UIAlertControllerStyleAlert];
        
        
        //修改title
        
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"提示"];
        
        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:TextColor range:NSMakeRange(0, alertControllerStr.length)];
        
        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, alertControllerStr.length)];
        
        [alert setValue:alertControllerStr forKey:@"attributedTitle"];
        
        //修改message
        
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"是否立即绑定账号"];
        
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, alertControllerMessageStr.length)];
        
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, alertControllerMessageStr.length)];
        
        [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
        

        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [action setValue:[UIColor grayColor] forKey:@"titleTextColor"];

        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"现在绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController pushViewController:[YJPayBindingVC new] animated:YES];
        }];
        
        [alert addAction:action];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
        
        }
    }
}

//取消绑定
- (void)cancleBinding{
  
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/accountBind/unbindAlipay",BaseUrl] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.labelText = NSLocalizedString(@"接触绑定成功", @"HUD message title");
            [hud hide:YES afterDelay:2.0];

            self.isReal = NO;
            [self.tableView reloadData];
            
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
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
