//
//  YJFindPWController.m
//  全球向导
//
//  Created by SYJ on 2016/11/1.
//  Copyright © 2016年 尚勇杰. All rights reserved.
//

#import "YJFindPWController.h"
#import "SDAutoLayout.h"
#import "ZYKeyboardUtil.h"
#import "CountDown.h"
#import "YJFinshController.h"
#import "WBHttpTool.h"
#import "MobileNumberHelper.h"
#import "KeychainIDFA.h"


@interface YJFindPWController ()<UITextFieldDelegate>

//头部图片
@property (nonatomic, strong) UIImageView *imgV;
//名称、手机号
@property (nonatomic, strong) UITextField *nameTf;
//密码
@property (nonatomic, strong) UITextField *passwordTf;
//图片验证码
@property (nonatomic, strong) UITextField *iconCode;
//输入数字验证码
@property (nonatomic, strong) UITextField *numCode;
//获取验证码
@property (nonatomic, strong) UIButton *numBtn;
//图片验证码
@property (nonatomic, strong) UIImageView *icon;
//登录/注册
@property (nonatomic, strong) UIButton *loginOrRegist;
//点击取消输入
@property (nonatomic, strong) UIButton *dis;

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;

@property (strong, nonatomic)  CountDown *countDownForBtn;

//更改密码输入方式
@property (nonatomic, strong) UIButton *PWBtn;

@end

@implementation YJFindPWController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _countDownForBtn = [[CountDown alloc] init];
    
    
    //处理键盘事件
    self.nameTf.delegate = self;
    self.passwordTf.delegate = self;
    self.iconCode.delegate = self;
    self.numCode.delegate = self;
    [self configKeyBoardRespond];
    
    
    
    self.imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg2"]];
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
    label.text = @"找回密码";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18.0];
    [self.imgV addSubview:label];
    
    
    [self setLogin];


    // Do any additional setup after loading the view.
}


//返回
- (void)backBtn{
    
//    UIViewController *rootVC = self.presentingViewController;
//    while (rootVC.presentingViewController) {
//        rootVC = rootVC.presentingViewController;
//    }
//    [rootVC dismissViewControllerAnimated:YES completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//键盘监听
- (void)configKeyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    __weak YJFindPWController *weakSelf = self;
#pragma explain - 全自动键盘弹出/收起处理 (需调用keyboardUtil 的 adaptiveViewHandleWithController:adaptiveView:)
#pragma explain - use animateWhenKeyboardAppearBlock, animateWhenKeyboardAppearAutomaticAnimBlock will be invalid.
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.nameTf, weakSelf.numCode, weakSelf.passwordTf,weakSelf.iconCode, nil];
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
     NSLog(@"\n\n键盘弹出来第 %d 次了~  高度比上一次增加了%0.f  当前高度是:%0.f"  , appearPostIndex, keyboardHeightIncrement, keyboardHeight);
     //do something
     }];
     */
    
#pragma explain - 自定义键盘收起处理(如不配置，则默认启动自动收起处理)
#pragma explain - if not configure this Block, automatically itself.
    /*
     [_keyboardUtil setAnimateWhenKeyboardDisappearBlock:^(CGFloat keyboardHeight) {
     NSLog(@"\n\n键盘在收起来~  上次高度为:+%f", keyboardHeight);
     //do something
     }];
     */
    
#pragma explain - 获取键盘信息
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
        NSLog(@"\n\n拿到键盘信息 和 ZYKeyboardUtil对象");
    }];
}



//点击跳转
- (void)loginClick:(UIButton *)btn{
    
    YJFinshController *vc = [[YJFinshController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
    
}
//加载布局
- (void)setLogin{
    
    //输入手机号
    
    UIImageView *phone = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"telephone"]];
    [self.view addSubview:phone];
    phone.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.imgV,30.0 * KHeight_Scale).heightIs(20.0 * KHeight_Scale).widthIs(18.0 * KWidth_Scale);
    
    self.nameTf = [[UITextField alloc]init];
    self.nameTf.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.nameTf];
    self.nameTf.placeholder = @"请输入手机号";
    self.nameTf.delegate = self;
    self.nameTf.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    [self.nameTf addTarget:self action:@selector(textFiledEdit:) forControlEvents:UIControlEventEditingChanged];
    self.nameTf.sd_layout.topSpaceToView(self.imgV,30.0 * KHeight_Scale).leftSpaceToView(phone,10).rightSpaceToView(self.view,40).heightIs(20 * KHeight_Scale);
    self.nameTf.keyboardType = UIKeyboardTypeNumberPad;
    
    //点击取消所有输入
    self.dis = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dis setImage:[UIImage imageNamed:@"X"] forState:UIControlStateNormal];
    [self.view addSubview:self.dis];
    [self.dis addTarget:self action:@selector(disText:) forControlEvents:UIControlEventTouchUpInside];
    self.dis.hidden = YES;
    self.dis.sd_layout.leftSpaceToView(self.nameTf,2).rightSpaceToView(self.view,20).heightIs(18.0 * KWidth_Scale).centerYEqualToView(self.nameTf);
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = BackGray;
    [self.view addSubview:line];
    line.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.nameTf,5).heightIs(1).rightSpaceToView(self.view,20);
    
    //输入图片验证码
    UIImageView *Code = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"indentifying_code2"]];
    [self.view addSubview:Code];
    Code.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(line,30.0 * KHeight_Scale).heightIs(20.0 * KHeight_Scale).widthIs(18.0 * KWidth_Scale);
    
    
    self.iconCode = [[UITextField alloc]init];
    self.iconCode.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.iconCode];
    [self.iconCode addTarget:self action:@selector(textFiledEdit:) forControlEvents:UIControlEventEditingChanged];
    self.iconCode.delegate = self;
    self.iconCode.sd_layout.leftSpaceToView(Code,10).topSpaceToView(line,30 * KHeight_Scale).heightIs(20 * KHeight_Scale).rightSpaceToView(self.view,110);
    self.iconCode.placeholder = @"请输入图片验证码";
    [self.iconCode addTarget:self action:@selector(textFiledEdit:) forControlEvents:UIControlEventEditingChanged];
    
    self.iconCode.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    
    
    self.icon = [[UIImageView alloc]init];
    [self.view addSubview:self.icon];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *deviceId = [KeychainIDFA IDFA];
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
    
    
    self.icon.userInteractionEnabled = YES;
    self.icon.sd_layout.rightSpaceToView(self.view,20).bottomEqualToView(self.iconCode).widthIs(80).heightIs(30 * KHeight_Scale);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(refuseIcon)];
    [self.icon addGestureRecognizer:tap];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = BackGray;
    [self.view addSubview:line1];
    line1.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.iconCode,5).heightIs(1).rightSpaceToView(self.view,20);
    
    
    
    //获取手机验证码
    
    UIImageView *num = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"indentifying_code"]];
    [self.view addSubview:num];
    num.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(line1,30.0 * KHeight_Scale).heightIs(20.0 * KHeight_Scale).widthIs(20.0 * KWidth_Scale);
    
    
    
    self.numCode = [[UITextField alloc]init];
    self.numCode.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.numCode];
    self.numCode.sd_layout.leftSpaceToView(num,8).topSpaceToView(line1,30 * KHeight_Scale).heightIs(20 * KHeight_Scale).rightSpaceToView(self.view,110);
    self.numCode.placeholder = @"请输入手机验证码";
    self.numCode.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    self.numCode.keyboardType = UIKeyboardTypeNumberPad;
    
    self.numBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.numBtn];
    [self.numBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.numBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.numBtn setBackgroundColor:[UIColor grayColor]];
    self.numBtn.enabled = NO;
    self.numBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(13)];
    [self.numBtn addTarget:self action:@selector(getNum:) forControlEvents:UIControlEventTouchUpInside];
    self.numBtn.sd_layout.rightSpaceToView(self.view,20).bottomEqualToView(self.numCode).widthIs(80).heightIs(30 * KHeight_Scale);
    self.numBtn.layer.masksToBounds = YES;
    self.numBtn.layer.cornerRadius = 10;
    self.numBtn.layer.borderWidth = 1;
    self.numBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = BackGray;
    [self.view addSubview:line3];
    line3.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.numCode,5).heightIs(1).rightSpaceToView(self.view,20);
    
    
    //输入密码
    UIImageView *pw = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lock"]];
    [self.view addSubview:pw];
    pw.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(line3,30.0 * KHeight_Scale).heightIs(20.0 * KHeight_Scale).widthIs(18.0 * KWidth_Scale);
    
    self.passwordTf = [[UITextField alloc]init];
    self.passwordTf.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.passwordTf];
    self.passwordTf.sd_layout.leftSpaceToView(pw,12.0).topSpaceToView(line3,30 * KHeight_Scale).heightIs(20 * KHeight_Scale).rightSpaceToView(self.view,45);
    self.passwordTf.placeholder = @"请输入密码(字母开头8-18位)";
    self.passwordTf.secureTextEntry = YES;
    self.passwordTf.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
    
    self.PWBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.PWBtn];
    [self.PWBtn setImage:[UIImage imageNamed:@"eyes"] forState:UIControlStateNormal];
    [self.PWBtn addTarget:self action:@selector(passChange:) forControlEvents:UIControlEventTouchUpInside];
    self.PWBtn.selected = NO;
    self.PWBtn.sd_layout.leftSpaceToView(self.passwordTf,2).rightSpaceToView(self.view,20).heightIs(20 * KHeight_Scale).widthIs(20 * KWidth_Scale).centerYEqualToView(self.passwordTf);
    
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = BackGray;
    [self.view addSubview:line2];
    line2.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.passwordTf,5).heightIs(1).rightSpaceToView(self.view,20);
    
    
    //登录
    self.loginOrRegist = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginOrRegist setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginOrRegist setTitle:@"完成" forState:UIControlStateNormal];
    [self.view addSubview:self.loginOrRegist];
    self.loginOrRegist.backgroundColor = [UIColor whiteColor];
    self.loginOrRegist.titleLabel.font = [UIFont systemFontOfSize:18.0];
    self.loginOrRegist.sd_layout.centerXEqualToView(self.view).topSpaceToView(line2,60.0 *KHeight_Scale).heightIs(40.0 * KHeight_Scale).widthIs(240.0 * KWidth_Scale);
    [self.loginOrRegist addTarget:self action:@selector(findPW) forControlEvents:UIControlEventTouchUpInside];
    self.loginOrRegist.layer.masksToBounds = YES;
    self.loginOrRegist.layer.cornerRadius = 17.0;
    self.loginOrRegist.layer.borderColor = TextColor.CGColor;
    self.loginOrRegist.layer.borderWidth = 1;
    
}

//刷新验证码
- (void)refuseIcon{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *deviceId = [KeychainIDFA IDFA];
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

//找回密码
- (void)findPW{
    
    if (self.nameTf.text.length == 11 && self.iconCode.text.length == 4 && self.numCode.text.length == 6 && [MobileNumberHelper isValidPassword:self.passwordTf.text]) {
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        [parameter setObject:self.numCode.text forKey:@"mobileCode"];
        [parameter setObject:self.passwordTf.text forKey:@"loginPwd"];
        NSString *deviceId = [KeychainIDFA IDFA];
        [parameter setObject:deviceId forKey:@"deviceId"];
        
        XXLog(@"%@",parameter);
        NSString *url = [NSString stringWithFormat:@"%@/user/updateLoginPwd",BaseUrl];
        
        XXLog(@"%@",url);
        
        [WBHttpTool Post:url parameters:parameter success:^(id responseObject) {
            
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSLog(@".....%@",dict);
            NSString *code = dict[@"code"];
            if ([code isEqualToString:@"1"]) {
                
                YJFinshController *vc = [[YJFinshController alloc]init];
                [self presentViewController:vc animated:NO completion:nil];
                
            }else{
                
                SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:dict[@"msg"] alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                }];
                alertV.sure_btnTitleColor = TextColor;
                [alertV show];
                
                
                NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
                NSString *deviceId = [KeychainIDFA IDFA];
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
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"请求失败！请查看网络等原因！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
            XXLog(@"%@",error);
        }];
    }else{
        
        SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"输入格式有误,请重新输入!" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
        }];
        alertV.sure_btnTitleColor = TextColor;
        [alertV show];

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


//获取验证码
- (void)getNum:(UIButton *)btn{
    
    
    if ([MobileNumberHelper isMobileNumber:self.nameTf.text] && self.iconCode.text.length == 4) {
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        [parameter setObject:self.nameTf.text forKey:@"mobile"];
        [parameter setObject:self.iconCode.text forKey:@"code"];
        NSString *deviceId = [KeychainIDFA IDFA];
        [parameter setObject:deviceId forKey:@"deviceId"];

        [WBHttpTool Post:[NSString stringWithFormat:@"%@/user/getUserInfo",BaseUrl] parameters:parameter success:^(id responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            XXLog(@".....%@",dict);
        

        if ([dict[@"code"] isEqualToString:@"1"]) {
            NSMutableDictionary *parame = [NSMutableDictionary dictionary];
            NSString *url = [NSString stringWithFormat:@"%@/user/getMobileCodeForForgetPwd",BaseUrl];
            NSString *deviceId = [KeychainIDFA IDFA];
            [parame setObject:deviceId forKey:@"deviceId"];
        
        XXLog(@"%@",url);

        [WBHttpTool Post:url parameters:parame success:^(id responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            XXLog(@".....%@",dict);
                
                NSString *code = dict[@"code"];
                
                if ([code isEqualToString:@"1"]) {
                    
                    SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"发送验证码成功,请注意查收!" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    }];
                    alertV.sure_btnTitleColor = TextColor;
                    [alertV show];
                    //60s的倒计时
                    NSTimeInterval aMinutes = 60;
                    [self startWithStartDate:[NSDate date] finishDate:[NSDate dateWithTimeIntervalSinceNow:aMinutes]];
                    
                }else{
                    
                    SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:dict[@"msg"] alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                    }];
                    alertV.sure_btnTitleColor = TextColor;
                    [alertV show];
                    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
                    NSString *deviceId = [KeychainIDFA IDFA];
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
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"请求失败！请查看网络等原因！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
            XXLog(@"%@",error);
        }];
        
        
        
    }else{
        
        SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:dict[@"msg"] alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
        }];
        alertV.sure_btnTitleColor = TextColor;
        [alertV show];
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        NSString *deviceId = [KeychainIDFA IDFA];
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
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"请求失败！请查看网络等原因！" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
                
            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
        XXLog(@"%@",error);
        }];
        
        
    }else{
        
        
        SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"手机号格式或验证码有误,请重新发送!" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
        }];
        alertV.sure_btnTitleColor = TextColor;
        [alertV show];
}
}

// 点击取消输入内容
- (void)disText:(UIButton *)btn{
    
    self.nameTf.text = nil;
    btn.hidden = YES;
}

- (void)textFiledEdit:(UITextField *)textField{
   
    if (self.nameTf.text.length == 11 && self.iconCode.text.length == 4) {
        [self.numBtn setBackgroundColor:TextColor];
        self.numBtn.enabled = YES;
    }else{
        
        [self.numBtn setBackgroundColor:[UIColor grayColor]];
        self.numBtn.enabled = NO;
    }

    
    if ([textField.text  isEqual: @""] || textField.text == nil) {
        
        self.dis.hidden = YES;
    }else{
        self.dis.hidden = NO;
    }
    
}



//此方法用两个NSDate对象做参数进行倒计时
-(void)startWithStartDate:(NSDate *)strtDate finishDate:(NSDate *)finishDate{
    __weak __typeof(self) weakSelf = self;
    
    [_countDownForBtn countDownWithStratDate:strtDate finishDate:finishDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
//        NSLog(@"second = %li",second);
        NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
        if (totoalSecond==0) {
            weakSelf.numBtn.enabled = YES;
            [weakSelf.numBtn setTitle:@"重新获取" forState:UIControlStateNormal];
            [weakSelf.numBtn setBackgroundColor:[UIColor blueColor]];

        }else{
            weakSelf.numBtn.enabled = NO;
            [weakSelf.numBtn setTitle:[NSString stringWithFormat:@"%lis后获取",totoalSecond] forState:UIControlStateNormal];
            [weakSelf.numBtn setBackgroundColor:[UIColor grayColor]];

        }
        
    }];
}


#pragma mark - textFiled代理

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.numCode resignFirstResponder];
    [self.passwordTf resignFirstResponder];
    [self.iconCode resignFirstResponder];
    [self.nameTf resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}






//设置状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)dealloc{
    //    [_countDownForLabel destoryTimer];
    [_countDownForBtn destoryTimer];
    NSLog(@"%s dealloc",object_getClassName(self));
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
