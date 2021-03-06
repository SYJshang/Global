
//
//  YJUserGuideCenterVC.m
//  全球向导
//
//  Created by SYJ on 2017/3/24.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJUserGuideCenterVC.h"
#import "SGTopTitleView.h"
#import "YJGEDateVC.h"
#import "YJGETableVC.h"
#import "YJGEFindVC.h"
#import "YJGEPhotoVC.h"


@interface YJUserGuideCenterVC ()<SGTopTitleViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;


@end

@implementation YJUserGuideCenterVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:YJLocalizedString(@"向导中心") font:19.0];

}



- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    
    self.titles = @[YJLocalizedString(@"向导发布"), YJLocalizedString(@"向导相册"),YJLocalizedString(@"向导行程"),YJLocalizedString(@"向导资料")];
    // , @"NBA", @"新闻", @"娱乐", @"音乐", @"网络电影"
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    self.topTitleView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    _topTitleView.staticTitleArr = [NSArray arrayWithArray:_titles];
    _topTitleView.isHiddenIndicator = NO;
    _topTitleView.delegate_SG = self;
    [self.view addSubview:_topTitleView];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height);
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
    
    YJGEFindVC *oneVC = [[YJGEFindVC alloc] init];
    oneVC.ID = self.ID;
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
    YJGEFindVC *oneVC = [[YJGEFindVC alloc] init];
    oneVC.ID = self.ID;
    [self addChildViewController:oneVC];
    
    // 电视剧
    YJGEPhotoVC *twoVC = [[YJGEPhotoVC alloc] init];
    twoVC.ID = self.ID;
    [self addChildViewController:twoVC];
    
    
    YJGEDateVC *threeVC = [[YJGEDateVC alloc] init];
    threeVC.ID = self.ID;
    [self addChildViewController:threeVC];
    
    YJGETableVC *fourVC = [[YJGETableVC alloc] init];
    fourVC.ID = self.ID;
    [self addChildViewController:fourVC];
    
    //
    //    // 电影
    //    TestThreeVC *threeVC = [[TestThreeVC alloc] init];
    //    [self addChildViewController:threeVC];
    //
    //    // 综艺
    //    TestFourVC *fourVC = [[TestFourVC alloc] init];
    //    [self addChildViewController:fourVC];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
