//
//  YJDataController.m
//  全球向导
//
//  Created by SYJ on 2016/11/9.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJDataController.h"
#import "CHTCalendarView.h"
#import "YJOrderFormController.h"
//#import "YJSelsectArr.h"

@interface YJDataController ()

@property (nonatomic, strong) CHTCalendarView *calendar;
//@property (nonatomic, strong) YJSelsectArr *model;


@end

@implementation YJDataController

//- (NSMutableArray *)arr{
//    if (_arr == nil) {
//        _arr = [NSMutableArray array];
//        
//    }
//    return _arr;
//}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"日期选择" font:19.0];
    UIBarButtonItem * leftItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
    UIBarButtonItem * rightItem = [UIBarButtonItem itemWithTarget:self action:@selector(finsh) title:@"完成" titleColor:TextColor font:AdaptedWidth(16)];

    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;

}

- (void)finsh{
    
    //选择的天数
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *select = [userDefaults objectForKey:saveSelectArr];
    if (select.count > 0 ) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"请选择日期后提交" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            
        }];
        alert.sure_btnTitleColor = TextColor;
        [alert show];
    }
    
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
    calendarView.isSelDate = YES;
    calendarView.isPostDate = NO;
    calendarView.sd_layout.centerXEqualToView(self.view).centerYEqualToView(self.view).heightIs(screen_width + 40).widthIs(screen_width - 4);
    self.calendar = calendarView;
    //[self setupViews];
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *select = [userDefaults objectForKey:saveSelectArr];
    
//    if (select.count != 0) {
    
    if (self.arr.count > 0) {
        calendarView.markedDays = self.arr;
    }else{
        calendarView.markedDays = nil;
    }
//    }else{
//        self.calendar.markedDays = nil;
//    }
    
    [calendarView reloadInterface];

    
    // Do any additional setup after loading the view.
}

- (void)back{
//    YJOrderFormController *vc = [[YJOrderFormController alloc]init];
    [self.navigationController popViewControllerAnimated:YES];
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
