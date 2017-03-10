//
//  YJDateVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/15.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJDateVC.h"
#import "CHTCalendarView.h"
#import "YJSelcetBtn.h"


@interface YJDateVC ()

@property (nonatomic, strong) CHTCalendarView *calendar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YJSelcetBtn *receved;
@property (nonatomic, strong) YJSelcetBtn *noOrd;



@end

@implementation YJDateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view.layer addSublayer: [self backgroundLayer]];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    [self.tableView.layer addSublayer: [self backgroundLayer]];


    
    //加载日期布局
    CHTCalendarView *calendarView = [[CHTCalendarView alloc] init];
    calendarView.layer.masksToBounds = YES;
    calendarView.layer.cornerRadius = 10;
    calendarView.backgroundColor = [UIColor whiteColor];
    [self.tableView addSubview:calendarView];
    calendarView.sd_layout.centerXEqualToView(self.tableView).centerYEqualToView(self.tableView).heightIs(screen_width).widthIs(screen_width);
    self.calendar = calendarView;
    //[self setupViews];
    NSMutableArray *select = [NSMutableArray arrayWithObjects:@"2017-03-17",@"2017-03-19",@"2017-03-13",@"2017-03-25", nil];
    
    if (select.count != 0) {
        calendarView.markedDays = select;
        calendarView.markedDayFilledColor = [UIColor blueColor];
    }else{
        self.calendar.markedDays = nil;
    }
    
    [calendarView reloadInterface];
    
    

    
    // Do any additional setup after loading the view.
}

- (void)btnClick:(UIButton *)btn{
    
    if (btn.tag == 1) {
        self.receved.selected = YES;
        self.noOrd.selected = NO;

    }
    
    if (btn.tag == 2) {
        self.receved.selected = NO;
        self.noOrd.selected = YES;
    }
}



//背景颜色
-(CAGradientLayer *)backgroundLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = @[(__bridge id)BackGray.CGColor,(__bridge id)[UIColor redColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.locations = @[@0.65,@1];
    return gradientLayer;
}

#pragma mark - delegate
-(NSString *)segmentTitle
{
    return @"向导日程";
}

-(UIScrollView *)streachScrollView
{
    return self.tableView;
}

- (void)dealloc{
    
    self.noOrd.hidden = YES;
    self.receved.hidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.noOrd.hidden = YES;
    self.receved.hidden = YES;

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self setBtn];

    
    self.noOrd.hidden = NO;
    self.receved.hidden = NO;
    

    
}

- (void)setBtn{
    
    YJSelcetBtn *receved = [[YJSelcetBtn alloc]init];
    [receved setTitle:@"已被预订日期" forState:UIControlStateNormal];
    receved.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
    [receved setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [receved setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [receved setImage:[UIImage imageNamed:@"bb2"] forState:UIControlStateNormal];
    [receved setImage:[UIImage imageNamed:@"bb1"] forState:UIControlStateSelected];
    [receved addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    receved.tag = 1;
    receved.selected = NO;
    self.receved = receved;
    [[UIApplication sharedApplication].keyWindow addSubview:self.receved];
    self.receved.frame = CGRectMake(screen_width / 2 - 100, screen_height - 40 * KHeight_Scale, 100, 15 * KHeight_Scale);
    
    //    self.receved.sd_layout.topSpaceToView(calendarView,20).heightIs(15 *  KHeight_Scale).leftSpaceToView(self.view,20).widthIs(130 * KWidth_Scale);
    
    
    YJSelcetBtn *noOrder = [[YJSelcetBtn alloc]init];
    [noOrder setTitle:@"不接单日期" forState:UIControlStateNormal];
    noOrder.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
    [noOrder setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [noOrder setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [noOrder setImage:[UIImage imageNamed:@"bb2"] forState:UIControlStateNormal];
    [noOrder setImage:[UIImage imageNamed:@"bb1"] forState:UIControlStateSelected];
    [noOrder addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    noOrder.selected = YES;
    noOrder.tag = 2;
    self.noOrd = noOrder;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.noOrd];
    self.noOrd.frame = CGRectMake(screen_width / 2 + 20, screen_height - 40 * KHeight_Scale, 100, 15 * KHeight_Scale);
    
    //    self.noOrd.sd_layout.topSpaceToView(calendarView,5).heightIs(15 *  KHeight_Scale).rightSpaceToView(self.tableView,20).widthIs(130 * KWidth_Scale);
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
