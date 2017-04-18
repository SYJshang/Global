//
//  YJDepositVC.m
//  全球向导
//
//  Created by SYJ on 2017/3/14.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJDepositVC.h"
#import "YJDepostionFinshVC.h"

@interface YJDepositVC (){
    
    UILabel *aliAccount;
    UITextField *money;
    YJDIYButton *Allbtn;
    YJDIYButton *deposiBtn;
    
}

@end

@implementation YJDepositVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"提现" font:19.0];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getNetWork];
    [self initUI];
    
    // Do any additional setup after loading the view.
}

- (void)getNetWork{
    
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/accountBind/viewCur",BaseUrl] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            NSString *m = [NSString stringWithFormat:@"%@",dict[@"data"][@"alipayAccount"]];
            aliAccount.text = m;
            
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
            
        }
        
    } failure:^(NSError *error) {
        
    }];

    
}

- (void)initUI{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    view.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 80).heightIs(50);
    
    UILabel *name = [[UILabel alloc]init];
    [view addSubview:name];
    name.text = YJLocalizedString(@"支付宝");
    name.textColor = [UIColor grayColor];
    name.textAlignment = NSTextAlignmentLeft;
    name.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    name.sd_layout.leftSpaceToView(view, 10).centerYEqualToView(view).heightRatioToView(view, 1.0).widthIs(120);
    
    aliAccount = [[UILabel alloc]init];
    [view addSubview:aliAccount];
    aliAccount.textColor = [UIColor grayColor];
    aliAccount.textAlignment = NSTextAlignmentRight;
    aliAccount.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    aliAccount.sd_layout.rightSpaceToView(view, 10).centerYEqualToView(view).heightRatioToView(view, 1.0).widthIs(200);
    
    
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    view1.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(view, 20).heightIs(100);
    
    UILabel *tixian = [[UILabel alloc]init];
    [view1 addSubview:tixian];
    tixian.text = @"提现金额";
    tixian.textColor = [UIColor grayColor];
    tixian.textAlignment = NSTextAlignmentLeft;
    tixian.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    tixian.sd_layout.leftSpaceToView(view1, 10).topSpaceToView(view1, 5).heightIs(20).widthIs(80);
    
    UILabel *icon = [[UILabel alloc]init];
    [view1 addSubview:icon];
    icon.text = @"￥";
    icon.textColor = [UIColor blackColor];
    icon.textAlignment = NSTextAlignmentLeft;
    icon.font = [UIFont systemFontOfSize:AdaptedWidth(20)];
    icon.sd_layout.leftSpaceToView(view1, 10).topSpaceToView(tixian, 5).heightIs(30).widthIs(20);
    
    
    money = [[UITextField alloc]init];
    [view1 addSubview:money];
    money.placeholder = @"提现金额";
    money.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    money.sd_layout.leftSpaceToView(icon, 10).rightSpaceToView(view1, 10).centerYEqualToView(icon).heightRatioToView(icon, 1);

    UIView *line = [[UIView alloc]init];
    [view1 addSubview:line];
    line.backgroundColor = BackGroundColor;
    line.sd_layout.leftSpaceToView(view1, 10).rightSpaceToView(view1, 10).topSpaceToView(money,5).heightIs(1.0);
    
    UILabel *jine = [[UILabel alloc]init];
    [view1 addSubview:jine];
    jine.text = [NSString stringWithFormat:@"可提现金额￥%@",self.totalMoney];
    jine.textColor = [UIColor grayColor];
    jine.textAlignment = NSTextAlignmentLeft;
    jine.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    jine.sd_layout.leftSpaceToView(view1, 10).topSpaceToView(line, 5).heightIs(20).widthIs(150);
    
    Allbtn = [YJDIYButton buttonWithtitle:@"全部提现" Block:^{
       
        XXLog(@"全部提现");
        money.text = self.totalMoney;
        
    }];
    [view1 addSubview:Allbtn];
    [Allbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    Allbtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    Allbtn.sd_layout.rightSpaceToView(view1, 10).centerYEqualToView(jine).heightRatioToView(jine, 1.0).widthIs(60);
    
    
    deposiBtn = [YJDIYButton buttonWithtitle:@"提现" Block:^{
        
        XXLog(@"...提现");
        [self deposit];
        
    }];
    [self.view addSubview:deposiBtn];
    deposiBtn.sd_layout.centerXEqualToView(self.view).topSpaceToView(view1, 30).heightIs(50).widthIs(300);
    deposiBtn.backgroundColor = TextColor;
    [deposiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deposiBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    deposiBtn.layer.masksToBounds = YES;
    deposiBtn.layer.cornerRadius = 5;
    deposiBtn.layer.borderColor = BackGroundColor.CGColor;
    deposiBtn.layer.borderWidth = 1.0;

    
}

//提现
- (void)deposit{
    
    NSInteger moneyDepostion = [money.text integerValue];
    if (moneyDepostion < 0.01 || moneyDepostion > 50000) {
        SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:@"请保证提现金额在0.01 - 50000 之间" alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
        }];
        alert.sure_btnTitleColor = TextColor;
        [alert show];

    }else{

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:money.text forKey:@"money"];
    [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/account/cash",BaseUrl] parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"1"]) {
            YJDepostionFinshVC *vc = [[YJDepostionFinshVC alloc]init];
            vc.aliAccount = aliAccount.text;
            vc.money = money.text;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alert.sure_btnTitleColor = TextColor;
            [alert show];
        }
        
    } failure:^(NSError *error) {
        
        XXLog(@"%@",error);
        
    }];
    
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
