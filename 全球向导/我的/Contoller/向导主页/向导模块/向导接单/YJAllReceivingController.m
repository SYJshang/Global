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

@interface YJAllReceivingController ()<UITableViewDelegate,UITableViewDataSource,DisAndReceingClickPush>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic)  CountDown *countDown;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation YJAllReceivingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, screen_width, screen_height - 108) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    [self.tableView registerClass:[YJGOrderCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[YJOrderBgCell class] forCellReuseIdentifier:@"cell1"];
    
    self.dataSource = @[@"2016-12-13 4:24:02",@"2016-12-13 14:24:10",@"2016-12-18 6:24:17",@"2016-12-19 12:25:01",@"2016-12-15 20:24:11",@"2016-12-21 14:34:08",@"2016-12-12 14:26:03",@"2016-12-16 22:23:49",@"2016-12-14 14:23:43",@"2016-12-15 14:23:14"];
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf= self;
    ///每秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
//        NSLog(@"6");
        [weakSelf updateTimeInVisibleCells];
    }];


    
    // Do any additional setup after loading the view.
}

#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180 * KHeight_Scale;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.row == 2) {
//        
//        YJOrderBgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
//        return cell;
//        
//    }
    
   
    
    
    YJGOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil) {
        cell = [[YJGOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
    
    cell.timeLab.text = [self getNowTimeWithString:self.dataSource[indexPath.row]];
    if ([cell.timeLab.text isEqualToString:@"00:00:00"]) {
        cell.stateLab.text = @"已失效";
        cell.timeLab.textColor = [UIColor grayColor];
    }else{
        cell.timeLab.textColor = TextColor;
    }
    cell.delegate = self;
    cell.tag = indexPath.row;
    
    return cell;
    
}

- (void)btnClickEnvent:(NSInteger)tag{
    
    if (tag == 1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否立即接单" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"NO,等会" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            XXLog(@"取消按钮");
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"立即接单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            XXLog(@"立即接单");
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if (tag == 2) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"联系向导" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            XXLog(@"取消按钮");
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"立即联系" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            XXLog(@"立即联系");
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if (tag == 3) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否取消订单" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            XXLog(@"取消按钮");
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"立即取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            XXLog(@"取消订单");
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }


    
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    [self.navigationController pushViewController:[YJReveingDetailVC new] animated:YES];
    
}

#pragma mark - 倒计时
-(void)updateTimeInVisibleCells{
    NSArray  *cells = self.tableView.visibleCells; //取出屏幕可见ceLl
    for (YJGOrderCell *cell in cells) {
        cell.timeLab.text = [self getNowTimeWithString:self.dataSource[cell.tag]];
        if ([cell.timeLab.text isEqualToString:@"00:00:00"]) {
            cell.stateLab.text = @"已失效";
            cell.timeLab.textColor = [UIColor grayColor];
        }else{
            cell.timeLab.textColor = TextColor;
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
    return [NSString stringWithFormat:@"0%@:%@:%@",hoursStr , minutesStr,secondsStr];
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
