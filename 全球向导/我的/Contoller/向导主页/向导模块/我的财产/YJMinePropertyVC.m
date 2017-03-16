
//
//  YJMinePropertyVC.m
//  全球向导
//
//  Created by SYJ on 2017/3/14.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJMinePropertyVC.h"
#import "YJDepositVC.h"
#import "YJMoneyDetailVC.h"

@interface YJMinePropertyVC (){
    
    UIImageView *propertyImg;
    UILabel *money;
    YJDIYButton *depositBtn;
    NSString *mon;
    
}

@end

@implementation YJMinePropertyVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1.0];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(detail) title:@"明细" titleColor:[UIColor grayColor] font:AdaptedWidth(17)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"我的财产" font:19.0];

    [self getNetWok];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)detail{
    
    XXLog(@"....明细");
    [self.navigationController pushViewController:[YJMoneyDetailVC new] animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    

    
    // Do any additional setup after loading the view.
}

- (void)initUI{
   
    propertyImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"property"]];
    [self.view addSubview:propertyImg];
    propertyImg.sd_layout.leftSpaceToView(self.view, 70).rightSpaceToView(self.view, 70).topSpaceToView(self.view, 20).heightIs(160);
    
    money = [[UILabel alloc]init];
    [self.view addSubview:money];
    money.textAlignment = NSTextAlignmentCenter;
    money.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    money.textColor = [UIColor blackColor];
    money.text = mon;
    money.sd_layout.centerXEqualToView(self.view).topSpaceToView(propertyImg, 5).heightIs(20).widthIs(200);
    
    NSString *priceText = [NSString stringWithFormat:@"余额 ￥%@",mon];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceText];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:AdaptedWidth(20.0)]
     
                          range:NSMakeRange(4, mon.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor blackColor]
     
                          range:NSMakeRange(4, mon.length)];
    
    money.attributedText = AttributedStr;
    
    
    
    depositBtn = [YJDIYButton buttonWithtitle:@"提现" Block:^{
       
        XXLog(@"...提现");
        YJDepositVC *vc = [[YJDepositVC alloc]init];
        vc.totalMoney = mon;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.view addSubview:depositBtn];
    depositBtn.sd_layout.centerXEqualToView(self.view).topSpaceToView(money, 30).heightIs(50).widthIs(300);
    depositBtn.backgroundColor = TextColor;
    [depositBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    depositBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    depositBtn.layer.masksToBounds = YES;
    depositBtn.layer.cornerRadius = 5;
    depositBtn.layer.borderColor = BackGray.CGColor;
    depositBtn.layer.borderWidth = 1.0;
    
}


- (void)getNetWok{
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/account/viewCur",BaseUrl] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            NSString *m = [NSString stringWithFormat:@"%@",dict[@"data"][@"useMoney"]];
            if (m == nil) {
                m = @"0";
            }
            mon = m;
            [money removeFromSuperview];
            [propertyImg removeFromSuperview];
            [depositBtn removeFromSuperview];
            [self initUI];
            
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
 
        }
        
    } failure:^(NSError *error) {
        
    }];
    
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
