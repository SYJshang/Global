//
//  YJTabBarController.m
//  全球向导
//
//  Created by SYJ on 2016/10/20.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJTabBarController.h"
#import "YJNavigationController.h"
#import "ViewController.h"
#import "YJGuideController.h"
#import "YJNewFindController.h"
#import "YJMineController.h"
#import "YJMessageVC.h"


#define TextColor [UIColor colorWithRed:255 / 255.0 green:198 / 255.0 blue:0 / 255.0 alpha:1.0]

@interface YJTabBarController ()

@end

@implementation YJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //主页
    ViewController *main = [[ViewController alloc]init] ;
//    main.view.backgroundColor = [UIColor redColor];
    [self addChildVc:main Title:@"目的地" withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"home2" withTitleColor:TextColor unselectedImage:@"home" withTitleColor:[UIColor lightGrayColor]];
    //向导
    YJGuideController  *caseVC = [[YJGuideController alloc]init];
//    caseVC.view.backgroundColor = [UIColor grayColor];
    [self addChildVc:caseVC Title:@"向导" withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"guide" withTitleColor:TextColor unselectedImage:@"guide2" withTitleColor:[UIColor lightGrayColor]];
    //新发现
    YJNewFindController *fitVC = [[YJNewFindController alloc]init];
//    fitVC.view.backgroundColor = [UIColor greenColor];
    [self addChildVc:fitVC Title:@"新发现" withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"find" withTitleColor:TextColor unselectedImage:@"find-2" withTitleColor:[UIColor lightGrayColor]];
    
    //消息
    YJMessageVC *storeVC = [[YJMessageVC alloc]init];
//    storeVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildVc:storeVC Title:@"消息" withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"message2" withTitleColor:TextColor unselectedImage:@"message" withTitleColor:[UIColor lightGrayColor]];
    //我的
    YJMineController *MyVC = [[YJMineController alloc]init];
//    MyVC.view.backgroundColor = [UIColor purpleColor];
    [self addChildVc:MyVC Title:@"我的" withTitleSize:12.0 andFoneName:@"HelveticaNeue-Bold" selectedImage:@"me2" withTitleColor:TextColor unselectedImage:@"me" withTitleColor:[UIColor lightGrayColor]];

    
    // Do any additional setup after loading the view.
}


- (void)addChildVc:(UIViewController *)childVc
             Title:(NSString *)title
     withTitleSize:(CGFloat)size
       andFoneName:(NSString *)foneName
     selectedImage:(NSString *)selectedImage
    withTitleColor:(UIColor *)selectColor
   unselectedImage:(NSString *)unselectedImage
    withTitleColor:(UIColor *)unselectColor{
    childVc.title = title;
    //设置图片
    childVc.tabBarItem  = [childVc.tabBarItem initWithTitle:title image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateSelected];
    YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
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
