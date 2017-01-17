//
//  YJAreaMianVC.m
//  全球向导
//
//  Created by SYJ on 2017/1/4.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJAreaMianVC.h"
#import "SGTopTitleView.h"
#import "YJLocaController.h"
#import "YJLocaAbroadVC.h"

@interface YJAreaMianVC ()<SGTopTitleViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSString *arerTitle;
@property (nonatomic, strong) NSNumber *cityID;


@end

@implementation YJAreaMianVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if (self.returnBlocks && self.arerTitle) {
        self.returnBlocks(self.arerTitle,self.cityID);
    }
}

//-(void)returnText:(CityName)block
//{
//    self.returnBlocks = block;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    
    self.titles = @[@"国内", @"国外"];
    // , @"NBA", @"新闻", @"娱乐", @"音乐", @"网络电影"
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 20, 200, 44)];
//    self.topTitleView.backgroundColor = BackGray;
    _topTitleView.staticTitleArr = [NSArray arrayWithArray:_titles];
    _topTitleView.isHiddenIndicator = NO;
    _topTitleView.delegate_SG = self;
    self.topTitleView.layer.masksToBounds = YES;
    self.topTitleView.layer.cornerRadius = 5;
    self.topTitleView.layer.borderColor = TextColor.CGColor;
    self.topTitleView.layer.borderWidth = 0.5;
    [[self navigationItem] setTitleView:self.topTitleView];
    
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    YJLocaController *oneVC = [[YJLocaController alloc] init];
    [oneVC returnText:^(NSString *cityname,NSNumber *cityID) {
        self.arerTitle = cityname;
        self.cityID = cityID;
    }];
    [self.mainScrollView addSubview:oneVC.view];
    [self addChildViewController:oneVC];
    
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];
}

#pragma mark - - - SGTopScrollMenu代理方法
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index{
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}

// 添加所有子控制器
- (void)setupChildViewController {
    // 精选
    YJLocaController *oneVC = [[YJLocaController alloc] init];
    [oneVC returnText:^(NSString *cityname,NSNumber *cityID) {
        self.arerTitle = cityname;
        self.cityID = cityID;
    }];

    [self addChildViewController:oneVC];
    
    // 电视剧
    YJLocaAbroadVC *twoVC = [[YJLocaAbroadVC alloc] init];
    [twoVC returnText:^(NSString *cityname,NSNumber *cityID) {
        self.arerTitle = cityname;
        self.cityID = cityID;
    }];
    [self addChildViewController:twoVC];
    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
    
    // 3.滚动时，改变标题选中
    [self.topTitleView staticTitleLabelSelecteded:selLabel];
    
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
