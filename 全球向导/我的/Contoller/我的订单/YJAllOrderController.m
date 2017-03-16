//
//  YJAllOrderController.m
//  全球向导
//
//  Created by SYJ on 2016/12/7.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJAllOrderController.h"
#import "YJAllOrderCell.h"
#import "YJDetailController.h"
#import "YJOrderListModel.h"
#import "YJPageModel.h"
#import "NoNetwork.h"
#import "YJConfirmController.h"



@interface YJAllOrderController ()<UITableViewDelegate,UITableViewDataSource,YJBtnClickEvE>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *orderList; //订单列表
@property (nonatomic, strong) YJPageModel *pageModel;  //页数列表

@property (nonatomic, strong) NoNetwork *noNetWork;

@property (nonatomic, assign) int cureenPage;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSMutableArray *totalCout; //总数


@end

@implementation YJAllOrderController

- (NSMutableArray *)totalCout{
    
    if (_totalCout == nil) {
        _totalCout = [NSMutableArray array];
    }
    return _totalCout;
}

- (NSMutableArray *)orderList{
    
    if (_orderList == nil) {
        _orderList = [NSMutableArray array];
    }
    return _orderList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    
//    1待付款 2待服务 3交易成功  4买家申请退款中 5向导申请退款中 6交易关闭 7待接单
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"待付款" forKey:@"1"];
    [dict setObject:@"待服务" forKey:@"2"];
    [dict setObject:@"交易成功" forKey:@"3"];
    [dict setObject:@"买家申请退款中" forKey:@"4"];
    [dict setObject:@"向导申请退款中" forKey:@"5"];
    [dict setObject:@"交易关闭" forKey:@"6"];
    [dict setObject:@"待接单" forKey:@"7"];

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dict forKey:@"orderStatus"];
    
//    NSDictionary *order = [defaults objectForKey:@"orderStatus"];
//    
//    XXLog(@"%@",order);
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, screen_width, screen_height - 108) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];

    //注册cell
    [self.tableView registerClass:[YJAllOrderCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.cureenPage = 1;
    self.count = 0;

    
    NSString *str = [YJBNetWorkNotifionTool stringFormStutas];
    XXLog(@"%@",str);
    if ([str isEqualToString:@"3"]) {
        
        //设置网络状态
        [self NetWorks];
    }
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getNetWork];
    }];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
      
        if (self.pageModel.totalCount <= self.totalCout.count ) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            [self getMoreData];
        }

        
    }];


    
//    [self getNetWork];
}


//设置网络状态
- (void)NetWorks{
    
    self.tableView.hidden = YES;
    
    [self.noNetWork removeFromSuperview];
    
    self.noNetWork = [[NoNetwork alloc]init];
    self.noNetWork.titleLabel.text = @"数据请求失败\n请设置网络之后重试";
    __weak typeof(self) weakSelf = self;
    self.noNetWork.btnBlock = ^{
        [weakSelf getNetWork];
    };
    [self.view addSubview:self.noNetWork];
}

- (void)noDatas{
    
    self.tableView.hidden = YES;
    
    [self.noNetWork removeFromSuperview];
    
    self.noNetWork = [[NoNetwork alloc]init];
    self.noNetWork.btrefresh.hidden = YES;
    self.noNetWork.titleLabel.text = @"暂无数据\n赶快去整出动静吧。。";
    __weak typeof(self) weakSelf = self;
    self.noNetWork.btnBlock = ^{
        [weakSelf getNetWork];
    };
    [self.view addSubview:self.noNetWork];
}


- (void)getNetWork{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/userInfo/myOrder/list",BaseUrl] parameters:nil success:^(id responseObject) {
        
        self.cureenPage = 1;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.totalCout = [YJOrderListModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"orderList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryOrder"][@"page"]];
         
            if (self.totalCout.count == 0) {
                [self noDatas];
            }

            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
        
    } failure:^(NSError *error) {
        
       [self getNetWork];
        
    }];
    
}

- (void)getMoreData{
    
    
    if (self.cureenPage < self.pageModel.totalPage) {
       self.cureenPage ++;
    }
    
    NSString *curee = [NSString stringWithFormat:@"%d",self.cureenPage];
    NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
    [parmeter setObject:curee forKey:@"currentPage"];
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myOrder/list",BaseUrl] parameters:parmeter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.orderList = [YJOrderListModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"orderList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryOrder"][@"page"]];
            
            for (YJOrderListModel *model in self.orderList) {
                [self.totalCout addObject:model];
            }

            if (self.orderList.count < self.pageModel.pageSize) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            
            
            [self.tableView reloadData];
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
        
    } failure:^(NSError *error) {
        
        [self getNetWork];
        
    }];
    
}


#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 190 * KHeight_Scale;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    XXLog(@"当前是共 %ld",self.totalCout.count);
    
    if (self.totalCout) {
        return self.totalCout.count;
    }
    
    return 0;

//    return self.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJAllOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) {
        cell = [[YJAllOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.delegate = self;
    YJOrderListModel *model = self.totalCout[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJOrderListModel *model = self.totalCout[indexPath.row];
    YJDetailController *vc = [[YJDetailController alloc]init];
    vc.orderID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnDidClickPlusButton:(UIButton *)ViewTag{
    
    XXLog(@"点击了第 %ld 个按钮",ViewTag.tag);
    
    YJAllOrderCell *cell = (YJAllOrderCell *)[[ViewTag superview]superview];
    //获取cell
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //获取当前选中cell
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    YJOrderListModel *model = self.totalCout[indexPath.row];
    
        switch (model.status) {
         
        case 1:{
            
            if (ViewTag.tag == 1) {
                XXLog(@"联系向导");
                
            }else if (ViewTag.tag == 2){
                YJConfirmController *vc = [[YJConfirmController alloc]init];
                vc.orderID = model.ID;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                [self cancleOrder:model.ID];
                XXLog(@"取消订单");
                
            }
             }
                break;

            case 2:{
            
            if (ViewTag.tag == 1) {
                XXLog(@"联系向导");
                
            }else if (ViewTag.tag == 2){
                [self getRefundMoney:model.ID];
                
            }else{
                [self affirmOrder:model.ID];
            }
        }
            
            break;
            
        case 3:{
            
            if (ViewTag.tag == 1) {
                XXLog(@"再次预定");
                YJConfirmController *vc = [[YJConfirmController alloc]init];
                vc.orderID = model.ID;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
               
                XXLog(@"去评价");
            }
        }
            
            break;
            
        case 4:{
            
            if (ViewTag.tag == 1) {
                XXLog(@"联系向导");
                
            }else{
                
                XXLog(@"不做操作");
            }
        }
            
            break;
        case 5:{
            
            if (ViewTag.tag == 1) {
                XXLog(@"联系向导");
                
            }else{
                
                XXLog(@"不做操作");
            }
        }
            
            break;
        case 6:{
            
            if (ViewTag.tag == 1) {
                XXLog(@"联系向导");
                
            }else{
                
                XXLog(@"不做操作");
            }
        }
            
            break;
            break;
        case 7:{
            
            if (ViewTag.tag == 1) {
                XXLog(@"联系向导");
                
            }else{
                
                XXLog(@"不做操作");
                [self cancleOrder:model.ID];
            }
        }
            
            break;

            
        default:
            
            if (ViewTag.tag == 1) {
                XXLog(@"联系向导");
                
            }
            break;
            
        
        
        
    }
}

//确认订单
- (void)affirmOrder:(NSString *)orderId{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:orderId forKey:@"orderId"];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myOrder/confirm",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.contentColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.label.text = NSLocalizedString(@"确认成功!", @"HUD message title");
            [hud hideAnimated:YES afterDelay:2.f];

            [self.tableView.mj_header beginRefreshing];
            
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];

    
}


//获取退款金额
- (void)getRefundMoney:(NSString *)orderId{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:orderId forKey:@"orderId"];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myOrder/findRefundMoney",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            NSString *title = [NSString stringWithFormat:@"当前可退款金额%@，确认无误后点击取消订单",dict[@"data"][@"refundMoney"]];
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:title alertViewBottomViewType:SGAlertViewBottomViewTypeTwo didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
                if (index == 1) {
                    [self cancleOrderForFinsh:orderId money:dict[@"data"][@"refundMoney"]];
                }
                
            }];
            alert.sure_btnTitleColor = TextColor;
            alert.sure_btnTitle = @"确认取消";
            [alert show];
            
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];

}



//取消待支付、待接单订单
- (void)cancleOrder:(NSString *)orderId{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:orderId forKey:@"orderId"];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myOrder/cancel",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.contentColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.label.text = NSLocalizedString(@"取消成功!", @"HUD message title");
            [hud hideAnimated:YES afterDelay:2.f];
            
            [self.tableView.mj_header beginRefreshing];
            
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

//取消待服务订单
- (void)cancleOrderForFinsh:(NSString *)orderId money:(NSString *)money{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:orderId forKey:@"orderId"];
    [parameter setObject:money forKey:@"refundMoney"];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/userInfo/myOrder/cancel2",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.contentColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.label.text = NSLocalizedString(@"取消成功!", @"HUD message title");
            [hud hideAnimated:YES afterDelay:2.f];
            
            [self.tableView.mj_header beginRefreshing];
        
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];

        }
        
        
    } failure:^(NSError *error) {
        
        XXLog(@"%@",error);
        
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
