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
#import <AlipaySDK/AlipaySDK.h>

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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[YJDescOrderCell class] forCellReuseIdentifier:@"first"];
    [self.tableView registerClass:[YJPayFormCell class] forCellReuseIdentifier:@"second"];
    [self.tableView registerClass:[YJPriceCell class] forCellReuseIdentifier:@"three"];
    [self.tableView registerClass:[YJConfirmCell class] forCellReuseIdentifier:@"four"];
    
    XXLog(@"%@",self.model);
    
    self.titleArr = @[@"时间",@"人数",@"联系电话",@"订单编号",@"其他备注"];
//    self.descArr = @[@"1天",@"6人",@"1234567890",@"12345",@"无",@"ass12345678"];
    
    
    if (self.model == nil) {
        [self getNetWorkData];
    }
    
    
    // Do any additional setup after loading the view.
}


- (void)getNetWorkData{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:self.orderID forKey:@"orderId"];
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/userInfo/myOrder/toPay",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.model = [YJOrderFinshModel mj_objectWithKeyValues:dict[@"data"]];
            
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


#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 6;
    }else if (section == 1){
        return self.model.orderDetailList.count + 1;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 120;
        }
        
        return 40;
        
    }else if (indexPath.section == 1){
        
        return 40;
    }
    
    return 60;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        return 10;
    }
    
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            YJConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"four"];
            [cell.icon sd_setImageWithURL:[NSURL URLWithString:self.model.showPicUrl] placeholderImage:[UIImage imageNamed:@"HeaderIcon"]];
            cell.name.text = [NSString stringWithFormat:@"%@/%@",self.model.bigTitle,self.model.smallTitle];
            return cell;
        }
        if (indexPath.row > 0 && indexPath.row < 6) {
            
            YJDescOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first"];
            cell.name.text = self.titleArr[indexPath.row - 1];
            
//            @[@"时间",@"人数",@"联系电话",@"订单编号",@"其他备注"]
            switch (indexPath.row) {
                case 1:
                    cell.desc.text = self.model.serviceNumber;
                    break;
                case 2:
                    cell.desc.text = self.model.personNumber;
                    break;
                case 3:
                    cell.desc.text = self.model.phone;
                    break;
                case 4:
                    cell.desc.text = self.model.orderNo;

                    break;
                case 5:
                    cell.desc.text = self.model.remark;
                    break;
                default:
                    break;
            }
            
//            cell.desc.text = self.descArr[indexPath.row - 1];
            return cell;
        }
    }else if (indexPath.section == 1){
        
        if (indexPath.row < self.model.orderDetailList.count) {
             YJDescOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first"];
            self.serModel = self.model.orderDetailList[indexPath.row];
            cell.name.text = self.serModel.productName;
            cell.desc.text = [NSString stringWithFormat:@"%@ %@ * %@",self.serModel.productDesc,self.serModel.price,self.serModel.number];
            return cell;
        }else{
            
            YJPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"three"];
//            cell.text = self.model.totalMoney;
            cell.model = self.model;
            return cell;
        }
        
    }else if (indexPath.section == 2) {
        
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"12345678";
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        if (indexPath.row ==0 ) {
            NSLog(@"微信支付");
        }
        
        if (indexPath.row == 1) {
            NSLog(@"支付宝支付");
            [self payOrder];
        }
    }
    
}

//支付
- (void)payOrder{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
//    [parameter setObject:self.orderID forKey:@"orderId"];
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myOrder/findAppPay/%@",BaseUrl,self.orderID] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
           
            
            // NOTE: 调用支付结果开始支付
//            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//                NSLog(@"reslut = %@",resultDic);
//            }];
            
            NSString *appScheme = @"alisdkdemo";
            NSString *order = dict[@"data"][@"payParam"];
            
            [[AlipaySDK defaultService] payOrder:order fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.contentColor = [UIColor whiteColor];
                hud.color = [UIColor blackColor];
                hud.label.text = NSLocalizedString(@"支付成功!", @"HUD message title");
                [hud hideAnimated:YES afterDelay:2.f];
                
                NSLog(@"reslut = %@",resultDic);


            }];


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
