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
#import "CLSeachBar.h"
#import "FTPopOverMenu.h"
#import "YJAreaMianVC.h"
#import "NSObject+YJJsonOrModel.h"
#import "YJUserModel.h"
#import "YJLunBoModel.h"
#import "YJGuideModel.h"
#import "YJNearbyModel.h"
#import "YJNewFindModel.h"
#import "YJBNetWorkNotifionTool.h"
#import "YJLunboWebVC.h"



#define STOREAPPID @"1104867082"

#define Height  CGRectGetHeight([UIScreen mainScreen].bounds)
#define Width   CGRectGetWidth([UIScreen mainScreen].bounds)

#define TextColor [UIColor colorWithRed:255 / 255.0 green:198 / 255.0 blue:0 / 255.0 alpha:1.0]


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,LunboDelegate>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) CLSeachBar *seacher;
@property (nonatomic, strong) YJUserModel *userModel;
@property (nonatomic, strong) NSDictionary *guideType;
@property (nonatomic, strong) NoNetwork *noNetWork;

@property (nonatomic, strong) NSMutableArray *lunboImgArr;//轮播图片点击跳转的url


@property (nonatomic, strong) UIButton *areaBtn; //地区按钮

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
    //一句代码实现检测更新,很简单哦 （需要在viewDidAppear完成时，再调用改方法。不然在网速飞快的时候，会出现一个bug，就是当前控制器viewDidLoad调用的话，可能当前视图还没加载完毕就需要推出UIAlertAction）
//    [self hsUpdateApp];
}

/**
 *  天朝专用检测app更新
 */
-(void)hsUpdateApp
{
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSLog(@"%@",infoDic);
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    
    //3从网络获取appStore版本号
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
    if (response == nil) {
        NSLog(@"你没有连接网络哦");
        return;
    }
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"hsUpdateAppError:%@",error);
        return;
    }
    //    NSLog(@"%@",appInfoDic);
    NSArray *array = appInfoDic[@"results"];
    
    if (array.count < 1) {
        NSLog(@"此APPID为未上架的APP或者查询不到");
        return;
    }
    
    NSDictionary *dic = array[0];
    NSString *appStoreVersion = dic[@"version"];
    //打印版本号
    NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
    //设置版本号
    currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (currentVersion.length==2) {
        currentVersion  = [currentVersion stringByAppendingString:@"0"];
    }else if (currentVersion.length==1){
        currentVersion  = [currentVersion stringByAppendingString:@"00"];
    }
    appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (appStoreVersion.length==2) {
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
    }else if (appStoreVersion.length==1){
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
    }
    
    //4当前版本号小于商店版本号,就更新
    if([currentVersion floatValue] < [appStoreVersion floatValue])
    {
        UIAlertController *alercConteoller = [UIAlertController alertControllerWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",dic[@"version"]] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //此处加入应用在app store的地址，方便用户去更新，一种实现方式如下
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
            [[UIApplication sharedApplication] openURL:url];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alercConteoller addAction:actionYes];
        [alercConteoller addAction:actionNo];
        [self presentViewController:alercConteoller animated:YES completion:nil];
    }else{
        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
    }
    
}




- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //设置导航控制器
    [self setNavitaion];

   

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

    //请求网络
    [self getNetWork];
    
}

- (void)setTable{
    
    //穿创建tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - 108) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //tableView的代理
    
    __weak __typeof(self) weakSelf = self;
    _tableView.delegate = weakSelf;
    _tableView.dataSource = weakSelf;
    //去掉tableView自带的线
    weakSelf.tableView.tableFooterView = [UIView new];
    
    
    //tableView的背景
//    _tableView.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    //注册cell
    [_tableView registerClass:[YJFirstCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[YJSecondCell class] forCellReuseIdentifier:@"secCell"];
    [_tableView registerClass:[YJThreeCell class] forCellReuseIdentifier:@"thCell"];
    [_tableView registerClass:[YJFourCell class] forCellReuseIdentifier:@"forCell"];
    //添加刷新
    weakSelf.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getNetWork];
    }];
    
    //    weakSelf.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:weakSelf refreshingAction:@selector(getNetWork)];
    //自动更改透明度
    weakSelf.tableView.mj_header.automaticallyChangeAlpha = YES;
    [weakSelf.tableView.mj_header beginRefreshing];
    
    weakSelf.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getNetWork];
    }];
//    weakSelf.tableView.mj_footer.hidden = YES;
}

- (void)getNetWork{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:@"" forKey:@"cityId"];
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

- (void)getMoreData{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:@"" forKey:@"cityId"];
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


- (void)setNavitaion{
    
    self.view.backgroundColor = BackGray;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = TextColor;
    
    self.areaBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.areaBtn.frame = CGRectMake(0, 7, 50, 30);
    [self.areaBtn setImageEdgeInsets:UIEdgeInsetsMake(-5,-15, -5, 0)];
    [self.areaBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, -15)];
    [self.areaBtn setImage:[UIImage imageNamed:@"position"] forState:UIControlStateNormal];
    self.areaBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.areaBtn setTitleColor:TextColor forState:UIControlStateNormal];
    [self.areaBtn setTitle:@"宁波" forState:UIControlStateNormal];
    [self.areaBtn addTarget:self action:@selector(location) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.areaBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"addhao"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 10, 22, 22);
    [btn addTarget:self action:@selector(onNavButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.titleView = [UILabel titleWithColor:TextColor title:@"首页" font:AdaptedWidth(19.0)];
    
}

/*
-(void)viewTapped:(UITapGestureRecognizer*)tap {
    
    [self.seacher endEditing:YES];
    
}



//自定义导航栏搜索框
- (void)setNavitaionSearch{
    
    
    self.seacher = [[CLSeachBar alloc] initWithFrame:CGRectMake(0, 7,Width * 0.6, 30)];
    self.navigationItem.titleView = self.seacher;
    self.seacher.delegate = self;
    [self styleOne:self.seacher];


    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 7, 50, 30);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [leftBtn setTitleColor:TextColor forState:UIControlStateNormal];
//    leftBtn.backgroundColor = [UIColor orangeColor];
    [leftBtn setTitle:@"北京" forState:UIControlStateNormal];
//    [leftBtn setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(location:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"addhao"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 10, 22, 22);
    [btn addTarget:self action:@selector(onNavButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}



- (void)styleOne:(CLSeachBar *)search
{
    search.placeholder = @"搜索向导/推荐";
    
    search.returnKeyType = UIReturnKeySearch;
    search.font = [UIFont systemFontOfSize:16];
    search.textColor = [UIColor whiteColor];
    [search setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [search setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    search.textColor = [UIColor blackColor];
    //修改为圆角
    search.layer.masksToBounds = YES;
    search.layer.cornerRadius = search.frame.size.height*0.2;
    search.layer.borderWidth = 1;
    search.layer.borderColor = TextColor.CGColor;
    search.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"search"];
    search.leftView = imageView;
    // 设置左边的view永远显示
    search.leftViewMode = UITextFieldViewModeUnlessEditing;
    // 设置右边永远显示清除按钮
    search.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

    XXLog(@"开始编辑");
}
*/

-(void)onNavButtonTapped:(UIBarButtonItem *)sender event:(UIEvent *)event
{
    
    // provide two methods to deal with the barbuttonitems
    // comment this fowowing line and see how the other way of dealing with barbuttonitems
    
    //#define IfMethodOne
    
    
#ifdef IfMethodOne
    CGRect rect = [self.navigationController.navigationBar convertRect:[event.allTouches.anyObject view].frame toView:[[UIApplication sharedApplication] keyWindow]];
    
    [FTPopOverMenu showFromSenderFrame:rect
                              withMenu:@[@"MenuOne",@"MenuTwo",@"MenuThree",@"MenuFour"]
                        imageNameArray:@[@"Pokemon_Go_01",@"Pokemon_Go_02",@"Pokemon_Go_03",@"Pokemon_Go_04"]
                             doneBlock:^(NSInteger selectedIndex) {
                                 NSLog(@"done");
                             } dismissBlock:^{
                                 NSLog(@"cancel");
                             }];
    
    
#else
    
    [FTPopOverMenu showFromEvent:event
                        withMenu:@[@"发布订单",@"发布行程",@"发布攻略"]
                  imageNameArray:@[@"release-found",@"release-order",@"release-strategy"]
                       doneBlock:^(NSInteger selectedIndex) {
                           
            
            if (selectedIndex == 0) {
                
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"你的操作时非法的，您要继续吗" preferredStyle:UIAlertControllerStyleAlert];
                               
                               // 添加按钮
            __weak typeof(alert) weakAlert = alert;
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                                   NSLog(@"点击了确定按钮--%@-%@",
                [weakAlert.textFields.firstObject text],
                [weakAlert.textFields.lastObject text]);
                               }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                                   NSLog(@"点击了取消按钮");
                               }]];
                               
        [self presentViewController:alert animated:YES completion:nil];                           }
                           
                       } dismissBlock:^{
                           
                           
                           
                       }];
    
#endif
    
    
}





- (void)location{
    
    YJAreaMianVC *locati = [[YJAreaMianVC alloc]init];
    [locati returnTitle:^(NSString *cityname, NSNumber *cityID) {
    self.navigationController.navigationBar.tintColor = TextColor;
    [self.areaBtn setTitle:cityname forState:UIControlStateNormal];

    XXLog(@"%@",self.areaBtn.titleLabel.text);
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
        titleView.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(screen_width / 2 - 40, 5, 80, 20)];
    
        if (section == 1) {
            title.text = @"向导推荐";
        }else if (section == 2){
            title.text = @"发现向导";
        }else if (section == 3){
            title.text = @"用户分享";
        }
    
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont boldSystemFontOfSize:16.0];
        title.textColor = [UIColor blackColor];
        [titleView addSubview:title];
        
        
        UIImageView *leftLine = [[UIImageView alloc]initWithFrame:CGRectMake(screen_width / 2 - 105, 12.5, 65, 5)];
        leftLine.image = [UIImage imageNamed:@"lineLeft"];
        [titleView addSubview:leftLine];
        
        UIImageView *rightLine = [[UIImageView alloc]initWithFrame:CGRectMake(screen_width / 2 + 40, 12.5, 65, 5)];
        rightLine.image = [UIImage imageNamed:@"lineRight"];
        [titleView addSubview:rightLine];
        
    
        YJDIYButton *btn = [YJDIYButton buttonWithFrame:CGRectMake(screen_width - 50, 5, 40, 20) title:@"More" imageName:@"arrow-right" Block:^{
            
            XXLog(@"section >>>> %ld",section);
            
        }];

        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0,33, 0, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -17, 0, 10)];
        [titleView addSubview:btn];
        
        
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
        if (guideModel) {
            cells.guideType = self.guideType;
            cells.guideModel = guideModel;
        }
        return cells;
        
    }else if (indexPath.section == 2){
        
        YJThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thCell"];
        if (self.userModel.guide) {
            cell.guideType = self.guideType;
            cell.guideModel = self.userModel.guide;
        }
        
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
    
}

#pragma mark - 其他delegate
- (void)Lunbo:(NSInteger)index{
    
    YJLunboWebVC *web = [[YJLunboWebVC alloc]init];
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
