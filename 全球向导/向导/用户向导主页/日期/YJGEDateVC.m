//
//  YJDateVC.m
//  全球向导
//
//  Created by SYJ on 2016/12/15.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJGEDateVC.h"
#import "CHTCalendarView.h"
#import "YJSelcetBtn.h"


@interface YJGEDateVC ()

@property (nonatomic, strong) CHTCalendarView *calendar;
@property (nonatomic, strong) YJSelcetBtn *receved;
@property (nonatomic, strong) YJSelcetBtn *noOrd;

@property (nonatomic, strong) NSMutableArray *orderArr;
@property (nonatomic, strong) NSMutableArray *guideArr;



@end

@implementation YJGEDateVC

- (NSMutableArray *)orderArr{
    
    if (_orderArr == nil) {
        _orderArr = [NSMutableArray array];
    }
    
    return _orderArr;
}

- (NSMutableArray *)guideArr{
    
    if (_guideArr == nil) {
        _guideArr = [NSMutableArray array];
    }
    
    return _guideArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view.layer addSublayer: [self backgroundLayer]];
    
   

    self.automaticallyAdjustsScrollViewInsets = NO;

    
    //加载日期布局
    self.calendar = [[CHTCalendarView alloc] init];
    self.calendar.layer.masksToBounds = YES;
    self.calendar.layer.cornerRadius = 10;
    self.calendar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.calendar];
    self.calendar.sd_layout.centerXEqualToView(self.view).centerYEqualToView(self.view).heightIs(screen_width).widthIs(screen_width);
    self.calendar = self.calendar;
    self.calendar.isPostDate = YES;
    self.calendar.isSelDate = NO;
    
    [self getDate];
    [self.calendar reloadInterface];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)getDate{
    
    NSMutableDictionary *parametr = [NSMutableDictionary dictionary];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/mainGuide/findUsedDate/%@",BaseUrl,self.ID] parameters:parametr success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            
            XXLog(@"%@",dict);
            
            NSArray *orderArr = dict[@"data"][@"usedDateList"];
            self.orderArr = [orderArr mutableCopy];
            
            if (self.orderArr != 0) {
                self.calendar.markedDays = self.orderArr;
            }

            
            
            
            [self.calendar reloadInterface];
            
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
    gradientLayer.colors = @[(__bridge id)BackGroundColor.CGColor,(__bridge id)[UIColor redColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.locations = @[@0.65,@1];
    return gradientLayer;
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
//    [self setBtn];

    
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
    
    self.noOrd.hidden = YES;
    self.receved.hidden = YES;
    
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
