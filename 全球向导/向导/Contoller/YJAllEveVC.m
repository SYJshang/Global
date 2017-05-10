//
//  YJAllEveVC.m
//  全球向导
//
//  Created by SYJ on 2017/3/24.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJAllEveVC.h"
#import "YJPageModel.h"
#import "YJEvaModel.h"
#import "NoNetwork.h"
#import "YJEveListCell.h"
#import "SDPhotoBrowser.h"

#define kSpace 10
#define imgWidth ([UIScreen mainScreen].bounds.size.width - 65 - 20)/3//高宽相等

@interface YJAllEveVC ()<UITableViewDelegate,UITableViewDataSource,ImageDelegate,SDPhotoBrowserDelegate>{
    
    SDPhotoBrowser *photoBrowser;

}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YJPageModel *pageModel;  //页数列表

@property (nonatomic, strong) NoNetwork *noNetWork;

@property (nonatomic, assign) int cureenPage;
@property (nonatomic, strong) NSMutableArray *orderList; //订单列表
@property (nonatomic, strong) NSMutableArray *totalCout; //总数


@end

@implementation YJAllEveVC

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
    self.view.backgroundColor = BackGray;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    
    //注册cell
    [self.tableView registerClass:[YJEveListCell class] forCellReuseIdentifier:@"eveaCell"];
    
    
    self.cureenPage = 1;
    //    self.count = 0;
    
    
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
    
    
    NSMutableDictionary *parpermt = [NSMutableDictionary dictionary];
    [parpermt setObject:self.ID forKey:@"guideId"];
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/mainGuide/findEvaFinish",BaseUrl] parameters:parpermt success:^(id responseObject) {
        
        self.cureenPage = 1;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.totalCout = [YJEvaModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"evaFinishList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryEvaFinish"][@"page"]];
            
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
            
        }
        else{
            
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
        
    } failure:^(NSError *error) {
        
        //       [self getNetWork];
        
    }];
    
}

- (void)getMoreData{
    
    
    if (self.cureenPage < self.pageModel.totalPage) {
        self.cureenPage ++;
    }
    
    NSString *curee = [NSString stringWithFormat:@"%d",self.cureenPage];
    NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
    [parmeter setObject:curee forKey:@"currentPage"];
    [parmeter setObject:self.ID forKey:@"guideId"];

    [WBHttpTool Post:[NSString stringWithFormat:@"%@/mainGuide/findEvaFinish",BaseUrl] parameters:parmeter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            self.orderList = [YJEvaModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"evaFinishList"]];
            self.pageModel = [YJPageModel mj_objectWithKeyValues:dict[@"data"][@"queryEvaFinish"][@"page"]];
            
            for (YJEvaModel *model in self.orderList) {
                [self.totalCout addObject:model];
            }
            
            if (self.totalCout.count < self.pageModel.totalCount) {
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
                
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YJEvaModel *model = self.totalCout[indexPath.row];
    NSArray *imgs;

    if (model.picUrls != nil && ![model.picUrls isKindOfClass:[NSNull class]] && ![model.picUrls isEqualToString:@""]) {
       imgs = [model.picUrls componentsSeparatedByString:@","];
    }else{
        imgs = nil;
    }
    
    
    CGFloat heg;
    if (imgs.count == 0) {
        heg = 0;
  
    }else{
        heg = (kSpace+imgWidth)*(imgs.count / 4 + 1);
    }
    
    XXLog(@"cell 高度为：%f",[YJEveListCell cellHegith:model] + heg);
    
   

    
    
    return [YJEveListCell cellHegith:model] + heg;

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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJEvaModel *model = self.totalCout[indexPath.row];
//    if (model.picUrls != nil && ![model.picUrls isKindOfClass:[NSNull class]] && ![model.picUrls isEqualToString:@""]) {
//        YJEveListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eveaCell" forIndexPath:indexPath];
//        cell.myDelegate = self;
//        YJEvaModel *model = self.totalCout[indexPath.row];
//        cell.model = model;
//        
//        return cell;
// 
//    }
    
    YJEveListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eveaCell"];
    cell.model = model;
    cell.myDelegate = self;
    return cell;
    
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    

}


#pragma mark - 点击图片代理
- (void)checkImage:(NSInteger)tag{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    UIImageView *img = (UIImageView *)[self.view viewWithTag:tag];
    YJEveListCell *cell = (YJEveListCell *)[[img superview] superview];
    
    
    YJEvaModel *model = self.totalCout[indexPath.row];
    NSArray *imgs;
    if (model.picUrls) {
    imgs = [model.picUrls componentsSeparatedByString:@","];

    }
    
    photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = tag;
    photoBrowser.imageCount = imgs.count;
    photoBrowser.sourceImagesContainerView = self.tableView;
    
    [photoBrowser show];
    
}


- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    YJEvaModel *model = self.totalCout[indexPath.row];
    NSArray *imgs;
    if (model.picUrls) {
        imgs = [model.picUrls componentsSeparatedByString:@","];
        
    }
    NSURL *url = [NSURL URLWithString:imgs[index]];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    
    return [UIImage imageNamed:@"horse"];
}



//设置状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
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
