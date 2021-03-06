//
//  ViewController.m
//  全球向导
//
//  Created by SYJ on 2016/10/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "ViewController.h"
#import "YJFirstCell.h"
#import "YJSecondCell.h"
#import "YJThreeCell.h"
#import "YJFourCell.h"
#import "FTPopOverMenu.h"
#import "YJAreaMianVC.h"
#import "YJUserModel.h"
#import "YJLunBoModel.h"
#import "YJGuideModel.h"
#import "YJNearbyModel.h"
#import "YJNewFindModel.h"
#import "YJBNetWorkNotifionTool.h"
#import "YJLunboWebVC.h"
#import "YJLocaController.h"
#import "YJMoreUserShareVC.h"
#import "YJMoreGuideVC.h"
#import "YJGuideRecVC.h"
#import "YJShareDetailVC.h"
#import "YJGuideDetailVC.h"
#import "YJUsreInfoModel.h"
#import "YJTravelController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,LunboDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YJUserModel *userModel;
@property (nonatomic, strong) NSDictionary *guideType;
@property (nonatomic, strong) NoNetwork *noNetWork;

@property (nonatomic, strong) NSMutableArray *lunboImgArr;//轮播图片点击跳转的url


@property (nonatomic, strong) UIButton *areaBtn; //地区按钮

@property (nonatomic, strong) NSString *cityID;

@property (nonatomic, strong) NSString *guideStatus;

@end

@implementation ViewController


- (NSMutableArray *)lunboImgArr{
    
    if (_lunboImgArr == nil) {
        _lunboImgArr = [NSMutableArray array];
    }
    return _lunboImgArr;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //获取版本信息
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/getAppVersion",BaseUrl] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            XXLog(@"%@",dict);
            NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
            NSString *ver = [NSString stringWithFormat:@"%@",dict[@"data"][@"curVersion"]];
            NSString *minver = [NSString stringWithFormat:@"%@",dict[@"data"][@"minVersion"]];

            
            if ([currentVersion compare:ver options:NSNumericSearch] == NSOrderedDescending || currentVersion == ver)
            {
            }else
            {
                
                if ([currentVersion compare:minver options:NSNumericSearch] == NSOrderedDescending  || currentVersion == minver) {
                    
                    SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"有新版本升级，是否立即升级？" alertViewBottomViewType:(SGAlertViewBottomViewTypeTwo) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    }];
                    alertV.sure_btnTitleColor = TextColor;
                    alertV.sure_btnTitle = @"立即升级";
                    [alertV show];
                    
                }else{
                    
                    SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"当前版本过小，部分功能可能无法使用，是否升级？" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    }];
                    alertV.sure_btnTitleColor = TextColor;
                    alertV.sure_btnTitle = @"立即升级";
                    [alertV show];
                    
                }
                
            }
            
            
        }
        
    } failure:^(NSError *error) {
        
    }];

}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.userModel = nil;
}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self getUserInfo];
    
    //设置导航控制器
    [self setNavitaion];
    
    [self getNetWork];

    NSString *str = [YJBNetWorkNotifionTool stringFormStutas];
    XXLog(@"%@",str);
    if ([str isEqualToString:@"3"]) {
        
        //设置网络状态
        [self NetWorks];
    }
    
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
   
       
    
    self.guideType = [NSDictionary dictionary];
    //设置tableView
    [self setTable];
    
    self.cityID = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];

    
    __weak __typeof(self) weakSelf = self;
    
    //添加刷新
    weakSelf.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getNetWork];
    }];
    

    //自动更改透明度
    weakSelf.tableView.mj_header.automaticallyChangeAlpha = YES;
    [weakSelf.tableView.mj_header beginRefreshing];
    
    weakSelf.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getMoreData];
    }];

    
    
    
}

- (void)setNavitaion{
    
    self.view.backgroundColor = BackGray;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = TextColor;
    
    self.areaBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.areaBtn.frame = CGRectMake(0, 7, 50, 30);
    [self.areaBtn setImageEdgeInsets:UIEdgeInsetsMake(-5,-15, -5, 0)];
    [self.areaBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, -15)];
    [self.areaBtn setImage:[UIImage imageNamed:@"position"] forState:UIControlStateNormal];
    self.areaBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.areaBtn setTitleColor:TextColor forState:UIControlStateNormal];
    
    NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
    if (cityName) {
        [self.areaBtn setTitle:cityName forState:UIControlStateNormal];
        
    }else{
        [self.areaBtn setTitle:@"北京市" forState:UIControlStateNormal];
    }
    [self.areaBtn addTarget:self action:@selector(location) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.areaBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 10, 22, 22);
    [btn addTarget:self action:@selector(onNavButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.titleView = [UILabel titleWithColor:TextColor title:YJLocalizedString(@"首页") font:AdaptedWidth(19.0)];
    
}

- (void)setTable{
    
    //穿创建tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //tableView的代理
    __weak __typeof(self) weakSelf = self;
    _tableView.delegate = weakSelf;
    _tableView.dataSource = weakSelf;
    //去掉tableView自带的线
    weakSelf.tableView.tableFooterView = [UIView new];
    
    
    //tableView的背景
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    //注册cell
    [_tableView registerClass:[YJFirstCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[YJSecondCell class] forCellReuseIdentifier:@"secCell"];
    [_tableView registerClass:[YJThreeCell class] forCellReuseIdentifier:@"thCell"];
    [_tableView registerClass:[YJFourCell class] forCellReuseIdentifier:@"forCell"];
  //    weakSelf.tableView.mj_footer.hidden = YES;
}



- (void)getUserInfo{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/user/getCurrentUserInfo",BaseUrl] parameters:nil success:^(id responseObject) {
        
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:dict[@"code"] forKey:@"code"];
        [userDefault synchronize];
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            NSDictionary *da = dict[@"data"];
            self.guideStatus = [NSString stringWithFormat:@"%@",dict[@"guideStatus"]];
            
            NSDictionary *usrInfo = da[@"userInfo"];
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"userInfo.plist"];
            [NSKeyedArchiver archiveRootObject:usrInfo toFile:path];
            

            YJUsreInfoModel *userModel = [YJUsreInfoModel mj_objectWithKeyValues:da[@"userInfo"]];
            
            BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
            if (!isAutoLogin) {
                
                [[EMClient sharedClient] loginWithUsername:userModel.ID
                                                  password:userModel.imPwd
                                                completion:^(NSString *aUsername, EMError *aError) {
                                                    if (!aError) {
                                                        [[EMClient sharedClient].options setIsAutoLogin:YES];
                                                        
                                                    } else {
                                                    }
                                                }];
                
            }
            
            [self.tableView reloadData];
            
        }else{
            
            return ;
        
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}




- (void)getNetWork{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    if (self.cityID) {
        [parameter setObject:self.cityID forKey:@"cityId"];
    }
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/mainApp/list",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
        
        [self.noNetWork removeFromSuperview];
        self.tableView.hidden = NO;
        //设置tableView
        self.userModel = [YJUserModel mj_objectWithKeyValues:dict[@"data"]];
        self.guideType = self.userModel.guideTypeMap;
//
            XXLog(@"刷新了tableview");
            //获取完成数据之后结束刷新
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];

        }else{
            
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:dict[@"msg"] alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
        }
        
        
        
    } failure:^(NSError *error) {
        XXLog(@"error >>>>>%@",error);
        [self NetWorks];
    }];
}

- (void)getMoreData{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    if (self.cityID) {
        [parameter setObject:self.cityID forKey:@"cityId"];
    }
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/mainApp/list",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"dict >>>>>%@",dict);
        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            [self.noNetWork removeFromSuperview];
            self.tableView.hidden = NO;
            //设置tableView
            self.userModel = [YJUserModel mj_objectWithKeyValues:dict[@"data"]];
            self.guideType = self.userModel.guideTypeMap;
            //
            XXLog(@"%@",self.userModel.guideTypeMap);
            [self.tableView reloadData];
            //获取完成数据之后结束刷新
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.tableView.mj_footer.hidden = YES;
            
            
        }else{
            
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:dict[@"msg"] alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
        }
        
        
        
    } failure:^(NSError *error) {
        XXLog(@"error >>>>>%@",error);
        [self NetWorks];
    }];
}



- (void)onNavButtonTapped:(UIBarButtonItem *)sender event:(UIEvent *)event
{
    

    
    [FTPopOverMenu showFromEvent:event
                        withMenu:@[YJLocalizedString(@"发布订单"),YJLocalizedString(@"发布分享"),YJLocalizedString(@"发布发现")]
                  imageNameArray:@[@"release-found",@"release-order",@"release-strategy"]
                       doneBlock:^(NSInteger selectedIndex) {
                           
            
            if (selectedIndex == 0) {
                
                    SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"功能开发中" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    }];
                    alertV.sure_btnTitleColor = TextColor;
                    [alertV show];
                
            }else if (selectedIndex == 1){
                
              NSString *code =  [[NSUserDefaults standardUserDefaults] objectForKey:@"code"];
                if ([code isEqualToString:@"1"]) {
                    
                    YJTravelController *vc = [[YJTravelController alloc]init];
                    vc.state = @"1";
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    
                    SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"未登录" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    }];
                    alertV.sure_btnTitleColor = TextColor;
                    [alertV show];
                    
                }

                
                
            }else if (selectedIndex == 2){
                
                NSString *code =  [[NSUserDefaults standardUserDefaults] objectForKey:@"code"];
                if ([code isEqualToString:@"1"] && [self.guideStatus isEqualToString:@"2"]) {
                    YJTravelController *vc = [[YJTravelController alloc]init];
                    vc.state = @"2";
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"未登录" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    }];
                    alertV.sure_btnTitleColor = TextColor;
                    [alertV show];
                    
                }


            }
                           
                       } dismissBlock:^{
                           
                           
                           
                       }];

    
    
}





- (void)location{
    
    YJLocaController *locati = [[YJLocaController alloc]init];
    
    [locati returnText:^(NSString *cityname) {
        
    self.navigationController.navigationBar.tintColor = TextColor;
    [self.areaBtn setTitle:cityname forState:UIControlStateNormal];
    XXLog(@"%@",self.areaBtn.titleLabel.text);
        
        NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
        NSArray *cityArr = [userdefault objectForKey:@"cityArr"];
        NSArray *cityID = [userdefault objectForKey:@"cityID"];
        XXLog(@"cityArr .........%@",cityArr);
        XXLog(@"cityID .........%@",cityID);
        [cityArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isEqualToString:cityname]) {
                XXLog(@"%ld",idx);
                [userdefault removeObjectForKey:@"city"];
                [userdefault removeObjectForKey:@"cityName"];

                self.cityID = cityID[idx];
                XXLog(@"%@",self.cityID);
                
                [userdefault setObject:self.cityID forKey:@"city"];
                [userdefault setObject:cityname forKey:@"cityName"];

                [self.tableView.mj_header beginRefreshing];
                
            }
            
        }];
        
        
    }];


    [self.navigationController pushViewController:locati animated:YES];
    
}




#pragma mark - table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }
    return 30;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        
        return 1;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return self.userModel.userRecList.count;
    }
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 30)];
        titleView.backgroundColor = [UIColor whiteColor];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(screen_width / 2 - 40, 5, 80, 20)];
    
        if (section == 1) {
            title.text = YJLocalizedString(@"向导推荐");
        }else if (section == 2){
            title.text = YJLocalizedString(@"向导发现");
        }else if (section == 3){
            title.text = YJLocalizedString(@"用户分享");
        }
    
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont boldSystemFontOfSize:16.0];
        title.textColor = [UIColor blackColor];
        [titleView addSubview:title];
        
        
        UIImageView *leftLine = [[UIImageView alloc]initWithFrame:CGRectMake(screen_width / 2 - 105, 14.5, 40, 0.5)];
        leftLine.image = [UIImage imageNamed:@"line"];
        [titleView addSubview:leftLine];
        
        UIImageView *rightLine = [[UIImageView alloc]initWithFrame:CGRectMake(screen_width / 2 + 40, 14.5, 40, 0.5)];
        rightLine.image = [UIImage imageNamed:@"line"];
        [titleView addSubview:rightLine];
        
    
        YJDIYButton *btn = [YJDIYButton buttonWithFrame:CGRectMake(screen_width - 50, 5, 40, 20) title:@"MORE" imageName:@"arrow-right" Block:^{
            
            XXLog(@"section >>>> %ld",section);
            
            if (section == 1) {
                
                 [self.navigationController pushViewController:[YJMoreGuideVC new] animated:YES];
               

                
            }else if (section == 2){

                
            }else{
                
                [self.navigationController pushViewController:[YJMoreUserShareVC new] animated:YES];

            }
            
            
            
            
        }];

        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0,33, 0, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -17, 0, 10)];
        [titleView addSubview:btn];
    
        if (section == 2) {
            btn.hidden = YES;
    }
        
        
        return titleView;
        
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 190 * KHeight_Scale;
    }else if (indexPath.section == 1){
        return 180 * KHeight_Scale;
    }else if (indexPath.section == 2){
        return 220 * KHeight_Scale;
    }
    return 200 * KHeight_Scale;
    
}

#pragma mark - table view dataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        YJFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableArray *picArr = [NSMutableArray array];
        NSMutableArray *nameArr = [NSMutableArray array];
        NSArray *lunboModel = [YJLunBoModel mj_objectArrayWithKeyValuesArray:self.userModel.linkList];
        for (YJLunBoModel *lunbo in lunboModel) {
            [picArr addObject:lunbo.picUrl];
            [self.lunboImgArr addObject:lunbo.url];
            [nameArr addObject:lunbo.name];
        }
        
        if (picArr) {
            cell.imagesURLStrings = picArr;
            cell.titleArr = nameArr;
        }else{
            cell.imagesURLStrings = nil;
            cell.titleArr = nil;
        }
        return cell;
        
    }else if (indexPath.section == 1){
        
        YJFourCell *cells = [tableView dequeueReusableCellWithIdentifier:@"forCell"];
        YJNewFindModel *guideModel = self.userModel.guideRec;
       // if (guideModel) {
            cells.guideType = self.guideType;
            cells.guideModel = guideModel;
       // }
        return cells;
        
    }else if (indexPath.section == 2){
        
        YJThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thCell"];

            cell.guideType = self.guideType;
            cell.guideModel = self.userModel.guide;

        
        return cell;
    }
    
    
    
    YJSecondCell *cells = [tableView dequeueReusableCellWithIdentifier:@"secCell"];
    NSArray *shareList = self.userModel.userRecList;
    YJNearbyModel *model = shareList[indexPath.row];
    cells.guideType = self.guideType;
    cells.shareList = model;
    return cells;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XXLog(@"当前组%ld 当前行%ld",indexPath.section,indexPath.row);
    
    if (indexPath.section == 1) {
        
        if (self.userModel.guideRec) {
            YJGuideRecVC *vc = [[YJGuideRecVC alloc]init];
            vc.ID = self.userModel.guideRec.ID;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            return;
            
        }
        
       
        
    }else if (indexPath.section == 2){
//        self.userModel.guide
        
       
        
        YJGuideDetailVC *vc = [[YJGuideDetailVC alloc]init];
        YJGuideModel *guideModel = self.userModel.guide;
        vc.guideId = guideModel.ID;
        [self.navigationController pushViewController:vc animated:YES];

        
    }else if (indexPath.section == 3){
        NSArray *shareList = self.userModel.userRecList;
        YJNearbyModel *model = shareList[indexPath.row];
        YJShareDetailVC *vc = [[YJShareDetailVC alloc]init];
        vc.ID = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

#pragma mark - 其他delegate
- (void)Lunbo:(NSInteger)index{
    
    YJLunboWebVC  *web = [[YJLunboWebVC alloc]init];
    if (self.lunboImgArr.count > 0) {
        web.url = self.lunboImgArr[index];
    }
    [self.navigationController pushViewController:web animated:YES];
}

- (void)dealloc{
    
    [self.tableView removeFromSuperview];
    [self.noNetWork removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
