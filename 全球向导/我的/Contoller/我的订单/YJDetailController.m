//
//  YJDetailController.m
//  全球向导
//
//  Created by SYJ on 2016/12/8.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJDetailController.h"
#import "SGTopTitleView.h"
#import "YJDetailOrderController.h"
#import "YJOrderStateController.h"
#import "YJfundDetailVC.h"


@interface YJDetailController ()<SGTopTitleViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation YJDetailController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setLaoutView];
    
}



- (void)setLaoutView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:YJLocalizedString(@"订单详情") font:19.0];
    UIBarButtonItem * leftItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    self.titles = @[YJLocalizedString(@"订单状态"), YJLocalizedString(@"订单详情")];
    // , @"NBA", @"新闻", @"娱乐", @"音乐", @"网络电影"
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    self.topTitleView.backgroundColor = BackGroundColor;
    _topTitleView.staticTitleArr = [NSArray arrayWithArray:_titles];
    _topTitleView.isHiddenIndicator = NO;
    _topTitleView.delegate_SG = self;
    [self.view addSubview:_topTitleView];
    
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
    
    YJOrderStateController *oneVC = [[YJOrderStateController alloc] init];
    oneVC.orderID = self.orderID;
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
    // 订单状态
    YJOrderStateController *oneVC = [[YJOrderStateController alloc] init];
    oneVC.orderID = self.orderID;
    [self addChildViewController:oneVC];
    // 订单详情
    if (self.isRefund == YES) {
        YJfundDetailVC *twoVC = [[YJfundDetailVC alloc] init];
        twoVC.ID = self.orderID;
        [self addChildViewController:twoVC];
    }else{
        YJDetailOrderController *twoVC = [[YJDetailOrderController alloc] init];
        twoVC.ID = self.orderID;
        [self addChildViewController:twoVC];
    }
   
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
    
    // 3.让选中的标题居中
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
