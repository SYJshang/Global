
//
//  YJPayBindingVC.m
//  全球向导
//
//  Created by SYJ on 2017/3/14.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJPayBindingVC.h"

@interface YJPayBindingVC ()

@property (nonatomic, strong) UITextField *realName; //真名
@property (nonatomic, strong) UITextField *aliAccout; //支付宝账号
@property (nonatomic, strong) UIButton *finshBtn; //完成按钮

@end

@implementation YJPayBindingVC


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"绑定账号" font:19.0];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    // Do any additional setup after loading the view.
}

- (void)initUI{
    
    self.aliAccout = [[UITextField alloc]init];
    self.aliAccout.placeholder = @"支付宝账号";
    [self.view addSubview:self.aliAccout];
    self.aliAccout.sd_layout.topSpaceToView(self.view, 10).leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).heightIs(50);
    
    UIView *line = [[UIView alloc]init];
    [self.view addSubview:line];
    line.backgroundColor = BackGray;
    line.sd_layout.topSpaceToView(self.aliAccout, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(1);
    
    self.realName = [[UITextField alloc]init];
    self.realName.placeholder = @"支付宝绑定名称";
    [self.view addSubview:self.realName];
    self.realName.sd_layout.topSpaceToView(self.aliAccout, 5).leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).heightIs(50);
    
    UIView *line1 = [[UIView alloc]init];
    [self.view addSubview:line1];
    line1.backgroundColor = BackGray;
    line1.sd_layout.topSpaceToView(self.realName, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(1);
    
    self.finshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.finshBtn];
    [self.finshBtn setTitle:@"确认绑定" forState:UIControlStateNormal];
    self.finshBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    [self.finshBtn setBackgroundColor:TextColor];
    [self.finshBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.finshBtn.layer.masksToBounds = YES;
    self.finshBtn.layer.cornerRadius = 5;
    self.finshBtn.layer.borderColor = BackGray.CGColor;
    self.finshBtn.layer.borderWidth = 0.5;
    self.finshBtn.sd_layout.centerXEqualToView(self.view).topSpaceToView(line1, 50).heightIs(50).widthIs(280);
    
    [self.finshBtn addTarget:self action:@selector(finsh) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)finsh{
    
    XXLog(@"确定绑定");
    
    if (self.aliAccout.text.length > 0 && self.realName.text.length > 0) {
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        [parameter setObject:self.realName.text forKey:@"realName"];
        [parameter setObject:self.aliAccout.text forKey:@"account"];
        
        [WBHttpTool Post:[NSString stringWithFormat:@"%@/guide/accountBind/bindAlipay",BaseUrl] parameters:parameter success:^(id responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            XXLog(@"%@",dict);
            
            if ([dict[@"code"] isEqualToString:@"1"]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.mode = MBProgressHUDModeText;
                hud.labelColor = [UIColor whiteColor];
                hud.color = [UIColor blackColor];
                hud.labelText = NSLocalizedString(@"绑定成功", @"HUD message title");
                [hud hide:YES afterDelay:2.0];
            }else{
                SGAlertView *alert = [SGAlertView alertViewWithTitle:@"提示" contentTitle:dict[@"msg"] alertViewBottomViewType:SGAlertViewBottomViewTypeOne didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    
                }];
                alert.sure_btnTitleColor = TextColor;
                [alert show];
                
            }

            
            
        } failure:^(NSError *error) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelColor = [UIColor whiteColor];
            hud.color = [UIColor blackColor];
            hud.labelText = NSLocalizedString(@"绑定失败", @"HUD message title");
            [hud hide:YES afterDelay:2.0];

            
        }];
    }
    
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
