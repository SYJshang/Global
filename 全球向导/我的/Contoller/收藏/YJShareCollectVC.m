//
//  YJShareCollectVC.m
//  全球向导
//
//  Created by SYJ on 2017/2/13.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJShareCollectVC.h"
#import "YJShareCollectCell.h"
#import "YJDIYButton.h"
#import "YJNearbyModel.h"
#import "YJPageModel.h"
#import "NoNetwork.h"

@interface YJShareCollectVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NoNetwork *noNetWork; //空白页面

@property (nonatomic, strong) YJPageModel *pageModel; //页数
@property (nonatomic, strong) NSMutableArray *shareList; //分享列表



@end

@implementation YJShareCollectVC

- (NSMutableArray *)shareList{
    
    if (_shareList == nil) {
        _shareList = [NSMutableArray array];
    }
    return _shareList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self setTableView];
    
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
        [weakSelf getNetWork];
    };
    [self.view addSubview:self.noNetWork];
}


//加载tableView
- (void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, screen_width, screen_height - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[YJShareCollectCell class] forCellReuseIdentifier:@"cell"];
    
    [self getNetWork];
    
}

- (void)getNetWork{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/userInfo/myColUserRec/list",BaseUrl] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        self.shareList = [YJNearbyModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"colUserRecList"]];
        
        self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryColUserRec"][@"page"]];
        
        if (self.shareList.count == 0) {
            
            self.tableView.hidden = YES;
            
            self.noNetWork = [[NoNetwork alloc]init];
            self.noNetWork.titleLabel.text = @"暂无数据\n赶紧搞出点事情吧...";
            //            self.noNetWork.btnBlock = ^{
            //                [weakSelf getNetWork];
            //            };
            self.noNetWork.btrefresh.hidden = YES;
            
            [self.view addSubview:self.noNetWork];
            
        }else{
            
            [self.noNetWork removeFromSuperview];
            self.tableView.hidden = NO;
        }
        
        
        XXLog(@"%@",self.pageModel.nextPage);
        
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shareList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180 * KWidth_Scale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJShareCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    YJNearbyModel *model = self.shareList[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
