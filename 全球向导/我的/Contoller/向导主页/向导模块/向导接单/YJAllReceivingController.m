//
//  YJAllReceivingController.m
//  全球向导
//
//  Created by SYJ on 2016/12/12.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJAllReceivingController.h"
#import "YJGOrderCell.h"
#import "YJOrderBgCell.h"
#import "YJReveingDetailVC.h"
#import "CountDown.h"
#import "YJGuideReceiveModel.h"
#import "YJPageModel.h"
#import "YJChatVC.h"

@interface YJAllReceivingController ()<UITableViewDelegate,UITableViewDataSource,DisAndReceingClickPush>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic)  CountDown *countDown;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSDictionary *closeTypeMap;//交易关闭类型
@property (nonatomic, strong) NSDictionary *orderStatusMap;//订单状态
@property (nonatomic, strong) NSDictionary *successTypeMap;//订单完成类型
@property (nonatomic, strong) NSDictionary *userInfoMap;//用户映射
@property (nonatomic, strong) NSMutableArray *orderList; //订单列表

@property (nonatomic, strong) NSString *nowTime;//当前时间


@property (nonatomic, strong) YJPageModel *pageModel;  //页数列表

@property (nonatomic, strong) NoNetwork *noNetWork;

@property (nonatomic, assign) int cureenPage;
@property (nonatomic, strong) NSMutableArray *totalCout; //总数



@end

@implementation YJAllReceivingController

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


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getNetWorkData];
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
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 108, screen_width, screen_height - 108) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    [self.tableView registerClass:[YJGOrderCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[YJOrderBgCell class] forCellReuseIdentifier:@"cell1"];
    
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf= self;
    ///每秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        [weakSelf updateTimeInVisibleCells];
    }];


    //初始化
    self.successTypeMap = [NSDictionary dictionary];
    self.closeTypeMap = [NSDictionary dictionary];
    self.orderStatusMap = [NSDictionary dictionary];
    self.userInfoMap = [NSDictionary dictionary];
    
    self.cureenPage = 1;
//    self.count = 0;
    
    
    NSString *str = [YJBNetWorkNotifionTool stringFormStutas];
    XXLog(@"%@",str);
    if ([str isEqualToString:@"3"]) {
        
        //设置网络状态
        [self NetWorks];
    }
    
    
    
    // Do any additional setup after loading the view.
}

//设置网络状态
- (void)NetWorks{
    
    self.tableView.hidden = YES;
    
    [self.noNetWork removeFromSuperview];
    
    self.noNetWork = [[NoNetwork alloc]init];
    self.noNetWork.titleLabel.text = @"数据请求失败\n请设置网络之后重试";
    __weak typeof(self) weakSelf = self;
    self.noNetWork.btnBlock = ^{
        [weakSelf getNetWorkData];
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
        [weakSelf getNetWorkData];
    };
    [self.view addSubview:self.noNetWork];
}


//获取网络加载数据
- (void)getNetWorkData{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:@"1" forKey:@"currentPage"];
    [parameter setObject:@"0" forKey:@"status"];
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/guide/trade/listInit",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.totalCout = [YJGuideReceiveModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"orderList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryOrder"][@"page"]];
            
            
            self.userInfoMap = dict[@"data"][@"userInfoMap"];
            self.orderStatusMap = dict[@"data"][@"orderStatusMap"];
            self.closeTypeMap = dict[@"data"][@"closeTypeMap"];
            self.successTypeMap = dict[@"data"][@"successTypeMap"];
            
            self.nowTime = dict[@"data"][@"now"];
            
            if (self.totalCout.count == 0) {
                [self noDatas];
            }
            
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];

            
            [self.tableView reloadData];
            
        }else if ([dict[@"code"] isEqualToString:@"2"]){
            
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"登录失效,请重新登录！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
//                [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];
                [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];

            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
            
        }else{
           
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
        }
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


//获取更多
- (void)getMoreData{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    
    if (self.cureenPage < self.pageModel.totalPage) {
        self.cureenPage ++;
    }
    
    NSString *curee = [NSString stringWithFormat:@"%d",self.cureenPage];
    NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
    [parmeter setObject:curee forKey:@"currentPage"];
    [parameter setObject:@"0" forKey:@"status"];

    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/guide/trade/list",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.orderList = [YJGuideReceiveModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"orderList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryOrder"][@"page"]];
            self.nowTime = dict[@"data"][@"now"];
            
            
            for (YJGuideReceiveModel *model in self.orderList) {
                [self.totalCout addObject:model];
            }
            
            if (self.orderList.count < self.pageModel.pageSize) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }

            [self.tableView reloadData];
            
        }else if ([dict[@"code"] isEqualToString:@"2"]){
            
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"登录失效,请重新登录！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
//                [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];
                [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];

            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
            
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
        }
        
    } failure:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}




#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 155 * KHeight_Scale;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.totalCout.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJGOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    YJGuideReceiveModel *model = self.totalCout[indexPath.row];
    
    if (model.status == 1 || model.status == 7 || model.status == 2) {
        cell.timeIcon.hidden = NO;
        cell.timeLab.hidden = NO;
        cell.timeLab.text = [self getNowTimeWithString:model.limitTime];

    }else{
        cell.timeIcon.hidden = YES;
        cell.timeLab.hidden = YES;
    }
    
    
    cell.userInfo = self.userInfoMap;
    cell.orderState = self.orderStatusMap;
    cell.model = model;
    cell.delegate = self;
    cell.tag = indexPath.row;
    return cell;
    
}

- (void)btnClickEnvent:(UIButton *)sender{
    
    YJGOrderCell *cell = (YJGOrderCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
        YJGuideReceiveModel *model = self.totalCout[indexPath.row];
        XXLog(@">>>>>>>>>>>%ld",model.status);
        if (model.status == 1 || model.status == 7) {
           
            
            switch (sender.tag) {
                case 1:
                    XXLog(@"1");
                    
                    [self receiveOrder:model.ID];
                    
                    break;
                case 2:{
                    
                    [self goToChat:model];
                }

                    break;
                case 3:
                    XXLog(@"3");
                    
                    [self reduseOrder:model.ID];

                    
                    break;
                    
                default:
                    break;
            }

        }else{
            
           [self goToChat:model];
        }
}

- (void)goToChat:(YJGuideReceiveModel *)model{
    
    YJChatVC *vc = [[YJChatVC alloc]initWithConversationChatter:model.buyerId conversationType:EMConversationTypeChat];
    NSString *text1 = self.userInfoMap[model.buyerId];
    vc.title = text1;
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark - 拒绝接单

- (void)reduseOrder:(NSString *)orderId{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:orderId forKey:@"orderId"];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/trade/cancel",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.labelText = NSLocalizedString(@"拒绝接单成功", @"HUD message title");
            [hud hide:YES afterDelay:2.0];

            
            [self.tableView reloadData];
        }else if ([dict[@"code"] isEqualToString:@"2"]){
            
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"登录失效,请重新登录！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
//                [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];
                [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];

            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
            
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 接单

- (void)receiveOrder:(NSString *)orderId{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:orderId forKey:@"orderId"];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/trade/receive",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.labelText = NSLocalizedString(@"接单成功", @"HUD message title");
            [hud hide:YES afterDelay:2.0];

            
            [self.tableView reloadData];
        }else if ([dict[@"code"] isEqualToString:@"2"]){
            
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"登录失效,请重新登录！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
//                [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];
                [self.navigationController pushViewController:[YJLoginFirstController new] animated:YES];

            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
            
        }else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
        }

        
        
    } failure:^(NSError *error) {
        
    }];

    
}




#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    YJGuideReceiveModel *model = self.totalCout[indexPath.row];
    YJReveingDetailVC *vc = [[YJReveingDetailVC alloc]init];
    vc.orderId = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 倒计时
-(void)updateTimeInVisibleCells{
    NSArray  *cells = self.tableView.visibleCells; //取出屏幕可见ceLl
    for (YJGOrderCell *cell in cells) {
        
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        YJGuideReceiveModel *model = self.totalCout[cell.tag];
        
        if (model.status == 1 || model.status == 7 || model.status == 2) {

            cell.timeLab.text = [self getNowTimeWithString:model.limitTime];
            if ([cell.timeLab.text isEqualToString:@"00:00:00"]) {
                cell.stateLab.text = @"交易关闭";
                cell.timeLab.text = @"00:00:00";
                cell.timeLab.textColor = [UIColor grayColor];
               
                cell.timeIcon.hidden = YES;
                cell.timeLab.hidden = YES;
                
            }else{
                cell.timeLab.textColor = TextColor;
            }

            
        }else{
            if (model.status == 6) {
                cell.stateLab.text = @"交易关闭";
                cell.timeLab.text = @"00:00:00";
                cell.timeLab.textColor = [UIColor grayColor];
            }
        }

    }
}
-(NSString *)getNowTimeWithString:(NSString *)aTimeString{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:aTimeString];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];

    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"00:00:00";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@:%@:%@:%@", dayStr,hoursStr, minutesStr,secondsStr];
    }
    
//    XXLog(@"剩余多少     %@",[NSString stringWithFormat:@"%@:%@:%@",hoursStr , minutesStr,secondsStr]);
    
    return [NSString stringWithFormat:@"%@:%@:%@",hoursStr , minutesStr,secondsStr];
}


//将时间戳转换为NSDate类型
-(NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds
{
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000.0;//这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

//将NSDate类型的时间转换为时间戳,从1970/1/1开始
-(long long)getDateTimeTOMilliSeconds:(NSDate *)datetime
{
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    long long totalMilliseconds = interval*1000 ;
    return totalMilliseconds;
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
