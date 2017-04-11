//
//  YJOderDataController.m
//  全球向导
//
//  Created by SYJ on 2016/11/15.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJOderDataController.h"
#import "YJSendOrderController.h"
#import "CHTCalendarView.h"

@interface YJOderDataController ()

@property (nonatomic, strong) CHTCalendarView *calendar;


@end

@implementation YJOderDataController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"日期选择" font:19.0];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.layer addSublayer: [self backgroundLayer]];
    
    //加载日期布局
    CHTCalendarView *calendarView = [[CHTCalendarView alloc] init];
    calendarView.layer.masksToBounds = YES;
    calendarView.layer.cornerRadius = 10;
    calendarView.frame = CGRectMake(0, 100, screen_width, screen_width);
    [self.view addSubview:calendarView];
    calendarView.sd_layout.centerXEqualToView(self.view).centerYEqualToView(self.view).heightIs(screen_width + 40).widthIs(screen_width - 4);
    self.calendar = calendarView;
    //[self setupViews];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *select = [userDefaults objectForKey:saveSelectArr];
    
    if (select.count != 0) {
        calendarView.markedDays = select;
    }else{
        self.calendar.markedDays = nil;
    }
    
    [calendarView reloadInterface];
    
    
    // Do any additional setup after loading the view.
}


//背景颜色
-(CAGradientLayer *)backgroundLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor purpleColor].CGColor,(__bridge id)[UIColor redColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.locations = @[@0.65,@1];
    return gradientLayer;
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
