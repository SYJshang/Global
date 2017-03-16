//
//  YJGuideCenterController.m
//  全球向导
//
//  Created by SYJ on 2016/12/9.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJGuideCenterController.h"
#import "YJReceiveOrderController.h"
#import "YJServerStateVC.h"
#import "YJGCenterController.h"
#import "YJPayTypeVC.h"
#import "YJMinePropertyVC.h"


@interface YJGuideCenterController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YJGuideCenterController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"向导中心" font:19.0];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];

    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BackGray;
    
    // Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

        return 20;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 49, screen_width - 20, 0.5)];
        [cell.contentView addSubview:line];
        line.backgroundColor = BackGray;
        
        switch (indexPath.section) {
            case 0:
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"向导主页";
                    cell.imageView.image = [UIImage imageNamed:@"guide_home1"];
                }else if (indexPath.row == 1){
                    cell.textLabel.text = @"我的接单";
                    cell.imageView.image = [UIImage imageNamed:@"order_receiving"];
                }else if (indexPath.row == 2){
                    cell.textLabel.text = @"我的收款";
                    cell.imageView.image = [UIImage imageNamed:@"gathering"];
                    line.hidden = YES;
                }
                break;
            case 1:
                
                cell.textLabel.text = @"服务类型";
                cell.imageView.image = [UIImage imageNamed:@"service_type"];
                line.hidden = YES;
                
                break;
            case 2:
                
                cell.textLabel.text = @"我的财产";
                cell.imageView.image = [UIImage imageNamed:@"My_property"];
                line.hidden = YES;
                
                break;
                
            case 3:
                
                cell.textLabel.text = @"退订政策";
                cell.imageView.image = [UIImage imageNamed:@"unsubscribe_policy"];
                line.hidden = YES;
                
                break;
                
            default:
                break;
        }
        
        
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的_进入箭头"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    kTipAlert(@"<%ld> selected...", indexPath.row);
    
    if (indexPath.section == 0) {
        
        XXLog(@"点击了%ld",(long)indexPath.row);
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[YJGCenterController new] animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController: [YJReceiveOrderController new] animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController: [YJPayTypeVC new] animated:YES];

                break;
                
            default:
                break;
        }
        
        
    }
    
    if (indexPath.section == 1) {
        
        XXLog(@"点击了%ld",(long)indexPath.row);
        [self.navigationController pushViewController:[YJServerStateVC new] animated:YES];
    }else if (indexPath.section == 2) {
        
        XXLog(@"点击了%ld",(long)indexPath.row);
        [self getIsRealName];
        
    }else if (indexPath.section == 3) {
        
        XXLog(@"点击了%ld",(long)indexPath.row);
        
    }else{
        XXLog(@"点击了%ld",(long)indexPath.row);
 
    }
    
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
                
                [self.navigationController pushViewController:[YJMinePropertyVC new] animated:YES];

            }else{
                SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"未绑定支付宝，请绑定支付宝之后重试" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    
                }];
                alert.sure_btnTitleColor = TextColor;
                [alert show];
                
            }
            
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
        
        
    } failure:^(NSError *error) {
        XXLog(@"......%@",error);
        
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
