//
//  YJRegisteController.m
//  全球向导
//
//  Created by SYJ on 2016/10/28.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJLoginFirstController.h"
#import "SDAutoLayout.h"
#import "YJRegsiterController.h"
#import "ZYKeyboardUtil.h"
#import "YJFindPWController.h"
#import "LYButton.h"
#import "MobileNumberHelper.h"
#import "YJLoginController.h"
#import "WBHttpTool.h"
#import "YJTabBarController.h"
#import "MBProgressHUD.h"



@interface YJLoginFirstController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>


//头部图片
@property (nonatomic, strong) UIImageView *imgV;

//密码
@property (nonatomic, strong) UITextField *passwordTf;
//图片验证码
@property (nonatomic, strong) UITextField *iconCode;
//图片验证码
@property (nonatomic, strong) UIImageView *icon;
//登录/注册
@property (nonatomic, strong) UIButton *loginOrRegist;
//忘记密码
@property (nonatomic, strong) UIButton *forgetPW;

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;

//点击取消输入
@property (nonatomic, strong) UIButton *dis;
//更改密码输入方式
@property (nonatomic, strong) UIButton *PWBtn;



@end

@implementation YJLoginFirstController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    self.fd_interactivePopDisabled = YES ;

    
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
    
    //处理键盘事件
    self.nameTf.delegate = self;
    self.passwordTf.delegate = self;
    self.iconCode.delegate = self;
//    self.numCode.delegate = self;
    [self configKeyBoardRespond];
    


    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg3"]];
    [self.view addSubview:self.imgV];
    self.imgV.userInteractionEnabled = YES;
    self.imgV.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,0).heightIs(200.0 * KWidth_Scale);
    
    //返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 30, 20, 16);
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.imgV addSubview:btn];
    [btn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((screen_width / 2) - 50 , 20, 100, 30)];
    label.text = @"登录";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18.0];
    [self.imgV addSubview:label];
    

    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.loginBtn];
    self.loginBtn.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.imgV,-5).widthIs(screen_width / 2).heightIs(40.0 * KWidth_Scale);
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.loginBtn.backgroundColor =  BackGroundColor;
    [self.loginBtn setTitleColor:TextColor forState:UIControlStateSelected];
    [self.loginBtn setSelected:YES];
    self.loginBtn.tag = 1;
    
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.registerBtn];
    self.registerBtn.sd_layout.leftSpaceToView(self.loginBtn,0).topSpaceToView(self.imgV,-5).widthIs(screen_width / 2).heightIs(40.0 * KWidth_Scale);
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.registerBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.registerBtn.backgroundColor = BackGroundColor;
    [self.registerBtn setTitleColor:TextColor forState:UIControlStateSelected];
    [self.registerBtn setSelected:NO];
    self.registerBtn.tag = 2;
    [self.registerBtn addTarget:self action:@selector(registerCliclk:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    line.sd_layout.leftSpaceToView(self.loginBtn,0).topSpaceToView(self.imgV,-5).widthIs(1).heightIs(40.0 * KWidth_Scale);
    
    [self setLogin];
    
    // Do any additional setup after loading the view.
}

//返回
- (void)backBtn{
    
//    UIViewController *rootVC = self.presentingViewController;
//    while (rootVC.presentingViewController) {
//        rootVC = rootVC.presentingViewController;
//    }
//    [self dismissModalViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:NO completion:nil];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    
//    [self presentViewController:[YJLoginController new] animated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];


}

- (void)registerCliclk:(UIButton *)btn{
    
    YJRegsiterController *vc = [[YJRegsiterController alloc]init];
//    [self presentViewController:vc animated:NO completion:nil];
    [self.navigationController pushViewController:vc animated:NO];

    
}

//键盘监听
- (void)configKeyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    __weak YJLoginFirstController *weakSelf = self;
#pragma explain - 全自动键盘弹出/收起处理 (需调用keyboardUtil 的 adaptiveViewHandleWithController:adaptiveView:)
#pragma explain - use animateWhenKeyboardAppearBlock, animateWhenKeyboardAppearAutomaticAnimBlock will be invalid.
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.nameTf,weakSelf.passwordTf,weakSelf.iconCode, nil];
    }];
    /*  or
     [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
     [keyboardUtil adaptiveViewHandleWithAdaptiveView:weakSelf.inputViewBorderView, weakSelf.secondTextField, weakSelf.thirdTextField, nil];
     }];
     */
    
    
#pragma explain - 自定义键盘弹出处理(如配置，全自动键盘处理则失效)
#pragma explain - use animateWhenKeyboardAppearAutomaticAnimBlock, animateWhenKeyboardAppearBlock must be nil.
    /*
     [_keyboardUtil setAnimateWhenKeyboardAppearBlock:^(int appearPostIndex, CGRect keyboardRect, CGFloat keyboardHeight, CGFloat keyboardHeightIncrement) {
     //do something
     }];
     */
    
#pragma explain - 自定义键盘收起处理(如不配置，则默认启动自动收起处理)
#pragma explain - if not configure this Block, automatically itself.
    /*
     [_keyboardUtil setAnimateWhenKeyboardDisappearBlock:^(CGFloat keyboardHeight) {
     //do something
     }];
     */
    
#pragma explain - 获取键盘信息
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [self.numCode resignFirstResponder];
    [self.passwordTf resignFirstResponder];
    [self.iconCode resignFirstResponder];
    [self.nameTf resignFirstResponder];
    return YES;
}


//加载布局
- (void)setLogin{
    
    //输入手机号
    UIImageView *phone = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"telephone"]];
    [self.view addSubview:phone];
    phone.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.loginBtn,38.0 * KHeight_Scale).heightIs(20.0 * KHeight_Scale).widthIs(18.0 * KWidth_Scale);
    
    self.nameTf = [[UITextField alloc]init];
    self.nameTf.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.nameTf];
    self.nameTf.placeholder = @"请输入手机号";
    self.nameTf.font = [UIFont systemFontOfSize:AdaptedWidth(15.0)];
    [self.nameTf addTarget:self action:@selector(textFiledEdit:) forControlEvents:UIControlEventEditingChanged];
    self.nameTf.sd_layout.centerYEqualToView(phone).leftSpaceToView(phone,10).rightSpaceToView(self.view,40).heightIs(20 * KHeight_Scale);
    self.nameTf.keyboardType = UIKeyboardTypeNumberPad;
    
    //点击取消所有输入
    self.dis = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dis setImage:[UIImage imageNamed:@"X"] forState:UIControlStateNormal];
    [self.view addSubview:self.dis];
    [self.dis addTarget:self action:@selector(disText:) forControlEvents:UIControlEventTouchUpInside];
    self.dis.hidden = YES;
    self.dis.sd_layout.leftSpaceToView(self.nameTf,2).rightSpaceToView(self.view,20).heightIs(18.0 * KWidth_Scale).centerYEqualToView(self.nameTf);
    
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = BackGroundColor;
    [self.view addSubview:line];
    line.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.nameTf,5).heightIs(1).rightSpaceToView(self.view,20);
   
    
    //输入图片验证码
    
    UIImageView *Code = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"indentifying_code2"]];
    [self.view addSubview:Code];
    Code.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(line,40.0 * KHeight_Scale).heightIs(20.0 * KHeight_Scale).widthIs(18.0 * KWidth_Scale);
    
    self.iconCode = [[UITextField alloc]init];
    self.iconCode.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.iconCode];
    self.iconCode.sd_layout.leftSpaceToView(Code,10).centerYEqualToView(Code).heightIs(20 * KHeight_Scale).rightSpaceToView(self.view,110);
    self.iconCode.placeholder = @"请输入图片验证码";
    self.iconCode.font = [UIFont systemFontOfSize:AdaptedWidth(15.0)];
//    self.iconCode.keyboardType = UIKeyboardTypeNumberPad;
    
    self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backImg"]];
    [self.view addSubview:self.icon];
    self.icon.userInteractionEnabled = YES;
    self.icon.sd_layout.rightSpaceToView(self.view,20).bottomEqualToView(self.iconCode).widthIs(80).heightIs(30 * KHeight_Scale);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(refuseIcon)];
    [self.icon addGestureRecognizer:tap];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *deviceId = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceID"];
    [parameter setObject:deviceId forKey:@"deviceId"];
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/verify/create",BaseUrl] parameters:parameter success:^(id responseObject) {
        self.icon.image = [[UIImage alloc]initWithData:responseObject];
        XXLog(@"成功");
    } failure:^(NSError *error) {
        SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"请求失败，请检查网络等原因！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
        }];
        alertV.sure_btnTitleColor = TextColor;
        [alertV show];
        XXLog(@"失败");
    }];
    

    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = BackGroundColor;
    [self.view addSubview:line1];
    line1.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.iconCode,5).heightIs(1).rightSpaceToView(self.view,20);
    
    //输入密码
    UIImageView *pw = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lock"]];
    [self.view addSubview:pw];
    pw.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(line1,40.0 * KHeight_Scale).heightIs(20.0 * KHeight_Scale).widthIs(18.0 * KWidth_Scale);
    

    
    self.passwordTf = [[UITextField alloc]init];
    self.passwordTf.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.passwordTf];
    self.passwordTf.sd_layout.leftSpaceToView(pw,10).centerYEqualToView(pw).heightIs(20 * KHeight_Scale).rightSpaceToView(self.view,45);
    self.passwordTf.placeholder = @"请输入密码";
    self.passwordTf.font = [UIFont systemFontOfSize:AdaptedWidth(15.0)];
    self.passwordTf.secureTextEntry = YES;
    
    self.PWBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.PWBtn];
    [self.PWBtn setImage:[UIImage imageNamed:@"eyes"] forState:UIControlStateNormal];
    [self.PWBtn addTarget:self action:@selector(passChange:) forControlEvents:UIControlEventTouchUpInside];
    self.PWBtn.selected = NO;
    self.PWBtn.sd_layout.leftSpaceToView(self.passwordTf,2).rightSpaceToView(self.view,20).heightIs(20 * KHeight_Scale).widthIs(20 * KWidth_Scale).centerYEqualToView(self.passwordTf);

    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = BackGroundColor;
    [self.view addSubview:line2];
    line2.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.passwordTf,5).heightIs(1).rightSpaceToView(self.view,20);
    
    //忘记密码
    self.forgetPW = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.forgetPW];
    [self.forgetPW setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.forgetPW setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.forgetPW.titleLabel.font = [UIFont systemFontOfSize:13.0];
    self.forgetPW.sd_layout.rightSpaceToView(self.view,20).topSpaceToView(line2,5).heightIs(15 * KHeight_Scale).widthIs(70);
    [self.forgetPW addTarget:self action:@selector(findPw) forControlEvents:UIControlEventTouchUpInside];
    
    //登录
    self.loginOrRegist = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginOrRegist setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginOrRegist setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:self.loginOrRegist];
    self.loginOrRegist.backgroundColor = [UIColor whiteColor];
    self.loginOrRegist.titleLabel.font = [UIFont systemFontOfSize:18.0];
    self.loginOrRegist.sd_layout.centerXEqualToView(self.view).topSpaceToView(line2,60.0 *KHeight_Scale).heightIs(40.0 * KHeight_Scale).widthIs(240.0 * KWidth_Scale);
    [self.loginOrRegist addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    self.loginOrRegist.layer.masksToBounds = YES;
    self.loginOrRegist.layer.cornerRadius = 17.0;
    self.loginOrRegist.layer.borderColor = TextColor.CGColor;
    self.loginOrRegist.layer.borderWidth = 1;
}

//刷新图片验证码
- (void)refuseIcon{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *deviceId = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceID"];
    [parameter setObject:deviceId forKey:@"deviceId"];
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/verify/create",BaseUrl] parameters:parameter success:^(id responseObject) {
        self.icon.image = [[UIImage alloc]initWithData:responseObject];
        XXLog(@"成功");
    } failure:^(NSError *error) {
        SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"请求失败，请检查网络等原因！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
        }];
        alertV.sure_btnTitleColor = TextColor;
        [alertV show];
        XXLog(@"失败");
    }];
    
}

- (void)login{
    
    if ([MobileNumberHelper isMobileNumber:self.nameTf.text] && self.iconCode.text.length == 4 && [MobileNumberHelper isValidPassword:self.passwordTf.text]) {
        
        [[EMClient sharedClient] logout:YES];
        
        XXLog(@"判断正确");
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        [parameter setObject:self.nameTf.text forKey:@"username"];
        [parameter setObject:self.iconCode.text forKey:@"code"];
        [parameter setObject:self.passwordTf.text forKey:@"password"];
        NSString *deviceId = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceID"];
        [parameter setObject:deviceId forKey:@"deviceId"];
        XXLog(@"%@",parameter);
        NSString *url = [NSString stringWithFormat:@"%@/user/loginProcess",BaseUrl];
        
        XXLog(@"%@",url);
        
        [WBHttpTool Post:url parameters:parameter success:^(id responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            XXLog(@"%@",dict);
            
            if ([dict[@"code"] isEqualToString:@"1"]) {
                //登录完成
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.mode = MBProgressHUDModeText;
                hud.labelColor = [UIColor whiteColor];
                hud.color = [UIColor blackColor];
                hud.labelText = NSLocalizedString(@"登录成功", @"HUD message title");
                [hud hide:YES afterDelay:2.0];
                
                NSArray *nCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
                NSHTTPCookie *cookie;
                for (id c in nCookies)
                {
                    if ([c isKindOfClass:[NSHTTPCookie class]])
                    {
                        cookie=(NSHTTPCookie *)c;
                        if ([cookie.name isEqualToString:@"SESSION"]) {
                            NSNumber *sessionOnly = [NSNumber numberWithBool:cookie.sessionOnly];
                            NSNumber *isSecure = [NSNumber numberWithBool:cookie.isSecure];
                            NSArray *cookies = [NSArray arrayWithObjects:cookie.name, cookie.value, sessionOnly, cookie.domain, cookie.path, isSecure, nil];
                            [[NSUserDefaults standardUserDefaults] setObject:cookies forKey:@"cookies"];
                            break;
                        }
                    }
                }
                
                
                //跳转界面
                
                if (self.type == 10) {
                [self presentViewController:[YJTabBarController new] animated:YES completion:nil];
  
                }else{
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                

            }else{
                //登录错误提示信息
                SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:dict[@"msg"] alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                }];
                alertV.sure_btnTitleColor = TextColor;
                [alertV show];

                NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
                NSString *deviceId = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceID"];
                [parameter setObject:deviceId forKey:@"deviceId"];
                
                [WBHttpTool GET:[NSString stringWithFormat:@"%@/verify/create",BaseUrl] parameters:parameter success:^(id responseObject) {
                    self.icon.image = [[UIImage alloc]initWithData:responseObject];
                    XXLog(@"成功");
                } failure:^(NSError *error) {
                    SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"请求失败，请检查网络等原因！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    }];
                    alertV.sure_btnTitleColor = TextColor;
                    [alertV show];
                    XXLog(@"失败");
                }];
                
            }
            
        } failure:^(NSError *error) {
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"请求失败，请检查网络等原因！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
            XXLog(@"失败");
        }];
        
    }else{
        //输入格式有错
        
        SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"输入格式有错,请检查手机号、验证码或密码格式！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
        }];
        alertV.sure_btnTitleColor = TextColor;
        [alertV show];
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        NSString *deviceId = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceID"];
        [parameter setObject:deviceId forKey:@"deviceId"];
        
        [WBHttpTool GET:[NSString stringWithFormat:@"%@/verify/create",BaseUrl] parameters:parameter success:^(id responseObject) {
            self.icon.image = [[UIImage alloc]initWithData:responseObject];
            XXLog(@"成功");
        } failure:^(NSError *error) {
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"请求失败，请检查网络等原因！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
            XXLog(@"失败");
        }];
        
    }
    
}


//改变密码输入方式
- (void)passChange:(UIButton *)btn{
    
    if (btn.selected == NO) {
        [btn setImage:[UIImage imageNamed:@"eyes2"] forState:UIControlStateNormal];
        btn.selected = YES;
        self.passwordTf.secureTextEntry = NO;
    }else{
        
        [btn setImage:[UIImage imageNamed:@"eyes"] forState:UIControlStateNormal];
        self.passwordTf.secureTextEntry = YES;
        btn.selected = NO;
    }
    
    
}

// 点击取消输入内容
- (void)disText:(UIButton *)btn{
    
    self.nameTf.text = nil;
    btn.hidden = YES;
}

- (void)textFiledEdit:(UITextField *)textField{
    
    
    if ([textField.text  isEqual: @""] || textField.text == nil) {
        
        self.dis.hidden = YES;
    }else{
        self.dis.hidden = NO;
    }
    
}


//找回密码
- (void)findPw{
    
    YJFindPWController *vc = [[YJFindPWController alloc]init];
//    [self presentViewController:vc animated:NO completion:nil];
    [self.navigationController pushViewController:vc animated:YES];

}


//设置状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
