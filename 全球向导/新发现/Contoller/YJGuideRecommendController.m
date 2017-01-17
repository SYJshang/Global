//
//  YJGuideRecommendController.m
//  全球向导
//
//  Created by SYJ on 2016/11/4.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJGuideRecommendController.h"
#import "YJGuideRecommendCell.h"
#import "MJRefresh.h"
#import "YJNFindGuideModel.h"
#import "YJPageModel.h"
#import "NoNetwork.h"

@interface YJGuideRecommendController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YJPageModel *pageModel;

@property (nonatomic, strong) NSMutableArray *newFindArr;//向导列表

@property (nonatomic, strong) NoNetwork *noNetWork;


@end

@implementation YJGuideRecommendController

- (NSMutableArray *)newFindArr{
    
    if (_newFindArr == nil) {
        _newFindArr = [NSMutableArray array];
    }
    
    return _newFindArr;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGray;
    [self setTableView];
    
    
    
    NSString *str = [YJBNetWorkNotifionTool stringFormStutas];
    XXLog(@"%@",str);
    if ([str isEqualToString:@"3"]) {
        
        //设置网络状态
        [self NetWorks];
    }
    
    //加载网络数据
    [self getNetWork];

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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height - 108) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[YJGuideRecommendCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getNetWork];
    }];
   
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (self.newFindArr.count < 19) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self getMoreData];
        }
        
        
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        //            [self.tableView.mj_footer endRefreshing];
        //
        //        });
        
    }];

    
}


- (void)getNetWork{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/mainGuideRec/list",BaseUrl] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        [self.noNetWork removeFromSuperview];
        self.tableView.hidden = NO;

        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            NSDictionary *data = dict[@"data"];
            
            self.pageModel = [YJPageModel mj_objectWithKeyValues:data[@"queryGuideRec"][@"page"]];
            self.newFindArr = [YJNFindGuideModel mj_objectArrayWithKeyValuesArray:data[@"guideRecList"]];
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }else{
            
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:dict[@"msg"] alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
        }
        
        
    } failure:^(NSError *error) {
        [self NetWorks];
    }];
    
}

- (void)getMoreData{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:self.pageModel.currentPage forKey:@"currentPage"];
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/mainGuideRec/list",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        [self.noNetWork removeFromSuperview];
        self.tableView.hidden = NO;
        
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            NSDictionary *data = dict[@"data"];
            XXLog(@"%@",data);
            
            self.pageModel = [YJPageModel mj_objectWithKeyValues:data[@"queryGuideRec"][@"page"]];
            self.newFindArr = [YJNFindGuideModel mj_objectArrayWithKeyValuesArray:data[@"guideRecList"]];

            
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
            
        }
        
        
    } failure:^(NSError *error) {
        
        [self getNetWork];
        
    }];
    
}



#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *arr = [NSMutableArray array];
    for (YJNFindGuideModel *model in self.newFindArr) {
        [arr addObject:model];
    }
    
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 190 * KHeight_Scale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJGuideRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil) {
        cell = [[YJGuideRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    YJNFindGuideModel *model = self.newFindArr[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    kTipAlert(@"<%ld> selected...", indexPath.row);
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
